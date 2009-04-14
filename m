From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/5] thinkpad-acpi: fix LED blinking through timer trigger
Date: Mon, 13 Apr 2009 23:44:11 -0300
Message-ID: <1239677054-3221-3-git-send-email-hmh@hmh.eng.br>
References: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40193 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750721AbZDNCoU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 22:44:20 -0400
In-Reply-To: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, stable@kernel.org

The set_blink hook code in the LED subdriver would never manage to get
a LED to blink, and instead it would just turn it on.  The consequence
of this is that the "timer" trigger would not cause the LED to blink
if given default parameters.

This problem exists since 2.6.26-rc1.

To fix it, switch the deferred LED work handling to use the
thinkpad-acpi-specific LED status (off/on/blink) directly.

This also makes the code easier to read, and to extend later.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: stable@kernel.org
---
 drivers/platform/x86/thinkpad_acpi.c |   41 +++++++++++++++------------------
 1 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a186c5b..a1d2abc 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -303,11 +303,17 @@ static u32 dbg_level;
 
 static struct workqueue_struct *tpacpi_wq;
 
+enum led_status_t {
+	TPACPI_LED_OFF = 0,
+	TPACPI_LED_ON,
+	TPACPI_LED_BLINK,
+};
+
 /* Special LED class that can defer work */
 struct tpacpi_led_classdev {
 	struct led_classdev led_classdev;
 	struct work_struct work;
-	enum led_brightness new_brightness;
+	enum led_status_t new_state;
 	unsigned int led;
 };
 
@@ -4213,7 +4219,7 @@ static void light_set_status_worker(struct work_struct *work)
 			container_of(work, struct tpacpi_led_classdev, work);
 
 	if (likely(tpacpi_lifecycle == TPACPI_LIFE_RUNNING))
-		light_set_status((data->new_brightness != LED_OFF));
+		light_set_status((data->new_state != TPACPI_LED_OFF));
 }
 
 static void light_sysfs_set(struct led_classdev *led_cdev,
@@ -4223,7 +4229,8 @@ static void light_sysfs_set(struct led_classdev *led_cdev,
 		container_of(led_cdev,
 			     struct tpacpi_led_classdev,
 			     led_classdev);
-	data->new_brightness = brightness;
+	data->new_state = (brightness != LED_OFF) ?
+				TPACPI_LED_ON : TPACPI_LED_OFF;
 	queue_work(tpacpi_wq, &data->work);
 }
 
@@ -4730,12 +4737,6 @@ enum {	/* For TPACPI_LED_OLD */
 	TPACPI_LED_EC_HLMS = 0x0e,	/* EC reg to select led to command */
 };
 
-enum led_status_t {
-	TPACPI_LED_OFF = 0,
-	TPACPI_LED_ON,
-	TPACPI_LED_BLINK,
-};
-
 static enum led_access_mode led_supported;
 
 TPACPI_HANDLE(led, ec, "SLED",	/* 570 */
@@ -4847,23 +4848,13 @@ static int led_set_status(const unsigned int led,
 	return rc;
 }
 
-static void led_sysfs_set_status(unsigned int led,
-				 enum led_brightness brightness)
-{
-	led_set_status(led,
-			(brightness == LED_OFF) ?
-			TPACPI_LED_OFF :
-			(tpacpi_led_state_cache[led] == TPACPI_LED_BLINK) ?
-				TPACPI_LED_BLINK : TPACPI_LED_ON);
-}
-
 static void led_set_status_worker(struct work_struct *work)
 {
 	struct tpacpi_led_classdev *data =
 		container_of(work, struct tpacpi_led_classdev, work);
 
 	if (likely(tpacpi_lifecycle == TPACPI_LIFE_RUNNING))
-		led_sysfs_set_status(data->led, data->new_brightness);
+		led_set_status(data->led, data->new_state);
 }
 
 static void led_sysfs_set(struct led_classdev *led_cdev,
@@ -4872,7 +4863,13 @@ static void led_sysfs_set(struct led_classdev *led_cdev,
 	struct tpacpi_led_classdev *data = container_of(led_cdev,
 			     struct tpacpi_led_classdev, led_classdev);
 
-	data->new_brightness = brightness;
+	if (brightness == LED_OFF)
+		data->new_state = TPACPI_LED_OFF;
+	else if (tpacpi_led_state_cache[data->led] != TPACPI_LED_BLINK)
+		data->new_state = TPACPI_LED_ON;
+	else
+		data->new_state = TPACPI_LED_BLINK;
+
 	queue_work(tpacpi_wq, &data->work);
 }
 
@@ -4890,7 +4887,7 @@ static int led_sysfs_blink_set(struct led_classdev *led_cdev,
 	} else if ((*delay_on != 500) || (*delay_off != 500))
 		return -EINVAL;
 
-	data->new_brightness = TPACPI_LED_BLINK;
+	data->new_state = TPACPI_LED_BLINK;
 	queue_work(tpacpi_wq, &data->work);
 
 	return 0;
-- 
1.6.2.1

