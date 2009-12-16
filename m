From: Len Brown <lenb@kernel.org>
Subject: [PATCH 014/103] thinkpad-acpi: adopt input device
Date: Wed, 16 Dec 2009 03:35:25 -0500
Message-ID: <d112ef95d4ec1ee7fe7123e3f21e4aac0d57570c.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62434 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761874AbZLPJGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:09 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:55 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Properly init the parent field of the input device.  Thanks to Alan
Jenkins, who noted this problem in a different driver.

Reported-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

