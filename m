From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/26] ACPI: thinkpad-acpi: minor hotkey_radio_sw fixes
Date: Thu, 21 Feb 2008 04:38:02 -0500
Message-ID: <d147da73c9a3f617e4685c6a7762961fe19833e7.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:15600 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756833AbYBUJjP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:39:15 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fixes some minor points in the radio switch code and docs.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/laptops/thinkpad-acpi.txt |    2 +-
 drivers/misc/thinkpad_acpi.c            |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 91f688c..606af16 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -306,7 +306,7 @@ sysfs notes:
 		The recommended polling frequency is 10Hz.
 
 	hotkey_radio_sw:
-		if the ThinkPad has a hardware radio switch, this
+		If the ThinkPad has a hardware radio switch, this
 		attribute will read 0 if the switch is in the "radios
 		disabled" position, and 1 if the switch is in the
 		"radios enabled" position.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3548350..c119cf2 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1161,15 +1161,15 @@ static void tpacpi_input_send_radiosw(void)
 {
 	int wlsw;
 
-	mutex_lock(&tpacpi_inputdev_send_mutex);
-
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
+
 		input_report_switch(tpacpi_inputdev,
 				    SW_RADIO, !!wlsw);
 		input_sync(tpacpi_inputdev);
-	}
 
-	mutex_unlock(&tpacpi_inputdev_send_mutex);
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
+	}
 }
 
 static void tpacpi_input_send_tabletsw(unsigned int state)
-- 
1.5.4

