From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ACPICA: Linuxize: Export debugger files to Linux
Date: Tue, 3 Nov 2015 17:25:11 +0300
Message-ID: <20151103142511.GB28591@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36918 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbKCOZW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Nov 2015 09:25:22 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lv.zheng@intel.com
Cc: linux-acpi@vger.kernel.org

Hello Lv Zheng,

This is a semi-automatic email about new static checker warnings.

The patch 995751025572: "ACPICA: Linuxize: Export debugger files to 
Linux" from Oct 19, 2015, leads to the following Smatch complaint:

drivers/acpi/acpica/dbcmds.c:1159 acpi_db_trace()
	 error: we previously assumed 'enable_arg' could be null (see line 1134)

drivers/acpi/acpica/dbcmds.c
  1133	
  1134		if (enable_arg) {
                    ^^^^^^^^^^
Check for NULL.

  1135			acpi_ut_strupr(enable_arg);
  1136		}
  1137	
  1138		if (once_arg) {
  1139			acpi_ut_strupr(once_arg);
  1140		}
  1141	
  1142		if (method_arg) {
  1143			if (acpi_db_trace_method_name) {
  1144				ACPI_FREE(acpi_db_trace_method_name);
  1145				acpi_db_trace_method_name = NULL;
  1146			}
  1147	
  1148			acpi_db_trace_method_name =
  1149			    ACPI_ALLOCATE(strlen(method_arg) + 1);
  1150			if (!acpi_db_trace_method_name) {
  1151				acpi_os_printf("Failed to allocate method name (%s)\n",
  1152					       method_arg);
  1153				return;
  1154			}
  1155	
  1156			strcpy(acpi_db_trace_method_name, method_arg);
  1157		}
  1158	
  1159		if (!strcmp(enable_arg, "ENABLE") ||
                            ^^^^^^^^^^
Unchecked dereferences.

  1160		    !strcmp(enable_arg, "METHOD") || !strcmp(enable_arg, "OPCODE")) {
  1161			if (!strcmp(enable_arg, "ENABLE")) {

regards,
dan carpenter
