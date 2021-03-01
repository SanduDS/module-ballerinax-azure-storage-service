//Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
import ballerinax/azure_storage_service.files as files;
import ballerina/log;

configurable string azureSharedKeyOrSasToken = ?; 
configurable string azurestorageAccountName = ?;

public function main() {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Setting up the configuration.                                                                                  //
    //* User can select one of the authorization methods from Shared key and Shared Access Signature provided.        //
    //* the user needs to metion the  authorizationMethod                                                             //
    //* User needs to provide the storage account name and the baseUrl will be created using it.                      //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        sharedKeyOrSASToken: azureSharedKeyOrSasToken,
        storageAccountName: azurestorageAccountName,
        authorizationMethod : SAS
    };

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Operations have be divided into two main categarites as Service level and non service level.                    //
    //Creating a non-service level client using the configuration.                                                    //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    files:FileShareClient azureClient = checkpanic new (configuration);
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //* Before Run this sample user needs to creat a fileshare in an Azure storage account file service and the       //
    //  created fileshare should be used for the non-service level operations.                                        //
    //* User needs to add necessary parameters which is indicated within <> symbols.                                  //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var result = azureClient->getFileList(fileShareName = "<fileShareName>");
    if (result is files:FileList) {
        log:print(result.toString());
    } else {
        log:print(result.message());
    }
}
