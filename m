From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/4 V2] ACPI: introduce module parameter acpi.aml_debug
Date: Sat, 12 Jun 2010 15:46:30 +0800
Message-ID: <1276328790.19052.17845.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40501 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab0FLHqI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jun 2010 03:46:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Moore, Robert" <robert.moore@intel.com>



Introduce module parameter acpi.aml_debug.

With acpi.aml_debug set, we can get AML debug object output
(Store (AAA, Debug)), even with CONFIG_ACPI_DEBUG cleared.

Together with the runtime custom method mechanism,
we can debug AML code problems without rebuilding the kernel.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/acpi/method-customizing.txt |    2 ++
 drivers/acpi/debugfs.c                    |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

Index: linux-2.6/drivers/acpi/debugfs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debugfs.c
+++ linux-2.6/drivers/acpi/debugfs.c
@@ -9,6 +9,27 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debugfs");
 
+static int param_set_aml_debug(const char *val, struct kernel_param *kp)
+{
+	if (!strncmp(val, "1\n", 2))
+		acpi_gbl_enable_aml_debug_object = 1;
+	else if (!strncmp(val, "0\n", 2))
+		acpi_gbl_enable_aml_debug_object = 0;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int param_get_aml_debug(char *buffer, struct kernel_param *kp)
+{
+	if (acpi_gbl_enable_aml_debug_object)
+		return sprintf(buffer, "1");
+	else
+		return sprintf(buffer, "0");
+}
+
+module_param_call(aml_debug, param_set_aml_debug, param_get_aml_debug, NULL, 0644);
 /* --------------------------------------------------------------------------
 				DebugFS Interface
    -------------------------------------------------------------------------- */
Index: linux-2.6/Documentation/acpi/method-customizing.txt
===================================================================
--- linux-2.6.orig/Documentation/acpi/method-customizing.txt
+++ linux-2.6/Documentation/acpi/method-customizing.txt
@@ -19,6 +19,8 @@ Note: Only ACPI METHOD can be overridden
       "Device", "OperationRegion", are not recognized.
 Note: The same ACPI control method can be overridden for many times,
       and it's always the latest one that used by Linux/kernel.
+Note: To get the ACPI debug object output (Store (AAAA, Debug)),
+      please run "echo 1 > /sys/module/acpi/parameters/aml_debug".
 
 1. override an existing method
    a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,


