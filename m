From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/3] SW_RADIO to SW_RFKILL_ALL rename
Date: Tue,  3 Jun 2008 23:36:09 -0300
Message-ID: <1212546971-29736-2-git-send-email-hmh@hmh.eng.br>
References: <1212546971-29736-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59403 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935AbYFDCgP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jun 2008 22:36:15 -0400
In-Reply-To: <1212546971-29736-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Rename SW_RADIO to SW_RFKILL_ALL in thinkpad-acpi code and docs, following
5adad0133907790c50283bf03271d920d6897043 "Input: rename SW_RADIO to
SW_RFKILL_ALL".

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    2 +-
 drivers/misc/thinkpad_acpi.c            |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 01c6c3d..64b3f14 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -503,7 +503,7 @@ generate input device EV_KEY events.
 In addition to the EV_KEY events, thinkpad-acpi may also issue EV_SW
 events for switches:
 
-SW_RADIO	T60 and later hardare rfkill rocker switch
+SW_RFKILL_ALL	T60 and later hardare rfkill rocker switch
 SW_TABLET_MODE	Tablet ThinkPads HKEY events 0x5009 and 0x500A
 
 Non hot-key ACPI HKEY event map:
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index a0ce0b2..f81e048 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1293,7 +1293,7 @@ static void tpacpi_input_send_radiosw(void)
 		mutex_lock(&tpacpi_inputdev_send_mutex);
 
 		input_report_switch(tpacpi_inputdev,
-				    SW_RADIO, !!wlsw);
+				    SW_RFKILL_ALL, !!wlsw);
 		input_sync(tpacpi_inputdev);
 
 		mutex_unlock(&tpacpi_inputdev_send_mutex);
@@ -2199,7 +2199,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 		if (tp_features.hotkey_wlsw) {
 			set_bit(EV_SW, tpacpi_inputdev->evbit);
-			set_bit(SW_RADIO, tpacpi_inputdev->swbit);
+			set_bit(SW_RFKILL_ALL, tpacpi_inputdev->swbit);
 		}
 		if (tp_features.hotkey_tablet) {
 			set_bit(EV_SW, tpacpi_inputdev->evbit);
-- 
1.5.5.3

