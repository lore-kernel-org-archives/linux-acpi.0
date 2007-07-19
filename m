From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 09/23] ACPI: thinkpad-acpi: register input
	device
Date: Wed, 18 Jul 2007 23:45:34 -0300
Message-ID: <1184813150184-git-send-email-hmh@hmh.eng.br>
References: <11848131483573-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11848131483573-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Register an input device to send input events to userspace.

This patch is based on a patch by Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   32 +++++++++++++++++++++++++++++++-
 drivers/misc/thinkpad_acpi.h |    9 +++++++++
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4d71893..4427c99 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -510,13 +510,14 @@ static char *next_cmd(char **cmds)
 /****************************************************************************
  ****************************************************************************
  *
- * Device model: hwmon and platform
+ * Device model: input, hwmon and platform
  *
  ****************************************************************************
  ****************************************************************************/
 
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
+static struct input_dev *tpacpi_inputdev;
 
 static struct platform_driver tpacpi_pdriver = {
 	.driver = {
@@ -4363,6 +4364,20 @@ static int __init thinkpad_acpi_module_init(void)
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+	tpacpi_inputdev = input_allocate_device();
+	if (!tpacpi_inputdev) {
+		printk(IBM_ERR "unable to allocate input device\n");
+		thinkpad_acpi_module_exit();
+		return -ENOMEM;
+	} else {
+		/* Prepare input device, but don't register */
+		tpacpi_inputdev->name = "ThinkPad Extra Buttons";
+		tpacpi_inputdev->phys = IBM_DRVR_NAME "/input0";
+		tpacpi_inputdev->id.bustype = BUS_HOST;
+		tpacpi_inputdev->id.vendor = TPACPI_HKEY_INPUT_VENDOR;
+		tpacpi_inputdev->id.product = TPACPI_HKEY_INPUT_PRODUCT;
+		tpacpi_inputdev->id.version = TPACPI_HKEY_INPUT_VERSION;
+	}
 	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
 		ret = ibm_init(&ibms_init[i]);
 		if (ret >= 0 && *ibms_init[i].param)
@@ -4372,6 +4387,14 @@ static int __init thinkpad_acpi_module_init(void)
 			return ret;
 		}
 	}
+	ret = input_register_device(tpacpi_inputdev);
+	if (ret < 0) {
+		printk(IBM_ERR "unable to register input device\n");
+		thinkpad_acpi_module_exit();
+		return ret;
+	} else {
+		tp_features.input_device_registered = 1;
+	}
 
 	return 0;
 }
@@ -4388,6 +4411,13 @@ static void thinkpad_acpi_module_exit(void)
 
 	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
 
+	if (tpacpi_inputdev) {
+		if (tp_features.input_device_registered)
+			input_unregister_device(tpacpi_inputdev);
+		else
+			input_free_device(tpacpi_inputdev);
+	}
+
 	if (tpacpi_hwmon)
 		hwmon_device_unregister(tpacpi_hwmon);
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 78ea4c8..00f1bd7 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -39,6 +39,7 @@
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/input.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -48,6 +49,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acnamesp.h>
 
+#include <linux/pci_ids.h>
 
 /****************************************************************************
  * Main driver
@@ -98,6 +100,11 @@ static const char *str_supported(int is_supported);
 #define vdbg_printk(a_dbg_level, format, arg...)
 #endif
 
+/* Input IDs */
+#define TPACPI_HKEY_INPUT_VENDOR	PCI_VENDOR_ID_IBM
+#define TPACPI_HKEY_INPUT_PRODUCT	0x5054 /* "TP" */
+#define TPACPI_HKEY_INPUT_VERSION	0x4101
+
 /* ACPI HIDs */
 #define IBM_HKEY_HID    "IBM0068"
 #define IBM_PCI_HID     "PNP0A03"
@@ -161,6 +168,7 @@ static int parse_strtoul(const char *buf, unsigned long max,
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
 static struct platform_driver tpacpi_pdriver;
+static struct input_dev *tpacpi_inputdev;
 static int tpacpi_create_driver_attributes(struct device_driver *drv);
 static void tpacpi_remove_driver_attributes(struct device_driver *drv);
 
@@ -233,6 +241,7 @@ static struct {
 	u16 light_status:1;
 	u16 wan:1;
 	u16 fan_ctrl_status_undef:1;
+	u16 input_device_registered:1;
 } tp_features;
 
 static struct list_head tpacpi_all_drivers;
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
