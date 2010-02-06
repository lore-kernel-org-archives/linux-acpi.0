From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/4] thinkpad-acpi: fix poll thread auto-start
Date: Sat,  6 Feb 2010 13:30:29 -0200
Message-ID: <1265470230-30797-4-git-send-email-hmh@hmh.eng.br>
References: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51815 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753071Ab0BFPaj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Feb 2010 10:30:39 -0500
In-Reply-To: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The driver was not starting the NVRAM polling thread if the input
device was bound immediately after registration.

This fixes:
http://bugzilla.kernel.org/show_bug.cgi?id=15118

Reported-by: Florian Zumbiehl <florz@florz.de>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a3f440c..f2dee94 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2607,16 +2607,11 @@ static int hotkey_inputdev_open(struct input_dev *dev)
 {
 	switch (tpacpi_lifecycle) {
 	case TPACPI_LIFE_INIT:
-		/*
-		 * hotkey_init will call hotkey_poll_setup_safe
-		 * at the appropriate moment
-		 */
-		return 0;
-	case TPACPI_LIFE_EXITING:
-		return -EBUSY;
 	case TPACPI_LIFE_RUNNING:
 		hotkey_poll_setup_safe(false);
 		return 0;
+	case TPACPI_LIFE_EXITING:
+		return -EBUSY;
 	}
 
 	/* Should only happen if tpacpi_lifecycle is corrupt */
@@ -2627,7 +2622,7 @@ static int hotkey_inputdev_open(struct input_dev *dev)
 static void hotkey_inputdev_close(struct input_dev *dev)
 {
 	/* disable hotkey polling when possible */
-	if (tpacpi_lifecycle == TPACPI_LIFE_RUNNING &&
+	if (tpacpi_lifecycle != TPACPI_LIFE_EXITING &&
 	    !(hotkey_source_mask & hotkey_driver_mask))
 		hotkey_poll_setup_safe(false);
 }
@@ -9038,6 +9033,9 @@ static int __init thinkpad_acpi_module_init(void)
 			return ret;
 		}
 	}
+
+	tpacpi_lifecycle = TPACPI_LIFE_RUNNING;
+
 	ret = input_register_device(tpacpi_inputdev);
 	if (ret < 0) {
 		printk(TPACPI_ERR "unable to register input device\n");
@@ -9047,7 +9045,6 @@ static int __init thinkpad_acpi_module_init(void)
 		tp_features.input_device_registered = 1;
 	}
 
-	tpacpi_lifecycle = TPACPI_LIFE_RUNNING;
 	return 0;
 }
 
-- 
1.6.5.7

