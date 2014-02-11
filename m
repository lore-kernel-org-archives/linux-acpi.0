From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2] ACPI: Add boot option to disable auto return object repair
Date: Tue, 11 Feb 2014 11:01:52 +0800
Message-ID: <1bba8193d622f38910791aad3ab195488e020bed.1370438773.git.lv.zheng@intel.com>
References: <bb948470a76cb84d51a586e3e85ae68cb80b1ee9.1369127269.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12788 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbaBKDB7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Feb 2014 22:01:59 -0500
In-Reply-To: <bb948470a76cb84d51a586e3e85ae68cb80b1ee9.1369127269.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Sometimes, there might be bugs caused by unexpected AML which is compliant
to the Windows but not compliant to the Linux implementation.

There is a predefined validation mechanism implemented in ACPICA to repair
the unexpected AML evaluation results that are caused by the unexpected
AMLs.  For example, BIOS may return misorder _CST result and the repair
mechanism can make an ascending order on the returned _CST package object
based on the C-state type.
This mechanism is quite useful to implement an AML interpreter with better
compliance with the real world where Windows is the de-facto standard and
BIOS codes are only tested on one platform thus not compliant to the
ACPI specification.

But if a compliance issue hasn't been figured out yet, it will be
difficult for developers to identify if the unexpected evaluation result
is caused by this mechanism or by the AML interpreter.
For example, _PR0 is expected to be a control method, but BIOS may use
Package: "Name(_PR0, Package(1) {P1PR})".
This boot option can disable the predefined validation mechanism so that
developers can make sure the root cause comes from the parser/executer.

This patch adds a new kernel parameter to disable this feature.

A build test has been made on a Dell Inspiron mini 1100 (i386 z530)
machine when this patch is applied and the corresponding boot test is
performed w/ or w/o the new kernel parameter specified.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=67901
Tested-by: Fabian Wehning <fabian.wehning@googlemail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/osl.c                  |   11 +++++++++++
 2 files changed, 16 insertions(+)

Index: linux-acpica/Documentation/kernel-parameters.txt
===================================================================
--- linux-acpica.orig/Documentation/kernel-parameters.txt
+++ linux-acpica/Documentation/kernel-parameters.txt
@@ -231,6 +231,14 @@ bytes respectively. Such letter suffixes
 
 	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT
 
+	acpica_no_return_repair [HW, ACPI]
+			Disable AML predefined validation mechanism
+			This mechanism can repair the evaluation result to make
+			the return objects more ACPI specification compliant.
+			This option is useful for developers to identify the
+			root cause of an AML interpreter issue when the issue
+			has something to do with the repair mechanism.
+
 	acpi_os_name=	[HW,ACPI] Tell ACPI BIOS the name of the OS
 			Format: To spoof as Windows 98: ="Microsoft Windows"
 
Index: linux-acpica/drivers/acpi/osl.c
===================================================================
--- linux-acpica.orig/drivers/acpi/osl.c
+++ linux-acpica/drivers/acpi/osl.c
@@ -1774,6 +1774,17 @@ static int __init acpi_no_auto_ssdt_setu
 
 __setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
 
+static int __init acpi_disable_return_repair(char *s)
+{
+	printk(KERN_NOTICE PREFIX
+	       "ACPI: Predefined validation mechanism disabled\n");
+	acpi_gbl_disable_auto_repair = TRUE;
+
+	return 1;
+}
+
+__setup("acpica_no_return_repair", acpi_disable_return_repair);
+
 acpi_status __init acpi_os_initialize(void)
 {
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
