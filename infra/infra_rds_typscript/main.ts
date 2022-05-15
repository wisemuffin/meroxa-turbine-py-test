import { Construct } from "constructs";
import { App, TerraformStack, RemoteBackend, TerraformOutput } from "cdktf";
import { AwsProvider, ec2 } from "@cdktf/provider-aws";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    // define resources here
    new AwsProvider(this, "AWS", {
      region: "ap-southeast-2",
    });

    const instance = new ec2.Instance(this, "compute", {
      ami: "ami-07cc15c3ba6f8e287",
      instanceType: "t2.micro",
    });

    new TerraformOutput(this, "public_ip", {
      value: instance.publicIp,
    });
  }
}

const app = new App();
const stack = new MyStack(app, "infra_rds_typscript");
new RemoteBackend(stack, {
  hostname: "app.terraform.io",
  organization: "wisemuffin",
  workspaces: {
    name: "infra_rds_typscript"
  }
});
app.synth();
