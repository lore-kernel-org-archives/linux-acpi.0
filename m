From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 2/9] ACPI: thinkpad-acpi: driver sysfs
	conversion
Date: Tue, 24 Apr 2007 11:48:13 -0300
Message-ID: <11774261003904-git-send-email-hmh@hmh.eng.br>
References: <11774261003184-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11774261003184-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add the sysfs attributes for the platform driver.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   42 +++++++++++++++++-
 drivers/misc/thinkpad_acpi.c    |   90 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/thinkpad_acpi.h    |    3 +
 3 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 0e4e053..cc079af 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -101,11 +101,39 @@ follow all sysfs guidelines and correctly process all errors (the sysfs
 interface makes extensive use of errors).  File descriptors and open /
 close operations to the sysfs inodes must also be properly implemented.
 
-Driver version -- /proc/acpi/ibm/driver
----------------------------------------
+The version of thinkpad-acpi's sysfs interface is exported by the driver
+as a driver attribute (see below).
+
+Sysfs driver attributes are on the driver's sysfs attribute space,
+for 2.6.20 this is /sys/bus/platform/drivers/thinkpad-acpi/.
+
+Sysfs device attributes are on the driver's sysfs attribute space,
+for 2.6.20 this is /sys/devices/platform/thinkpad-acpi/.
+
+Driver version
+--------------
+
+procfs: /proc/acpi/ibm/driver
+sysfs driver attribute: version
 
 The driver name and version. No commands can be written to this file.
 
+Sysfs interface version
+-----------------------
+
+sysfs driver attribute: interface_version
+
+Version of the thinkpad-acpi sysfs interface, as an unsigned long
+(output in hex format: 0xAAAABBCC), where:
+	AAAA - major revision
+	BB - minor revision
+	CC - bugfix revision
+
+The sysfs interface version changelog for the driver can be found at the
+end of this document.  Changes to the sysfs interface done by the kernel
+subsystems are not documented here, nor are they tracked by this
+attribute.
+
 Hot keys -- /proc/acpi/ibm/hotkey
 ---------------------------------
 
@@ -745,9 +773,19 @@ to enable more than one output class, just add their values.
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
 
+The level of debugging information output by the driver can be changed
+at runtime through sysfs, using the driver attribute debug_level.  The
+attribute takes the same bitmask as the debug module parameter above.
+
 Force loading of module
 -----------------------
 
 If thinkpad-acpi refuses to detect your ThinkPad, you can try to specify
 the module parameter force_load=1.  Regardless of whether this works or
 not, please contact ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org with a report.
+
+
+Sysfs interface changelog:
+
+0x000100:	Initial sysfs support, as a single platform driver and
+		device.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e47eaf7..a31d00d 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -22,6 +22,7 @@
  */
 
 #define IBM_VERSION "0.14"
+#define TPACPI_SYSFS_VERSION 0x000100
 
 /*
  *  Changelog:
@@ -493,6 +494,87 @@ static struct platform_driver tpacpi_pdriver = {
 };
 
 
+/*************************************************************************
+ * thinkpad-acpi driver attributes
+ */
+
+/* interface_version --------------------------------------------------- */
+static ssize_t tpacpi_driver_interface_version_show(
+				struct device_driver *drv,
+				char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", TPACPI_SYSFS_VERSION);
+}
+
+static DRIVER_ATTR(interface_version, S_IRUGO,
+		tpacpi_driver_interface_version_show, NULL);
+
+/* debug_level --------------------------------------------------------- */
+static ssize_t tpacpi_driver_debug_show(struct device_driver *drv,
+						char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", dbg_level);
+}
+
+static ssize_t tpacpi_driver_debug_store(struct device_driver *drv,
+						const char *buf, size_t count)
+{
+	unsigned long t;
+	char *endp;
+
+	t = simple_strtoul(buf, &endp, 0);
+	while (*endp && isspace(*endp))
+		endp++;
+	if (*endp)
+		return -EINVAL;
+
+	dbg_level = t;
+
+	return count;
+}
+
+static DRIVER_ATTR(debug_level, S_IWUSR | S_IRUGO,
+		tpacpi_driver_debug_show, tpacpi_driver_debug_store);
+
+/* version ------------------------------------------------------------- */
+static ssize_t tpacpi_driver_version_show(struct device_driver *drv,
+						char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s v%s\n", IBM_DESC, IBM_VERSION);
+}
+
+static DRIVER_ATTR(version, S_IRUGO,
+		tpacpi_driver_version_show, NULL);
+
+/* --------------------------------------------------------------------- */
+
+static struct driver_attribute* tpacpi_driver_attributes[] = {
+	&driver_attr_debug_level, &driver_attr_version,
+	&driver_attr_interface_version,
+};
+
+static int __init tpacpi_create_driver_attributes(struct device_driver *drv)
+{
+	int i, res;
+
+	i = 0;
+	res = 0;
+	while (!res && i < ARRAY_SIZE(tpacpi_driver_attributes)) {
+		res = driver_create_file(drv, tpacpi_driver_attributes[i]);
+		i++;
+	}
+
+	return res;
+}
+
+static void tpacpi_remove_driver_attributes(struct device_driver *drv)
+{
+	int i;
+
+	for(i = 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)
+		driver_remove_file(drv, tpacpi_driver_attributes[i]);
+}
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -3268,6 +3350,13 @@ static int __init thinkpad_acpi_module_init(void)
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+	ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
+	if (ret) {
+		printk(IBM_ERR "unable to create sysfs driver attributes\n");
+		thinkpad_acpi_module_exit();
+		return ret;
+	}
+
 
 	/* Device initialization */
 	tpacpi_pdev = platform_device_register_simple(IBM_DRVR_NAME, -1,
@@ -3318,6 +3407,7 @@ static void thinkpad_acpi_module_exit(void)
 	if (tpacpi_pdev)
 		platform_device_unregister(tpacpi_pdev);
 
+	tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
 	platform_driver_unregister(&tpacpi_pdriver);
 
 	if (proc_dir)
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index fea5809..3786058 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -32,6 +32,7 @@
 #include <linux/list.h>
 
 #include <linux/proc_fs.h>
+#include <linux/sysfs.h>
 #include <linux/backlight.h>
 #include <linux/fb.h>
 #include <linux/platform_device.h>
@@ -137,6 +138,8 @@ static char *next_cmd(char **cmds);
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
 static struct platform_driver tpacpi_pdriver;
+static int tpacpi_create_driver_attributes(struct device_driver *drv);
+static void tpacpi_remove_driver_attributes(struct device_driver *drv);
 
 /* Module */
 static int experimental;
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
