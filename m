From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 3/6] ACPI: ibm-acpi: add header file
Date: Sun, 11 Mar 2007 21:20:46 -0300
Message-ID: <11736588493502-git-send-email-hmh@hmh.eng.br>
References: <11736588493609-git-send-email-hmh@hmh.eng.br>
	<11736588493322-git-send-email-hmh@hmh.eng.br>
	<11736588491476-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11736588491476-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add a (private) header file for ibm-acpi, and move type definitions and
ThinkPad driver constants to the new header file.

This patch has no functional changes.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/acpi/ibm_acpi.c |  137 +---------------
 drivers/acpi/ibm_acpi.h |  437 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 438 insertions(+), 136 deletions(-)
 create mode 100644 drivers/acpi/ibm_acpi.h

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 3363eda..59cbafc 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -78,44 +78,13 @@
  *  2004-08-09	0.1	initial release, support for X series
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/string.h>
-
-#include <linux/proc_fs.h>
-#include <linux/backlight.h>
-#include <linux/fb.h>
-#include <asm/uaccess.h>
-
-#include <linux/dmi.h>
-#include <linux/jiffies.h>
-#include <linux/workqueue.h>
-
-#include <acpi/acpi_drivers.h>
-#include <acpi/acnamesp.h>
-
-#define IBM_NAME "ibm"
-#define IBM_DESC "IBM ThinkPad ACPI Extras"
-#define IBM_FILE "ibm_acpi"
-#define IBM_URL "http://ibm-acpi.sf.net/"
+#include "ibm_acpi.h"
 
 MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
 MODULE_DESCRIPTION(IBM_DESC);
 MODULE_VERSION(IBM_VERSION);
 MODULE_LICENSE("GPL");
 
-#define IBM_DIR IBM_NAME
-
-#define IBM_LOG IBM_FILE ": "
-#define IBM_ERR	   KERN_ERR    IBM_LOG
-#define IBM_NOTICE KERN_NOTICE IBM_LOG
-#define IBM_INFO   KERN_INFO   IBM_LOG
-#define IBM_DEBUG  KERN_DEBUG  IBM_LOG
-
-#define IBM_MAX_ACPI_ARGS 3
-
 #define __unused __attribute__ ((unused))
 
 static int experimental;
@@ -207,22 +176,6 @@ IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
 	   "JFNS",		/* 770x-JL */
     );				/* all others */
 
-#define IBM_HKEY_HID	"IBM0068"
-#define IBM_PCI_HID	"PNP0A03"
-
-enum thermal_access_mode {
-	IBMACPI_THERMAL_NONE = 0,	/* No thermal support */
-	IBMACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
-	IBMACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
-	IBMACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
-	IBMACPI_THERMAL_TPEC_16,	/* Use ACPI EC regs, 16 sensors */
-};
-
-#define IBMACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
-struct ibm_thermal_sensors_struct {
-	s32 temp[IBMACPI_MAX_THERMAL_SENSORS];
-};
-
 /*
  * FAN ACCESS MODES
  *
@@ -323,72 +276,12 @@ struct ibm_thermal_sensors_struct {
  * 	but the ACPI tables just mention level 7.
  */
 
-enum fan_status_access_mode {
-	IBMACPI_FAN_NONE = 0,		/* No fan status or control */
-	IBMACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
-	IBMACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
-};
-
-enum fan_control_access_mode {
-	IBMACPI_FAN_WR_NONE = 0,	/* No fan control */
-	IBMACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
-	IBMACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
-	IBMACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
-};
-
-enum fan_control_commands {
-	IBMACPI_FAN_CMD_SPEED 	= 0x0001,	/* speed command */
-	IBMACPI_FAN_CMD_LEVEL 	= 0x0002,	/* level command  */
-	IBMACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd,
-						 * and also watchdog cmd */
-};
-
-enum {					/* Fan control constants */
-	fan_status_offset = 0x2f,	/* EC register 0x2f */
-	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
-					 * 0x84 must be read before 0x85 */
-
-	IBMACPI_FAN_EC_DISENGAGED 	= 0x40,	/* EC mode: tachometer
-						 * disengaged */
-	IBMACPI_FAN_EC_AUTO		= 0x80, /* EC mode: auto fan
-						 * control */
-};
-
 static char *ibm_thinkpad_ec_found = NULL;
 
-struct ibm_struct {
-	char *name;
-	char param[32];
-
-	char *hid;
-	struct acpi_driver *driver;
-
-	int (*init) (void);
-	int (*read) (char *);
-	int (*write) (char *);
-	void (*exit) (void);
-
-	void (*notify) (struct ibm_struct *, u32);
-	acpi_handle *handle;
-	int type;
-	struct acpi_device *device;
-
-	int driver_registered;
-	int proc_created;
-	int init_called;
-	int notify_installed;
-
-	int experimental;
-};
-
 static struct proc_dir_entry *proc_dir = NULL;
 
 static struct backlight_device *ibm_backlight_device = NULL;
 
-#define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
-#define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
-#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
-
 static int acpi_evalf(acpi_handle handle,
 		      void *res, char *method, char *fmt, ...)
 {
@@ -775,13 +668,6 @@ static int wan_write(char *buf)
 	return 0;
 }
 
-enum video_access_mode {
-	IBMACPI_VIDEO_NONE = 0,
-	IBMACPI_VIDEO_570,	/* 570 */
-	IBMACPI_VIDEO_770,	/* 600e/x, 770e, 770x */
-	IBMACPI_VIDEO_NEW,	/* all others */
-};
-
 static enum video_access_mode video_supported;
 static int video_orig_autosw;
 
@@ -1248,12 +1134,6 @@ static int cmos_write(char *buf)
 	return 0;
 }
 
-enum led_access_mode {
-	IBMACPI_LED_NONE = 0,
-	IBMACPI_LED_570,	/* 570 */
-	IBMACPI_LED_OLD,	/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
-	IBMACPI_LED_NEW,	/* all others */
-};
 static enum led_access_mode led_supported;
 
 static int led_init(void)
@@ -1310,10 +1190,6 @@ static const int led_exp_hlbl[] = { 0, 0, 1 };	/* led# * */
 static const int led_exp_hlcl[] = { 0, 1, 1 };	/* led# * */
 static const int led_led_arg1[] = { 0, 0x80, 0xc0 };
 
-#define IBMACPI_LED_EC_HLCL 0x0c
-#define IBMACPI_LED_EC_HLBL 0x0d
-#define IBMACPI_LED_EC_HLMS 0x0e
-
 static int led_write(char *buf)
 {
 	char *cmd;
@@ -1629,8 +1505,6 @@ static int ecdump_write(char *buf)
 	return 0;
 }
 
-static int brightness_offset = 0x31;
-
 static int brightness_get(struct backlight_device *bd)
 {
 	u8 level;
@@ -1659,9 +1533,6 @@ static int brightness_read(char *p)
 	return len;
 }
 
-#define TP_CMOS_BRIGHTNESS_UP	4
-#define TP_CMOS_BRIGHTNESS_DOWN	5
-
 static int brightness_set(int value)
 {
 	int cmos_cmd, inc, i;
@@ -1752,8 +1623,6 @@ static void brightness_exit(void)
 	}
 }
 
-static int volume_offset = 0x30;
-
 static int volume_read(char *p)
 {
 	int len = 0;
@@ -1772,10 +1641,6 @@ static int volume_read(char *p)
 	return len;
 }
 
-#define TP_CMOS_VOLUME_DOWN	0
-#define TP_CMOS_VOLUME_UP	1
-#define TP_CMOS_VOLUME_MUTE	2
-
 static int volume_write(char *buf)
 {
 	int cmos_cmd, inc, i;
diff --git a/drivers/acpi/ibm_acpi.h b/drivers/acpi/ibm_acpi.h
new file mode 100644
index 0000000..7ebaaa4
--- /dev/null
+++ b/drivers/acpi/ibm_acpi.h
@@ -0,0 +1,437 @@
+/*
+ *  ibm_acpi.h - IBM ThinkPad ACPI Extras
+ *
+ *
+ *  Copyright (C) 2004-2005 Borislav Deianov <borislav-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org>
+ *  Copyright (C) 2006-2007 Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ *  02110-1301, USA.
+ */
+
+#ifndef __IBM_ACPI_H__
+#define __IBM_ACPI_H__
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include <linux/proc_fs.h>
+#include <linux/backlight.h>
+#include <linux/fb.h>
+#include <asm/uaccess.h>
+
+#include <linux/dmi.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
+
+#include <acpi/acpi_drivers.h>
+#include <acpi/acnamesp.h>
+
+
+/****************************************************************************
+ * Main driver
+ */
+
+#define IBM_NAME "ibm"
+#define IBM_DESC "IBM ThinkPad ACPI Extras"
+#define IBM_FILE "ibm_acpi"
+#define IBM_URL "http://ibm-acpi.sf.net/"
+
+#define IBM_DIR IBM_NAME
+
+#define IBM_LOG IBM_FILE ": "
+#define IBM_ERR	   KERN_ERR    IBM_LOG
+#define IBM_NOTICE KERN_NOTICE IBM_LOG
+#define IBM_INFO   KERN_INFO   IBM_LOG
+#define IBM_DEBUG  KERN_DEBUG  IBM_LOG
+
+#define IBM_MAX_ACPI_ARGS 3
+
+/* ThinkPad CMOS commands */
+#define TP_CMOS_VOLUME_DOWN	0
+#define TP_CMOS_VOLUME_UP	1
+#define TP_CMOS_VOLUME_MUTE	2
+#define TP_CMOS_BRIGHTNESS_UP	4
+#define TP_CMOS_BRIGHTNESS_DOWN	5
+
+#define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
+#define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
+#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
+
+/* ACPI HIDs */
+#define IBM_HKEY_HID    "IBM0068"
+#define IBM_PCI_HID     "PNP0A03"
+
+/* ACPI helpers */
+static int acpi_evalf(acpi_handle handle,
+		      void *res, char *method, char *fmt, ...);
+static int acpi_ec_read(int i, u8 * p);
+static int acpi_ec_write(int i, u8 v);
+static int _sta(acpi_handle handle);
+
+/* ACPI handles */
+static acpi_handle root_handle;			/* root namespace */
+static acpi_handle ec_handle;			/* EC */
+static acpi_handle ecrd_handle, ecwr_handle;	/* 570 EC access */
+static acpi_handle cmos_handle, hkey_handle;	/* basic thinkpad handles */
+
+static void ibm_handle_init(char *name,
+		   acpi_handle * handle, acpi_handle parent,
+		   char **paths, int num_paths, char **path);
+#define IBM_HANDLE_INIT(object)						\
+	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
+		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
+
+/* procfs support */
+static struct proc_dir_entry *proc_dir;
+static int ibm_acpi_driver_init(void);
+static int ibm_acpi_driver_read(char *p);
+
+/* procfs helpers */
+static int dispatch_read(char *page, char **start, off_t off, int count,
+		int *eof, void *data);
+static int dispatch_write(struct file *file, const char __user * userbuf,
+		unsigned long count, void *data);
+static char *next_cmd(char **cmds);
+
+/* Module */
+static int experimental;
+static char *ibm_thinkpad_ec_found;
+
+static char* check_dmi_for_ec(void);
+static int acpi_ibm_init(void);
+static void acpi_ibm_exit(void);
+
+
+/****************************************************************************
+ * Subdrivers
+ */
+
+struct ibm_struct {
+	char *name;
+	char param[32];
+
+	char *hid;
+	struct acpi_driver *driver;
+
+	int (*init) (void);
+	int (*read) (char *);
+	int (*write) (char *);
+	void (*exit) (void);
+
+	void (*notify) (struct ibm_struct *, u32);
+	acpi_handle *handle;
+	int type;
+	struct acpi_device *device;
+
+	int driver_registered;
+	int proc_created;
+	int init_called;
+	int notify_installed;
+
+	int experimental;
+};
+
+static struct ibm_struct ibms[];
+static int set_ibm_param(const char *val, struct kernel_param *kp);
+static int ibm_init(struct ibm_struct *ibm);
+static void ibm_exit(struct ibm_struct *ibm);
+
+/* ACPI devices */
+static void dispatch_notify(acpi_handle handle, u32 event, void *data);
+static int setup_notify(struct ibm_struct *ibm);
+static int ibm_device_add(struct acpi_device *device);
+static int register_ibmacpi_subdriver(struct ibm_struct *ibm);
+
+
+/*
+ * Bay subdriver
+ */
+
+#ifdef CONFIG_ACPI_IBM_BAY
+static int bay_status_supported, bay_eject_supported;
+static int bay_status2_supported, bay_eject2_supported;
+
+static acpi_handle bay_handle, bay_ej_handle;
+static acpi_handle bay2_handle, bay2_ej_handle;
+
+static int bay_init(void);
+static void bay_notify(struct ibm_struct *ibm, u32 event);
+static int bay_read(char *p);
+static int bay_write(char *buf);
+#endif /* CONFIG_ACPI_IBM_BAY */
+
+
+/*
+ * Beep subdriver
+ */
+
+static acpi_handle beep_handle;
+
+static int beep_read(char *p);
+static int beep_write(char *buf);
+
+
+/*
+ * Bluetooth subdriver
+ */
+
+static int bluetooth_supported;
+
+static int bluetooth_init(void);
+static int bluetooth_status(void);
+static int bluetooth_read(char *p);
+static int bluetooth_write(char *buf);
+
+
+/*
+ * Brightness (backlight) subdriver
+ */
+
+static struct backlight_device *ibm_backlight_device;
+static int brightness_offset = 0x31;
+
+static int brightness_init(void);
+static void brightness_exit(void);
+static int brightness_get(struct backlight_device *bd);
+static int brightness_set(int value);
+static int brightness_update_status(struct backlight_device *bd);
+static int brightness_read(char *p);
+static int brightness_write(char *buf);
+
+
+/*
+ * CMOS subdriver
+ */
+
+static int cmos_eval(int cmos_cmd);
+static int cmos_read(char *p);
+static int cmos_write(char *buf);
+
+
+/*
+ * Dock subdriver
+ */
+
+static acpi_handle pci_handle;
+#ifdef CONFIG_ACPI_IBM_DOCK
+static acpi_handle dock_handle;
+
+static void dock_notify(struct ibm_struct *ibm, u32 event);
+static int dock_read(char *p);
+static int dock_write(char *buf);
+#endif /* CONFIG_ACPI_IBM_DOCK */
+
+
+/*
+ * EC dump subdriver
+ */
+
+static int ecdump_read(char *p) ;
+static int ecdump_write(char *buf);
+
+
+/*
+ * Fan subdriver
+ */
+
+enum {					/* Fan control constants */
+	fan_status_offset = 0x2f,	/* EC register 0x2f */
+	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
+					 * 0x84 must be read before 0x85 */
+
+	IBMACPI_FAN_EC_DISENGAGED 	= 0x40,	/* EC mode: tachometer
+						 * disengaged */
+	IBMACPI_FAN_EC_AUTO		= 0x80, /* EC mode: auto fan
+						 * control */
+};
+
+enum fan_status_access_mode {
+	IBMACPI_FAN_NONE = 0,		/* No fan status or control */
+	IBMACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
+	IBMACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
+};
+
+enum fan_control_access_mode {
+	IBMACPI_FAN_WR_NONE = 0,	/* No fan control */
+	IBMACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
+	IBMACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
+	IBMACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
+};
+
+enum fan_control_commands {
+	IBMACPI_FAN_CMD_SPEED 	= 0x0001,	/* speed command */
+	IBMACPI_FAN_CMD_LEVEL 	= 0x0002,	/* level command  */
+	IBMACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd,
+						 * and also watchdog cmd */
+};
+
+static enum fan_status_access_mode fan_status_access_mode;
+static enum fan_control_access_mode fan_control_access_mode;
+static enum fan_control_commands fan_control_commands;
+static int fan_control_status_known;
+static u8 fan_control_initial_status;
+static int fan_watchdog_maxinterval;
+
+static acpi_handle fans_handle, gfan_handle, sfan_handle;
+
+static int fan_init(void);
+static void fan_exit(void);
+static int fan_get_status(u8 *status);
+static int fan_get_speed(unsigned int *speed);
+static void fan_watchdog_fire(struct work_struct *ignored);
+static void fan_watchdog_reset(void);
+static int fan_set_level(int level);
+static int fan_set_enable(void);
+static int fan_set_disable(void);
+static int fan_set_speed(int speed);
+static int fan_read(char *p);
+static int fan_write(char *buf);
+static int fan_write_cmd_level(const char *cmd, int *rc);
+static int fan_write_cmd_enable(const char *cmd, int *rc);
+static int fan_write_cmd_disable(const char *cmd, int *rc);
+static int fan_write_cmd_speed(const char *cmd, int *rc);
+static int fan_write_cmd_watchdog(const char *cmd, int *rc);
+
+
+/*
+ * Hotkey subdriver
+ */
+
+static int hotkey_supported;
+static int hotkey_mask_supported;
+static int hotkey_orig_status;
+static int hotkey_orig_mask;
+
+static int hotkey_init(void);
+static void hotkey_exit(void);
+static int hotkey_get(int *status, int *mask);
+static int hotkey_set(int status, int mask);
+static void hotkey_notify(struct ibm_struct *ibm, u32 event);
+static int hotkey_read(char *p);
+static int hotkey_write(char *buf);
+
+
+/*
+ * LED subdriver
+ */
+
+enum led_access_mode {
+	IBMACPI_LED_NONE = 0,
+	IBMACPI_LED_570,	/* 570 */
+	IBMACPI_LED_OLD,	/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
+	IBMACPI_LED_NEW,	/* all others */
+};
+
+enum {	/* For IBMACPI_LED_OLD */
+	IBMACPI_LED_EC_HLCL = 0x0c,	/* EC reg to get led to power on */
+	IBMACPI_LED_EC_HLBL = 0x0d,	/* EC reg to blink a lit led */
+	IBMACPI_LED_EC_HLMS = 0x0e,	/* EC reg to select led to command */
+};
+
+static enum led_access_mode led_supported;
+static acpi_handle led_handle;
+
+static int led_init(void);
+static int led_read(char *p);
+static int led_write(char *buf);
+
+/*
+ * Light (thinklight) subdriver
+ */
+
+static int light_supported;
+static int light_status_supported;
+static acpi_handle lght_handle, ledb_handle;
+
+static int light_init(void);
+static int light_read(char *p);
+static int light_write(char *buf);
+
+
+/*
+ * Thermal subdriver
+ */
+
+enum thermal_access_mode {
+	IBMACPI_THERMAL_NONE = 0,	/* No thermal support */
+	IBMACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
+	IBMACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
+	IBMACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
+	IBMACPI_THERMAL_TPEC_16,	/* Use ACPI EC regs, 16 sensors */
+};
+
+#define IBMACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
+struct ibm_thermal_sensors_struct {
+	s32 temp[IBMACPI_MAX_THERMAL_SENSORS];
+};
+
+static int thermal_init(void);
+static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s);
+static int thermal_read(char *p);
+
+
+/*
+ * Video subdriver
+ */
+
+enum video_access_mode {
+	IBMACPI_VIDEO_NONE = 0,
+	IBMACPI_VIDEO_570,	/* 570 */
+	IBMACPI_VIDEO_770,	/* 600e/x, 770e, 770x */
+	IBMACPI_VIDEO_NEW,	/* all others */
+};
+
+static enum video_access_mode video_supported;
+static int video_orig_autosw;
+static acpi_handle vid_handle, vid2_handle;
+
+static int video_init(void);
+static void video_exit(void);
+static int video_status(void);
+static int video_autosw(void);
+static int video_switch(void);
+static int video_switch2(int status);
+static int video_expand(void);
+static int video_read(char *p);
+static int video_write(char *buf);
+
+
+/*
+ * Volume subdriver
+ */
+
+static int volume_offset = 0x30;
+
+static int volume_read(char *p);
+static int volume_write(char *buf);
+
+
+/*
+ * Wan subdriver
+ */
+
+static int wan_supported;
+
+static int wan_init(void);
+static int wan_status(void);
+static int wan_read(char *p);
+static int wan_write(char *buf);
+
+
+#endif /* __IBM_ACPI_H */
-- 
1.5.0.3


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
