From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI, PCI, irq: remove redundant check for null string pointer
Date: Tue,  5 Jan 2016 10:57:11 +0000
Message-ID: <1451991431-8342-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

source is decleared as a 4 byte char array in struct acpi_pci_routing_table
so !prt->source is a redundant null string pointer check. Detected with
smatch:

drivers/acpi/pci_irq.c:134 do_prt_fixups() warn: this array is probably
  non-NULL. 'prt->source'

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/pci_irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index c933675..d30184c 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -131,9 +131,6 @@ static void do_prt_fixups(struct acpi_prt_entry *entry,
 		quirk = &prt_quirks[i];
 
 		/* All current quirks involve link devices, not GSIs */
-		if (!prt->source)
-			continue;
-
 		if (dmi_check_system(quirk->system) &&
 		    entry->id.segment == quirk->segment &&
 		    entry->id.bus == quirk->bus &&
-- 
2.6.4
