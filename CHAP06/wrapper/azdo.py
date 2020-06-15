import os


def tfoutputtoAzdo(outputlist, jsonObject):

    """
    This function convert a dict to Azure DevOps pipelines variable
    outputlist : dict { terraform_output : azure devpops variable}
    jsonOject : the terraform output in Json format (terraform output -json)
    """

    if(len(outputlist) > 0):
            for k, v in outputlist.items():
                tfoutput_name = k
                azdovar = str(v)
                if tfoutput_name in jsonObject.keys():
                    var_value = jsonObject[tfoutput_name]["value"]
                    print(
                        "Run [echo ##vso[task.setvariable variable="+azdovar+";]"+var_value+"]")
                    os.system(
                        "echo ##vso[task.setvariable variable="+azdovar+";]"+var_value+"")
                else:
                    print("key {} is not present in terraform output".format(
                        tfoutput_name))
