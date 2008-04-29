From: Len Brown <lenb@kernel.org>
Subject: [PATCH 165/171] ACPI: thinkpad-acpi: fluff really minor fix
Date: Tue, 29 Apr 2008 04:44:30 -0400
Message-ID: <998a81bdf167011706cd446174b2ac4ce408d996.1209457073.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28120 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755541AbYD2Ipo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:44 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix a minor (nano?) thing that bothered me at exactly at the wrong time.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 547324e..0d05719 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3880,7 +3880,7 @@ static int led_set_status(unsigned int led, enum led_status_t ledstatus)
 					      led * led_exp_hlbl[ledstatus]);
 			if (rc >= 0)
 				rc = ec_write(TPACPI_LED_EC_HLCL,
-					       led * led_exp_hlcl[ledstatus]);
+					      led * led_exp_hlcl[ledstatus]);
 			break;
 	case TPACPI_LED_NEW:
 			/* all others */
-- 
1.5.5.1.99.gf0ec4

