/*
 * JBoss, Home of Professional Open Source
 *
 * Copyright 2017 Red Hat, Inc. and/or its affiliates.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
package org.keycloak.quickstart.springboot.web;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author <a href="mailto:psilva@redhat.com">Pedro Igor</a>
 */
@RestController
public class ApplicationController {

    @RequestMapping(value = "/api/user", method = RequestMethod.GET)
    public String userRoleProtectedResource() {
        return createResponse();
    }

    @RequestMapping(value = "/api/claim", method = RequestMethod.GET)
    public String claimProtectedResource() {
        return createResponse();
    }

    @RequestMapping(value = "/api/admin", method = RequestMethod.GET)
    public String adminRoleProtectedResource() {
        return createResponse();
    }



    private String createResponse() {
        StackTraceElement[] stacktrace = Thread.currentThread().getStackTrace();
        StackTraceElement e = stacktrace[2];//maybe this number needs to be corrected
        String methodName = e.getMethodName();
        return "Access Granted to --> " + methodName;
    }
}
