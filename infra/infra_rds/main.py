#!/usr/bin/env python
import os

from constructs import Construct
from cdktf import App, NamedRemoteWorkspace, TerraformStack, TerraformOutput, RemoteBackend
from cdktf_cdktf_provider_aws import AwsProvider, ec2

aws_access_key_id = os.getenv("AWS_ACCESS_KEY_ID")
aws_secret_access_key = os.getenv("AWS_SECRET_ACCESS_KEY")

class MyStack(TerraformStack):
    def __init__(self, scope: Construct, ns: str):
        super().__init__(scope, ns)

        AwsProvider(self, "AWS", region="ap-southeast-2", access_key=aws_access_key_id, secret_key=aws_secret_access_key) # shared_config_files=["~/.aws/config"], shared_credentials_files=["~/.aws/credentials"])

        instance = ec2.Instance(self, "compute",
                                ami="ami-07cc15c3ba6f8e287",
                                instance_type="t2.micro",
                                )

        TerraformOutput(self, "public_ip",
                        value=instance.public_ip,
                        )


app = App()
stack = MyStack(app, "aws_instance")

RemoteBackend(stack,
              hostname='app.terraform.io',
              organization='wisemuffin',
              workspaces=NamedRemoteWorkspace('meroxa')
              )

app.synth()
