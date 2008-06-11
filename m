From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/23] thinkpad-acpi: SW_RADIO to SW_RFKILL_ALL rename
Date: Wed, 11 Jun 2008 03:59:06 -0400
Message-ID: <5183e52edee67d221f5e53f1443e3a7614fb2530.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:37090 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbYFKH73 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:29 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A007Q0GV446G2@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:29 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Rename SW_RADIO to SW_RFKILL_ALL in thinkpad-acpi code and docs, following
5adad0133907790c50283bf03271d920d6897043 "Input: rename SW_RADIO to
SW_RFKILL_ALL".

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.6.rc2.23.gea81e

