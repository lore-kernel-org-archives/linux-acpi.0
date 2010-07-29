From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] acpi ec_sys: Be more cautious about ec write access
Date: Thu, 29 Jul 2010 22:08:45 +0200
Message-ID: <1280434125-11943-3-git-send-email-trenn@suse.de>
References: <1280434125-11943-1-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1280434125-11943-1-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, akpm@linux-foundation.org, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

- Set Kconfig option default n
- Only allow root to read/write io file (sever bug!)
- Introduce write support module param -> default off
- Properly clean up if any debugfs files cannot be created

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: mjg59@srcf.ucam.org
CC: platform-driver-x86@vger.kernel.org
CC: linux-acpi@vger.kernel.org
CC: astarikovskiy@suse.de
---
 drivers/acpi/Kconfig  |   11 ++++++++---
 drivers/acpi/ec_sys.c |   30 +++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f7226d1..08e0140 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -106,14 +106,19 @@ config ACPI_SYSFS_POWER
 
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
-	default y
+	default n
 	help
 	  Say N to disable Embedded Controller /sys/kernel/debug interface
 
+	  Be aware that using this interface can confuse your Embedded
+	  Controller in a way that a normal reboot is not enough. You then
+	  have to power of your system, and remove the laptop battery for
+	  some seconds.
 	  An Embedded Controller typically is available on laptops and reads
 	  sensor values like battery state and temperature.
-	  The kernel access the EC through ACPI parsed code provided by BIOS
-	  tables.
+	  The kernel accesses the EC through ACPI parsed code provided by BIOS
+	  tables. This option allows to access the EC directly without ACPI
+	  code being involved.
 	  Thus this option is a debug option that helps to write ACPI drivers
 	  and can be used to identify ACPI code or EC firmware bugs.
 
diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index 3ef9781..9a319f3 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -17,6 +17,11 @@ MODULE_AUTHOR("Thomas Renninger <trenn@suse.de>");
 MODULE_DESCRIPTION("ACPI EC sysfs access driver");
 MODULE_LICENSE("GPL");
 
+static bool write_support;
+module_param(write_support, bool, 0644);
+MODULE_PARM_DESC(write_support, "Dangerous, reboot and removal of battery may "
+		 "be needed.");
+
 #define EC_SPACE_SIZE 256
 
 struct sysdev_class acpi_ec_sysdev_class = {
@@ -102,6 +107,7 @@ int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
 {
 	struct dentry *dev_dir;
 	char name[64];
+
 	if (ec_device_count == 0) {
 		acpi_ec_debugfs_dir = debugfs_create_dir("ec", NULL);
 		if (!acpi_ec_debugfs_dir)
@@ -111,17 +117,27 @@ int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
 	sprintf(name, "ec%u", ec_device_count);
 	dev_dir = debugfs_create_dir(name, acpi_ec_debugfs_dir);
 	if (!dev_dir) {
-		if (ec_device_count == 0)
-			debugfs_remove_recursive(acpi_ec_debugfs_dir);
-		/* TBD: Proper cleanup for multiple ECs */
+		if (ec_device_count != 0)
+			goto error;
 		return -ENOMEM;
 	}
 
-	debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe);
-	debugfs_create_bool("use_global_lock", 0444, dev_dir,
-			    (u32 *)&first_ec->global_lock);
-	debugfs_create_file("io", 0666, dev_dir, ec, &acpi_ec_io_ops);
+	if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
+		goto error;
+	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
+				 (u32 *)&first_ec->global_lock))
+		goto error;
+
+	if (!write_support)
+		acpi_ec_io_ops.write = NULL;
+	if (!debugfs_create_file("io", 0600, dev_dir, ec, &acpi_ec_io_ops))
+		goto error;
+
 	return 0;
+
+error:
+	debugfs_remove_recursive(acpi_ec_debugfs_dir);
+	return -ENOMEM;
 }
 
 static int __init acpi_ec_sys_init(void)
-- 
1.6.3
