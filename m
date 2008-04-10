From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 09/13] ACPI: thinkpad-acpi: add sysfs led
	class support to thinkpad leds (v3.1)
Date: Thu, 10 Apr 2008 00:53:01 -0300
Message-ID: <1207799585-10112-10-git-send-email-hmh@hmh.eng.br>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1207799585-10112-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add a sysfs led class interface to the led subdriver.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
---
 Documentation/laptops/thinkpad-acpi.txt |   47 +++++++++--
 drivers/misc/thinkpad_acpi.c            |  136 ++++++++++++++++++++++++++++++-
 2 files changed, 176 insertions(+), 7 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 22c1ac4..27ca0f9 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -875,28 +875,63 @@ The cmos command interface is prone to firmware split-brain problems, as
 in newer ThinkPads it is just a compatibility layer.  Do not use it, it is
 exported just as a debug tool.
 
-LED control -- /proc/acpi/ibm/led
----------------------------------
+LED control
+-----------
 
-Some of the LED indicators can be controlled through this feature. The
-available commands are:
+procfs: /proc/acpi/ibm/led
+sysfs attributes: as per led class, see below for names
+
+Some of the LED indicators can be controlled through this feature.  On
+some older ThinkPad models, it is possible to query the status of the
+LED indicators as well.  Newer ThinkPads cannot query the real status
+of the LED indicators.
+
+procfs notes:
+
+The available commands are:
 
 	echo '<led number> on' >/proc/acpi/ibm/led
 	echo '<led number> off' >/proc/acpi/ibm/led
 	echo '<led number> blink' >/proc/acpi/ibm/led
 
 The <led number> range is 0 to 7. The set of LEDs that can be
-controlled varies from model to model. Here is the mapping on the X40:
+controlled varies from model to model. Here is the common ThinkPad
+mapping:
 
 	0 - power
 	1 - battery (orange)
 	2 - battery (green)
-	3 - UltraBase
+	3 - UltraBase/dock
 	4 - UltraBay
+	5 - UltraBase battery slot
+	6 - (unknown)
 	7 - standby
 
 All of the above can be turned on and off and can be made to blink.
 
+sysfs notes:
+
+The ThinkPad LED sysfs interface is described in detail by the led class
+documentation, in Documentation/leds-class.txt.
+
+The leds are named (in LED ID order, from 0 to7):
+"tpacpi::power", "tpacpi:orange:batt", "tpacpi:green:batt",
+"tpacpi::dock_active", "tpacpi::bay_active", "tpacpi::dock_batt",
+"tpacpi::unknown_led", "tpacpi::standby".
+
+Due to limitations in the sysfs led class, if the status of the LED
+indicators cannot be read due to an error, thinkpad-acpi will report it as
+a brightness of zero (same as LED off).
+
+If the thinkpad firmware doesn't support reading the current status,
+trying to read the current LED brightness will just return whatever
+brightness was last written to that attribute.
+
+These LEDs can blink using hardware acceleration.  To request that a
+ThinkPad indicator LED should blink in hardware accelerated mode, use the
+"timer" trigger, and leave the delay_on and delay_off parameters set to
+zero (to request hardware acceleration autodetection).
+
 ACPI sounds -- /proc/acpi/ibm/beep
 ----------------------------------
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index f647dc7..547324e 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -277,6 +277,7 @@ struct tpacpi_led_classdev {
 	struct led_classdev led_classdev;
 	struct work_struct work;
 	enum led_brightness new_brightness;
+	unsigned int led;
 };
 
 /****************************************************************************
@@ -3813,20 +3814,38 @@ TPACPI_HANDLE(led, ec, "SLED",	/* 570 */
 	   "LED",		/* all others */
 	   );			/* R30, R31 */
 
+#define TPACPI_LED_NUMLEDS 8
+static struct tpacpi_led_classdev *tpacpi_leds;
+static enum led_status_t tpacpi_led_state_cache[TPACPI_LED_NUMLEDS];
+static const char const *tpacpi_led_names[TPACPI_LED_NUMLEDS] = {
+	/* there's a limit of 19 chars + NULL before 2.6.26 */
+	"tpacpi::power",
+	"tpacpi:orange:batt",
+	"tpacpi:green:batt",
+	"tpacpi::dock_active",
+	"tpacpi::bay_active",
+	"tpacpi::dock_batt",
+	"tpacpi::unknown_led",
+	"tpacpi::standby",
+};
+
 static int led_get_status(unsigned int led)
 {
 	int status;
+	enum led_status_t led_s;
 
 	switch (led_supported) {
 	case TPACPI_LED_570:
 		if (!acpi_evalf(ec_handle,
 				&status, "GLED", "dd", 1 << led))
 			return -EIO;
-		return (status == 0)?
+		led_s = (status == 0)?
 				TPACPI_LED_OFF :
 				((status == 1)?
 					TPACPI_LED_ON :
 					TPACPI_LED_BLINK);
+		tpacpi_led_state_cache[led] = led_s;
+		return led_s;
 	default:
 		return -ENXIO;
 	}
@@ -3873,11 +3892,96 @@ static int led_set_status(unsigned int led, enum led_status_t ledstatus)
 		rc = -ENXIO;
 	}
 
+	if (!rc)
+		tpacpi_led_state_cache[led] = ledstatus;
+
 	return rc;
 }
 
+static void led_sysfs_set_status(unsigned int led,
+				 enum led_brightness brightness)
+{
+	led_set_status(led,
+			(brightness == LED_OFF) ?
+			TPACPI_LED_OFF :
+			(tpacpi_led_state_cache[led] == TPACPI_LED_BLINK) ?
+				TPACPI_LED_BLINK : TPACPI_LED_ON);
+}
+
+static void led_set_status_worker(struct work_struct *work)
+{
+	struct tpacpi_led_classdev *data =
+		container_of(work, struct tpacpi_led_classdev, work);
+
+	if (likely(tpacpi_lifecycle == TPACPI_LIFE_RUNNING))
+		led_sysfs_set_status(data->led, data->new_brightness);
+}
+
+static void led_sysfs_set(struct led_classdev *led_cdev,
+			enum led_brightness brightness)
+{
+	struct tpacpi_led_classdev *data = container_of(led_cdev,
+			     struct tpacpi_led_classdev, led_classdev);
+
+	data->new_brightness = brightness;
+	schedule_work(&data->work);
+}
+
+static int led_sysfs_blink_set(struct led_classdev *led_cdev,
+			unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct tpacpi_led_classdev *data = container_of(led_cdev,
+			     struct tpacpi_led_classdev, led_classdev);
+
+	/* Can we choose the flash rate? */
+	if (*delay_on == 0 && *delay_off == 0) {
+		/* yes. set them to the hardware blink rate (1 Hz) */
+		*delay_on = 500; /* ms */
+		*delay_off = 500; /* ms */
+	} else if ((*delay_on != 500) || (*delay_off != 500))
+		return -EINVAL;
+
+	data->new_brightness = TPACPI_LED_BLINK;
+	schedule_work(&data->work);
+
+	return 0;
+}
+
+static enum led_brightness led_sysfs_get(struct led_classdev *led_cdev)
+{
+	int rc;
+
+	struct tpacpi_led_classdev *data = container_of(led_cdev,
+			     struct tpacpi_led_classdev, led_classdev);
+
+	rc = led_get_status(data->led);
+
+	if (rc == TPACPI_LED_OFF || rc < 0)
+		rc = LED_OFF;	/* no error handling in led class :( */
+	else
+		rc = LED_FULL;
+
+	return rc;
+}
+
+static void led_exit(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < TPACPI_LED_NUMLEDS; i++) {
+		if (tpacpi_leds[i].led_classdev.name)
+			led_classdev_unregister(&tpacpi_leds[i].led_classdev);
+	}
+
+	kfree(tpacpi_leds);
+	tpacpi_leds = NULL;
+}
+
 static int __init led_init(struct ibm_init_struct *iibm)
 {
+	unsigned int i;
+	int rc;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing LED subdriver\n");
 
 	TPACPI_ACPIHANDLE_INIT(led);
@@ -3898,6 +4002,35 @@ static int __init led_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "LED commands are %s, mode %d\n",
 		str_supported(led_supported), led_supported);
 
+	tpacpi_leds = kzalloc(sizeof(*tpacpi_leds) * TPACPI_LED_NUMLEDS,
+			      GFP_KERNEL);
+	if (!tpacpi_leds) {
+		printk(TPACPI_ERR "Out of memory for LED data\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < TPACPI_LED_NUMLEDS; i++) {
+		tpacpi_leds[i].led = i;
+
+		tpacpi_leds[i].led_classdev.brightness_set = &led_sysfs_set;
+		tpacpi_leds[i].led_classdev.blink_set = &led_sysfs_blink_set;
+		if (led_supported == TPACPI_LED_570)
+			tpacpi_leds[i].led_classdev.brightness_get =
+							&led_sysfs_get;
+
+		tpacpi_leds[i].led_classdev.name = tpacpi_led_names[i];
+
+		INIT_WORK(&tpacpi_leds[i].work, led_set_status_worker);
+
+		rc = led_classdev_register(&tpacpi_pdev->dev,
+					   &tpacpi_leds[i].led_classdev);
+		if (rc < 0) {
+			tpacpi_leds[i].led_classdev.name = NULL;
+			led_exit();
+			return rc;
+		}
+	}
+
 	return (led_supported != TPACPI_LED_NONE)? 0 : 1;
 }
 
@@ -3968,6 +4101,7 @@ static struct ibm_struct led_driver_data = {
 	.name = "led",
 	.read = led_read,
 	.write = led_write,
+	.exit = led_exit,
 };
 
 /*************************************************************************
-- 
1.5.4.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
