From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] ACPI: Remove unused struct acpi_pci_root.id member
Date: Wed, 19 Dec 2012 10:30:44 -0700
Message-ID: <20121219173044.12424.11336.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This member is never initialized and never referenced, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/acpi/acpi_bus.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7ced5dc..4f42c0e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -397,7 +397,6 @@ int unregister_acpi_bus_type(struct acpi_bus_type *);
 struct acpi_pci_root {
 	struct list_head node;
 	struct acpi_device * device;
-	struct acpi_pci_id id;
 	struct pci_bus *bus;
 	u16 segment;
 	struct resource secondary;	/* downstream bus range */
