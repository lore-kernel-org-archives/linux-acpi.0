From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 5/7] ACPI: thinkpad-acpi: add bluetooth and
	WWAN rfkill support
Date: Tue,  1 Jul 2008 15:27:53 -0300
Message-ID: <1214936875-4812-6-git-send-email-hmh@hmh.eng.br>
References: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1214936875-4812-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivo van Doorn <IvDoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add a read/write rfkill interface to the bluetooth radio switch on the
bluetooth submodule, and one for the wireless wan radio switch to the wan
submodule.

Since rfkill does care for when a switch changes state, use WLSW
notifications to also check if the WWAN or Bluetooth switches did not
change state (due to them being slaves of WLSW in firmware/hardware, but
that reality not being always properly exported by the thinkpad firmware).

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Ivo van Doorn <IvDoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: John W. Linville <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
---
 Documentation/laptops/thinkpad-acpi.txt |   22 +++-
 drivers/misc/Kconfig                    |    2 +
 drivers/misc/thinkpad_acpi.c            |  208 +++++++++++++++++++++++++++----
 3 files changed, 200 insertions(+), 32 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 64b3f14..1c1c021 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -621,7 +621,8 @@ Bluetooth
 ---------
 
 procfs: /proc/acpi/ibm/bluetooth
-sysfs device attribute: bluetooth_enable
+sysfs device attribute: bluetooth_enable (deprecated)
+sysfs rfkill class: switch "tpacpi_bluetooth_sw"
 
 This feature shows the presence and current state of a ThinkPad
 Bluetooth device in the internal ThinkPad CDC slot.
@@ -643,8 +644,12 @@ Sysfs notes:
 		0: disables Bluetooth / Bluetooth is disabled
 		1: enables Bluetooth / Bluetooth is enabled.
 
-	Note: this interface will be probably be superseded by the
-	generic rfkill class, so it is NOT to be considered stable yet.
+	Note: this interface has been superseded by the	generic rfkill
+	class.  It has been deprecated, and it will be removed in year
+	2010.
+
+	rfkill controller switch "tpacpi_bluetooth_sw": refer to
+	Documentation/rfkill.txt for details.
 
 Video output control -- /proc/acpi/ibm/video
 --------------------------------------------
@@ -1374,7 +1379,8 @@ EXPERIMENTAL: WAN
 -----------------
 
 procfs: /proc/acpi/ibm/wan
-sysfs device attribute: wwan_enable
+sysfs device attribute: wwan_enable (deprecated)
+sysfs rfkill class: switch "tpacpi_wwan_sw"
 
 This feature is marked EXPERIMENTAL because the implementation
 directly accesses hardware registers and may not work as expected. USE
@@ -1404,8 +1410,12 @@ Sysfs notes:
 		0: disables WWAN card / WWAN card is disabled
 		1: enables WWAN card / WWAN card is enabled.
 
-	Note: this interface will be probably be superseded by the
-	generic rfkill class, so it is NOT to be considered stable yet.
+	Note: this interface has been superseded by the	generic rfkill
+	class.  It has been deprecated, and it will be removed in year
+	2010.
+
+	rfkill controller switch "tpacpi_wwan_sw": refer to
+	Documentation/rfkill.txt for details.
 
 Multiple Commands, Module Parameters
 ------------------------------------
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 636af28..90bc0d4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -250,6 +250,8 @@ config THINKPAD_ACPI
 	select INPUT
 	select NEW_LEDS
 	select LEDS_CLASS
+	select NET
+	select RFKILL
 	---help---
 	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 202d63e..dc8d00a 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -68,6 +68,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/input.h>
 #include <linux/leds.h>
+#include <linux/rfkill.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
@@ -144,6 +145,12 @@ enum {
 
 #define TPACPI_MAX_ACPI_ARGS 3
 
+/* rfkill switches */
+enum {
+	TPACPI_RFK_BLUETOOTH_SW_ID = 0,
+	TPACPI_RFK_WWAN_SW_ID,
+};
+
 /* Debugging */
 #define TPACPI_LOG TPACPI_FILE ": "
 #define TPACPI_ERR	   KERN_ERR    TPACPI_LOG
@@ -905,6 +912,43 @@ static int __init tpacpi_check_std_acpi_brightness_support(void)
 	return 0;
 }
 
+static int __init tpacpi_new_rfkill(const unsigned int id,
+			struct rfkill **rfk,
+			const enum rfkill_type rfktype,
+			const char *name,
+			int (*toggle_radio)(void *, enum rfkill_state),
+			int (*get_state)(void *, enum rfkill_state *))
+{
+	int res;
+	enum rfkill_state initial_state;
+
+	*rfk = rfkill_allocate(&tpacpi_pdev->dev, rfktype);
+	if (!*rfk) {
+		printk(TPACPI_ERR
+			"failed to allocate memory for rfkill class\n");
+		return -ENOMEM;
+	}
+
+	(*rfk)->name = name;
+	(*rfk)->get_state = get_state;
+	(*rfk)->toggle_radio = toggle_radio;
+
+	if (!get_state(NULL, &initial_state))
+		(*rfk)->state = initial_state;
+
+	res = rfkill_register(*rfk);
+	if (res < 0) {
+		printk(TPACPI_ERR
+			"failed to register %s rfkill switch: %d\n",
+			name, res);
+		rfkill_free(*rfk);
+		*rfk = NULL;
+		return res;
+	}
+
+	return 0;
+}
+
 /*************************************************************************
  * thinkpad-acpi driver attributes
  */
@@ -1906,10 +1950,18 @@ static struct attribute *hotkey_mask_attributes[] __initdata = {
 	&dev_attr_hotkey_wakeup_hotunplug_complete.attr,
 };
 
+static void bluetooth_update_rfk(void);
+static void wan_update_rfk(void);
 static void tpacpi_send_radiosw_update(void)
 {
 	int wlsw;
 
+	/* Sync these BEFORE sending any rfkill events */
+	if (tp_features.bluetooth)
+		bluetooth_update_rfk();
+	if (tp_features.wan)
+		wan_update_rfk();
+
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
 		mutex_lock(&tpacpi_inputdev_send_mutex);
 
@@ -2581,6 +2633,8 @@ enum {
 	TP_ACPI_BLUETOOTH_UNK		= 0x04,	/* unknown function */
 };
 
+static struct rfkill *tpacpi_bluetooth_rfkill;
+
 static int bluetooth_get_radiosw(void)
 {
 	int status;
@@ -2590,15 +2644,29 @@ static int bluetooth_get_radiosw(void)
 
 	/* WLSW overrides bluetooth in firmware/hardware, reflect that */
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status)
-		return 0;
+		return RFKILL_STATE_HARD_BLOCKED;
 
 	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
 		return -EIO;
 
-	return (status & TP_ACPI_BLUETOOTH_RADIOSSW) != 0;
+	return ((status & TP_ACPI_BLUETOOTH_RADIOSSW) != 0) ?
+		RFKILL_STATE_UNBLOCKED : RFKILL_STATE_SOFT_BLOCKED;
 }
 
-static int bluetooth_set_radiosw(int radio_on)
+static void bluetooth_update_rfk(void)
+{
+	int status;
+
+	if (!tpacpi_bluetooth_rfkill)
+		return;
+
+	status = bluetooth_get_radiosw();
+	if (status < 0)
+		return;
+	rfkill_force_state(tpacpi_bluetooth_rfkill, status);
+}
+
+static int bluetooth_set_radiosw(int radio_on, int update_rfk)
 {
 	int status;
 
@@ -2620,6 +2688,9 @@ static int bluetooth_set_radiosw(int radio_on)
 	if (!acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
 		return -EIO;
 
+	if (update_rfk)
+		bluetooth_update_rfk();
+
 	return 0;
 }
 
@@ -2634,7 +2705,8 @@ static ssize_t bluetooth_enable_show(struct device *dev,
 	if (status < 0)
 		return status;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", status ? 1 : 0);
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			(status == RFKILL_STATE_UNBLOCKED) ? 1 : 0);
 }
 
 static ssize_t bluetooth_enable_store(struct device *dev,
@@ -2647,7 +2719,7 @@ static ssize_t bluetooth_enable_store(struct device *dev,
 	if (parse_strtoul(buf, 1, &t))
 		return -EINVAL;
 
-	res = bluetooth_set_radiosw(t);
+	res = bluetooth_set_radiosw(t, 1);
 
 	return (res) ? res : count;
 }
@@ -2667,8 +2739,27 @@ static const struct attribute_group bluetooth_attr_group = {
 	.attrs = bluetooth_attributes,
 };
 
+static int tpacpi_bluetooth_rfk_get(void *data, enum rfkill_state *state)
+{
+	int bts = bluetooth_get_radiosw();
+
+	if (bts < 0)
+		return bts;
+
+	*state = bts;
+	return 0;
+}
+
+static int tpacpi_bluetooth_rfk_set(void *data, enum rfkill_state state)
+{
+	return bluetooth_set_radiosw((state == RFKILL_STATE_UNBLOCKED), 0);
+}
+
 static void bluetooth_exit(void)
 {
+	if (tpacpi_bluetooth_rfkill)
+		rfkill_unregister(tpacpi_bluetooth_rfkill);
+
 	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
 			&bluetooth_attr_group);
 }
@@ -2699,14 +2790,26 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 			   "bluetooth hardware not installed\n");
 	}
 
-	if (tp_features.bluetooth) {
-		res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+	if (!tp_features.bluetooth)
+		return 1;
+
+	res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
 				&bluetooth_attr_group);
-		if (res)
-			return res;
+	if (res)
+		return res;
+
+	res = tpacpi_new_rfkill(TPACPI_RFK_BLUETOOTH_SW_ID,
+				&tpacpi_bluetooth_rfkill,
+				RFKILL_TYPE_BLUETOOTH,
+				"tpacpi_bluetooth_sw",
+				tpacpi_bluetooth_rfk_set,
+				tpacpi_bluetooth_rfk_get);
+	if (res) {
+		bluetooth_exit();
+		return res;
 	}
 
-	return (tp_features.bluetooth)? 0 : 1;
+	return 0;
 }
 
 /* procfs -------------------------------------------------------------- */
@@ -2719,7 +2822,8 @@ static int bluetooth_read(char *p)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	else {
 		len += sprintf(p + len, "status:\t\t%s\n",
-				(status)? "enabled" : "disabled");
+				(status == RFKILL_STATE_UNBLOCKED) ?
+					"enabled" : "disabled");
 		len += sprintf(p + len, "commands:\tenable, disable\n");
 	}
 
@@ -2735,9 +2839,9 @@ static int bluetooth_write(char *buf)
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
-			bluetooth_set_radiosw(1);
+			bluetooth_set_radiosw(1, 1);
 		} else if (strlencmp(cmd, "disable") == 0) {
-			bluetooth_set_radiosw(0);
+			bluetooth_set_radiosw(0, 1);
 		} else
 			return -EINVAL;
 	}
@@ -2763,6 +2867,8 @@ enum {
 	TP_ACPI_WANCARD_UNK		= 0x04,	/* unknown function */
 };
 
+static struct rfkill *tpacpi_wan_rfkill;
+
 static int wan_get_radiosw(void)
 {
 	int status;
@@ -2772,15 +2878,29 @@ static int wan_get_radiosw(void)
 
 	/* WLSW overrides WWAN in firmware/hardware, reflect that */
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status)
-		return 0;
+		return RFKILL_STATE_HARD_BLOCKED;
 
 	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
 		return -EIO;
 
-	return (status & TP_ACPI_WANCARD_RADIOSSW) != 0;
+	return ((status & TP_ACPI_WANCARD_RADIOSSW) != 0) ?
+		RFKILL_STATE_UNBLOCKED : RFKILL_STATE_SOFT_BLOCKED;
 }
 
-static int wan_set_radiosw(int radio_on)
+static void wan_update_rfk(void)
+{
+	int status;
+
+	if (!tpacpi_wan_rfkill)
+		return;
+
+	status = wan_get_radiosw();
+	if (status < 0)
+		return;
+	rfkill_force_state(tpacpi_wan_rfkill, status);
+}
+
+static int wan_set_radiosw(int radio_on, int update_rfk)
 {
 	int status;
 
@@ -2802,6 +2922,9 @@ static int wan_set_radiosw(int radio_on)
 	if (!acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
 		return -EIO;
 
+	if (update_rfk)
+		wan_update_rfk();
+
 	return 0;
 }
 
@@ -2816,7 +2939,8 @@ static ssize_t wan_enable_show(struct device *dev,
 	if (status < 0)
 		return status;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", status ? 1 : 0);
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			(status == RFKILL_STATE_UNBLOCKED) ? 1 : 0);
 }
 
 static ssize_t wan_enable_store(struct device *dev,
@@ -2829,7 +2953,7 @@ static ssize_t wan_enable_store(struct device *dev,
 	if (parse_strtoul(buf, 1, &t))
 		return -EINVAL;
 
-	res = wan_set_radiosw(t);
+	res = wan_set_radiosw(t, 1);
 
 	return (res) ? res : count;
 }
@@ -2849,8 +2973,27 @@ static const struct attribute_group wan_attr_group = {
 	.attrs = wan_attributes,
 };
 
+static int tpacpi_wan_rfk_get(void *data, enum rfkill_state *state)
+{
+	int wans = wan_get_radiosw();
+
+	if (wans < 0)
+		return wans;
+
+	*state = wans;
+	return 0;
+}
+
+static int tpacpi_wan_rfk_set(void *data, enum rfkill_state state)
+{
+	return wan_set_radiosw((state == RFKILL_STATE_UNBLOCKED), 0);
+}
+
 static void wan_exit(void)
 {
+	if (tpacpi_wan_rfkill)
+		rfkill_unregister(tpacpi_wan_rfkill);
+
 	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
 		&wan_attr_group);
 }
@@ -2879,14 +3022,26 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 			   "wan hardware not installed\n");
 	}
 
-	if (tp_features.wan) {
-		res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+	if (!tp_features.wan)
+		return 1;
+
+	res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
 				&wan_attr_group);
-		if (res)
-			return res;
+	if (res)
+		return res;
+
+	res = tpacpi_new_rfkill(TPACPI_RFK_WWAN_SW_ID,
+				&tpacpi_wan_rfkill,
+				RFKILL_TYPE_WWAN,
+				"tpacpi_wwan_sw",
+				tpacpi_wan_rfk_set,
+				tpacpi_wan_rfk_get);
+	if (res) {
+		wan_exit();
+		return res;
 	}
 
-	return (tp_features.wan)? 0 : 1;
+	return 0;
 }
 
 /* procfs -------------------------------------------------------------- */
@@ -2899,7 +3054,8 @@ static int wan_read(char *p)
 		len += sprintf(p + len, "status:\t\tnot supported\n");
 	else {
 		len += sprintf(p + len, "status:\t\t%s\n",
-				(status)? "enabled" : "disabled");
+				(status == RFKILL_STATE_UNBLOCKED) ?
+					"enabled" : "disabled");
 		len += sprintf(p + len, "commands:\tenable, disable\n");
 	}
 
@@ -2915,9 +3071,9 @@ static int wan_write(char *buf)
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
-			wan_set_radiosw(1);
+			wan_set_radiosw(1, 1);
 		} else if (strlencmp(cmd, "disable") == 0) {
-			wan_set_radiosw(0);
+			wan_set_radiosw(0, 1);
 		} else
 			return -EINVAL;
 	}
-- 
1.5.5.4


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
