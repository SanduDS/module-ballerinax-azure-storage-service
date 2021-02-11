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

#Stores the URI parameter names and the releavnt remote function names that URI parameter can be used.
map<string[]> uriParameters = {
    prefix: [LIST_SHARES, GET_DIRECTORY_LIST, GET_FILE_LIST],
    marker: [LIST_SHARES, GET_DIRECTORY_LIST, GET_FILE_LIST],
    maxresults: [LIST_SHARES, GET_DIRECTORY_LIST, GET_FILE_LIST],
    include: [LIST_SHARES],
    timeout: [LIST_SHARES, GET_DIRECTORY_LIST, GET_FILE_LIST]    
};

#Stores the header names and the releavnt remote function names that headers can be used.
map<string[]> requestHeaders = {
    X_MS_META_NAME: [CREATE_SHARE, CREATE_DIRECTORY],
    X_MS_HARE_QUOTA: [CREATE_SHARE],
    X_MS_ACCESS_TIER: [CREATE_SHARE],
    X_MS_ENABLED_PRTOCOLS: [CREATE_SHARE]
};

public type ListShareURIParameters record {|
    string prefix?;
    string marker?;
    string maxresults?;
    string include?;
    string timeout?;
|};

public type GetDirectoryListURIParamteres record {|
    string prefix?;
    string sharesnapshot?;
    string marker?;
    string maxresults?;
    string timeout?;
|};

public type GetFileListURIParamteres record {|
    string prefix?;
    string sharesnapshot?;
    string marker?;
    string maxresults?;
    string timeout?;
|};

public type CreateShareHeaders record {|
    string 'x\-ms\-meta\-name?;
    string 'x\-ms\-share\-quota?;
    string 'x\-ms\-access\-tier?;
    string 'x\-ms\-enabled\-protocols?;
|};

public type URIRecord ListShareURIParameters|GetDirectoryListURIParamteres|GetFileListURIParamteres;

public type RequestHeader CreateShareHeaders;








