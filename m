From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 05/10] thinkpad-acpi: silence bogus complain during rmmod
Date: Tue,  8 Dec 2009 23:36:25 -0200
Message-ID: <1260322590-5571-6-git-send-email-hmh@hmh.eng.br>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52536 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967094AbZLIBgc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:36:32 -0500
In-Reply-To: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix this bogus warning during module shutdown, when
backlight event reporting is enabled:

"thinkpad_acpi: required events 0x00018000 not enabled!"

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 4406136..86418cd 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2189,7 +2189,8 @@ static int hotkey_mask_set(u32 mask)
 		       fwmask, hotkey_acpi_mask);
 	}
 
-	hotkey_mask_warn_incomplete_mask();
+	if (tpacpi_lifecycle != TPACPI_LIFE_EXITING)
+		hotkey_mask_warn_incomplete_mask();
 
 	return rc;
 }
-- 
1.6.5.4

