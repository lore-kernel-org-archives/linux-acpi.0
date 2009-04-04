From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 08/12] thinkpad-acpi: restrict access to some firmware LEDs
Date: Sat,  4 Apr 2009 01:25:49 -0300
Message-ID: <1238819153-16004-9-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41924 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363AbZDDE0C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:26:02 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some of the ThinkPad LEDs indicate critical conditions that can cause
data loss or cause hardware damage when ignored (e.g. force-ejecting
a powered up bay; ignoring a failing battery, or empty battery; force-
undocking with the dock buses still active, etc).

On almost all ThinkPads, LED access is write-only, and the firmware
usually does fire-and-forget signaling on them, so you effectively
lose whatever message the firmware was trying to convey to the user
when you override the LED state, without any chance to restore it.

Restrict access to all LEDs that can convey important alarms, or that
could mislead the user into incorrectly operating the hardware.  This
will make the Lenovo engineers less unhappy about the whole issue.

Allow users that really want it to still control all LEDs, it is the
unaware user that we have to worry about.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |   11 +++++
 drivers/platform/x86/Kconfig            |   24 ++++++++++
 drivers/platform/x86/thinkpad_acpi.c    |   76 +++++++++++++++++++++++--------
 3 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index de6f14c..bce1d95 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -901,6 +901,17 @@ some older ThinkPad models, it is possible to query the status of the
 LED indicators as well.  Newer ThinkPads cannot query the real status
 of the LED indicators.
 
+Because misuse of the LEDs could induce an unaware user to perform
+dangerous actions (like undocking or ejecting a bay device while the
+buses are still active), or mask an important alarm (such as a nearly
+empty battery, or a broken battery), access to most LEDs is
+restricted.
+
+Unrestricted access to all LEDs requires that thinkpad-acpi be
+compiled with the CONFIG_THINKPAD_ACPI_UNSAFE_LEDS option enabled.
+Distributions must never enable this option.  Individual users that
+are aware of the consequences are welcome to enabling it.
+
 procfs notes:
 
 The available commands are:
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 3608081..d45c6ab 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -226,6 +226,30 @@ config THINKPAD_ACPI_DEBUG
 
 	  If you are not sure, say N here.
 
+config THINKPAD_ACPI_UNSAFE_LEDS
+	bool "Allow control of important LEDs (unsafe)"
+	depends on THINKPAD_ACPI
+	default n
+	---help---
+	  Overriding LED state on ThinkPads can mask important
+	  firmware alerts (like critical battery condition), or misled
+	  the user into damaging the hardware (undocking or ejecting
+	  the bay while buses are still active), etc.
+
+	  LED control on the ThinkPad is write-only (with very few
+	  exceptions on very ancient models), which makes it
+	  impossible to know beforehand if important information will
+	  be lost when one changes LED state.
+
+	  Users that know what they are doing can enable this option
+	  and the driver will allow control of every LED, including
+	  the ones on the dock stations.
+
+	  Never enable this option on a distribution kernel.
+
+	  Say N here, unless you are building a kernel for your own
+	  use, and need to control the important firmware LEDs.
+
 config THINKPAD_ACPI_DOCK
 	bool "Legacy Docking Station Support"
 	depends on THINKPAD_ACPI
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ef6c963..d03b76a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4657,6 +4657,16 @@ static const char * const tpacpi_led_names[TPACPI_LED_NUMLEDS] = {
 	"tpacpi::unknown_led",
 	"tpacpi::standby",
 };
+#define TPACPI_SAFE_LEDS	0x0081U
+
+static inline bool tpacpi_is_led_restricted(const unsigned int led)
+{
+#ifdef CONFIG_THINKPAD_ACPI_UNSAFE_LEDS
+	return false;
+#else
+	return (TPACPI_SAFE_LEDS & (1 << led)) == 0;
+#endif
+}
 
 static int led_get_status(const unsigned int led)
 {
@@ -4694,16 +4704,20 @@ static int led_set_status(const unsigned int led,
 	switch (led_supported) {
 	case TPACPI_LED_570:
 		/* 570 */
-		if (led > 7)
+		if (unlikely(led > 7))
 			return -EINVAL;
+		if (unlikely(tpacpi_is_led_restricted(led)))
+			return -EPERM;
 		if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
 				(1 << led), led_sled_arg1[ledstatus]))
 			rc = -EIO;
 		break;
 	case TPACPI_LED_OLD:
 		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
-		if (led > 7)
+		if (unlikely(led > 7))
 			return -EINVAL;
+		if (unlikely(tpacpi_is_led_restricted(led)))
+			return -EPERM;
 		rc = ec_write(TPACPI_LED_EC_HLMS, (1 << led));
 		if (rc >= 0)
 			rc = ec_write(TPACPI_LED_EC_HLBL,
@@ -4714,6 +4728,10 @@ static int led_set_status(const unsigned int led,
 		break;
 	case TPACPI_LED_NEW:
 		/* all others */
+		if (unlikely(led >= TPACPI_LED_NUMLEDS))
+			return -EINVAL;
+		if (unlikely(tpacpi_is_led_restricted(led)))
+			return -EPERM;
 		if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
 				led, led_led_arg1[ledstatus]))
 			rc = -EIO;
@@ -4806,6 +4824,30 @@ static void led_exit(void)
 	kfree(tpacpi_leds);
 }
 
+static int __init tpacpi_init_led(unsigned int led)
+{
+	int rc;
+
+	tpacpi_leds[led].led = led;
+
+	tpacpi_leds[led].led_classdev.brightness_set = &led_sysfs_set;
+	tpacpi_leds[led].led_classdev.blink_set = &led_sysfs_blink_set;
+	if (led_supported == TPACPI_LED_570)
+		tpacpi_leds[led].led_classdev.brightness_get =
+						&led_sysfs_get;
+
+	tpacpi_leds[led].led_classdev.name = tpacpi_led_names[led];
+
+	INIT_WORK(&tpacpi_leds[led].work, led_set_status_worker);
+
+	rc = led_classdev_register(&tpacpi_pdev->dev,
+				&tpacpi_leds[led].led_classdev);
+	if (rc < 0)
+		tpacpi_leds[led].led_classdev.name = NULL;
+
+	return rc;
+}
+
 static int __init led_init(struct ibm_init_struct *iibm)
 {
 	unsigned int i;
@@ -4839,27 +4881,21 @@ static int __init led_init(struct ibm_init_struct *iibm)
 	}
 
 	for (i = 0; i < TPACPI_LED_NUMLEDS; i++) {
-		tpacpi_leds[i].led = i;
-
-		tpacpi_leds[i].led_classdev.brightness_set = &led_sysfs_set;
-		tpacpi_leds[i].led_classdev.blink_set = &led_sysfs_blink_set;
-		if (led_supported == TPACPI_LED_570)
-			tpacpi_leds[i].led_classdev.brightness_get =
-							&led_sysfs_get;
-
-		tpacpi_leds[i].led_classdev.name = tpacpi_led_names[i];
-
-		INIT_WORK(&tpacpi_leds[i].work, led_set_status_worker);
-
-		rc = led_classdev_register(&tpacpi_pdev->dev,
-					   &tpacpi_leds[i].led_classdev);
-		if (rc < 0) {
-			tpacpi_leds[i].led_classdev.name = NULL;
-			led_exit();
-			return rc;
+		if (!tpacpi_is_led_restricted(i)) {
+			rc = tpacpi_init_led(i);
+			if (rc < 0) {
+				led_exit();
+				return rc;
+			}
 		}
 	}
 
+#ifdef CONFIG_THINKPAD_ACPI_UNSAFE_LEDS
+	if (led_supported != TPACPI_LED_NONE)
+		printk(TPACPI_NOTICE
+			"warning: userspace override of important "
+			"firmware LEDs is enabled\n");
+#endif
 	return (led_supported != TPACPI_LED_NONE)? 0 : 1;
 }
 
-- 
1.6.2.1

