From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / hotplug / PCI: Drop unnecessary parentheses
Date: Tue, 29 Aug 2017 14:56:05 +0300
Message-ID: <20170829115605.33643-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52783 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbdH2L4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Aug 2017 07:56:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

There is no need for them and it makes the code look uglier than it
should. Remove them.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 5ed2dcaa8e27..4e07441660e6 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -527,7 +527,7 @@ static void disable_slot(struct acpiphp_slot *slot)
 	list_for_each_entry(func, &slot->funcs, sibling)
 		acpi_bus_trim(func_to_acpi_device(func));
 
-	slot->flags &= (~SLOT_ENABLED);
+	slot->flags &= ~SLOT_ENABLED;
 }
 
 static bool slot_no_hotplug(struct acpiphp_slot *slot)
-- 
2.14.1

