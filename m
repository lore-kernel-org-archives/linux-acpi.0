From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PCI: Do not try to acquire _OSC control if that is hopeless
Date: Mon, 30 Jul 2012 22:40:32 +0200
Message-ID: <201207302240.32480.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


If acpi_pci_osc_support() fails for the given flags, it doesn't make
sense to call acpi_pci_osc_control_set() down the road for the same
flags, because it will certainly fail too.  Moreover, problem
diagnostics is then harder, because it is not too easy to identify
the reason of the _OSC failure in those cases.

For this reason, check the status returned by acpi_pci_osc_support()
for PCIe support flags and do not attempt to execute
acpi_pci_osc_control_set() for those flags and print a message if
it's "failure".  For compatibility with the existing code, disable
ASPM in that case too.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/pci_root.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Index: linux/drivers/acpi/pci_root.c
===================================================================
--- linux.orig/drivers/acpi/pci_root.c
+++ linux/drivers/acpi/pci_root.c
@@ -573,8 +573,15 @@ static int __devinit acpi_pci_root_add(s
 			OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
 	if (pci_msi_enabled())
 		flags |= OSC_MSI_SUPPORT;
-	if (flags != base_flags)
-		acpi_pci_osc_support(root, flags);
+	if (flags != base_flags) {
+		status = acpi_pci_osc_support(root, flags);
+		if (ACPI_FAILURE(status)) {
+			dev_info(root->bus->bridge, "ACPI _OSC support "
+				"notification failed, disabling PCIe ASPM\n");
+			pcie_no_aspm();
+			flags = base_flags;
+		}
+	}
 
 	if (!pcie_ports_disabled
 	    && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
