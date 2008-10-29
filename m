From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 7/8] PCI: check if MSI is enabled before adding _OSC support
	capability
Date: Tue, 28 Oct 2008 23:48:51 -0600
Message-ID: <20081029054851.2263.36283.stgit@bob.kio>
References: <20081029054815.2263.40833.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081029054815.2263.40833.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx
List-Id: linux-acpi@vger.kernel.org

PCI: check if MSI is enabled before adding _OSC support capability

Ensure that pci=nomsi is not set before adding the _OSC support capability
OSC_MSI_SUPPORT to the root bridge.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

 drivers/acpi/pci_root.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)


diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 75a59ea..32afd02 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -194,6 +194,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	unsigned long long value = 0;
 	acpi_handle handle = NULL;
 	struct acpi_device *child;
+	u32 flags;
 
 
 	if (!device)
@@ -211,17 +212,18 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 
 	device->ops.bind = acpi_pci_bind;
 
-	pci_acpi_osc_support(device->handle,
-			     OSC_EXT_PCI_CONFIG_SUPPORT |
-			     OSC_PCI_SEGMENT_GROUPS_SUPPORT |
-#ifdef CONFIG_PCI_MSI
-			     OSC_MSI_SUPPORT |
-#endif
+	flags = (OSC_EXT_PCI_CONFIG_SUPPORT |
+		 OSC_PCI_SEGMENT_GROUPS_SUPPORT |
 #ifdef CONFIG_PCIEASPM
-			     OSC_ACTIVE_STATE_PWR_SUPPORT |
-			     OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
+		 OSC_ACTIVE_STATE_PWR_SUPPORT |
+		 OSC_CLOCK_PWR_CAPABILITY_SUPPORT |
+#endif
+		 0);
+#ifdef CONFIG_PCI_MSI
+	if (pci_msi_enabled())
+		flags |= OSC_MSI_SUPPORT;
 #endif
-			     0);
+	pci_acpi_osc_support(device->handle, flags);
 
 	/* 
 	 * Segment
