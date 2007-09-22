From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/32] ACPI: thinkpad-acpi: issue EV_SYNC after EV_SWITCH
Date: Fri, 21 Sep 2007 23:46:31 -0400
Message-ID: <11904328193063-git-send-email-lenb@kernel.org>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:53613 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757482AbXIVDrI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:47:08 -0400
In-Reply-To: <1190432818954-git-send-email-lenb@kernel.org>
Message-Id: <bb7babb9ad37bb7b915a9bbb0f46ebc4f8b7300f.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
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
1.5.3.1.27.g57543
