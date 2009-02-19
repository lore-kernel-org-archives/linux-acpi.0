From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/3] ACPI: pci: make new pci.h header local to driver
Date: Thu, 19 Feb 2009 12:51:43 -0700
Message-ID: <20090219195143.20619.18258.stgit@bob.kio>
References: <20090219195009.20619.20334.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:30516 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZBSTvo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Feb 2009 14:51:44 -0500
In-Reply-To: <20090219195009.20619.20334.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

The PCI-related declarations in acpi_drivers.h are used
only by the PCI root and related drivers.  This patch moves
those declarations to a new drivers/acpi/pci.h file.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci.h          |   18 ++++++++++++++++++
 drivers/acpi/pci_bind.c     |    2 ++
 drivers/acpi/pci_irq.c      |    2 ++
 drivers/acpi/pci_root.c     |    2 ++
 include/acpi/acpi_drivers.h |   13 -------------
 5 files changed, 24 insertions(+), 13 deletions(-)
 create mode 100644 drivers/acpi/pci.h

diff --git a/drivers/acpi/pci.h b/drivers/acpi/pci.h
new file mode 100644
index 0000000..b3512cf
--- /dev/null
+++ b/drivers/acpi/pci.h
@@ -0,0 +1,18 @@
+/* ACPI PCI Interrupt Link (pci_link.c) */
+
+int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
+			       int *polarity, char **name);
+int acpi_pci_link_free_irq(acpi_handle handle);
+
+/* ACPI PCI Interrupt Routing (pci_irq.c) */
+
+int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus);
+void acpi_pci_irq_del_prt(int segment, int bus);
+
+/* ACPI PCI Device Binding (pci_bind.c) */
+
+struct pci_bus;
+
+int acpi_pci_bind(struct acpi_device *device);
+int acpi_pci_bind_root(struct acpi_device *device, struct acpi_pci_id *id,
+		       struct pci_bus *bus);
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 95650f8..5504c9d 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -35,6 +35,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "pci.h"
+
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_bind");
 
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index be6b909..c20c848 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -40,6 +40,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "pci.h"
+
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_irq");
 
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 5b38a02..61e8979 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -36,6 +36,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "pci.h"
+
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 5fc1bb0..9ea2684 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -75,23 +75,10 @@
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_irq_penalty_init(void);
-int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
-			       int *polarity, char **name);
-int acpi_pci_link_free_irq(acpi_handle handle);
-
-/* ACPI PCI Interrupt Routing (pci_irq.c) */
-
-int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus);
-void acpi_pci_irq_del_prt(int segment, int bus);
 
 /* ACPI PCI Device Binding (pci_bind.c) */
 
-struct pci_bus;
-
 acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id);
-int acpi_pci_bind(struct acpi_device *device);
-int acpi_pci_bind_root(struct acpi_device *device, struct acpi_pci_id *id,
-		       struct pci_bus *bus);
 
 /* Arch-defined function to add a bus to the system */
 

