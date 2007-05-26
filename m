From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH] ACPI: thinkpad-acpi: register input device
Date: Sat, 26 May 2007 14:31:02 -0300
Message-ID: <11802006651698-git-send-email-hmh@hmh.eng.br>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11802004861625-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, dtor-JGs/UdohzUI@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Register an input device to send input events to userspace.

This patch is based on a patch by Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   31 +++++++++++++++++++++++++++++--
 drivers/misc/thinkpad_acpi.h |    3 +++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e1c84e3..c0b8155 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -487,13 +487,14 @@ static char *next_cmd(char **cmds)
 /****************************************************************************
  ****************************************************************************
  *
- * Device model: hwmon and platform
+ * Device model: input, hwmon and platform
  *
  ****************************************************************************
  ****************************************************************************/
 
 static struct platform_device *tpacpi_pdev = NULL;
 static struct class_device *tpacpi_hwmon = NULL;
+static struct input_dev *tpacpi_inputdev = NULL;
 
 static struct platform_driver tpacpi_pdriver = {
 	.driver = {
@@ -3883,7 +3884,6 @@ static struct proc_dir_entry *proc_dir = NULL;
 /* Subdriver registry */
 static LIST_HEAD(tpacpi_all_drivers);
 
-
 /*
  * Module and infrastructure proble, init and exit handling
  */
@@ -4266,6 +4266,18 @@ static int __init thinkpad_acpi_module_init(void)
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
+		tpacpi_inputdev->phys = "thinkpad/input0";
+		tpacpi_inputdev->id.bustype = BUS_HOST;
+		tpacpi_inputdev->id.product = 0x0001;
+	}
 	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
 		ret = ibm_init(&ibms_init[i]);
 		if (ret >= 0 && *ibms_init[i].param)
@@ -4275,6 +4287,14 @@ static int __init thinkpad_acpi_module_init(void)
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
@@ -4291,6 +4311,13 @@ static void thinkpad_acpi_module_exit(void)
 
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
index 72d62f2..8c0a0db 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -39,6 +39,7 @@
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/input.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -161,6 +162,7 @@ static int parse_strtoul(const char *buf, unsigned long max,
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
 static struct platform_driver tpacpi_pdriver;
+static struct input_dev *tpacpi_inputdev;
 static int tpacpi_create_driver_attributes(struct device_driver *drv);
 static void tpacpi_remove_driver_attributes(struct device_driver *drv);
 
@@ -232,6 +234,7 @@ static struct {
 	u16 light_status:1;
 	u16 wan:1;
 	u16 fan_ctrl_status_undef:1;
+	u16 input_device_registered:1;
 } tp_features;
 
 static struct list_head tpacpi_all_drivers;
-- 
1.5.1.6


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
