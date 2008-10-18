From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/4] ACPI: thinkpad-acpi: trivial fix of error message
Date: Sat, 18 Oct 2008 14:23:53 -0300
Message-ID: <1224350635-14021-3-git-send-email-hmh@hmh.eng.br>
References: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33756 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928AbYJRRYD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Oct 2008 13:24:03 -0400
In-Reply-To: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Trivial fix makes the error message match the code before it (ibm->driver
vs ibm->acpi-driver) better.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 1dcf066..6c9b6c8 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -582,7 +582,8 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 
 	ibm->acpi->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
 	if (!ibm->acpi->driver) {
-		printk(TPACPI_ERR "kzalloc(ibm->driver) failed\n");
+		printk(TPACPI_ERR
+		       "failed to allocate memory for ibm->acpi->driver\n");
 		return -ENOMEM;
 	}
 
-- 
1.5.6.5

