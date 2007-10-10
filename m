From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/37] ACPI: thinkpad-acpi: issue EV_SYNC after EV_SWITCH
Date: Wed, 10 Oct 2007 01:06:18 -0400
Message-ID: <1191992804-14965-12-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20396 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751002AbXJJFGx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:53 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <f4e1e43c607b5ead89b2135c348392810420de69.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We were missing a input_sync on the radio switch event report path. Add it.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 0222bba..8aa0f96 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1149,9 +1149,11 @@ static void tpacpi_input_send_radiosw(void)
 {
 	int wlsw;
 
-	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw))
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
 		input_report_switch(tpacpi_inputdev,
 				    SW_RADIO, !!wlsw);
+		input_sync(tpacpi_inputdev);
+	}
 }
 
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
-- 
1.5.3.4.206.g58ba4
