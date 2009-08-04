From: Alex Chiang <achiang@hp.com>
Subject: [PATCH] ACPI: pci_slot.ko wants a 64-bit _SUN
Date: Tue, 4 Aug 2009 14:44:17 -0600
Message-ID: <20090804204417.GA26918@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755316AbZHDUoU@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: chad.smith@hp.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: linux-acpi@vger.kernel.org

Similar to commit b6adc195 (PCI hotplug: acpiphp wants a 64-bit
_SUN), pci_slot.ko reads and creates sysfs directories based on
the _SUN method.

Certain HP platforms return 64 bits in _SUN. This change to
pci_slot.ko allows us to see the correct sysfs directories.

Reported-by: Chad Smith <chad.smith@hp.com>
Cc: stable@kernel.org
Signed-off-by: Alex Chiang <achiang@hp.com>
---
Stable team, this should be backported to all kernels in the
stable series.

---
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 12158e0..ab40e06 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -57,7 +57,7 @@ ACPI_MODULE_NAME("pci_slot");
 				MY_NAME , ## arg);		\
 	} while (0)
 
-#define SLOT_NAME_SIZE 20		/* Inspired by #define in acpiphp.h */
+#define SLOT_NAME_SIZE 21		/* Inspired by #define in acpiphp.h */
 
 struct acpi_pci_slot {
 	acpi_handle root_handle;	/* handle of the root bridge */
@@ -149,7 +149,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 		return AE_OK;
 	}
 
-	snprintf(name, sizeof(name), "%u", (u32)sun);
+	snprintf(name, sizeof(name), "%llu", sun);
 	pci_slot = pci_create_slot(pci_bus, device, name, NULL);
 	if (IS_ERR(pci_slot)) {
 		err("pci_create_slot returned %ld\n", PTR_ERR(pci_slot));
