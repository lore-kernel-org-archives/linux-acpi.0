From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/7] ACPI: thinkpad-acpi: add mutex-based locking to input device event send path
Date: Thu, 20 Sep 2007 10:50:56 -0300
Message-ID: <11902962613078-git-send-email-hmh@hmh.eng.br>
References: <11902962603691-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51911 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754682AbXITNvI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Sep 2007 09:51:08 -0400
In-Reply-To: <11902962603691-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Protect the input device event sending path with a mutex, since hot key
input events are not atomic and require an cohesive event block to be sent
together.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 8aa0f96..0ced9d6 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -519,6 +519,7 @@ static char *next_cmd(char **cmds)
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
 static struct input_dev *tpacpi_inputdev;
+static struct mutex tpacpi_inputdev_send_mutex;
 
 
 static int tpacpi_resume_handler(struct platform_device *pdev)
@@ -1131,6 +1132,8 @@ static void tpacpi_input_send_key(unsigned int scancode,
 				  unsigned int keycode)
 {
 	if (keycode != KEY_RESERVED) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
+
 		input_report_key(tpacpi_inputdev, keycode, 1);
 		if (keycode == KEY_UNKNOWN)
 			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
@@ -1142,6 +1145,8 @@ static void tpacpi_input_send_key(unsigned int scancode,
 			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
 				    scancode);
 		input_sync(tpacpi_inputdev);
+
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
 	}
 }
 
@@ -1149,11 +1154,15 @@ static void tpacpi_input_send_radiosw(void)
 {
 	int wlsw;
 
+	mutex_lock(&tpacpi_inputdev_send_mutex);
+
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
 		input_report_switch(tpacpi_inputdev,
 				    SW_RADIO, !!wlsw);
 		input_sync(tpacpi_inputdev);
 	}
+
+	mutex_unlock(&tpacpi_inputdev_send_mutex);
 }
 
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
@@ -4737,6 +4746,7 @@ static int __init thinkpad_acpi_module_init(void)
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+	mutex_init(&tpacpi_inputdev_send_mutex);
 	tpacpi_inputdev = input_allocate_device();
 	if (!tpacpi_inputdev) {
 		printk(IBM_ERR "unable to allocate input device\n");
-- 
1.5.3.1

