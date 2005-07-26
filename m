From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH]Disable ACPI PCI link device if no PCI device uses it -
 takes 2
Date: Tue, 26 Jul 2005 15:52:23 +0800
Message-ID: <1122364343.7106.3.camel@linux-hp.sh.intel.com>
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
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
Looks like people agree device drivers should call
free_irq/pci_disable_irq at suspend time per the OLS report. This patch
tries to disable pci link device if no PCI device is using it, which is
one goal of pci driver calls pci_disable_irq. This patch also warns
users if some drivers don't call pci_disable_irq at suspend time. Next
step we will implement acpi_unregister_gsi for x86/x86_64, so we can
automically mask ioapic/pic if no device is using them. And in the same
way, alarm users if driver doesn't call free_irq at suspend time.
Greg, is the PCI part ok for you? It just has very small changes in PCI
part.

Thanks,
Shaohua 

Signed-off-by: Shaohua Li<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

 linux-2.6.13-rc3-root/arch/i386/pci/acpi.c        |    1 
 linux-2.6.13-rc3-root/arch/i386/pci/common.c      |    6 +
 linux-2.6.13-rc3-root/arch/i386/pci/irq.c         |    1 
 linux-2.6.13-rc3-root/arch/i386/pci/pci.h         |    1 
 linux-2.6.13-rc3-root/drivers/acpi/pci_irq.c      |   85 ++++++++++++------
 linux-2.6.13-rc3-root/drivers/acpi/pci_link.c     |  101 ++++++++++++++++++----
 linux-2.6.13-rc3-root/include/acpi/acpi_drivers.h |    3 
 linux-2.6.13-rc3-root/include/linux/acpi.h        |    4 
 8 files changed, 155 insertions(+), 47 deletions(-)

diff -puN arch/i386/pci/acpi.c~suspend_resume_irq arch/i386/pci/acpi.c
--- linux-2.6.13-rc3/arch/i386/pci/acpi.c~suspend_resume_irq	2005-07-26 09:19:49.327792752 +0800
+++ linux-2.6.13-rc3-root/arch/i386/pci/acpi.c	2005-07-26 09:19:49.346789864 +0800
@@ -30,6 +30,7 @@ static int __init pci_acpi_init(void)
 	acpi_irq_penalty_init();
 	pcibios_scanned++;
 	pcibios_enable_irq = acpi_pci_irq_enable;
+	pcibios_disable_irq = acpi_pci_irq_disable;
 
 	if (pci_routeirq) {
 		/*
diff -puN arch/i386/pci/common.c~suspend_resume_irq arch/i386/pci/common.c
--- linux-2.6.13-rc3/arch/i386/pci/common.c~suspend_resume_irq	2005-07-26 09:19:49.329792448 +0800
+++ linux-2.6.13-rc3-root/arch/i386/pci/common.c	2005-07-26 09:19:49.346789864 +0800
@@ -254,3 +254,9 @@ int pcibios_enable_device(struct pci_dev
 
 	return pcibios_enable_irq(dev);
 }
+
+void pcibios_disable_device (struct pci_dev *dev)
+{
+	if (pcibios_disable_irq)
+		pcibios_disable_irq(dev);
+}
diff -puN arch/i386/pci/irq.c~suspend_resume_irq arch/i386/pci/irq.c
--- linux-2.6.13-rc3/arch/i386/pci/irq.c~suspend_resume_irq	2005-07-26 09:19:49.330792296 +0800
+++ linux-2.6.13-rc3-root/arch/i386/pci/irq.c	2005-07-26 09:19:49.347789712 +0800
@@ -56,6 +56,7 @@ struct irq_router_handler {
 };
 
 int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
+void (*pcibios_disable_irq)(struct pci_dev *dev) = NULL;
 
 /*
  *  Check passed address for the PCI IRQ Routing Table signature
diff -puN arch/i386/pci/pci.h~suspend_resume_irq arch/i386/pci/pci.h
--- linux-2.6.13-rc3/arch/i386/pci/pci.h~suspend_resume_irq	2005-07-26 09:19:49.332791992 +0800
+++ linux-2.6.13-rc3-root/arch/i386/pci/pci.h	2005-07-26 09:19:49.347789712 +0800
@@ -73,3 +73,4 @@ extern int pcibios_scanned;
 extern spinlock_t pci_config_lock;
 
 extern int (*pcibios_enable_irq)(struct pci_dev *dev);
+extern void (*pcibios_disable_irq)(struct pci_dev *dev);
diff -puN drivers/acpi/pci_irq.c~suspend_resume_irq drivers/acpi/pci_irq.c
--- linux-2.6.13-rc3/drivers/acpi/pci_irq.c~suspend_resume_irq	2005-07-26 09:19:49.333791840 +0800
+++ linux-2.6.13-rc3-root/drivers/acpi/pci_irq.c	2005-07-26 09:34:20.288386616 +0800
@@ -269,7 +269,51 @@ acpi_pci_irq_del_prt (int segment, int b
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
+typedef int (*irq_lookup_func)(struct acpi_prt_entry *, int *, int *, char **);
 
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
+	irq_lookup_func		func)
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
+	irq_lookup_func		func)
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
@@ -462,7 +494,9 @@ acpi_pci_irq_enable (
 EXPORT_SYMBOL(acpi_pci_irq_enable);
 
 
-#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
+/* FIXME: implement x86/x86_64 version */
+void __attribute__((weak)) acpi_unregister_gsi(u32 i) {}
+
 void
 acpi_pci_irq_disable (
 	struct pci_dev		*dev)
@@ -489,14 +523,14 @@ acpi_pci_irq_disable (
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
 
@@ -512,4 +546,3 @@ acpi_pci_irq_disable (
 
 	return_VOID;
 }
-#endif /* CONFIG_ACPI_DEALLOCATE_IRQ */
diff -puN drivers/acpi/pci_link.c~suspend_resume_irq drivers/acpi/pci_link.c
--- linux-2.6.13-rc3/drivers/acpi/pci_link.c~suspend_resume_irq	2005-07-26 09:19:49.335791536 +0800
+++ linux-2.6.13-rc3-root/drivers/acpi/pci_link.c	2005-07-26 15:17:02.766414808 +0800
@@ -68,6 +68,10 @@ static struct acpi_driver acpi_pci_link_
 			},
 };
 
+/*
+ * If a link is initialized, we never change its active and initialized
+ * later even the link is disable. Instead, we just repick the active irq
+ */
 struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
 	u8			edge_level;		/* All IRQs */
@@ -76,8 +80,7 @@ struct acpi_pci_link_irq {
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 	u8			initialized:1;
-	u8			suspend_resume:1;
-	u8			reserved:6;
+	u8			reserved:7;
 };
 
 struct acpi_pci_link {
@@ -85,12 +88,14 @@ struct acpi_pci_link {
 	struct acpi_device	*device;
 	acpi_handle		handle;
 	struct acpi_pci_link_irq irq;
+	int			refcnt;
 };
 
 static struct {
 	int			count;
 	struct list_head	entries;
 }				acpi_link;
+DECLARE_MUTEX(acpi_link_lock);
 
 
 /* --------------------------------------------------------------------------
@@ -532,12 +537,12 @@ static int acpi_pci_link_allocate(
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
-	if (link->irq.suspend_resume) {
-		acpi_pci_link_set(link, link->irq.active);
-		link->irq.suspend_resume = 0;
-	}
-	if (link->irq.initialized)
+	if (link->irq.initialized) {
+		if (link->refcnt == 0)
+			/* This means the link is disabled but initialized */
+			acpi_pci_link_set(link, link->irq.active);
 		return_VALUE(0);
+	}
 
 	/*
 	 * search for active IRQ in list of possible IRQs.
@@ -596,13 +601,13 @@ static int acpi_pci_link_allocate(
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
@@ -613,7 +618,7 @@ acpi_pci_link_get_irq (
 	struct acpi_device	*device = NULL;
 	struct acpi_pci_link	*link = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_get_irq");
+	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate_irq");
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
@@ -633,21 +638,70 @@ acpi_pci_link_get_irq (
 		return_VALUE(-1);
 	}
 
-	if (acpi_pci_link_allocate(link))
+	down(&acpi_link_lock);
+	if (acpi_pci_link_allocate(link)) {
+		up(&acpi_link_lock);
 		return_VALUE(-1);
+	}
 	   
 	if (!link->irq.active) {
+		up(&acpi_link_lock);
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link active IRQ is 0!\n"));
 		return_VALUE(-1);
 	}
+	link->refcnt ++;
+	up(&acpi_link_lock);
 
 	if (edge_level) *edge_level = link->irq.edge_level;
 	if (active_high_low) *active_high_low = link->irq.active_high_low;
 	if (name) *name = acpi_device_bid(link->device);
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		"Link %s is referenced\n", acpi_device_bid(link->device)));
 	return_VALUE(link->irq.active);
 }
 
+/*
+ * We don't change link's irq information here.  After it is reenabled, we
+ * continue use the info
+ */
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
 
+	link = (struct acpi_pci_link *) acpi_driver_data(device);
+	if (!link) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+		return_VALUE(-1);
+	}
+
+	down(&acpi_link_lock);
+	if (!link->irq.initialized) {
+		up(&acpi_link_lock);
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link isn't initialized\n"));
+		return_VALUE(-1);
+	}
+
+	link->refcnt --;
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		"Link %s is dereferenced\n", acpi_device_bid(link->device)));
+
+	if (link->refcnt == 0) {
+		acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
+	}
+	up(&acpi_link_lock);
+	return_VALUE(link->irq.active);
+}
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -677,6 +731,7 @@ acpi_pci_link_add (
 	strcpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
 	acpi_driver_data(device) = link;
 
+	down(&acpi_link_lock);
 	result = acpi_pci_link_get_possible(link);
 	if (result)
 		goto end;
@@ -712,6 +767,7 @@ acpi_pci_link_add (
 end:
 	/* disable all links -- to be activated on use */
 	acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
+	up(&acpi_link_lock);
 
 	if (result)
 		kfree(link);
@@ -726,19 +782,30 @@ irqrouter_suspend(
 {
 	struct list_head        *node = NULL;
 	struct acpi_pci_link    *link = NULL;
+	int			ret = 0;
 
 	ACPI_FUNCTION_TRACE("irqrouter_suspend");
 
 	list_for_each(node, &acpi_link.entries) {
 		link = list_entry(node, struct acpi_pci_link, node);
 		if (!link) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Invalid link context\n"));
 			continue;
 		}
-		if (link->irq.active && link->irq.initialized)
-			link->irq.suspend_resume = 1;
+		/* We ignore legacy IDE device irq */
+		if (link->irq.initialized && link->refcnt != 0
+			&& link->irq.active != 14 && link->irq.active !=15) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				"Devices with interrupt %d don't call"
+				" pci_disable_device at .suspend, "
+				"please fix the drivers\n",
+				link->irq.active));
+			link->refcnt = 0;
+			ret = -EINVAL;
+		}
 	}
-	return_VALUE(0);
+	return_VALUE(ret);
 }
 
 
@@ -756,8 +823,9 @@ acpi_pci_link_remove (
 
 	link = (struct acpi_pci_link *) acpi_driver_data(device);
 
-	/* TBD: Acquire/release lock */
+	down(&acpi_link_lock);
 	list_del(&link->node);
+	up(&acpi_link_lock);
 
 	kfree(link);
 
@@ -849,6 +917,7 @@ int __init acpi_irq_balance_set(char *st
 __setup("acpi_irq_balance", acpi_irq_balance_set);
 
 
+/* FIXME: we will remove this interface after all drivers call pci_disable_device */
 static struct sysdev_class irqrouter_sysdev_class = {
         set_kset_name("irqrouter"),
         .suspend = irqrouter_suspend,
diff -puN include/acpi/acpi_drivers.h~suspend_resume_irq include/acpi/acpi_drivers.h
--- linux-2.6.13-rc3/include/acpi/acpi_drivers.h~suspend_resume_irq	2005-07-26 09:19:49.336791384 +0800
+++ linux-2.6.13-rc3-root/include/acpi/acpi_drivers.h	2005-07-26 09:19:49.349789408 +0800
@@ -56,8 +56,9 @@
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_irq_penalty_init (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index, int *edge_level,
+int acpi_pci_link_allocate_irq (acpi_handle handle, int index, int *edge_level,
 	int *active_high_low, char **name);
+int acpi_pci_link_free_irq(acpi_handle handle);
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 
diff -puN include/linux/acpi.h~suspend_resume_irq include/linux/acpi.h
--- linux-2.6.13-rc3/include/linux/acpi.h~suspend_resume_irq	2005-07-26 09:19:49.338791080 +0800
+++ linux-2.6.13-rc3-root/include/linux/acpi.h	2005-07-26 09:26:53.679281520 +0800
@@ -453,9 +453,7 @@ int acpi_gsi_to_irq (u32 gsi, unsigned i
  * If this matches the last registration, any IRQ resources for gsi
  * are freed.
  */
-#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
 void acpi_unregister_gsi (u32 gsi);
-#endif
 
 #ifdef CONFIG_ACPI_PCI
 
@@ -480,9 +478,7 @@ struct pci_dev;
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 
-#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
 void acpi_pci_irq_disable (struct pci_dev *dev);
-#endif
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
_




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
