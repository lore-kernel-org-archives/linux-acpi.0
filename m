From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/9] Revert "PCI: allocate bus resources from the top down"
Date: Thu, 16 Dec 2010 10:38:36 -0700
Message-ID: <20101216173836.8185.67037.stgit@bob.kio>
References: <20101216173614.8185.19462.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101216173614.8185.19462.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org


This reverts commit b126b4703afa4010b161784a43650337676dd03b.

We're going back to the old behavior of allocating from bus resources
in _CRS order.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pci/bus.c |   53 +++++------------------------------------------------
 1 files changed, 5 insertions(+), 48 deletions(-)


diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5624db8..69546e9 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -64,49 +64,6 @@ void pci_bus_remove_resources(struct pci_bus *bus)
 	}
 }
 
-/*
- * Find the highest-address bus resource below the cursor "res".  If the
- * cursor is NULL, return the highest resource.
- */
-static struct resource *pci_bus_find_resource_prev(struct pci_bus *bus,
-						   unsigned int type,
-						   struct resource *res)
-{
-	struct resource *r, *prev = NULL;
-	int i;
-
-	pci_bus_for_each_resource(bus, r, i) {
-		if (!r)
-			continue;
-
-		if ((r->flags & IORESOURCE_TYPE_BITS) != type)
-			continue;
-
-		/* If this resource is at or past the cursor, skip it */
-		if (res) {
-			if (r == res)
-				continue;
-			if (r->end > res->end)
-				continue;
-			if (r->end == res->end && r->start > res->start)
-				continue;
-		}
-
-		if (!prev)
-			prev = r;
-
-		/*
-		 * A small resource is higher than a large one that ends at
-		 * the same address.
-		 */
-		if (r->end > prev->end ||
-		    (r->end == prev->end && r->start > prev->start))
-			prev = r;
-	}
-
-	return prev;
-}
-
 /**
  * pci_bus_alloc_resource - allocate a resource from a parent bus
  * @bus: PCI bus
@@ -132,10 +89,9 @@ pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 					  resource_size_t),
 		void *alignf_data)
 {
-	int ret = -ENOMEM;
+	int i, ret = -ENOMEM;
 	struct resource *r;
 	resource_size_t max = -1;
-	unsigned int type = res->flags & IORESOURCE_TYPE_BITS;
 
 	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
 
@@ -143,9 +99,10 @@ pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 	if (!(res->flags & IORESOURCE_MEM_64))
 		max = PCIBIOS_MAX_MEM_32;
 
-	/* Look for space at highest addresses first */
-	r = pci_bus_find_resource_prev(bus, type, NULL);
-	for ( ; r; r = pci_bus_find_resource_prev(bus, type, r)) {
+	pci_bus_for_each_resource(bus, r, i) {
+		if (!r)
+			continue;
+
 		/* type_mask must match */
 		if ((res->flags ^ r->flags) & type_mask)
 			continue;
