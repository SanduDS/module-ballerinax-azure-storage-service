# Ballerina Azure Storage Service Connector
Connects to Microsoft Azure Storage Service using Ballerina.

![CI](https://github.com/ballerina-platform/module-ballerinax-azure-storage-service/workflows/CI/badge.svg?branch=main)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Introduction
Azure storage is a cloud storage service for azure provided by Microsoft to fulfill the cloud storage needs with high availability, security, durability, scalability and redundancy. Data in Azure Storage is accessible from anywhere in the world over HTTP or HTTPS. Microsoft provides a Rest API and a collection of client libraries for different languages. Azure storage supports scripting in Azure PowerShell or Azure CLI, and also it provides visual solutions for working with data  by azure portal and azure storage explorer. All azure storage services can be access through a storage account. There are several types of storage accounts. Each type supports different features and has its own pricing mode.

# Compatibility
|                     |    Version                                  |
|:-------------------:|:-------------------------------------------:|
| Ballerina Language  | Swan-Lake-Alpha2                            |
| File Service  API   | Version 2014-02-14 of the storage service   |

## Azure Storage Service - Files

Files stored in Azure File service shares are accessible via the SMB protocol, and also via REST APIs. The File service offers the following four resources: the storage account, shares, directories, and files. Shares provide a way to organize sets of files and also can be mounted as an SMB file share that is hosted in the cloud.

### Operations on File Service level
The `ballerinax/azure_storage_service.files` module contains operations to do file service level operations like list file shares, get/set fileshare properities.

### Operations on Fileshares
This module contains operation such as create fileshares, delete fileshares etc. 

### Operations on FileShare Directories/Files
The module provides operations on fileshares and files/directories such as creating, uploading, copying files etc.

### Prerequisites

* An Azure account and subscription.
If you don't have an Azure subscription, [sign up for a free Azure account](https://azure.microsoft.com/free/).

* A stroage service account.
If you don't have [azure storage account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal), 
  learn how to create your azure storage service account.

* Java 11 Installed
Java Development Kit (JDK) with version 11 is required.

* Ballerina SLAlpha2 Installed
Ballerina Swan Lake Alpha Version 2 is required.

* Shared Access Signature Authentication Credentials
    *Use generated SAS token from the azure storage account. 
    *Azure storage account base URL

### Configuration
Instantiate the connector by giving authorization credentials to the congfiguration

### Sample
First, import the `ballerinax/azure_storage_service.files` module into the Ballerina project. You may use ballerina configurable variables to provide the configuration valuesa as below.
```ballerina
import ballerinax/azure_storage_service.Files as fileShare;
import ballerinax/logs;

configurable string azureSharedKeyOrSasToken = ?; 
configurable string azurestorageAccountName = ?;
```

1. You can now make the connection configuration using the Azure shared key or the Azure shared access signature key by copying from the azure portal. If you use the azure Shared key, you must need to provide the method that you use to authorize the requests using the authorizationMethod(enum) field of the AzureConfiguration record.  In the file service module, You will have separate two clients as "ServiceLevelClient" and "FileShareClient"  for service level and non-service level functions respectively.
```ballerina
fileShare:AzureConfiguration azureConfiguration = {
        sharedKeyOrSASToken: azureSharedKeyOrSasToken,
        storageAccountName: azurestorageAccountName,
        authorizationMethod:<SHARED_ACCESS_SIGNATURE(default) or SHARED_ACCESS_KEY>    
    };

fileShare:FileShareClient azureClient = new (azureConfiguration);
fileShare:ServiceLevelClient azureServiceLevelClient = new (azureConfiguration);
```
2. Then creating a fileshare using the service level client who can use service level function and a valid Shared access siganture(SAS) token or a shared key .
```ballerina
    var creationResponse = azureServiceLevelClient->createShare("demoshare");
    if(creationResponse is boolean){
        log:print("Fileshare Creation: "+creationResponse.toString());
    }else{
       log:printError(creationResponse.toString()); 
    }
```

3. You can now upload a file using the non-service level client.
```ballerina
    var uploadResponse = azureClient->directUpload(fileShareName = "demoshare", 
    localFilePath = "resources/uploads/test.txt", azureFileName = "testfile.txt");
    if (uploadResponse is boolean) {
        log:print("upload status:" + UploadResponse.toString());
    } else {
        log:printError(UploadResponse.toString()); 
    }
```

4. You can now download the file using non service level client.
```ballerina
    var downloadResponse = azureClient->getFile(fileShareName = "demoshare", fileName = "testfile.txt",
    localFilePath = "resources/downloads/downloadedFile.txt");
    if (downloadResponse is boolean) {
        log:print("Download status:" + UploadResponse.toString());
    } else {
       log:printError(DownloadResponse.toString());
    }
```

5. You can delete thefileshare using the service level client who can use service level function and a valid SAS token. 
```ballerina
    var deletionResponse = azureServiceLevelClient->deleteShare("demoshare");
    if (deletionResponse is boolean) {
        log:print("Fileshare Deletion status:" + deletionResponse.toString());
    } else {
        log:printError(deletionResponse.toString()); 
    }
```
## Please check for the [sample directory](https://github.com/ballerina-platform/module-ballerinax-azure-storage-service/tree/main/modules/files/samples/files) for more examples.