From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/26] ACPI: thinkpad-acpi: always track input device open/close
Date: Thu, 21 Feb 2008 04:37:57 -0500
Message-ID: <1bc6b9cdd5e608f0b7e6160a823c9dcd51820410.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:38020 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759030AbYBUJjH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:39:07 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The open() and close() hooks for the input device are useful even when
hotkey NVRAM polling support is not in use, so it is better to always have
them around.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 723d37b..6da3f40 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1417,6 +1417,14 @@ static void hotkey_poll_setup_safe(int may_warn)
 	mutex_unlock(&hotkey_mutex);
 }
 
+#else /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
+static void hotkey_poll_setup_safe(int __unused)
+{
+}
+
+#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
 static int hotkey_inputdev_open(struct input_dev *dev)
 {
 	switch (tpacpi_lifecycle) {
@@ -1444,7 +1452,6 @@ static void hotkey_inputdev_close(struct input_dev *dev)
 	if (tpacpi_lifecycle == TPACPI_LIFE_RUNNING)
 		hotkey_poll_setup_safe(0);
 }
-#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
@@ -2023,12 +2030,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 				(hotkey_report_mode < 2) ?
 					"enabled" : "disabled");
 
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 		tpacpi_inputdev->open = &hotkey_inputdev_open;
 		tpacpi_inputdev->close = &hotkey_inputdev_close;
 
 		hotkey_poll_setup_safe(1);
-#endif
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -2221,9 +2226,7 @@ static void hotkey_resume(void)
 	hotkey_radio_sw_notify_change();
 	hotkey_wakeup_reason_notify_change();
 	hotkey_wakeup_hotunplug_complete_notify_change();
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_poll_setup_safe(0);
-#endif
 }
 
 /* procfs -------------------------------------------------------------- */
-- 
1.5.4

