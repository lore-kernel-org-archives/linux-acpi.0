From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/5] thinkpad-acpi: enhance led support
Date: Sat, 30 May 2009 13:25:08 -0300
Message-ID: <1243700709-25977-5-git-send-email-hmh@hmh.eng.br>
References: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51642 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759715AbZE3QZT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 May 2009 12:25:19 -0400
In-Reply-To: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add support for extra LEDs on recent ThinkPads, and avoid registering
with the led class the LEDs which are not available for a given
ThinkPad model.

All non-restricted LEDs are always available through the procfs
interface, as the firmware doesn't care if an attempt is made to
access an invalid LED.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |   23 +++++++-
 drivers/platform/x86/thinkpad_acpi.c    |   88 ++++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index e7e9a69..88fc066 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -920,7 +920,7 @@ The available commands are:
 	echo '<LED number> off' >/proc/acpi/ibm/led
 	echo '<LED number> blink' >/proc/acpi/ibm/led
 
-The <LED number> range is 0 to 7. The set of LEDs that can be
+The <LED number> range is 0 to 15. The set of LEDs that can be
 controlled varies from model to model. Here is the common ThinkPad
 mapping:
 
@@ -932,6 +932,11 @@ mapping:
 	5 - UltraBase battery slot
 	6 - (unknown)
 	7 - standby
+	8 - dock status 1
+	9 - dock status 2
+	10, 11 - (unknown)
+	12 - thinkvantage
+	13, 14, 15 - (unknown)
 
 All of the above can be turned on and off and can be made to blink.
 
@@ -940,10 +945,12 @@ sysfs notes:
 The ThinkPad LED sysfs interface is described in detail by the LED class
 documentation, in Documentation/leds-class.txt.
 
-The leds are named (in LED ID order, from 0 to 7):
+The LEDs are named (in LED ID order, from 0 to 12):
 "tpacpi::power", "tpacpi:orange:batt", "tpacpi:green:batt",
 "tpacpi::dock_active", "tpacpi::bay_active", "tpacpi::dock_batt",
-"tpacpi::unknown_led", "tpacpi::standby".
+"tpacpi::unknown_led", "tpacpi::standby", "tpacpi::dock_status1",
+"tpacpi::dock_status2", "tpacpi::unknown_led2", "tpacpi::unknown_led3",
+"tpacpi::thinkvantage".
 
 Due to limitations in the sysfs LED class, if the status of the LED
 indicators cannot be read due to an error, thinkpad-acpi will report it as
@@ -958,6 +965,12 @@ ThinkPad indicator LED should blink in hardware accelerated mode, use the
 "timer" trigger, and leave the delay_on and delay_off parameters set to
 zero (to request hardware acceleration autodetection).
 
+LEDs that are known not to exist in a given ThinkPad model are not
+made available through the sysfs interface.  If you have a dock and you
+notice there are LEDs listed for your ThinkPad that do not exist (and
+are not in the dock), or if you notice that there are missing LEDs,
+a report to ibm-acpi-devel@lists.sourceforge.net is appreciated.
+
 
 ACPI sounds -- /proc/acpi/ibm/beep
 ----------------------------------
@@ -1555,3 +1568,7 @@ Sysfs interface changelog:
 0x020300:	hotkey enable/disable support removed, attributes
 		hotkey_bios_enabled and hotkey_enable deprecated and
 		marked for removal.
+
+0x020400:	Marker for 16 LEDs support.  Also, LEDs that are known
+		to not exist in a given model are not registered with
+		the LED sysfs class anymore.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index da739d5..06c7c03 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -22,7 +22,7 @@
  */
 
 #define TPACPI_VERSION "0.23"
-#define TPACPI_SYSFS_VERSION 0x020300
+#define TPACPI_SYSFS_VERSION 0x020400
 
 /*
  *  Changelog:
@@ -4815,7 +4815,7 @@ TPACPI_HANDLE(led, ec, "SLED",	/* 570 */
 	   "LED",		/* all others */
 	   );			/* R30, R31 */
 
-#define TPACPI_LED_NUMLEDS 8
+#define TPACPI_LED_NUMLEDS 16
 static struct tpacpi_led_classdev *tpacpi_leds;
 static enum led_status_t tpacpi_led_state_cache[TPACPI_LED_NUMLEDS];
 static const char * const tpacpi_led_names[TPACPI_LED_NUMLEDS] = {
@@ -4828,15 +4828,20 @@ static const char * const tpacpi_led_names[TPACPI_LED_NUMLEDS] = {
 	"tpacpi::dock_batt",
 	"tpacpi::unknown_led",
 	"tpacpi::standby",
+	"tpacpi::dock_status1",
+	"tpacpi::dock_status2",
+	"tpacpi::unknown_led2",
+	"tpacpi::unknown_led3",
+	"tpacpi::thinkvantage",
 };
-#define TPACPI_SAFE_LEDS	0x0081U
+#define TPACPI_SAFE_LEDS	0x1081U
 
 static inline bool tpacpi_is_led_restricted(const unsigned int led)
 {
 #ifdef CONFIG_THINKPAD_ACPI_UNSAFE_LEDS
 	return false;
 #else
-	return (TPACPI_SAFE_LEDS & (1 << led)) == 0;
+	return (1U & (TPACPI_SAFE_LEDS >> led)) == 0;
 #endif
 }
 
@@ -4998,6 +5003,10 @@ static int __init tpacpi_init_led(unsigned int led)
 
 	tpacpi_leds[led].led = led;
 
+	/* LEDs with no name don't get registered */
+	if (!tpacpi_led_names[led])
+		return 0;
+
 	tpacpi_leds[led].led_classdev.brightness_set = &led_sysfs_set;
 	tpacpi_leds[led].led_classdev.blink_set = &led_sysfs_blink_set;
 	if (led_supported == TPACPI_LED_570)
@@ -5016,10 +5025,59 @@ static int __init tpacpi_init_led(unsigned int led)
 	return rc;
 }
 
+static const struct tpacpi_quirk led_useful_qtable[] __initconst = {
+	TPACPI_Q_IBM('1', 'E', 0x009f), /* A30 */
+	TPACPI_Q_IBM('1', 'N', 0x009f), /* A31 */
+	TPACPI_Q_IBM('1', 'G', 0x009f), /* A31 */
+
+	TPACPI_Q_IBM('1', 'I', 0x0097), /* T30 */
+	TPACPI_Q_IBM('1', 'R', 0x0097), /* T40, T41, T42, R50, R51 */
+	TPACPI_Q_IBM('7', '0', 0x0097), /* T43, R52 */
+	TPACPI_Q_IBM('1', 'Y', 0x0097), /* T43 */
+	TPACPI_Q_IBM('1', 'W', 0x0097), /* R50e */
+	TPACPI_Q_IBM('1', 'V', 0x0097), /* R51 */
+	TPACPI_Q_IBM('7', '8', 0x0097), /* R51e */
+	TPACPI_Q_IBM('7', '6', 0x0097), /* R52 */
+
+	TPACPI_Q_IBM('1', 'K', 0x00bf), /* X30 */
+	TPACPI_Q_IBM('1', 'Q', 0x00bf), /* X31, X32 */
+	TPACPI_Q_IBM('1', 'U', 0x00bf), /* X40 */
+	TPACPI_Q_IBM('7', '4', 0x00bf), /* X41 */
+	TPACPI_Q_IBM('7', '5', 0x00bf), /* X41t */
+
+	TPACPI_Q_IBM('7', '9', 0x1f97), /* T60 (1) */
+	TPACPI_Q_IBM('7', '7', 0x1f97), /* Z60* (1) */
+	TPACPI_Q_IBM('7', 'F', 0x1f97), /* Z61* (1) */
+	TPACPI_Q_IBM('7', 'B', 0x1fb7), /* X60 (1) */
+
+	/* (1) - may have excess leds enabled on MSB */
+
+	/* Defaults (order matters, keep last, don't reorder!) */
+	{ /* Lenovo */
+	  .vendor = PCI_VENDOR_ID_LENOVO,
+	  .bios = TPACPI_MATCH_ANY, .ec = TPACPI_MATCH_ANY,
+	  .quirks = 0x1fffU,
+	},
+	{ /* IBM ThinkPads with no EC version string */
+	  .vendor = PCI_VENDOR_ID_IBM,
+	  .bios = TPACPI_MATCH_ANY, .ec = TPACPI_MATCH_UNKNOWN,
+	  .quirks = 0x00ffU,
+	},
+	{ /* IBM ThinkPads with EC version string */
+	  .vendor = PCI_VENDOR_ID_IBM,
+	  .bios = TPACPI_MATCH_ANY, .ec = TPACPI_MATCH_ANY,
+	  .quirks = 0x00bfU,
+	},
+};
+
+#undef TPACPI_LEDQ_IBM
+#undef TPACPI_LEDQ_LNV
+
 static int __init led_init(struct ibm_init_struct *iibm)
 {
 	unsigned int i;
 	int rc;
+	unsigned long useful_leds;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing LED subdriver\n");
 
@@ -5041,6 +5099,9 @@ static int __init led_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "LED commands are %s, mode %d\n",
 		str_supported(led_supported), led_supported);
 
+	if (led_supported == TPACPI_LED_NONE)
+		return 1;
+
 	tpacpi_leds = kzalloc(sizeof(*tpacpi_leds) * TPACPI_LED_NUMLEDS,
 			      GFP_KERNEL);
 	if (!tpacpi_leds) {
@@ -5048,8 +5109,12 @@ static int __init led_init(struct ibm_init_struct *iibm)
 		return -ENOMEM;
 	}
 
+	useful_leds = tpacpi_check_quirks(led_useful_qtable,
+					  ARRAY_SIZE(led_useful_qtable));
+
 	for (i = 0; i < TPACPI_LED_NUMLEDS; i++) {
-		if (!tpacpi_is_led_restricted(i)) {
+		if (!tpacpi_is_led_restricted(i) &&
+		    test_bit(i, &useful_leds)) {
 			rc = tpacpi_init_led(i);
 			if (rc < 0) {
 				led_exit();
@@ -5059,12 +5124,11 @@ static int __init led_init(struct ibm_init_struct *iibm)
 	}
 
 #ifdef CONFIG_THINKPAD_ACPI_UNSAFE_LEDS
-	if (led_supported != TPACPI_LED_NONE)
-		printk(TPACPI_NOTICE
-			"warning: userspace override of important "
-			"firmware LEDs is enabled\n");
+	printk(TPACPI_NOTICE
+		"warning: userspace override of important "
+		"firmware LEDs is enabled\n");
 #endif
-	return (led_supported != TPACPI_LED_NONE)? 0 : 1;
+	return 0;
 }
 
 #define str_led_status(s) \
@@ -5094,7 +5158,7 @@ static int led_read(char *p)
 	}
 
 	len += sprintf(p + len, "commands:\t"
-		       "<led> on, <led> off, <led> blink (<led> is 0-7)\n");
+		       "<led> on, <led> off, <led> blink (<led> is 0-15)\n");
 
 	return len;
 }
@@ -5109,7 +5173,7 @@ static int led_write(char *buf)
 		return -ENODEV;
 
 	while ((cmd = next_cmd(&buf))) {
-		if (sscanf(cmd, "%d", &led) != 1 || led < 0 || led > 7)
+		if (sscanf(cmd, "%d", &led) != 1 || led < 0 || led > 15)
 			return -EINVAL;
 
 		if (strstr(cmd, "off")) {
-- 
1.6.2.4

