From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] acpi ec_sys: Export fields of all regions from the EC to debugfs readable (v2)
Date: Wed,  4 Aug 2010 15:53:07 +0200
Message-ID: <1280929987-10401-1-git-send-email-trenn@suse.de>
References: <20100730163053.bff43f26.akpm@linux-foundation.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20100730163053.bff43f26.akpm@linux-foundation.org>
Sender: platform-driver-x86-owner@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, mjg59@srcf.ucam.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, akpm@linux-foundation.org, hmh@hmh.eng.br
List-Id: linux-acpi@vger.kernel.org

>From the /sys/kernel/debug/ec/*/io file userspace can read and write EC byte
wise.
This patch introduces /sys/kernel/debug/ec/*/fields/* which exports all
fields of an Embedded Controller.
This has several advantages:
  - Shows defined EC registers (not as dangerous as accessing arbitrary ones)
  - Reads are done through the ACPI layer and may get accessed differently
    than reading blank bytes (burst mode).
  - People do not have to read the DSDT.dsl to map register names to EC fields

The patch has two unresolved isses:
  - Unfortunately write access does not work for fields, acpica is missing this
    capablity.
  - All EC region fields (also SystemMemory, IO, etc.) are shown which may not
    result in EC access. Ideally only the EC region fields are shown.
    -> again acpica does not let us differ this.

Recent changes (v2):
  - Return -EPERM if process has not CAP_SYS_RAWIO capability
  - Do allow parallel access to EC files for stress testing ec.c driver
    (instead of returning -EBUSY which was brought up akpm)
  - Minor change in Kconfig description
    Do not mention that EC is only accessed via ACPI interpreted code which
    is not true for some native laptop driver hacks.
  - Fix write_support file creation: mode and .write callback function, both
    must be set (or removed) appropriately.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: mjg59@srcf.ucam.org
CC: platform-driver-x86@vger.kernel.org
CC: linux-acpi@vger.kernel.org
CC: astarikovskiy@suse.de
CC: akpm@linux-foundation.org
CC: hmh@hmh.eng.br
---
 Documentation/ABI/testing/debugfs-ec |   38 +++++++++-
 drivers/acpi/Kconfig                 |    6 +-
 drivers/acpi/ec_sys.c                |  131 +++++++++++++++++++++++++++++++---
 drivers/acpi/internal.h              |    3 +
 4 files changed, 163 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-ec b/Documentation/ABI/testing/debugfs-ec
index 6546115..6bd5222 100644
--- a/Documentation/ABI/testing/debugfs-ec
+++ b/Documentation/ABI/testing/debugfs-ec
@@ -1,14 +1,21 @@
-What:		/sys/kernel/debug/ec/*/{gpe,use_global_lock,io}
+What:		/sys/kernel/debug/ec/*/{gpe,use_global_lock,io,field/*}
 Date:		July 2010
 Contact:	Thomas Renninger <trenn@suse.de>
 Description:
 
+files: gpe, use_global_lock
+---------------------------
+
 General information like which GPE is assigned to the EC and whether
 the global lock should get used.
-Knowing the EC GPE one can watch the amount of HW events related to
+Knowing the EC GPE, one can watch the amount of HW events related to
 the EC here (XY -> GPE number from /sys/kernel/debug/ec/*/gpe):
 /sys/firmware/acpi/interrupts/gpeXY
 
+
+file: io
+--------
+
 The io file is binary and a userspace tool located here:
 ftp://ftp.suse.com/pub/people/trenn/sources/ec/
 should get used to read out the 256 Embedded Controller registers
@@ -18,3 +25,30 @@ CAUTION: Do not write to the Embedded Controller if you don't know
 what you are doing! Rebooting afterwards also is a good idea.
 This can influence the way your machine is cooled and fans may
 not get switched on again after you did a wrong write.
+
+
+files: fields/*
+---------------
+
+Shows EC register fields as defined in the EmbeddedController object of the
+DSDT.
+Reads are done through the ACPI layer and may get accessed differently than
+reading blank bytes through the io file (e.g. with burst mode enabled).
+People can read the DSDT.dsl to map register names to EC fields, but with the
+names displayed this should not be necessary anymore.
+
+Typical EC region definition:
+                    OperationRegion (ECRM, EmbeddedControl, 0x00, 0xFF)
+                    Field (ECRM, ByteAcc, NoLock, Preserve)
+                    {
+                        S0PW,   32,
+                        S0CT,   32,
+                                Offset (0x80),
+                        FNSW,   1,
+                        ...
+                    }
+
+Reading /sys/../ec/*/fields/SOPW will read the first 4 bytes of the EC and
+display it.
+Reading /sys/../ec/*/fields/FNSW will read one byte at offset 0x80 and mask out
+ 7 bits and return a bit value (FNSW is defined as a one bit field).
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 08e0140..490eeef 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -116,9 +116,9 @@ config ACPI_EC_DEBUGFS
 	  some seconds.
 	  An Embedded Controller typically is available on laptops and reads
 	  sensor values like battery state and temperature.
-	  The kernel accesses the EC through ACPI parsed code provided by BIOS
-	  tables. This option allows to access the EC directly without ACPI
-	  code being involved.
+	  This option allows to access the EC directly without ACPI code being
+	  involved (io file) or by calling the ACPI interpreter and access EC
+	  ACPI field objects (field files, read-only).
 	  Thus this option is a debug option that helps to write ACPI drivers
 	  and can be used to identify ACPI code or EC firmware bugs.
 
diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index 0e869b3..2be0066 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -6,11 +6,19 @@
  *      Thomas Renninger <trenn@suse.de>
  *
  * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * Ideally this would not be a separate driver, but hook into the
+ * .add function of the ec.c driver.
+ * But the ec.c driver must be compiled in and it's essential that
+ * this debug module can be loaded at runtime.
+ * The driver relies on the fact that an ACPI EC object can
+ * never vanish at runtime.
  */
 
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/debugfs.h>
+#include <linux/capability.h>
 #include "internal.h"
 
 MODULE_AUTHOR("Thomas Renninger <trenn@suse.de>");
@@ -30,10 +38,11 @@ struct sysdev_class acpi_ec_sysdev_class = {
 
 static struct dentry *acpi_ec_debugfs_dir;
 
-static int acpi_ec_open_io(struct inode *i, struct file *f)
+static int acpi_ec_open(struct inode *i, struct file *f)
 {
 	f->private_data = i->i_private;
-	return 0;
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
 }
 
 static ssize_t acpi_ec_read_io(struct file *f, char __user *buf,
@@ -96,18 +105,107 @@ static ssize_t acpi_ec_write_io(struct file *f, const char __user *buf,
 	return count;
 }
 
+#ifdef ACPICA_CAN_DO_FIELD_WRITES
+/* ACPICA currently does not provide a function to write to field
+   objects */
+static ssize_t acpi_ec_write_field(struct file *f, const char __user *buf,
+				   size_t count, loff_t *off)
+{
+	struct acpi_ec *ec = f->private_data;
+	char name[5];
+	union acpi_object arg0 = { .type = ACPI_TYPE_INTEGER };
+	struct acpi_object_list arg_list = { 1, &arg0 };
+	acpi_status status;
+
+	if (*off > 0)
+		return -EINVAL;
+
+	strncpy(name, f->f_dentry->d_name.name, 5);
+
+	if (strict_strtoll(buf, 0, &arg0.integer.value))
+		return -EINVAL;
+
+	/* This does not work, only real methods can be evaluted
+	   with an arguement */
+	status = acpi_evaluate_object(ec->handle, name, &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+	*off = count;
+	return count;
+}
+#endif
+
+static ssize_t acpi_ec_read_field(struct file *f, char __user *buf,
+				  size_t count, loff_t *off)
+{
+	struct acpi_ec *ec = f->private_data;
+	char name[5];
+	unsigned long long value;
+	acpi_status status;
+
+	if (*off > 0)
+		return 0;
+	strncpy(name, f->f_dentry->d_name.name, 5);
+
+	status = acpi_evaluate_integer(ec->handle, name, NULL, &value);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	count = *off = sprintf(buf, "0x%llx\n", value);
+	if (!*off)
+		return -EINVAL;
+	return count;
+}
+
 static struct file_operations acpi_ec_io_ops = {
-	.owner = THIS_MODULE,
-	.open  = acpi_ec_open_io,
-	.read  = acpi_ec_read_io,
-	.write = acpi_ec_write_io,
+	.owner		= THIS_MODULE,
+	.open		= acpi_ec_open,
+	.read		= acpi_ec_read_io,
+};
+
+static struct file_operations acpi_ec_field_ops = {
+	.owner		= THIS_MODULE,
+	.open		= acpi_ec_open,
+	.llseek		= no_llseek,
+	.read		= acpi_ec_read_field,
 };
 
+static acpi_status acpi_ec_find_fields(acpi_handle handle, u32 level,
+				       void *context, void **return_value)
+{
+	char node_name[5];
+	struct acpi_buffer buffer = { sizeof(node_name), node_name };
+	struct acpi_ec *ec = context;
+	acpi_status status;
+	mode_t mode = 0400;
+
+#ifdef ACPICA_CAN_DO_FIELD_WRITES
+	if (write_support) {
+		mode = 0600;
+		acpi_ec_field_ops.write = acpi_ec_write_field;
+	}
+#endif
+
+	status = acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+	if (ACPI_SUCCESS(status)) {
+		if (!debugfs_create_file(node_name, mode, ec->field_dir,
+					 ec, &acpi_ec_field_ops))
+			return AE_ERROR;
+	}
+	return AE_OK;
+}
+
 int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
 {
-	struct dentry *dev_dir;
+	struct dentry *dev_dir, *field_dir;
 	char name[64];
 	mode_t mode = 0400;
+	acpi_status status;
+
+	if (write_support) {
+		mode = 0600;
+		acpi_ec_io_ops.write = acpi_ec_write_io;
+	}
 
 	if (ec_device_count == 0) {
 		acpi_ec_debugfs_dir = debugfs_create_dir("ec", NULL);
@@ -129,13 +227,26 @@ int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
 				 (u32 *)&first_ec->global_lock))
 		goto error;
 
-	if (write_support)
-		mode = 0600;
 	if (!debugfs_create_file("io", mode, dev_dir, ec, &acpi_ec_io_ops))
 		goto error;
+	/*
+	 * Find and register all fields. For now we do not differ
+	 * EmbeddedController operation region fields because acpica does not
+	 * allow us to do that. So some fields may result in system memory,
+	 * io port,.. and not EC accesses.
+	 */
+	field_dir = debugfs_create_dir("fields", dev_dir);
+	if (!field_dir)
+		goto error;
+	ec->field_dir = field_dir;
 
-	return 0;
+	status = acpi_walk_namespace(ACPI_TYPE_LOCAL_REGION_FIELD, ec->handle,
+				     1, acpi_ec_find_fields, NULL, ec,
+				     NULL);
+	if (ACPI_FAILURE(status))
+		goto error;
 
+	return 0;
 error:
 	debugfs_remove_recursive(acpi_ec_debugfs_dir);
 	return -ENOMEM;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 8ae2726..14d1bab 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -64,6 +64,9 @@ struct acpi_ec {
 	struct transaction *curr;
 	spinlock_t curr_lock;
 	struct sys_device sysdev;
+#if defined CONFIG_ACPI_EC_DEBUGFS || defined CONFIG_ACPI_EC_DEBUGFS_MODULE
+	struct dentry *field_dir;
+#endif
 };
 
 extern struct acpi_ec *first_ec;
-- 
1.6.3
