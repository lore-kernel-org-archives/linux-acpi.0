From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 07/20] ACPI: thinkpad-acpi: spring cleanup
	part 2
Date: Tue,  8 Jan 2008 13:02:44 -0200
Message-ID: <1199804577-32017-8-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Move most subdriver-related stuff imported from the header file closer to
their subdriver code.  Also, delete unneeded forward declarations.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |  613 +++++++++++++-----------------------------
 1 files changed, 185 insertions(+), 428 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 59b127c..e435b55 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -82,8 +82,6 @@
  *  2004-08-09	0.1	initial release, support for X series
  */
 
-/* ==================================================== BEGIN HEADER */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -199,79 +197,22 @@ static const char *str_supported(int is_supported);
 /* ACPI HIDs */
 #define IBM_HKEY_HID    "IBM0068"
 
-/* ACPI helpers */
-static int __must_check acpi_evalf(acpi_handle handle,
-		      void *res, char *method, char *fmt, ...);
-static int __must_check acpi_ec_read(int i, u8 * p);
-static int __must_check acpi_ec_write(int i, u8 v);
-static int __must_check _sta(acpi_handle handle);
-
-/* ACPI handles */
-static acpi_handle root_handle;			/* root namespace */
-static acpi_handle ec_handle;			/* EC */
-static acpi_handle ecrd_handle, ecwr_handle;	/* 570 EC access */
-static acpi_handle cmos_handle, hkey_handle;	/* basic thinkpad handles */
-
-static void drv_acpi_handle_init(char *name,
-		   acpi_handle *handle, acpi_handle parent,
-		   char **paths, int num_paths, char **path);
-#define IBM_ACPIHANDLE_INIT(object)						\
-	drv_acpi_handle_init(#object, &object##_handle, *object##_parent,	\
-		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
-
-/* ThinkPad ACPI helpers */
-static int issue_thinkpad_cmos_command(int cmos_cmd);
-
-/* procfs support */
-static struct proc_dir_entry *proc_dir;
-
-/* procfs helpers */
-static int dispatch_procfs_read(char *page, char **start, off_t off,
-		int count, int *eof, void *data);
-static int dispatch_procfs_write(struct file *file,
-		const char __user * userbuf,
-		unsigned long count, void *data);
-static char *next_cmd(char **cmds);
-
 /* sysfs support */
 struct attribute_set {
 	unsigned int members, max_members;
 	struct attribute_group group;
 };
 
-static struct attribute_set *create_attr_set(unsigned int max_members,
-						const char* name);
-#define destroy_attr_set(_set) \
-	kfree(_set);
-static int add_to_attr_set(struct attribute_set* s, struct attribute *attr);
-static int add_many_to_attr_set(struct attribute_set* s,
-			struct attribute **attr,
-			unsigned int count);
-#define register_attr_set_with_sysfs(_attr_set, _kobj) \
-	sysfs_create_group(_kobj, &_attr_set->group)
-static void delete_attr_set(struct attribute_set* s, struct kobject *kobj);
-
+/* Helpers */
 static int parse_strtoul(const char *buf, unsigned long max,
 			unsigned long *value);
 
-/* Device model */
-static struct platform_device *tpacpi_pdev;
-static struct platform_device *tpacpi_sensors_pdev;
-static struct device *tpacpi_hwmon;
-static struct platform_driver tpacpi_pdriver;
-static struct input_dev *tpacpi_inputdev;
-static int tpacpi_create_driver_attributes(struct device_driver *drv);
-static void tpacpi_remove_driver_attributes(struct device_driver *drv);
-
 /* Module */
 static int experimental;
 static u32 dbg_level;
 static int force_load;
 static unsigned int hotkey_report_mode;
 
-static int thinkpad_acpi_module_init(void);
-static void thinkpad_acpi_module_exit(void);
-
 
 /****************************************************************************
  * Subdrivers
@@ -354,365 +295,9 @@ struct thinkpad_id_data {
 
 	char *model_str;
 };
-
 static struct thinkpad_id_data thinkpad_id;
 
-static struct list_head tpacpi_all_drivers;
-
-static struct ibm_init_struct ibms_init[];
-static int set_ibm_param(const char *val, struct kernel_param *kp);
-static int ibm_init(struct ibm_init_struct *iibm);
-static void ibm_exit(struct ibm_struct *ibm);
-
-
-/*
- * procfs master subdriver
- */
-static int thinkpad_acpi_driver_init(struct ibm_init_struct *iibm);
-static int thinkpad_acpi_driver_read(char *p);
-
-
-/*
- * Bay subdriver
- */
-
-#ifdef CONFIG_THINKPAD_ACPI_BAY
-static acpi_handle bay_handle, bay_ej_handle;
-static acpi_handle bay2_handle, bay2_ej_handle;
-
-static int bay_init(struct ibm_init_struct *iibm);
-static void bay_notify(struct ibm_struct *ibm, u32 event);
-static int bay_read(char *p);
-static int bay_write(char *buf);
-#endif /* CONFIG_THINKPAD_ACPI_BAY */
-
-
-/*
- * Beep subdriver
- */
-
-static acpi_handle beep_handle;
-
-static int beep_read(char *p);
-static int beep_write(char *buf);
-
-
-/*
- * Bluetooth subdriver
- */
-
-enum {
-	/* ACPI GBDC/SBDC bits */
-	TP_ACPI_BLUETOOTH_HWPRESENT	= 0x01,	/* Bluetooth hw available */
-	TP_ACPI_BLUETOOTH_RADIOSSW	= 0x02,	/* Bluetooth radio enabled */
-	TP_ACPI_BLUETOOTH_UNK		= 0x04,	/* unknown function */
-};
-
-static int bluetooth_init(struct ibm_init_struct *iibm);
-static int bluetooth_get_radiosw(void);
-static int bluetooth_set_radiosw(int radio_on);
-static int bluetooth_read(char *p);
-static int bluetooth_write(char *buf);
-
-
-/*
- * Brightness (backlight) subdriver
- */
-
-#define TPACPI_BACKLIGHT_DEV_NAME "thinkpad_screen"
-
-static struct backlight_device *ibm_backlight_device;
-static int brightness_offset = 0x31;
-static int brightness_mode;
-static unsigned int brightness_enable;	/* 0 = no, 1 = yes, 2 = auto */
-
-static int brightness_init(struct ibm_init_struct *iibm);
-static void brightness_exit(void);
-static int brightness_get(struct backlight_device *bd);
-static int brightness_set(int value);
-static int brightness_update_status(struct backlight_device *bd);
-static int brightness_read(char *p);
-static int brightness_write(char *buf);
-
-
-/*
- * CMOS subdriver
- */
-
-static int cmos_read(char *p);
-static int cmos_write(char *buf);
-
-
-/*
- * Dock subdriver
- */
-
-#ifdef CONFIG_THINKPAD_ACPI_DOCK
-static acpi_handle pci_handle;
-static acpi_handle dock_handle;
-
-static void dock_notify(struct ibm_struct *ibm, u32 event);
-static int dock_read(char *p);
-static int dock_write(char *buf);
-#endif /* CONFIG_THINKPAD_ACPI_DOCK */
-
-
-/*
- * EC dump subdriver
- */
-
-static int ecdump_read(char *p) ;
-static int ecdump_write(char *buf);
-
-
-/*
- * Fan subdriver
- */
-
-enum {					/* Fan control constants */
-	fan_status_offset = 0x2f,	/* EC register 0x2f */
-	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
-					 * 0x84 must be read before 0x85 */
-
-	TP_EC_FAN_FULLSPEED = 0x40,	/* EC fan mode: full speed */
-	TP_EC_FAN_AUTO	    = 0x80,	/* EC fan mode: auto fan control */
-
-	TPACPI_FAN_LAST_LEVEL = 0x100,	/* Use cached last-seen fan level */
-};
-
-enum fan_status_access_mode {
-	TPACPI_FAN_NONE = 0,		/* No fan status or control */
-	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
-	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
-};
-
-enum fan_control_access_mode {
-	TPACPI_FAN_WR_NONE = 0,		/* No fan control */
-	TPACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
-	TPACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
-	TPACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
-};
-
-enum fan_control_commands {
-	TPACPI_FAN_CMD_SPEED 	= 0x0001,	/* speed command */
-	TPACPI_FAN_CMD_LEVEL 	= 0x0002,	/* level command  */
-	TPACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd,
-						 * and also watchdog cmd */
-};
-
-static int fan_control_allowed;
-
-static enum fan_status_access_mode fan_status_access_mode;
-static enum fan_control_access_mode fan_control_access_mode;
-static enum fan_control_commands fan_control_commands;
-static u8 fan_control_initial_status;
-static u8 fan_control_desired_level;
-static int fan_watchdog_maxinterval;
-
-static struct mutex fan_mutex;
-
-static acpi_handle fans_handle, gfan_handle, sfan_handle;
-
-static int fan_init(struct ibm_init_struct *iibm);
-static void fan_exit(void);
-static int fan_get_status(u8 *status);
-static int fan_get_status_safe(u8 *status);
-static int fan_get_speed(unsigned int *speed);
-static void fan_update_desired_level(u8 status);
-static void fan_watchdog_fire(struct work_struct *ignored);
-static void fan_watchdog_reset(void);
-static int fan_set_level(int level);
-static int fan_set_level_safe(int level);
-static int fan_set_enable(void);
-static int fan_set_disable(void);
-static int fan_set_speed(int speed);
-static int fan_read(char *p);
-static int fan_write(char *buf);
-static int fan_write_cmd_level(const char *cmd, int *rc);
-static int fan_write_cmd_enable(const char *cmd, int *rc);
-static int fan_write_cmd_disable(const char *cmd, int *rc);
-static int fan_write_cmd_speed(const char *cmd, int *rc);
-static int fan_write_cmd_watchdog(const char *cmd, int *rc);
-
-
-/*
- * Hotkey subdriver
- */
-
-enum {	/* hot key scan codes (derived from ACPI DSDT) */
-	TP_ACPI_HOTKEYSCAN_FNF1		= 0,
-	TP_ACPI_HOTKEYSCAN_FNF2,
-	TP_ACPI_HOTKEYSCAN_FNF3,
-	TP_ACPI_HOTKEYSCAN_FNF4,
-	TP_ACPI_HOTKEYSCAN_FNF5,
-	TP_ACPI_HOTKEYSCAN_FNF6,
-	TP_ACPI_HOTKEYSCAN_FNF7,
-	TP_ACPI_HOTKEYSCAN_FNF8,
-	TP_ACPI_HOTKEYSCAN_FNF9,
-	TP_ACPI_HOTKEYSCAN_FNF10,
-	TP_ACPI_HOTKEYSCAN_FNF11,
-	TP_ACPI_HOTKEYSCAN_FNF12,
-	TP_ACPI_HOTKEYSCAN_FNBACKSPACE,
-	TP_ACPI_HOTKEYSCAN_FNINSERT,
-	TP_ACPI_HOTKEYSCAN_FNDELETE,
-	TP_ACPI_HOTKEYSCAN_FNHOME,
-	TP_ACPI_HOTKEYSCAN_FNEND,
-	TP_ACPI_HOTKEYSCAN_FNPAGEUP,
-	TP_ACPI_HOTKEYSCAN_FNPAGEDOWN,
-	TP_ACPI_HOTKEYSCAN_FNSPACE,
-	TP_ACPI_HOTKEYSCAN_VOLUMEUP,
-	TP_ACPI_HOTKEYSCAN_VOLUMEDOWN,
-	TP_ACPI_HOTKEYSCAN_MUTE,
-	TP_ACPI_HOTKEYSCAN_THINKPAD,
-};
-
-static int hotkey_orig_status;
-static u32 hotkey_orig_mask;
-
-static struct mutex hotkey_mutex;
-
-static int hotkey_init(struct ibm_init_struct *iibm);
-static void hotkey_exit(void);
-static void hotkey_notify(struct ibm_struct *ibm, u32 event);
-static int hotkey_read(char *p);
-static int hotkey_write(char *buf);
-
-
-/*
- * LED subdriver
- */
-
-enum led_access_mode {
-	TPACPI_LED_NONE = 0,
-	TPACPI_LED_570,	/* 570 */
-	TPACPI_LED_OLD,	/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
-	TPACPI_LED_NEW,	/* all others */
-};
-
-enum {	/* For TPACPI_LED_OLD */
-	TPACPI_LED_EC_HLCL = 0x0c,	/* EC reg to get led to power on */
-	TPACPI_LED_EC_HLBL = 0x0d,	/* EC reg to blink a lit led */
-	TPACPI_LED_EC_HLMS = 0x0e,	/* EC reg to select led to command */
-};
-
-static enum led_access_mode led_supported;
-static acpi_handle led_handle;
-
-static int led_init(struct ibm_init_struct *iibm);
-static int led_read(char *p);
-static int led_write(char *buf);
-
-/*
- * Light (thinklight) subdriver
- */
-
-static acpi_handle lght_handle, ledb_handle;
-
-static int light_init(struct ibm_init_struct *iibm);
-static int light_read(char *p);
-static int light_write(char *buf);
-
-
-/*
- * Thermal subdriver
- */
-
-enum thermal_access_mode {
-	TPACPI_THERMAL_NONE = 0,	/* No thermal support */
-	TPACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
-	TPACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
-	TPACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
-	TPACPI_THERMAL_TPEC_16,		/* Use ACPI EC regs, 16 sensors */
-};
-
-enum { /* TPACPI_THERMAL_TPEC_* */
-	TP_EC_THERMAL_TMP0 = 0x78,	/* ACPI EC regs TMP 0..7 */
-	TP_EC_THERMAL_TMP8 = 0xC0,	/* ACPI EC regs TMP 8..15 */
-	TP_EC_THERMAL_TMP_NA = -128,	/* ACPI EC sensor not available */
-};
-
-#define TPACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
-struct ibm_thermal_sensors_struct {
-	s32 temp[TPACPI_MAX_THERMAL_SENSORS];
-};
-
-static enum thermal_access_mode thermal_read_mode;
-
-static int thermal_init(struct ibm_init_struct *iibm);
-static int thermal_get_sensor(int idx, s32 *value);
-static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s);
-static int thermal_read(char *p);
-
-
-/*
- * Video subdriver
- */
-
-enum video_access_mode {
-	TPACPI_VIDEO_NONE = 0,
-	TPACPI_VIDEO_570,	/* 570 */
-	TPACPI_VIDEO_770,	/* 600e/x, 770e, 770x */
-	TPACPI_VIDEO_NEW,	/* all others */
-};
-
-enum {	/* video status flags, based on VIDEO_570 */
-	TP_ACPI_VIDEO_S_LCD = 0x01,	/* LCD output enabled */
-	TP_ACPI_VIDEO_S_CRT = 0x02,	/* CRT output enabled */
-	TP_ACPI_VIDEO_S_DVI = 0x08,	/* DVI output enabled */
-};
-
-enum {  /* TPACPI_VIDEO_570 constants */
-	TP_ACPI_VIDEO_570_PHSCMD = 0x87,	/* unknown magic constant :( */
-	TP_ACPI_VIDEO_570_PHSMASK = 0x03,	/* PHS bits that map to
-						 * video_status_flags */
-	TP_ACPI_VIDEO_570_PHS2CMD = 0x8b,	/* unknown magic constant :( */
-	TP_ACPI_VIDEO_570_PHS2SET = 0x80,	/* unknown magic constant :( */
-};
-
-static enum video_access_mode video_supported;
-static int video_orig_autosw;
-static acpi_handle vid_handle, vid2_handle;
-
-static int video_init(struct ibm_init_struct *iibm);
-static void video_exit(void);
-static int video_outputsw_get(void);
-static int video_outputsw_set(int status);
-static int video_autosw_get(void);
-static int video_autosw_set(int enable);
-static int video_outputsw_cycle(void);
-static int video_expand_toggle(void);
-static int video_read(char *p);
-static int video_write(char *buf);
-
-
-/*
- * Volume subdriver
- */
-
-static int volume_offset = 0x30;
-
-static int volume_read(char *p);
-static int volume_write(char *buf);
-
-
-/*
- * Wan subdriver
- */
-
-enum {
-	/* ACPI GWAN/SWAN bits */
-	TP_ACPI_WANCARD_HWPRESENT	= 0x01,	/* Wan hw available */
-	TP_ACPI_WANCARD_RADIOSSW	= 0x02,	/* Wan radio enabled */
-	TP_ACPI_WANCARD_UNK		= 0x04,	/* unknown function */
-};
-
-static int wan_init(struct ibm_init_struct *iibm);
-static int wan_get_radiosw(void);
-static int wan_set_radiosw(int radio_on);
-static int wan_read(char *p);
-static int wan_write(char *buf);
-
-/* ==================================================== END HEADER */
+static LIST_HEAD(tpacpi_all_drivers);
 
 MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
 MODULE_DESCRIPTION(IBM_DESC);
@@ -948,6 +533,10 @@ static int issue_thinkpad_cmos_command(int cmos_cmd)
  * ACPI device model
  */
 
+#define IBM_ACPIHANDLE_INIT(object)						\
+	drv_acpi_handle_init(#object, &object##_handle, *object##_parent,	\
+		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
+
 static void drv_acpi_handle_init(char *name,
 			   acpi_handle *handle, acpi_handle parent,
 			   char **paths, int num_paths, char **path)
@@ -1298,6 +887,9 @@ static struct attribute_set *create_attr_set(unsigned int max_members,
 	return &sobj->s;
 }
 
+#define destroy_attr_set(_set) \
+	kfree(_set);
+
 /* not multi-threaded safe, use it in a single thread per set */
 static int add_to_attr_set(struct attribute_set* s, struct attribute *attr)
 {
@@ -1334,6 +926,9 @@ static void delete_attr_set(struct attribute_set* s, struct kobject *kobj)
 	destroy_attr_set(s);
 }
 
+#define register_attr_set_with_sysfs(_attr_set, _kobj) \
+	sysfs_create_group(_kobj, &_attr_set->group)
+
 static int parse_strtoul(const char *buf,
 		unsigned long max, unsigned long *value)
 {
@@ -1403,6 +998,33 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
  * Hotkey subdriver
  */
 
+enum {	/* hot key scan codes (derived from ACPI DSDT) */
+	TP_ACPI_HOTKEYSCAN_FNF1		= 0,
+	TP_ACPI_HOTKEYSCAN_FNF2,
+	TP_ACPI_HOTKEYSCAN_FNF3,
+	TP_ACPI_HOTKEYSCAN_FNF4,
+	TP_ACPI_HOTKEYSCAN_FNF5,
+	TP_ACPI_HOTKEYSCAN_FNF6,
+	TP_ACPI_HOTKEYSCAN_FNF7,
+	TP_ACPI_HOTKEYSCAN_FNF8,
+	TP_ACPI_HOTKEYSCAN_FNF9,
+	TP_ACPI_HOTKEYSCAN_FNF10,
+	TP_ACPI_HOTKEYSCAN_FNF11,
+	TP_ACPI_HOTKEYSCAN_FNF12,
+	TP_ACPI_HOTKEYSCAN_FNBACKSPACE,
+	TP_ACPI_HOTKEYSCAN_FNINSERT,
+	TP_ACPI_HOTKEYSCAN_FNDELETE,
+	TP_ACPI_HOTKEYSCAN_FNHOME,
+	TP_ACPI_HOTKEYSCAN_FNEND,
+	TP_ACPI_HOTKEYSCAN_FNPAGEUP,
+	TP_ACPI_HOTKEYSCAN_FNPAGEDOWN,
+	TP_ACPI_HOTKEYSCAN_FNSPACE,
+	TP_ACPI_HOTKEYSCAN_VOLUMEUP,
+	TP_ACPI_HOTKEYSCAN_VOLUMEDOWN,
+	TP_ACPI_HOTKEYSCAN_MUTE,
+	TP_ACPI_HOTKEYSCAN_THINKPAD,
+};
+
 enum {	/* Keys available through NVRAM polling */
 	TPACPI_HKEY_NVRAM_KNOWN_MASK = 0x00fb88c0U,
 	TPACPI_HKEY_NVRAM_GOOD_MASK  = 0x00fb8000U,
@@ -1464,6 +1086,8 @@ static unsigned int hotkey_config_change;
 
 #endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
+static struct mutex hotkey_mutex;
+
 static int hotkey_orig_status;
 static u32 hotkey_orig_mask;
 static u32 hotkey_all_mask;
@@ -2635,6 +2259,16 @@ static struct ibm_struct hotkey_driver_data = {
  * Bluetooth subdriver
  */
 
+enum {
+	/* ACPI GBDC/SBDC bits */
+	TP_ACPI_BLUETOOTH_HWPRESENT	= 0x01,	/* Bluetooth hw available */
+	TP_ACPI_BLUETOOTH_RADIOSSW	= 0x02,	/* Bluetooth radio enabled */
+	TP_ACPI_BLUETOOTH_UNK		= 0x04,	/* unknown function */
+};
+
+static int bluetooth_get_radiosw(void);
+static int bluetooth_set_radiosw(int radio_on);
+
 /* sysfs bluetooth enable ---------------------------------------------- */
 static ssize_t bluetooth_enable_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -2799,6 +2433,16 @@ static struct ibm_struct bluetooth_driver_data = {
  * Wan subdriver
  */
 
+enum {
+	/* ACPI GWAN/SWAN bits */
+	TP_ACPI_WANCARD_HWPRESENT	= 0x01,	/* Wan hw available */
+	TP_ACPI_WANCARD_RADIOSSW	= 0x02,	/* Wan radio enabled */
+	TP_ACPI_WANCARD_UNK		= 0x04,	/* unknown function */
+};
+
+static int wan_get_radiosw(void);
+static int wan_set_radiosw(int radio_on);
+
 /* sysfs wan enable ---------------------------------------------------- */
 static ssize_t wan_enable_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -2962,9 +2606,33 @@ static struct ibm_struct wan_driver_data = {
  * Video subdriver
  */
 
+enum video_access_mode {
+	TPACPI_VIDEO_NONE = 0,
+	TPACPI_VIDEO_570,	/* 570 */
+	TPACPI_VIDEO_770,	/* 600e/x, 770e, 770x */
+	TPACPI_VIDEO_NEW,	/* all others */
+};
+
+enum {	/* video status flags, based on VIDEO_570 */
+	TP_ACPI_VIDEO_S_LCD = 0x01,	/* LCD output enabled */
+	TP_ACPI_VIDEO_S_CRT = 0x02,	/* CRT output enabled */
+	TP_ACPI_VIDEO_S_DVI = 0x08,	/* DVI output enabled */
+};
+
+enum {  /* TPACPI_VIDEO_570 constants */
+	TP_ACPI_VIDEO_570_PHSCMD = 0x87,	/* unknown magic constant :( */
+	TP_ACPI_VIDEO_570_PHSMASK = 0x03,	/* PHS bits that map to
+						 * video_status_flags */
+	TP_ACPI_VIDEO_570_PHS2CMD = 0x8b,	/* unknown magic constant :( */
+	TP_ACPI_VIDEO_570_PHS2SET = 0x80,	/* unknown magic constant :( */
+};
+
 static enum video_access_mode video_supported;
 static int video_orig_autosw;
 
+static int video_autosw_get(void);
+static int video_autosw_set(int enable);
+
 IBM_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
 	   "\\_SB.PCI0.AGP0.VID0",	/* 600e/x, 770x */
 	   "\\_SB.PCI0.VID0",	/* 770e */
@@ -3370,6 +3038,10 @@ static struct ibm_struct light_driver_data = {
 
 #ifdef CONFIG_THINKPAD_ACPI_DOCK
 
+static void dock_notify(struct ibm_struct *ibm, u32 event);
+static int dock_read(char *p);
+static int dock_write(char *buf);
+
 IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 	   "\\_SB.PCI0.DOCK",	/* 600e/x,770e,770x,A2xm/p,T20-22,X20-21 */
 	   "\\_SB.PCI0.PCI1.DOCK",	/* all others */
@@ -3524,6 +3196,7 @@ static int dock_write(char *buf)
  */
 
 #ifdef CONFIG_THINKPAD_ACPI_BAY
+
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
 	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */
@@ -3741,6 +3414,19 @@ static struct ibm_struct cmos_driver_data = {
  * LED subdriver
  */
 
+enum led_access_mode {
+	TPACPI_LED_NONE = 0,
+	TPACPI_LED_570,	/* 570 */
+	TPACPI_LED_OLD,	/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
+	TPACPI_LED_NEW,	/* all others */
+};
+
+enum {	/* For TPACPI_LED_OLD */
+	TPACPI_LED_EC_HLCL = 0x0c,	/* EC reg to get led to power on */
+	TPACPI_LED_EC_HLBL = 0x0d,	/* EC reg to blink a lit led */
+	TPACPI_LED_EC_HLMS = 0x0e,	/* EC reg to select led to command */
+};
+
 static enum led_access_mode led_supported;
 
 IBM_HANDLE(led, ec, "SLED",	/* 570 */
@@ -3930,8 +3616,30 @@ static struct ibm_struct beep_driver_data = {
  * Thermal subdriver
  */
 
+enum thermal_access_mode {
+	TPACPI_THERMAL_NONE = 0,	/* No thermal support */
+	TPACPI_THERMAL_ACPI_TMP07,	/* Use ACPI TMP0-7 */
+	TPACPI_THERMAL_ACPI_UPDT,	/* Use ACPI TMP0-7 with UPDT */
+	TPACPI_THERMAL_TPEC_8,		/* Use ACPI EC regs, 8 sensors */
+	TPACPI_THERMAL_TPEC_16,		/* Use ACPI EC regs, 16 sensors */
+};
+
+enum { /* TPACPI_THERMAL_TPEC_* */
+	TP_EC_THERMAL_TMP0 = 0x78,	/* ACPI EC regs TMP 0..7 */
+	TP_EC_THERMAL_TMP8 = 0xC0,	/* ACPI EC regs TMP 8..15 */
+	TP_EC_THERMAL_TMP_NA = -128,	/* ACPI EC sensor not available */
+};
+
+#define TPACPI_MAX_THERMAL_SENSORS 16	/* Max thermal sensors supported */
+struct ibm_thermal_sensors_struct {
+	s32 temp[TPACPI_MAX_THERMAL_SENSORS];
+};
+
 static enum thermal_access_mode thermal_read_mode;
 
+static int thermal_get_sensor(int idx, s32 *value);
+static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s);
+
 /* sysfs temp##_input -------------------------------------------------- */
 
 static ssize_t thermal_temp_input_show(struct device *dev,
@@ -4306,7 +4014,16 @@ static struct ibm_struct ecdump_driver_data = {
  * Backlight/brightness subdriver
  */
 
+#define TPACPI_BACKLIGHT_DEV_NAME "thinkpad_screen"
+
 static struct backlight_device *ibm_backlight_device;
+static int brightness_offset = 0x31;
+static int brightness_mode;
+static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
+
+static int brightness_get(struct backlight_device *bd);
+static int brightness_set(int value);
+static int brightness_update_status(struct backlight_device *bd);
 
 static struct backlight_ops ibm_backlight_data = {
         .get_brightness = brightness_get,
@@ -4628,6 +4345,8 @@ static struct ibm_struct brightness_driver_data = {
  * Volume subdriver
  */
 
+static int volume_offset = 0x30;
+
 static int volume_read(char *p)
 {
 	int len = 0;
@@ -4819,15 +4538,59 @@ static struct ibm_struct volume_driver_data = {
  * 	but the ACPI tables just mention level 7.
  */
 
+enum {					/* Fan control constants */
+	fan_status_offset = 0x2f,	/* EC register 0x2f */
+	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
+					 * 0x84 must be read before 0x85 */
+
+	TP_EC_FAN_FULLSPEED = 0x40,	/* EC fan mode: full speed */
+	TP_EC_FAN_AUTO	    = 0x80,	/* EC fan mode: auto fan control */
+
+	TPACPI_FAN_LAST_LEVEL = 0x100,	/* Use cached last-seen fan level */
+};
+
+enum fan_status_access_mode {
+	TPACPI_FAN_NONE = 0,		/* No fan status or control */
+	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
+	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
+};
+
+enum fan_control_access_mode {
+	TPACPI_FAN_WR_NONE = 0,		/* No fan control */
+	TPACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
+	TPACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
+	TPACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
+};
+
+enum fan_control_commands {
+	TPACPI_FAN_CMD_SPEED 	= 0x0001,	/* speed command */
+	TPACPI_FAN_CMD_LEVEL 	= 0x0002,	/* level command  */
+	TPACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd,
+						 * and also watchdog cmd */
+};
+
+static int fan_control_allowed;
+
 static enum fan_status_access_mode fan_status_access_mode;
 static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
 
 static u8 fan_control_initial_status;
 static u8 fan_control_desired_level;
+static int fan_watchdog_maxinterval;
+
+static struct mutex fan_mutex;
 
+static int fan_get_status(u8 *status);
+static int fan_get_status_safe(u8 *status);
+static int fan_get_speed(unsigned int *speed);
+static void fan_update_desired_level(u8 status);
 static void fan_watchdog_fire(struct work_struct *ignored);
-static int fan_watchdog_maxinterval;
+static void fan_watchdog_reset(void);
+static int fan_set_level(int level);
+static int fan_set_level_safe(int level);
+static int fan_set_enable(void);
+
 static DECLARE_DELAYED_WORK(fan_watchdog_task, fan_watchdog_fire);
 
 IBM_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
@@ -5710,9 +5473,6 @@ static struct device_attribute dev_attr_thinkpad_acpi_pdev_name =
 /* /proc support */
 static struct proc_dir_entry *proc_dir;
 
-/* Subdriver registry */
-static LIST_HEAD(tpacpi_all_drivers);
-
 
 /*
  * Module and infrastructure proble, init and exit handling
@@ -5727,6 +5487,8 @@ static const char * __init str_supported(int is_supported)
 }
 #endif /* CONFIG_THINKPAD_ACPI_DEBUG */
 
+static void ibm_exit(struct ibm_struct *ibm);
+
 static int __init ibm_init(struct ibm_init_struct *iibm)
 {
 	int ret;
@@ -6042,25 +5804,18 @@ static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 	return -EINVAL;
 }
 
-static int experimental;
 module_param(experimental, int, 0);
 
-static u32 dbg_level;
 module_param_named(debug, dbg_level, uint, 0);
 
-static int force_load;
 module_param(force_load, bool, 0);
 
-static int fan_control_allowed;
 module_param_named(fan_control, fan_control_allowed, bool, 0);
 
-static int brightness_mode;
 module_param_named(brightness_mode, brightness_mode, int, 0);
 
-static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
 module_param(brightness_enable, uint, 0);
 
-static unsigned int hotkey_report_mode;
 module_param(hotkey_report_mode, uint, 0);
 
 #define IBM_PARAM(feature) \
@@ -6084,6 +5839,8 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
+static void thinkpad_acpi_module_exit(void);
+
 static int __init thinkpad_acpi_module_init(void)
 {
 	int ret, i;
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
