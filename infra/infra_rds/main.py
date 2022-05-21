#!/usr/bin/env python
# dont forget these manual steps for now: https://docs.meroxa.com/platform/resources/mysql/amazon-rds/#configure-security-groups
# also in console you need to pubically accessable = y
import os

from constructs import Construct
from cdktf import App, NamedRemoteWorkspace, TerraformStack, TerraformOutput, RemoteBackend
from cdktf_cdktf_provider_aws import AwsProvider, rds, vpc, lambdafunction

aws_access_key_id = os.getenv("AWS_ACCESS_KEY_ID")
aws_secret_access_key = os.getenv("AWS_SECRET_ACCESS_KEY")
dev_password = os.getenv("DEV_PASSWORD")

class MyStack(TerraformStack):
    def __init__(self, scope: Construct, ns: str):
        super().__init__(scope, ns)

        AwsProvider(self, "AWS", region="ap-southeast-2", access_key=aws_access_key_id, secret_key=aws_secret_access_key) # shared_config_files=["~/.aws/config"], shared_credentials_files=["~/.aws/credentials"])

        # instance = rds.DbInstance(self, id="davemeroxards", instance_class="db.t3.micro", engine="postgresql", password=dev_password, username="dave", name="meroxa", allocated_storage="1")

        # will skip security group and acl and just allow access via GUI

        # ingress = vpc.SecurityGroupIngress( 
        #     from_port        = 3306,
        #     to_port          = 3306,
        #     protocol         = "tcp",
        #     cidr_blocks      = ["18.233.218.4/32", "52.73.115.93/32", "3.215.90.7/32", "23.22.136.187/32"]        
        # )

        # security_group = vpc.SecurityGroup(id="sg-meroxa",
        #     description      = "TLS from VPC",
        #     ingress=ingress
        #     )

        param_group = rds.DbParameterGroup(self, 
            id="pg-meroxa-rds",
            family="mysql8.0",
            parameter=[
                rds.DbParameterGroupParameter(name="binlog_format", value="ROW"),
                rds.DbParameterGroupParameter(name="binlog_row_image", value="FULL")
            ]
        )

        instance = rds.DbInstance(self, id="rds-mysql-meroxa", allocated_storage    = 10,
            engine               = "mysql",
            engine_version       = "8.0",
            instance_class       = "db.t3.micro",
            name                 = "mydb",
            username             = "dave",
            password             = dev_password,
            parameter_group_name = param_group.name,
            # security_group_names=[security_group.name],
            skip_final_snapshot  = True,
            backup_retention_period=1,
            backup_window="03:10-3:30"
            
            )

        TerraformOutput(self, "instance name",
                        value=instance.name,
                        )


app = App()
stack = MyStack(app, "aws_instance")

RemoteBackend(stack,
              hostname='app.terraform.io',
              organization='wisemuffin',
              workspaces=NamedRemoteWorkspace('meroxa')
              )

app.synth()
