From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 08/13] ACPI: thinkpad-acpi: add sysfs led class support for thinklight (v3.1)
Date: Thu, 10 Apr 2008 00:53:00 -0300
Message-ID: <1207799585-10112-9-git-send-email-hmh@hmh.eng.br>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53671 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755017AbYDJDxN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 23:53:13 -0400
In-Reply-To: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Purdie <rpurdie@rpsys.net>

Add a sysfs led class interface to the thinklight (light subdriver).

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Purdie <rpurdie@rpsys.net>
---
 Documentation/laptops/thinkpad-acpi.txt |   25 +++++++++++---
 drivers/misc/thinkpad_acpi.c            |   57 ++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 0f403ff..22c1ac4 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -692,16 +692,31 @@ while others are still having problems. For more information:
 
 https://bugs.freedesktop.org/show_bug.cgi?id=2000
 
-ThinkLight control -- /proc/acpi/ibm/light
-------------------------------------------
+ThinkLight control
+------------------
+
+procfs: /proc/acpi/ibm/light
+sysfs attributes: as per led class, for the "tpacpi::thinklight" led
+
+procfs notes:
 
-The current status of the ThinkLight can be found in this file. A few
-models which do not make the status available will show it as
-"unknown". The available commands are:
+The ThinkLight status can be read and set through the procfs interface.  A
+few models which do not make the status available will show the ThinkLight
+status as "unknown". The available commands are:
 
 	echo on  > /proc/acpi/ibm/light
 	echo off > /proc/acpi/ibm/light
 
+sysfs notes:
+
+The ThinkLight sysfs interface is documented by the led class
+documentation, in Documentation/leds-class.txt.  The ThinkLight led name
+is "tpacpi::thinklight".
+
+Due to limitations in the sysfs led class, if the status of the thinklight
+cannot be read or if it is unknown, thinkpad-acpi will report it as "off".
+It is impossible to know if the status returned through sysfs is valid.
+
 Docking / undocking -- /proc/acpi/ibm/dock
 ------------------------------------------
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c39f1ad..f647dc7 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3279,13 +3279,49 @@ static int light_set_status(int status)
 	return -ENXIO;
 }
 
+static void light_set_status_worker(struct work_struct *work)
+{
+	struct tpacpi_led_classdev *data =
+			container_of(work, struct tpacpi_led_classdev, work);
+
+	if (likely(tpacpi_lifecycle == TPACPI_LIFE_RUNNING))
+		light_set_status((data->new_brightness != LED_OFF));
+}
+
+static void light_sysfs_set(struct led_classdev *led_cdev,
+			enum led_brightness brightness)
+{
+	struct tpacpi_led_classdev *data =
+		container_of(led_cdev,
+			     struct tpacpi_led_classdev,
+			     led_classdev);
+	data->new_brightness = brightness;
+	schedule_work(&data->work);
+}
+
+static enum led_brightness light_sysfs_get(struct led_classdev *led_cdev)
+{
+	return (light_get_status() == 1)? LED_FULL : LED_OFF;
+}
+
+static struct tpacpi_led_classdev tpacpi_led_thinklight = {
+	.led_classdev = {
+		.name		= "tpacpi::thinklight",
+		.brightness_set	= &light_sysfs_set,
+		.brightness_get	= &light_sysfs_get,
+	}
+};
+
 static int __init light_init(struct ibm_init_struct *iibm)
 {
+	int rc = 0;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing light subdriver\n");
 
 	TPACPI_ACPIHANDLE_INIT(ledb);
 	TPACPI_ACPIHANDLE_INIT(lght);
 	TPACPI_ACPIHANDLE_INIT(cmos);
+	INIT_WORK(&tpacpi_led_thinklight.work, light_set_status_worker);
 
 	/* light not supported on 570, 600e/x, 770e, 770x, G4x, R30, R31 */
 	tp_features.light = (cmos_handle || lght_handle) && !ledb_handle;
@@ -3299,7 +3335,25 @@ static int __init light_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "light is %s\n",
 		str_supported(tp_features.light));
 
-	return (tp_features.light)? 0 : 1;
+	if (tp_features.light) {
+		rc = led_classdev_register(&tpacpi_pdev->dev,
+					   &tpacpi_led_thinklight.led_classdev);
+	}
+
+	if (rc < 0) {
+		tp_features.light = 0;
+		tp_features.light_status = 0;
+	} else {
+		rc = (tp_features.light)? 0 : 1;
+	}
+	return rc;
+}
+
+static void light_exit(void)
+{
+	led_classdev_unregister(&tpacpi_led_thinklight.led_classdev);
+	if (work_pending(&tpacpi_led_thinklight.work))
+		flush_scheduled_work();
 }
 
 static int light_read(char *p)
@@ -3347,6 +3401,7 @@ static struct ibm_struct light_driver_data = {
 	.name = "light",
 	.read = light_read,
 	.write = light_write,
+	.exit = light_exit,
 };
 
 /*************************************************************************
-- 
1.5.4.4

