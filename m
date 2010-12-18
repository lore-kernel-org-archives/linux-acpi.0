From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH] PCI / Hotplug: Fix unexpected driver unregister in pciehp_acpi.c
Date: Sat, 18 Dec 2010 13:29:45 +0100
Message-ID: <201012181329.46071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If pcie_ports_disabled is set, pcie_port_service_register() returns
error code and select_detection_mode() should not attempt to
unregister dummy_driver and use dummy_slots.  It should return
PCIEHP_DETECT_ACPI immediately instead.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi Jesse,

I'm not sure if you've got this patch.  It fixes a problem introduced in the
2.6.37 merge window, so I guess it should be merged before 2.6.37 final.

Details in https://bugzilla.kernel.org/show_bug.cgi?id=20232#c23 .

Thanks,
Rafael

---
 drivers/pci/hotplug/pciehp_acpi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_acpi.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_acpi.c
@@ -115,7 +115,8 @@ static struct pcie_port_service_driver _
 static int __init select_detection_mode(void)
 {
 	struct dummy_slot *slot, *tmp;
-	pcie_port_service_register(&dummy_driver);
+	if (pcie_port_service_register(&dummy_driver))
+		return PCIEHP_DETECT_ACPI;
 	pcie_port_service_unregister(&dummy_driver);
 	list_for_each_entry_safe(slot, tmp, &dummy_slots, list) {
 		list_del(&slot->list);
