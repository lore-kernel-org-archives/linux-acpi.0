From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/4] ACPI: pci: make new pci.h header local to driver
Date: Fri, 14 Nov 2008 16:02:48 -0700
Message-ID: <20081114230248.18623.76520.stgit@bob.kio>
References: <20081114230117.18623.8172.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:18433 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756256AbYKNXCt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2008 18:02:49 -0500
In-Reply-To: <20081114230117.18623.8172.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

The pci-related declarations in acpi_drivers.h are used
only by the PCI root and related drivers.  The usual way
to do this is to have a per-driver header, so I created
such a header and moved these declarations to it.

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
index 4b252ea..676d0a4 100644
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
index 11acaee..a5ba18c 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -38,6 +38,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "pci.h"
+
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_irq");
 
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 642554b..5a8fc37 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -35,6 +35,8 @@
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
 

