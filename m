From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH]ACPI pcibios_disable_device implementation for x86
Date: Tue, 17 May 2005 13:57:21 +0800
Message-ID: <1116309441.7339.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, kaneshige <kaneshige.kenji-tPnzhWqfZ96MLkP6nYsO9A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
This an implementation of pcibios_disable_device for x86. It's porting
from current ia64 implementation, but more sample. The design of
pcibios_disable_device is for ioapic hotplug, but here we used it for
suspend/resume, since we must disable PIC/IOAPIC/irq router at suspend.
Most changes are in ACPI part. It's against -mm tree.

Thanks,
Shaohua
---

 linux-2.6.11-root/arch/i386/kernel/acpi/boot.c |   11 +++
 linux-2.6.11-root/arch/i386/kernel/mpparse.c   |   45 +++++++++++--
 linux-2.6.11-root/arch/i386/pci/acpi.c         |    1 
 linux-2.6.11-root/arch/i386/pci/common.c       |    6 +
 linux-2.6.11-root/arch/i386/pci/irq.c          |    1 
 linux-2.6.11-root/arch/i386/pci/pci.h          |    1 
 linux-2.6.11-root/arch/x86_64/kernel/mpparse.c |   43 ++++++++++---
 linux-2.6.11-root/drivers/acpi/pci_irq.c       |   82 +++++++++++++++++--------
 linux-2.6.11-root/drivers/acpi/pci_link.c      |   76 +++++++++++++++++++----
 linux-2.6.11-root/include/acpi/acpi_drivers.h  |    3 
 linux-2.6.11-root/include/asm-i386/mpspec.h    |    1 
 linux-2.6.11-root/include/asm-x86_64/mpspec.h  |    1 
 linux-2.6.11-root/include/linux/acpi.h         |    4 -
 13 files changed, 216 insertions(+), 59 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~suspend_resume_irq arch/i386/kernel/acpi/boot.c
--- linux-2.6.11/arch/i386/kernel/acpi/boot.c~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/acpi/boot.c	2005-05-10 15:59:52.000000000 +0800
@@ -484,6 +484,17 @@ unsigned int acpi_register_gsi(u32 gsi, 
 }
 EXPORT_SYMBOL(acpi_register_gsi);
 
+void acpi_unregister_gsi(u32 gsi)
+{
+	/* ELCR set to edge? seems not required */
+#ifdef CONFIG_X86_IO_APIC
+	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC) {
+		mp_unregister_gsi(gsi);
+	}
+#endif
+}
+EXPORT_SYMBOL(acpi_unregister_gsi);
+
 /*
  *  ACPI based hotplug support for CPU
  */
diff -puN arch/i386/kernel/mpparse.c~suspend_resume_irq arch/i386/kernel/mpparse.c
--- linux-2.6.11/arch/i386/kernel/mpparse.c~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/mpparse.c	2005-05-10 16:22:32.000000000 +0800
@@ -865,7 +865,7 @@ static struct mp_ioapic_routing {
 	int			apic_id;
 	int			gsi_base;
 	int			gsi_end;
-	u32			pin_programmed[4];
+	int			refcnts[MP_MAX_IOAPIC_PIN];
 } mp_ioapic_routing[MAX_IO_APICS];
 

@@ -1057,7 +1057,6 @@ int mp_register_gsi (u32 gsi, int edge_l
 {
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
-	int			idx, bit = 0;
 
 #ifdef CONFIG_ACPI_BUS
 	/* Don't set up the ACPI SCI because it's already set up */
@@ -1081,27 +1080,57 @@ int mp_register_gsi (u32 gsi, int edge_l
 	 * with redundant pin->gsi mappings (but unique PCI devices);
 	 * we only program the IOAPIC on the first.
 	 */
-	bit = ioapic_pin % 32;
-	idx = (ioapic_pin < 32) ? 0 : (ioapic_pin / 32);
-	if (idx > 3) {
+	if (ioapic_pin > MP_MAX_IOAPIC_PIN) {
 		printk(KERN_ERR "Invalid reference to IOAPIC pin "
 			"%d-%d\n", mp_ioapic_routing[ioapic].apic_id, 
 			ioapic_pin);
 		return gsi;
 	}
-	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
+
+	if (mp_ioapic_routing[ioapic].refcnts[ioapic_pin] ++ ) {
 		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
 		return gsi;
 	}
 
-	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
-
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
 		    edge_level == ACPI_EDGE_SENSITIVE ? 0 : 1,
 		    active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
 	return gsi;
 }
 
+void mp_unregister_gsi(u32 gsi)
+{
+	int			ioapic = -1;
+	int			ioapic_pin = 0;
+
+#ifdef CONFIG_ACPI_BUS
+	/* we don't touch SCI */
+	if (acpi_fadt.sci_int == gsi)
+		return;
+#endif
+
+	ioapic = mp_find_ioapic(gsi);
+	if (ioapic < 0) {
+		printk(KERN_WARNING "No IOAPIC for GSI %u\n", gsi);
+		return;
+	}
+
+	ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_base;
+
+	mp_ioapic_routing[ioapic].refcnts[ioapic_pin] --;
+	if (mp_ioapic_routing[ioapic].refcnts[ioapic_pin])
+		return;
+
+	/*
+	 * TBD: we do nothing here so the vector of a pin isn't changed. This
+	 * is quite useful for suspend/resume. IOAPIC hotplug should clear the
+	 * interrupt gate and free vector, since i386 doesn't support IOAPIC
+	 * hotplug, we temporarily ignore it.
+	 */
+	printk(KERN_INFO "Pin %d-%d is unregistered\n",
+			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
+}
+
 #endif /*CONFIG_X86_IO_APIC && (CONFIG_ACPI_INTERPRETER || CONFIG_ACPI_BOOT)*/
 #endif /*CONFIG_ACPI_BOOT*/
diff -puN arch/i386/pci/acpi.c~suspend_resume_irq arch/i386/pci/acpi.c
--- linux-2.6.11/arch/i386/pci/acpi.c~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/arch/i386/pci/acpi.c	2005-05-10 15:59:52.000000000 +0800
@@ -30,6 +30,7 @@ static int __init pci_acpi_init(void)
 	acpi_irq_penalty_init();
 	pcibios_scanned++;
 	pcibios_enable_irq = acpi_pci_irq_enable;
+	pcibios_disable_irq = acpi_pci_irq_disable;
 
 	if (pci_routeirq) {
 		/*
diff -puN arch/i386/pci/common.c~suspend_resume_irq arch/i386/pci/common.c
--- linux-2.6.11/arch/i386/pci/common.c~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/arch/i386/pci/common.c	2005-05-10 15:59:52.000000000 +0800
@@ -253,3 +253,9 @@ int pcibios_enable_device(struct pci_dev
 
 	return pcibios_enable_irq(dev);
 }
+
+void pcibios_disable_device (struct pci_dev *dev)
+{
+	if (pcibios_disable_irq)
+		pcibios_disable_irq(dev);
+}
diff -puN arch/i386/pci/irq.c~suspend_resume_irq arch/i386/pci/irq.c
--- linux-2.6.11/arch/i386/pci/irq.c~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/arch/i386/pci/irq.c	2005-05-10 15:59:52.000000000 +0800
@@ -56,6 +56,7 @@ struct irq_router_handler {
 };
 
 int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
+void (*pcibios_disable_irq)(struct pci_dev *dev) = NULL;
 
 /*
  *  Check passed address for the PCI IRQ Routing Table signature
diff -puN arch/i386/pci/pci.h~suspend_resume_irq arch/i386/pci/pci.h
--- linux-2.6.11/arch/i386/pci/pci.h~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/arch/i386/pci/pci.h	2005-05-10 15:59:52.000000000 +0800
@@ -73,3 +73,4 @@ extern int pcibios_scanned;
 extern spinlock_t pci_config_lock;
 
 extern int (*pcibios_enable_irq)(struct pci_dev *dev);
+extern void (*pcibios_disable_irq)(struct pci_dev *dev);
diff -puN drivers/acpi/pci_irq.c~suspend_resume_irq drivers/acpi/pci_irq.c
--- linux-2.6.11/drivers/acpi/pci_irq.c~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/drivers/acpi/pci_irq.c	2005-05-12 16:59:51.000000000 +0800
@@ -269,7 +269,51 @@ acpi_pci_irq_del_prt (int segment, int b
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
+typedef int (*acpi_irq_lookup_func)(struct acpi_prt_entry *, int *, int *, char **);
 
+static int
+acpi_pci_allocate_irq(struct acpi_prt_entry *entry,
+	int	*edge_level,
+	int	*active_high_low,
+	char	**link)
+{
+	int	irq;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_allocate_irq");
+
+	if (entry->link.handle) {
+		irq = acpi_pci_link_allocate_irq(entry->link.handle,
+			entry->link.index, edge_level, active_high_low, link);
+		if (irq < 0) {
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
+			return_VALUE(-1);
+		}
+	} else {
+		irq = entry->link.index;
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IRQ %d\n", irq));
+	return_VALUE(irq);
+}
+
+static int
+acpi_pci_free_irq(struct acpi_prt_entry *entry,
+	int	*edge_level,
+	int	*active_high_low,
+	char	**link)
+{
+	int	irq;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_free_irq");
+	if (entry->link.handle) {
+		irq = acpi_pci_link_free_irq(entry->link.handle);
+	} else {
+		irq = entry->link.index;
+	}
+	return_VALUE(irq);
+}
 /*
  * acpi_pci_irq_lookup
  * success: return IRQ >= 0
@@ -282,12 +326,13 @@ acpi_pci_irq_lookup (
 	int			pin,
 	int			*edge_level,
 	int			*active_high_low,
-	char			**link)
+	char			**link,
+	acpi_irq_lookup_func	func)
 {
 	struct acpi_prt_entry	*entry = NULL;
 	int segment = pci_domain_nr(bus);
 	int bus_nr = bus->number;
-	int irq;
+	int ret;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_lookup");
 
@@ -301,22 +346,8 @@ acpi_pci_irq_lookup (
 		return_VALUE(-1);
 	}
 	
-	if (entry->link.handle) {
-		irq = acpi_pci_link_get_irq(entry->link.handle,
-			entry->link.index, edge_level, active_high_low, link);
-		if (irq < 0) {
-			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
-			return_VALUE(-1);
-		}
-	} else {
-		irq = entry->link.index;
-		*edge_level = ACPI_LEVEL_SENSITIVE;
-		*active_high_low = ACPI_ACTIVE_LOW;
-	}
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IRQ %d\n", irq));
-
-	return_VALUE(irq);
+	ret = func(entry, edge_level, active_high_low, link);
+	return_VALUE(ret);
 }
 
 /*
@@ -330,7 +361,8 @@ acpi_pci_irq_derive (
 	int			pin,
 	int			*edge_level,
 	int			*active_high_low,
-	char			**link)
+	char			**link,
+	acpi_irq_lookup_func	func)
 {
 	struct pci_dev		*bridge = dev;
 	int			irq = -1;
@@ -363,7 +395,7 @@ acpi_pci_irq_derive (
 		}
 
 		irq = acpi_pci_irq_lookup(bridge->bus, PCI_SLOT(bridge->devfn),
-			pin, edge_level, active_high_low, link);
+			pin, edge_level, active_high_low, link, func);
 	}
 
 	if (irq < 0) {
@@ -415,7 +447,7 @@ acpi_pci_irq_enable (
 	 * values override any BIOS-assigned IRQs set during boot.
 	 */
  	irq = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
-		&edge_level, &active_high_low, &link);
+		&edge_level, &active_high_low, &link, acpi_pci_allocate_irq);
 
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
@@ -423,7 +455,7 @@ acpi_pci_irq_enable (
 	 */
 	if (irq < 0)
  		irq = acpi_pci_irq_derive(dev, pin, &edge_level,
-			&active_high_low, &link);
+			&active_high_low, &link, acpi_pci_allocate_irq);
  
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
@@ -461,7 +493,6 @@ acpi_pci_irq_enable (
 EXPORT_SYMBOL(acpi_pci_irq_enable);
 

-#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
 void
 acpi_pci_irq_disable (
 	struct pci_dev		*dev)
@@ -488,14 +519,14 @@ acpi_pci_irq_disable (
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
 	 */
  	gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
-				  &edge_level, &active_high_low, NULL);
+			&edge_level, &active_high_low, NULL, acpi_pci_free_irq);
 	/*
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
 	if (gsi < 0)
  		gsi = acpi_pci_irq_derive(dev, pin,
-					  &edge_level, &active_high_low, NULL);
+			&edge_level, &active_high_low, NULL, acpi_pci_free_irq);
 	if (gsi < 0)
 		return_VOID;
 
@@ -511,4 +542,3 @@ acpi_pci_irq_disable (
 
 	return_VOID;
 }
-#endif /* CONFIG_ACPI_DEALLOCATE_IRQ */
diff -puN drivers/acpi/pci_link.c~suspend_resume_irq drivers/acpi/pci_link.c
--- linux-2.6.11/drivers/acpi/pci_link.c~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/drivers/acpi/pci_link.c	2005-05-10 17:05:28.000000000 +0800
@@ -68,6 +68,12 @@ static struct acpi_driver acpi_pci_link_
 			},
 };
 
+/*
+ * If a link is initialized but disabled since no device uses it any more
+ * (because of hotplug or suspend/resume), we keep its active irq number and
+ * reuse it when other device uses it again.  This way, link's active irq
+ * always isn't changed after it's initialized once.
+ */
 struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
 	u8			edge_level;		/* All IRQs */
@@ -76,8 +82,7 @@ struct acpi_pci_link_irq {
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 	u8			initialized:1;
-	u8			suspend_resume:1;
-	u8			reserved:6;
+	u8			reserved:7;
 };
 
 struct acpi_pci_link {
@@ -85,6 +90,7 @@ struct acpi_pci_link {
 	struct acpi_device	*device;
 	acpi_handle		handle;
 	struct acpi_pci_link_irq irq;
+	int			refcnt;
 };
 
 static struct {
@@ -532,12 +538,16 @@ static int acpi_pci_link_allocate(
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
-	if (link->irq.suspend_resume) {
-		acpi_pci_link_set(link, link->irq.active);
-		link->irq.suspend_resume = 0;
-	}
-	if (link->irq.initialized)
+	if (link->irq.initialized) {
+		if (link->refcnt == 0)
+			/*
+			 * This means the link is initialized but disabled.
+			 * Just reuse the active irq number.
+			 * TBD: should we reevaluate _PRS after resume?
+			 */
+			acpi_pci_link_set(link, link->irq.active);
 		return_VALUE(0);
+	}
 
 	/*
 	 * search for active IRQ in list of possible IRQs.
@@ -596,13 +606,13 @@ static int acpi_pci_link_allocate(
 }
 
 /*
- * acpi_pci_link_get_irq
+ * acpi_pci_link_allocate_irq
  * success: return IRQ >= 0
  * failure: return -1
  */
 
 int
-acpi_pci_link_get_irq (
+acpi_pci_link_allocate_irq (
 	acpi_handle		handle,
 	int			index,
 	int			*edge_level,
@@ -613,7 +623,7 @@ acpi_pci_link_get_irq (
 	struct acpi_device	*device = NULL;
 	struct acpi_pci_link	*link = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_get_irq");
+	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate_irq");
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
@@ -644,10 +654,47 @@ acpi_pci_link_get_irq (
 	if (edge_level) *edge_level = link->irq.edge_level;
 	if (active_high_low) *active_high_low = link->irq.active_high_low;
 	if (name) *name = acpi_device_bid(link->device);
+
+	link->refcnt ++;
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		"Link %s is referenced\n", acpi_device_bid(link->device)));
 	return_VALUE(link->irq.active);
 }
 
+/* Disable link device if no reference on it. */
+int
+acpi_pci_link_free_irq(acpi_handle handle)
+{
+	struct acpi_device	*device = NULL;
+	struct acpi_pci_link	*link = NULL;
+	acpi_status		result;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_link_free_irq");
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link device\n"));
+		return_VALUE(-1);
+	}
+
+	link = (struct acpi_pci_link *) acpi_driver_data(device);
+	if (!link) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+		return_VALUE(-1);
+	}
+	if (!link->irq.initialized) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link isn't initialized\n"));
+		return_VALUE(-1);
+	}
+
+	link->refcnt --;
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		"Link %s is dereferenced\n", acpi_device_bid(link->device)));
 
+	if (link->refcnt == 0)
+		acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
+	return_VALUE(link->irq.active);
+}
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -735,8 +782,13 @@ irqrouter_suspend(
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
 			continue;
 		}
-		if (link->irq.active && link->irq.initialized)
-			link->irq.suspend_resume = 1;
+		if (link->irq.initialized && link->refcnt != 0) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Link device [%s] refrerence isn't 0\n",
+				acpi_device_bid(link->device)));
+			link->refcnt = 0;
+			/* We can't call _DIS method here */
+		}
 	}
 	return_VALUE(0);
 }
diff -puN include/acpi/acpi_drivers.h~suspend_resume_irq include/acpi/acpi_drivers.h
--- linux-2.6.11/include/acpi/acpi_drivers.h~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/include/acpi/acpi_drivers.h	2005-05-10 15:59:52.000000000 +0800
@@ -56,8 +56,9 @@
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_irq_penalty_init (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index, int *edge_level,
+int acpi_pci_link_allocate_irq (acpi_handle handle, int index, int *edge_level,
 	int *active_high_low, char **name);
+int acpi_pci_link_free_irq(acpi_handle handle);
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 
diff -puN include/asm-i386/mpspec.h~suspend_resume_irq include/asm-i386/mpspec.h
--- linux-2.6.11/include/asm-i386/mpspec.h~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/include/asm-i386/mpspec.h	2005-05-10 15:59:52.000000000 +0800
@@ -33,6 +33,7 @@ extern void mp_register_ioapic (u8 id, u
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
 extern int mp_register_gsi (u32 gsi, int edge_level, int active_high_low);
+extern void mp_unregister_gsi (u32 gsi);
 #endif /*CONFIG_ACPI_BOOT*/
 
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_APICS)
diff -puN include/linux/acpi.h~suspend_resume_irq include/linux/acpi.h
--- linux-2.6.11/include/linux/acpi.h~suspend_resume_irq	2005-05-10 15:59:52.000000000 +0800
+++ linux-2.6.11-root/include/linux/acpi.h	2005-05-10 15:59:52.000000000 +0800
@@ -431,9 +431,7 @@ int acpi_gsi_to_irq (u32 gsi, unsigned i
  * If this matches the last registration, any IRQ resources for gsi
  * are freed.
  */
-#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
 void acpi_unregister_gsi (u32 gsi);
-#endif
 
 #ifdef CONFIG_ACPI_PCI
 
@@ -458,9 +456,7 @@ struct pci_dev;
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 
-#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
 void acpi_pci_irq_disable (struct pci_dev *dev);
-#endif
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
diff -puN arch/x86_64/kernel/mpparse.c~suspend_resume_irq arch/x86_64/kernel/mpparse.c
--- linux-2.6.11/arch/x86_64/kernel/mpparse.c~suspend_resume_irq	2005-05-12 16:37:51.000000000 +0800
+++ linux-2.6.11-root/arch/x86_64/kernel/mpparse.c	2005-05-13 11:06:23.486693288 +0800
@@ -724,7 +724,7 @@ static struct mp_ioapic_routing {
 	int			apic_id;
 	int			gsi_start;
 	int			gsi_end;
-	u32			pin_programmed[4];
+	int			refcnts[MP_MAX_IOAPIC_PIN];
 } mp_ioapic_routing[MAX_IO_APICS];
 

@@ -911,7 +911,6 @@ int mp_register_gsi(u32 gsi, int edge_le
 {
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
-	int			idx, bit = 0;
 
 	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC)
 		return gsi;
@@ -935,27 +934,55 @@ int mp_register_gsi(u32 gsi, int edge_le
 	 * with redundant pin->gsi mappings (but unique PCI devices);
 	 * we only program the IOAPIC on the first.
 	 */
-	bit = ioapic_pin % 32;
-	idx = (ioapic_pin < 32) ? 0 : (ioapic_pin / 32);
-	if (idx > 3) {
+	if (ioapic_pin > MP_MAX_IOAPIC_PIN) {
 		printk(KERN_ERR "Invalid reference to IOAPIC pin "
 			"%d-%d\n", mp_ioapic_routing[ioapic].apic_id, 
 			ioapic_pin);
 		return gsi;
 	}
-	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
+	if (mp_ioapic_routing[ioapic].refcnts[ioapic_pin] ++ ) {
 		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
 		return gsi;
 	}
 
-	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
-
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
 		edge_level == ACPI_EDGE_SENSITIVE ? 0 : 1,
 		active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
 	return gsi;
 }
 
+void mp_unregister_gsi(u32 gsi)
+{
+	int			ioapic = -1;
+	int			ioapic_pin = 0;
+
+#ifdef CONFIG_ACPI_BUS
+	/* we don't touch SCI */
+	if (acpi_fadt.sci_int == gsi)
+		return;
+#endif
+
+	ioapic = mp_find_ioapic(gsi);
+	if (ioapic < 0) {
+		printk(KERN_WARNING "No IOAPIC for GSI %u\n", gsi);
+		return;
+	}
+
+	ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_start;
+
+	mp_ioapic_routing[ioapic].refcnts[ioapic_pin] --;
+	if (mp_ioapic_routing[ioapic].refcnts[ioapic_pin])
+		return;
+	/*
+	 * TBD: we do nothing here so the vector of a pin isn't changed. This
+	 * is quite useful for suspend/resume. IOAPIC hotplug should clear the
+	 * interrupt gate and free vector, since x64 doesn't support IOAPIC
+	 * hotplug, we temporarily ignore it.
+	 */
+	printk(KERN_INFO "Pin %d-%d is unregistered\n",
+		mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
+}
+
 #endif /*CONFIG_X86_IO_APIC*/
 #endif /*CONFIG_ACPI_BOOT*/
diff -puN include/asm-x86_64/mpspec.h~suspend_resume_irq include/asm-x86_64/mpspec.h
--- linux-2.6.11/include/asm-x86_64/mpspec.h~suspend_resume_irq	2005-05-12 16:38:55.000000000 +0800
+++ linux-2.6.11-root/include/asm-x86_64/mpspec.h	2005-05-12 16:39:53.000000000 +0800
@@ -188,6 +188,7 @@ extern void mp_register_ioapic (u8 id, u
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
 extern int mp_register_gsi (u32 gsi, int edge_level, int active_high_low);
+extern void mp_unregister_gsi (u32 gsi);
 #endif /*CONFIG_X86_IO_APIC*/
 #endif
 
_




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
