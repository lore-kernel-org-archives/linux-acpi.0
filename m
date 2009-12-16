From: Len Brown <lenb@kernel.org>
Subject: [PATCH 011/103] thinkpad-acpi: fix some version quirks
Date: Wed, 16 Dec 2009 03:35:22 -0500
Message-ID: <90765c6aee568137521ba19347c744b5abde8161.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760535AbZLPKFv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:05:51 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:51 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update some of the BIOS/EC version quirks.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 1ee734c..6160813 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1779,7 +1779,7 @@ static const struct tpacpi_quirk tpacpi_bios_version_qtable[] __initconst = {
 
 	TPV_QL1('7', '9',  'E', '3',  '5', '0'), /* T60/p */
 	TPV_QL1('7', 'C',  'D', '2',  '2', '2'), /* R60, R60i */
-	TPV_QL0('7', 'E',  'D', '0'),		 /* R60e, R60i */
+	TPV_QL1('7', 'E',  'D', '0',  '1', '5'), /* R60e, R60i */
 
 	/*      BIOS FW    BIOS VERS  EC FW     EC VERS */
 	TPV_QI2('1', 'W',  '9', '0',  '1', 'V', '2', '8'), /* R50e (1) */
@@ -1795,8 +1795,8 @@ static const struct tpacpi_quirk tpacpi_bios_version_qtable[] __initconst = {
 	TPV_QI1('7', '4',  '6', '4',  '2', '7'), /* X41 (0) */
 	TPV_QI1('7', '5',  '6', '0',  '2', '0'), /* X41t (0) */
 
-	TPV_QL0('7', 'B',  'D', '7'),		 /* X60/s */
-	TPV_QL0('7', 'J',  '3', '0'),		 /* X60t */
+	TPV_QL1('7', 'B',  'D', '7',  '4', '0'), /* X60/s */
+	TPV_QL1('7', 'J',  '3', '0',  '1', '3'), /* X60t */
 
 	/* (0) - older versions lack DMI EC fw string and functionality */
 	/* (1) - older versions known to lack functionality */
-- 
1.6.0.6

