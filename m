From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: support customizing ACPI control methods at runtime
Date: Wed, 02 Dec 2009 13:31:00 +0800
Message-ID: <1259731860.2029.1221.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39048 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbZLBFal (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2009 00:30:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Thomas Renninger <trenn@suse.de>


Introduce a new debugfs I/F (/sys/kernel/debug/acpi/custom_method) for ACPI,
which can be used to customize the ACPI control methods at runtime.

We can use this to debug the AML code level bugs instead of overriding the
whole DSDT table, without rebuilding/rebooting kernel any more.

Detailed description about how to use this debugfs I/F is stated in
Documentation/acpi/method-customizing.txt

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/acpi/method-customizing.txt |   66 +++++++++++++++++++++++
 drivers/acpi/debug.c                      |   84 +++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/debug.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debug.c
+++ linux-2.6/drivers/acpi/debug.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
+#include <linux/debugfs.h>
 #include <asm/uaccess.h>
 #include <acpi/acpi_drivers.h>
 
@@ -196,6 +197,79 @@ module_param_call(trace_state, param_set
 		  NULL, 0644);
 
 /* --------------------------------------------------------------------------
+				DebugFS Interface
+   -------------------------------------------------------------------------- */
+
+static ssize_t cm_write(struct file *file, const char __user *user_buf,
+			size_t count, loff_t *ppos)
+{
+	static char *buf;
+	static int uncopied_bytes;
+	struct acpi_table_header table;
+	acpi_status status;
+
+	if (!(*ppos)) {
+		/* parse the table header to get the table length */
+		if (count <= sizeof(struct acpi_table_header))
+			return -EINVAL;
+		if (copy_from_user(&table, user_buf,
+			sizeof(struct acpi_table_header)))
+			return -EFAULT;
+		uncopied_bytes = table.length;
+		buf = kzalloc(uncopied_bytes, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+	}
+
+	if (uncopied_bytes < count) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(buf + (*ppos), user_buf, count)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	uncopied_bytes -= count;
+	*ppos += count;
+
+	if (!uncopied_bytes) {
+		status = acpi_install_method(buf);
+		kfree(buf);
+		if (ACPI_FAILURE(status))
+			return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations cm_fops = {
+	.write = cm_write,
+};
+
+static int acpi_debugfs_init(void)
+{
+	struct dentry *acpi_dir, *cm_dentry;
+
+	acpi_dir = debugfs_create_dir("acpi", NULL);
+	if (!acpi_dir)
+		goto err;
+
+	cm_dentry = debugfs_create_file("custom_method", S_IWUGO,
+					acpi_dir, NULL, &cm_fops);
+	if (!cm_dentry)
+		goto err;
+
+	return 0;
+
+err:
+	if (acpi_dir)
+		debugfs_remove(acpi_dir);
+	return -EINVAL;
+}
+
+/* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_PROCFS
@@ -286,7 +360,7 @@ static const struct file_operations acpi
 };
 #endif
 
-int __init acpi_debug_init(void)
+int __init acpi_procfs_init(void)
 {
 #ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *entry;
@@ -321,3 +395,11 @@ int __init acpi_debug_init(void)
 	return 0;
 #endif
 }
+
+int __init acpi_debug_init(void)
+{
+	acpi_debugfs_init();
+	acpi_procfs_init();
+	return 0;
+}
+
Index: linux-2.6/Documentation/acpi/method-customizing.txt
===================================================================
--- /dev/null
+++ linux-2.6/Documentation/acpi/method-customizing.txt
@@ -0,0 +1,66 @@
+Linux ACPI Custom Control Method How To
+=======================================
+
+Written by Zhang Rui <rui.zhang@intel.com>
+
+
+Linux supports customizing ACPI control methods at runtime.
+
+Users can use this to
+1. override an existing method which may not work correctly,
+   or just for debugging purposes.
+2. insert a completely new method in order to create a missing
+   method such as _OFF, _ON, _STA, _INI, etc.
+For these cases, it is far simpler to dynamically install a single
+control method rather than override the entire DSDT, because kernel
+rebuild/reboot is not needed and test result can be got in minutes.
+
+Note: Only ACPI METHOD can be overridden, any other object types like
+      "Device", "OperationRegion", are not recognized.
+Note: The same ACPI control method can be overridden for many times,
+      and it's always the latest one that used by Linux/kernel.
+
+1. override an existing method
+   a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
+      just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
+   b) disassemble the table by running "iasl -d dsdt.dat".
+   c) rewrite the ASL code of the method and save it in a new file,
+   d) package the new file (psr.asl) to an ACPI table format.
+      Here is an example of a customized \_SB._AC._PSR method,
+
+      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
+      {
+	External (ACON)
+
+	Method (\_SB_.AC._PSR, 0, NotSerialized)
+	{
+		Store ("In AC _PSR", Debug)
+		Return (ACON)
+	}
+      }
+      Note that the full pathname of the method in ACPI namespace
+      should be used.
+      And remember to use "External" to declare external objects.
+   e) assemble the file to generate the AML code of the method.
+      e.g. "iasl psr.asl" (psr.aml is generated as a result)
+   f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
+   g) override the old method via the debugfs by running
+      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
+
+2. insert a new method
+   This is easier than overriding an existing method.
+   We just need to create the ASL code of the method we want to
+   insert and then follow the step c) ~ g) in section 1.
+
+3. undo your changes
+   The "undo" operation is not supported for a new inserted method
+   right now, i.e. we can not remove a method currently.
+   For an overrided method, in order to undo your changes, please
+   save a copy of the method original ASL code in step c) section 1,
+   and redo step c) ~ g) to override the method with the original one.
+
+
+Note: We can use a kernel with multiple custom ACPI method running,
+      But each individual write to debugfs can implement a SINGLE
+      method override. i.e. if we want to insert/override multiple
+      ACPI methods, we need to redo step c) ~ g) for multiple times.


