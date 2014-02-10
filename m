From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH 2/2] ACPI, PCI, ISA: Fix memory leak when there is no IRQ in the ACPI subsystem.
Date: Mon, 10 Feb 2014 14:00:11 +0100
Message-ID: <1392037211-29349-2-git-send-email-tomasz.nowicki@linaro.org>
References: <1392037211-29349-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392037211-29349-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Whenever we register ISA interrupt or not, we need to free the IRQ routing
table entry.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/pci_irq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b0e31b6..6ec0f36 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -432,6 +432,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 #endif
 		dev_warn(&dev->dev, "PCI INT %c: no GSI\n", pin_name(pin));
 
+		kfree(entry);
 		return 0;
 	}
 
-- 
1.7.9.5
