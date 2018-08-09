From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH 1/2] PCI/ACPI: correct error message for ASPM disabling
Date: Thu,  9 Aug 2018 18:46:22 +0000
Message-ID: <1533840383-7841-1-git-send-email-okaya@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

If _OSC execution fails today for platforms without an _OSC
entry, code is printing a misleading message saying disabling
ASPM as follows:

acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

We need to ensure that platform supports ASPM to begin with.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reported-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/acpi/pci_root.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7433035..9d738e2 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -455,8 +455,13 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
 	if (ACPI_FAILURE(status)) {
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
-			 acpi_format_exception(status));
+		char *aspm_msg = "";
+
+		if (pcie_aspm_support_enabled())
+			aspm_msg = "; disabling ASPM";
+
+		dev_info(&device->dev, "_OSC failed (%s) %s\n",
+				 acpi_format_exception(status), aspm_msg);
 		*no_aspm = 1;
 		return;
 	}
-- 
2.7.4
