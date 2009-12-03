From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/8] thinkpad-acpi: fix some version quirks
Date: Thu,  3 Dec 2009 09:41:20 -0200
Message-ID: <1259840485-2516-4-git-send-email-hmh@hmh.eng.br>
References: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33657 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753683AbZLCLl3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 06:41:29 -0500
In-Reply-To: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update some of the BIOS/EC version quirks.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
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
1.6.5.2

