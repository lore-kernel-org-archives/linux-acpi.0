From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 6/8] thinkpad-acpi: adopt input device
Date: Thu,  3 Dec 2009 09:41:23 -0200
Message-ID: <1259840485-2516-7-git-send-email-hmh@hmh.eng.br>
References: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34937 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754000AbZLCLla (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 06:41:30 -0500
In-Reply-To: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Properly init the parent field of the input device.  Thanks to Alan
Jenkins, who noted this problem in a different driver.

Reported-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 86418cd..dd8bd07 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8375,6 +8375,7 @@ static int __init thinkpad_acpi_module_init(void)
 						PCI_VENDOR_ID_IBM;
 		tpacpi_inputdev->id.product = TPACPI_HKEY_INPUT_PRODUCT;
 		tpacpi_inputdev->id.version = TPACPI_HKEY_INPUT_VERSION;
+		tpacpi_inputdev->dev.parent = &tpacpi_pdev->dev;
 	}
 	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
 		ret = ibm_init(&ibms_init[i]);
-- 
1.6.5.2

