From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in 3.10.80 vs. 3.10.79
Date: Thu, 11 Jun 2015 22:50:40 +0200
Message-ID: <1903121.bsBlXHXLzb@vostro.rjw.lan>
References: <CAL1RGDV6hr3_Oa6O-kPzx9EemtOWWtYq+-RkCzN7axNPLz5MJw@mail.gmail.com> <25627634.TOSvDFmF1a@vostro.rjw.lan> <CAL1RGDWt8+ZJ3_+xKnYcDMs+D0Ta289Y6sqTPvBLLmPEMovTnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL1RGDWt8+ZJ3_+xKnYcDMs+D0Ta289Y6sqTPvBLLmPEMovTnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Dreier <roland@purestorage.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, George McCollister <george.mccollister@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday, June 11, 2015 12:01:40 PM Roland Dreier wrote:
> On Wed, Jun 10, 2015 at 4:23 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Can you please file a bug at bugzilla.kernel.org to track this and attach
> > the output of acpidump from the affected system in there?
> 
> Done: https://bugzilla.kernel.org/show_bug.cgi?id=99831

Thanks!

I've looked at things in the meantime and my current theory about what happens
is that the code in reserve_range() (drivers/pnp/system.c) fails to reserve
addres ranges that overlap with the ones previously reserverd by acpi_reserve_resources()
and so the PCI subsystem feels free to use them and then everything falls apart.

Changing the ordering between those two routines would work around that problem,
but in my view that wouldn't be a proper fix.  In fact, the role of reserve_range()
is to reserve the resources so as to prevent them from being used going forward,
so they need not be reserved each in one piece.  Instead, we can just check if they
overlap with the ones reserved by acpi_reserve_resources() and only request the
non-overlapping parts of them to avoid conflicts.

So I wonder if the patch below makes any difference?

---
 drivers/acpi/osl.c      |    6 --
 drivers/acpi/resource.c |  129 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/system.c    |   51 +++++++++++++++---
 include/linux/acpi.h    |   10 +++
 4 files changed, 182 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -175,11 +175,7 @@ static void __init acpi_request_region (
 	if (!addr || !length)
 		return;
 
-	/* Resources are never freed */
-	if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
-		request_region(addr, length, desc);
-	else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		request_mem_region(addr, length, desc);
+	acpi_reserve_region(addr, length, gas->space_id, 0, desc);
 }
 
 static void __init acpi_reserve_resources(void)
Index: linux-pm/drivers/acpi/resource.c
===================================================================
--- linux-pm.orig/drivers/acpi/resource.c
+++ linux-pm/drivers/acpi/resource.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/ioport.h>
+#include <linux/list.h>
 #include <linux/slab.h>
 
 #ifdef CONFIG_X86
@@ -621,3 +622,131 @@ int acpi_dev_filter_resource_type(struct
 	return (type & types) ? 0 : 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_filter_resource_type);
+
+struct acpi_region {
+	struct list_head node;
+	u64 start;
+	u64 end;
+};
+
+static LIST_HEAD(acpi_io_regions);
+static LIST_HEAD(acpi_mem_regions);
+
+static int acpi_add_region(u64 start, u64 end, struct list_head *head,
+			   u8 space_id, unsigned long flags, char *desc)
+{
+	struct acpi_region *reg;
+	struct resource *res;
+	unsigned int length = end - start + 1;
+
+	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	reg->start = start;
+	reg->end = end;
+	list_add(&reg->node, head);
+	res = space_id == ACPI_ADR_SPACE_SYSTEM_IO ?
+		request_region(start, length, desc) :
+		request_mem_region(start, length, desc);
+	if (res) {
+		res->flags &= ~flags;
+		return 0;
+	}
+	return -EIO;
+}
+
+/**
+ * acpi_reserve_region - Reserve an I/O or memory region as a system resource.
+ * @start: Starting address of the region.
+ * @length: Length of the region.
+ * @space_id: Identifier of address space to reserve the region from.
+ * @flags: Resource flags to clear for the region after requesting it.
+ * @desc: Region description (for messages).
+ *
+ * Reserve an I/O or memory region as a system resource to prevent others from
+ * using it.  If the new region overlaps with one of the regions (in the given
+ * address space) already reserved by this routine, only the non-overlapping
+ * parts of it will be reserved.
+ *
+ * Returned is either 0 (success) or a negative error code indicating a resource
+ * reservation problem.  It is the code of the first encountered error, but the
+ * routine doesn't abort until it has attempted to request all of the parts of
+ * the new region that don't overlap with other regions reserved previously.
+ *
+ * The resources requested by this routine are never released.
+ */
+int acpi_reserve_region(u64 start, unsigned int length, u8 space_id,
+			unsigned long flags, char *desc)
+{
+	struct list_head *regions, *head;
+	struct acpi_region *reg;
+	u64 end = start + length - 1;
+	int ret = 0;
+
+	if (space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		regions = &acpi_io_regions;
+	else if (space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		regions = &acpi_mem_regions;
+	else
+		return -EINVAL;
+
+	if (list_empty(regions))
+		return acpi_add_region(start, end, regions, space_id, flags, desc);
+
+	reg = list_first_entry(regions, struct acpi_region, node);
+	if (reg->start > end) {
+		/* The new region goes in front of the first existing one. */
+		return acpi_add_region(start, end, regions, space_id, flags, desc);
+	} else if (reg->end >= start) {
+		head = reg->node.prev;
+		goto overlap;
+	}
+
+ loop:
+	head = NULL;
+	list_for_each_entry_continue(reg, regions, node)
+		if (reg->end < start) {
+			continue;
+		} else if (reg->start > end) {
+			/* No overlap, the new region can be inserted here. */
+			int auxret = acpi_add_region(start, end, reg->node.prev,
+						     space_id, flags, desc);
+			return ret ? ret : auxret;
+		} else {
+			head = reg->node.prev;
+			break;
+		}
+
+	if (!head) {
+		/* The new region goes after the last existing one. */
+		int auxret = acpi_add_region(start, end, regions->prev,
+					     space_id, flags, desc);
+		return ret ? ret : auxret;
+	}
+
+ overlap:
+	/*
+	 * We know that reg->end >= start and reg->start <= end at this point.
+	 * The part of the new region immediately preceding the existing
+	 * overlapping one can be added right away.
+	 */
+	if (reg->start > start) {
+		int auxret = acpi_add_region(start, reg->start - 1, head,
+					     space_id, flags, desc);
+		if (!ret)
+			ret = auxret;
+	}
+
+	/*
+	 * Skip the overlapping part of the new region and handle the rest as
+	 * a new region to insert.
+	 */
+	if (reg->end < end) {
+		start = reg->end + 1;
+		goto loop;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_reserve_region);
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -342,6 +342,9 @@ int acpi_check_region(resource_size_t st
 
 int acpi_resources_are_enforced(void);
 
+int acpi_reserve_region(u64 start, unsigned int length, u8 space_id,
+			unsigned long flags, char *desc);
+
 #ifdef CONFIG_HIBERNATION
 void __init acpi_no_s4_hw_signature(void);
 #endif
@@ -537,6 +540,13 @@ static inline int acpi_check_region(reso
 	return 0;
 }
 
+static inline int acpi_reserve_region(u64 start, unsigned int length,
+				      u8 space_id, unsigned long flags,
+				      char *desc)
+{
+	return -ENXIO;
+}
+
 struct acpi_table_header;
 static inline int acpi_table_parse(char *id,
 				int (*handler)(struct acpi_table_header *))
Index: linux-pm/drivers/pnp/system.c
===================================================================
--- linux-pm.orig/drivers/pnp/system.c
+++ linux-pm/drivers/pnp/system.c
@@ -7,6 +7,7 @@
  *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/pnp.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -22,25 +23,57 @@ static const struct pnp_device_id pnp_de
 	{"", 0}
 };
 
+#ifdef CONFIG_ACPI
+static inline bool reserve_region(u64 start, unsigned int length, char *desc)
+{
+	return !acpi_reserve_region(start, length, ACPI_ADR_SPACE_SYSTEM_IO,
+				    IORESOURCE_BUSY, desc);
+}
+static inline bool reserve_mem_region(u64 start, unsigned int length, char *desc)
+{
+	return !acpi_reserve_region(start, length, ACPI_ADR_SPACE_SYSTEM_MEMORY,
+				    IORESOURCE_BUSY, desc);
+}
+#else
+static inline bool reserve_region(u64 start, unsigned int length, char *desc)
+{
+	struct resource *res;
+
+	res = request_region(start, length, desc);
+	if (res) {
+		res->flags &= ~IORESOURCE_BUSY;
+		return true;
+	}
+	return false;
+}
+static inline bool reserve_mem_region(u64 start, unsigned int length, char *desc)
+{
+	struct resource *res;
+
+	res = request_mem_region(start, length, desc);
+	if (res) {
+		res->flags &= ~IORESOURCE_BUSY;
+		return true;
+	}
+	return false;
+}
+#endif
+
 static void reserve_range(struct pnp_dev *dev, struct resource *r, int port)
 {
 	char *regionid;
 	const char *pnpid = dev_name(&dev->dev);
 	resource_size_t start = r->start, end = r->end;
-	struct resource *res;
+	bool reserved;
 
 	regionid = kmalloc(16, GFP_KERNEL);
 	if (!regionid)
 		return;
 
 	snprintf(regionid, 16, "pnp %s", pnpid);
-	if (port)
-		res = request_region(start, end - start + 1, regionid);
-	else
-		res = request_mem_region(start, end - start + 1, regionid);
-	if (res)
-		res->flags &= ~IORESOURCE_BUSY;
-	else
+	reserved = port ? reserve_region(start, end - start + 1, regionid) :
+			reserve_mem_region(start, end - start + 1, regionid);
+	if (!reserved)
 		kfree(regionid);
 
 	/*
@@ -49,7 +82,7 @@ static void reserve_range(struct pnp_dev
 	 * have double reservations.
 	 */
 	dev_info(&dev->dev, "%pR %s reserved\n", r,
-		 res ? "has been" : "could not be");
+		 reserved ? "has been" : "could not be");
 }
 
 static void reserve_resources_of_dev(struct pnp_dev *dev)
