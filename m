From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/7] ACPI: thinkpad-acpi: issue EV_SYNC after EV_SWITCH
Date: Sat, 22 Sep 2007 22:10:37 -0300
Message-ID: <11905098423456-git-send-email-hmh@hmh.eng.br>
References: <11905098422303-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45140 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852AbXIWBKt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Sep 2007 21:10:49 -0400
In-Reply-To: <11905098422303-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We were missing a input_sync on the radio switch event report path. Add it.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
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
1.5.3.1

