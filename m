From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V9 2/2] ACPI, PCI, irq: remove interrupt number restriction
Date: Wed,  9 Dec 2015 11:18:28 -0500
Message-ID: <1449677909-12432-3-git-send-email-okaya@codeaurora.org>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, helgaas@kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The ACPI compiler uses the extended format when used interrupt numbers
are greater than 15. The extended IRQ syntax is 32 bits according to the
ACPI spec. The code supports parsing the extended interrupt numbers.
However, due to used data structure type; the code silently truncates
interrupt numbers greater than 256.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 0286f17..5114d80 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -68,12 +68,12 @@ static struct acpi_scan_handler pci_link_handler = {
  * later even the link is disable. Instead, we just repick the active irq
  */
 struct acpi_pci_link_irq {
-	u8 active;		/* Current IRQ */
+	u32 active;		/* Current IRQ */
 	u8 triggering;		/* All IRQs */
 	u8 polarity;		/* All IRQs */
 	u8 resource_type;
 	u8 possible_count;
-	u8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
+	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 	u8 initialized:1;
 	u8 reserved:7;
 };
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
