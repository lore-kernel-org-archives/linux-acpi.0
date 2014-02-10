From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH 1/2] ACPI, PCI, ISA: Call ISA-specific code only for architectures which support ISA.
Date: Mon, 10 Feb 2014 14:00:10 +0100
Message-ID: <1392037211-29349-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:35844 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbaBJNAg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Feb 2014 08:00:36 -0500
Received: by mail-ea0-f174.google.com with SMTP id b10so2971548eae.19
        for <linux-acpi@vger.kernel.org>; Mon, 10 Feb 2014 05:00:35 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

This commit enables ISA-specific code if and only if CONFIG_{E}ISA is set
in the kernel configuration so that we do not have to maintain
acpi_isa_irq_to_gsi() function for architectures which do not support ISA.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/pci_irq.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 41c5e1b..b0e31b6 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -418,6 +418,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * driver reported one, then use it. Exit in any case.
 	 */
 	if (gsi < 0) {
+#if IS_ENABLED(CONFIG_ISA) || IS_ENABLED(CONFIG_EISA)
 		u32 dev_gsi;
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq > 0 && (dev->irq <= 0xF) &&
@@ -427,10 +428,9 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 			acpi_register_gsi(&dev->dev, dev_gsi,
 					  ACPI_LEVEL_SENSITIVE,
 					  ACPI_ACTIVE_LOW);
-		} else {
-			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
-				 pin_name(pin));
-		}
+		} else
+#endif
+		dev_warn(&dev->dev, "PCI INT %c: no GSI\n", pin_name(pin));
 
 		return 0;
 	}
-- 
1.7.9.5

