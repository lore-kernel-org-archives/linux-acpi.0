From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/32] ACPI: thinkpad-acpi: add mutex-based locking to input device event send path
Date: Fri, 21 Sep 2007 23:46:32 -0400
Message-ID: <11904328192862-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
 <1190432807843-git-send-email-lenb@kernel.org>
 <1190432808586-git-send-email-lenb@kernel.org>
 <11904328092328-git-send-email-lenb@kernel.org>
 <11904328102889-git-send-email-lenb@kernel.org>
 <1190432811241-git-send-email-lenb@kernel.org>
 <11904328111749-git-send-email-lenb@kernel.org>
 <11904328122495-git-send-email-lenb@kernel.org>
 <1190432813700-git-send-email-lenb@kernel.org>
 <11904328141573-git-send-email-lenb@kernel.org>
 <11904328153830-git-send-email-lenb@kernel.org>
 <11904328151023-git-send-email-lenb@kernel.org>
 <1190432816575-git-send-email-lenb@kernel.org>
 <1190432817158-git-send-email-lenb@kernel.org>
 <1190432818954-git-send-email-lenb@kernel.org>
 <11904328193063-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:53613 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757437AbXIVDrI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:47:08 -0400
In-Reply-To: <11904328193063-git-send-email-lenb@kernel.org>
Message-Id: <92746a28e48c4a850f574f3dea1c073cada35a22.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Protect the input device event sending path with a mutex, since hot key
input events are not atomic and require an cohesive event block to be sent
together.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.3.1.27.g57543
