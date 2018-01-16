From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH] ACPI/PCI: pci_link: reduce verbosity when IRQ is enabled
Date: Tue, 16 Jan 2018 13:51:04 -0500
Message-ID: <1516128664-23634-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeAPSvL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jan 2018 13:51:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

When ACPI Link object is enabled, the message is printed with a warning
prefix. Some test tools are capturing warning and test error types as
errors. Let's reduce the verbosity of success case.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index bc3d914..85ad679 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -612,7 +612,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 			acpi_isa_irq_penalty[link->irq.active] +=
 				PIRQ_PENALTY_PCI_USING;
 
-		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
+		pr_info("%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
 	}
-- 
1.9.1

