From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 11/14] ACPI: thinkpad-acpi: fluff really minor fix
Date: Sat, 26 Apr 2008 01:02:27 -0300
Message-ID: <1209182550-32725-12-git-send-email-hmh@hmh.eng.br>
References: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54797 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115AbYDZECi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Apr 2008 00:02:38 -0400
In-Reply-To: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix a minor (nano?) thing that bothered me at exactly at the wrong time.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 2ab3633..f471b46 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3881,7 +3881,7 @@ static int led_set_status(unsigned int led, enum led_status_t ledstatus)
 					      led * led_exp_hlbl[ledstatus]);
 			if (rc >= 0)
 				rc = ec_write(TPACPI_LED_EC_HLCL,
-					       led * led_exp_hlcl[ledstatus]);
+					      led * led_exp_hlcl[ledstatus]);
 			break;
 	case TPACPI_LED_NEW:
 			/* all others */
-- 
1.5.4.4

