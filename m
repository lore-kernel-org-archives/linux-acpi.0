From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in 3.10.80 vs. 3.10.79
Date: Sat, 13 Jun 2015 04:52:10 +0200
Message-ID: <2035450.JLWirv5QXd@vostro.rjw.lan>
References: <CAL1RGDV6hr3_Oa6O-kPzx9EemtOWWtYq+-RkCzN7axNPLz5MJw@mail.gmail.com> <1903121.bsBlXHXLzb@vostro.rjw.lan> <CAL1RGDVMwmpB2Gap3HcWzUP6MAr83wtkZLic9dv8Ms6wLEX95A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49139 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752101AbbFMC0T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2015 22:26:19 -0400
In-Reply-To: <CAL1RGDVMwmpB2Gap3HcWzUP6MAr83wtkZLic9dv8Ms6wLEX95A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Dreier <roland@purestorage.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, George McCollister <george.mccollister@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On Friday, June 12, 2015 08:01:15 AM Roland Dreier wrote:
> On Thu, Jun 11, 2015 at 1:50 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Changing the ordering between those two routines would work around that problem,
> > but in my view that wouldn't be a proper fix.  In fact, the role of reserve_range()
> > is to reserve the resources so as to prevent them from being used going forward,
> > so they need not be reserved each in one piece.  Instead, we can just check if they
> > overlap with the ones reserved by acpi_reserve_resources() and only request the
> > non-overlapping parts of them to avoid conflicts.
> >
> > So I wonder if the patch below makes any difference?
> 
> I will give this a try and make sure it fixes my system, although I'm
> pretty sure it will.

OK, thanks!

Below is a more sophisticated, so to speak, version of it with a changelog and
all.  It works for me, but more testing would be much appreciated.

> However I'm not sure I agree that this is a better fix than just
> having pnp reserve ranges before acpi.  It already creates a special
> relationship between pnp and acpi, and acpi_reserve_region is a bunch
> of extra code.

There is a special relationship between ACPI and PNP on ACPI-based systems
anyway, because PNP devices are discovered via ACPI on them (and there really
is no difference between "PNP devices" and "devices enumerated via ACPI" on
those systems).

Yes, acpi_reserve_region() is quite a bit of extra code, but what it does is
safe from the perspective of introducing more problems due to initialization
ordering changes.

> Could we really have a system where the hierarchy of acpi being a subset of
> a pnp bus doesn't work?

That is not a problem.

I've reordered acpi_reserve_region() before the initial ACPI namespace scan
to make sure that address ranges used by the fixed ACPI hardware features will
not be stepped on in that process (which includes things like the enumeration
of the PCI host bridge).  It simply makes sense to have it in there.

Now, reordering the PNP "system" driver reservations before the acpi_reserve_region()
call site is not quite straightforward, because it is not suffcient to simply invoke
pnp_system_init() from there as it only registers the driver.  A matching device
has to be discovered to trigger reserve_resources_of_dev() and that only happens
during the initial ACPI namespace scan mentioned above.  While in principle
something like acpi_get_devices() could be used to force an extra namespace walk
to look for the specific devices matching the "system" driver earlier, that also
would be extra code and walking the entire ACPI namespace is not a lightweight
operation.

Moreover, it might lead to further regressions on some systems, because some
reservations made by the "system" driver fail on the systems I have access
to, so presumably something else already uses those address ranges when
reserve_resources_of_dev() is called for them and I'm not sure what would
happen if reserve_resources_of_dev() was called before that thing, in general.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / PNP: Avoid conflicting resource reservations

Commit b9a5e5e18fbf "ACPI / init: Fix the ordering of
acpi_reserve_resources()" overlooked the fact that the memory
and/or I/O regions reserved by acpi_reserve_resources() may
conflict with those reserved by the PNP "system" driver.

If that conflict actually takes place, it causes the reservations
made by the "system" driver to fail while before commit b9a5e5e18fbf
it would cause the reservations made by acpi_reserve_resources() to
fail.  In turn, that causes the resources that haven't been reserved
by the "system" driver to be allocated by others (e.g. PCI) which
sometimes leads to functional problems (up to and including boot
failures).

To fix that issue, introduce a common resource reservation routine,
acpi_reserve_region(), to be used by both acpi_reserve_resources()
and the "system" driver, that will track all resources reserved by
it and avoid making conflicting requests.

Fixes: b9a5e5e18fbf "ACPI / init: Fix the ordering of acpi_reserve_resources()"
Reported-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c      |    6 -
 drivers/acpi/resource.c |  189 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/system.c    |   35 ++++++--
 include/linux/acpi.h    |   10 ++
 4 files changed, 226 insertions(+), 14 deletions(-)

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
@@ -621,3 +622,191 @@ int acpi_dev_filter_resource_type(struct
 	return (type & types) ? 0 : 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_filter_resource_type);
+
+struct reserved_region {
+	struct list_head node;
+	u64 start;
+	u64 end;
+};
+
+static LIST_HEAD(reserved_io_regions);
+static LIST_HEAD(reserved_mem_regions);
+
+static int request_range(u64 start, u64 end, u8 space_id, unsigned long flags,
+			 char *desc)
+{
+	unsigned int length = end - start + 1;
+	struct resource *res;
+
+	res = space_id == ACPI_ADR_SPACE_SYSTEM_IO ?
+		request_region(start, length, desc) :
+		request_mem_region(start, length, desc);
+	if (!res)
+		return -EIO;
+
+	res->flags &= ~flags;
+	return 0;
+}
+
+static int acpi_add_region(u64 start, u64 end, u8 space_id, unsigned long flags,
+			   char *desc, struct list_head *head)
+{
+	struct reserved_region *reg;
+	int error;
+
+	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	error = request_range(start, end, space_id, flags, desc);
+	if (error)
+		return error;
+
+	reg->start = start;
+	reg->end = end;
+	list_add(&reg->node, head);
+	return 0;
+}
+
+static int acpi_add_region_before(u64 start, u64 end, u8 space_id,
+				  unsigned long flags, char *desc,
+				  struct reserved_region *reg)
+{
+	int ret;
+
+	if (reg->start == end + 1) {
+		/* Try to combine. */
+		ret = request_range(start, end, space_id, flags, desc);
+		if (!ret)
+			reg->start = start;
+	} else {
+		ret = acpi_add_region(start, end, space_id, flags, desc,
+				      reg->node.prev);
+	}
+	return ret;
+}
+
+static int acpi_add_region_after(u64 start, u64 end, u8 space_id,
+				 unsigned long flags, char *desc,
+				 struct reserved_region *reg)
+{
+	int ret;
+
+	if (reg->end == start - 1) {
+		/* Try to combine. */
+		ret = request_range(start, end, space_id, flags, desc);
+		if (!ret)
+			reg->end = end;
+	} else {
+		ret = acpi_add_region(start, end, space_id, flags, desc,
+				      &reg->node);
+	}
+	return ret;
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
+	struct list_head *regions;
+	struct reserved_region *reg;
+	u64 end = start + length - 1;
+	int ret = 0, error = 0;
+
+	if (space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		regions = &reserved_io_regions;
+	else if (space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		regions = &reserved_mem_regions;
+	else
+		return -EINVAL;
+
+	if (list_empty(regions))
+		return acpi_add_region(start, end, space_id, flags, desc, regions);
+
+	list_for_each_entry(reg, regions, node)
+		if (reg->start > end) {
+			/* No overlap.  Add the new region here and get out. */
+			return acpi_add_region_before(start, end, space_id,
+						      flags, desc, reg);
+		} else if (reg->end == start - 1) {
+			goto combine;
+		} else if (reg->end >= start) {
+			goto overlap;
+		}
+
+	/* The new region goes after the last existing one. */
+	reg = list_last_entry(regions, struct reserved_region, node);
+	return acpi_add_region_after(start, end, space_id, flags, desc, reg);
+
+ overlap:
+	/*
+	 * The new region overlaps an existing one.
+	 *
+	 * The head part of the new region immediately preceding the existing
+	 * overlapping one can be combined with it right away.
+	 */
+	if (reg->start > start) {
+		error = request_range(start, reg->start - 1, space_id, flags, desc);
+		if (error)
+			ret = error;
+		else
+			reg->start = start;
+	}
+
+ combine:
+	/*
+	 * The new region is adjacent to an existing one.  If it extends beyond
+	 * that region all the way to the next one, it is possible to combine
+	 * all three of them.
+	 */
+	if (reg->end < end) {
+		struct reserved_region *next = NULL;
+		u64 a = reg->end + 1, b = end;
+
+		if (!list_is_last(&reg->node, regions)) {
+			next = list_next_entry(reg, node);
+			if (next->start <= end)
+				b = next->start - 1;
+		}
+		error = request_range(a, b, space_id, flags, desc);
+		if (!error) {
+			if (next && next->start == b + 1) {
+				reg->end = next->end;
+				list_del(&next->node);
+				kfree(next);
+				start = reg->end + 1;
+				goto combine;
+			} else {
+				reg->end = end;
+			}
+		} else if (next) {
+			if (!ret)
+				ret = error;
+
+			reg = next;
+			goto combine;
+		}
+	}
+
+	return ret ? ret : error;
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
@@ -22,25 +23,41 @@ static const struct pnp_device_id pnp_de
 	{"", 0}
 };
 
+#ifdef CONFIG_ACPI
+static bool __reserve_range(u64 start, unsigned int length, bool io, char *desc)
+{
+	u8 space_id = io ? ACPI_ADR_SPACE_SYSTEM_IO : ACPI_ADR_SPACE_SYSTEM_MEMORY;
+	return !acpi_reserve_region(start, length, space_id, IORESOURCE_BUSY, desc);
+}
+#else
+static bool __reserve_range(u64 start, unsigned int length, bool io, char *desc)
+{
+	struct resource *res;
+
+	res = io ? request_region(start, length, desc) :
+		request_mem_region(start, length, desc);
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
+	reserved = __reserve_range(start, end - start + 1, !!port, regionid);
+	if (!reserved)
 		kfree(regionid);
 
 	/*
@@ -49,7 +66,7 @@ static void reserve_range(struct pnp_dev
 	 * have double reservations.
 	 */
 	dev_info(&dev->dev, "%pR %s reserved\n", r,
-		 res ? "has been" : "could not be");
+		 reserved ? "has been" : "could not be");
 }
 
 static void reserve_resources_of_dev(struct pnp_dev *dev)

