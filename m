From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/6] thinkpad-acpi: don't leave ERR_PTR() pointers around
Date: Sun, 20 Sep 2009 14:09:22 -0300
Message-ID: <1253466567-4285-2-git-send-email-hmh@hmh.eng.br>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46977 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754800AbZITRKT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:10:19 -0400
In-Reply-To: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

backlight_device_register returns ERR_PTR() in case of problems, and
the current code would leave that ERR_PTR in ibm_backlight_device.

The current code paths won't touch it in that situation, but that could
change.  Make sure to set ibm_backlight_device to NULL in the error
path.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f78d275..b789ee8 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6010,8 +6010,10 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 					TPACPI_BACKLIGHT_DEV_NAME, NULL, NULL,
 					&ibm_backlight_data);
 	if (IS_ERR(ibm_backlight_device)) {
+		int rc = PTR_ERR(ibm_backlight_device);
+		ibm_backlight_device = NULL;
 		printk(TPACPI_ERR "Could not register backlight device\n");
-		return PTR_ERR(ibm_backlight_device);
+		return rc;
 	}
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_BRGHT,
 			"brightness is supported\n");
-- 
1.6.3.3

