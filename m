From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH] ACPI: support overriding an ACPI control method at
 runtime
Date: Wed, 25 Nov 2009 17:01:18 +0800
Message-ID: <1259139678.10510.59.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26247 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934446AbZKYJCd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 04:02:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>


Introduce a new debugfs I/F (/sys/kernel/debug/acpi/custom_method)for ACPI,
which can be used to override an ACPI control method at runtime.

We can use this to debug the AML code level bugs instead of overriding the
whole DSDT table, without rebuilding/rebooting kernel any more.

Detailed description about how to use this debugfs I/F is stated in
Documentation/acpi/method-override.txt

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/acpi/method_override.txt |   59 +++++++++++++++++++++++
 drivers/acpi/debug.c                   |   84 ++++++++++++++++++++++++++++++++-
 2 files changed, 142 insertions(+), 1 deletion(-)

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
Index: linux-2.6/Documentation/acpi/method_override.txt
===================================================================
--- /dev/null
+++ linux-2.6/Documentation/acpi/method_override.txt
@@ -0,0 +1,59 @@
+Linux ACPI Custom Control Method How To
+=======================================
+
+Written by Zhang Rui <rui.zhang@intel.com>
+
+
+Now Linux supports overriding an ACPI control method at runtime
+and users can use this instead of custom DSDT in most cases.
+
+This makes the AML code level debugging much easier,
+because kernel rebuild/reboot is not needed any more
+and the test results can be gotten in minutes.
+
+In order to make full use of this new debug method, here are the
+steps that should be followed by both users(bug reporters) and
+ACPI developers (ACPI bugzilla maintainers):
+
+1. users get the ACPI table AML code via /sys/firmware/acpi/tables,
+   and send them to ACPI developers
+2. ACPI developers disassemble the table and see if there are any
+   buggy methods
+3. ACPI developers edit the ASL code of the ACPI control method
+   that we want to override and save it in a new file
+4. ACPI developers package the new file to a SSDT table format
+5. ACPI developers assemble this file to generate the AML code of
+   the custom control method and send them to users
+6. users mount debugfs
+7. users test the custom ACPI control method via the debugfs
+8. users send the test results to ACPI developers.
+
+Here is an example about how I use it to override \_SB._AC._PSR,
+1. cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat
+2. cd /tmp
+3. iasl -d dsdt.dat
+4. copy the ASL code of \_SB._AC._PSR and paste it in a new file,
+   say psr.asl
+5. edit, save and package it to an ACPI table and here is the
+   output of "cat psr.asl"
+
+DefinitionBlock ("psr.aml", "SSDT", 1, "Sony", "VAIO", 0x20080715)
+{
+            Method (\_SB_.AC._PSR, 0, NotSerialized)
+            {
+                Store ("In AC _PSR", Debug)
+                Return (One)
+            }
+}
+
+6. iasl psr.asl (psr.aml is generated as a result of this step)
+7. mount -t debugfs none /sys/kernel/debug
+8. cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method
+9. now the _PSR always returns 1, together with an ACPI Debug message.
+
+Note: Only ACPI METHOD can be overriden, any other object types like
+      "Device", "OperationRegion", are not recognized.
+Note: Only ONE ACPI method is overriden at a time. If an ACPI table
+      with multiple ACPI methods is sent to kernel, there are no
+      error message. Only the first method is actually overriden,
+      and any other methods in this table are ignored.


