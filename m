From: jbarnes-sJ/iWh9BUns@public.gmane.org (Jesse Barnes)
Subject: Re: [DMESG] cpumask_t in action
Date: Thu, 6 Nov 2003 09:23:46 -0800
Sender: linux-ia64-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031106172346.GB28613@sgi.com>
References: <20031105222202.GA24119@sgi.com> <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031106165159.GE26869-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 06, 2003 at 04:51:59PM +0000, Matthew Wilcox wrote:
> The arch/ia64 code is not the only offender; ACPI is terribly verbose too.
> I'm going to cc the acpi list too.  See comments below.
> 
> ... and again.
> 
> > CPU 0: 61 virtual and 50 physical address bits
> > ACPI: Local APIC address 0xc0000000fee00000
> > ACPI: LSAPIC (acpi_id[0x00] lsapic_id[0x00] lsapic_eid[0x00] enabled)
> > CPU 0 (0x0000) enabled (BSP)
> > ACPI: LSAPIC (acpi_id[0x01] lsapic_id[0x20] lsapic_eid[0x00] enabled)
> > CPU 1 (0x2000) enabled
> > ACPI: LSAPIC (acpi_id[0x02] lsapic_id[0x00] lsapic_eid[0x02] enabled)
> > CPU 2 (0x0002) enabled
> > ACPI: LSAPIC (acpi_id[0x03] lsapic_id[0x20] lsapic_eid[0x02] enabled)
> > CPU 3 (0x2002) enabled
> [ snip 180 lines ]
> > ACPI: LSAPIC (acpi_id[0x5e] lsapic_id[0x00] lsapic_eid[0x5e] enabled)
> > CPU 94 (0x005e) enabled
> > ACPI: LSAPIC (acpi_id[0x5f] lsapic_id[0x20] lsapic_eid[0x5e] enabled)
> > CPU 95 (0x205e) enabled

And here's a patch to quiet this stuff.

Jesse

===== drivers/acpi/tables.c 1.16 vs edited =====
--- 1.16/drivers/acpi/tables.c	Thu Sep 18 16:22:09 2003
+++ edited/drivers/acpi/tables.c	Thu Nov  6 09:22:35 2003
@@ -35,6 +35,13 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 
+#undef ACPI_TABLES_DEBUG
+#ifdef ACPI_TABLES_DEBUG
+#define Dprintk(x...) printk(x)
+#else
+#define Dprintk(x...)
+#endif
+
 #define PREFIX			"ACPI: "
 
 #define ACPI_MAX_TABLES		256
@@ -118,7 +125,7 @@
 	{
 		struct acpi_table_lapic *p =
 			(struct acpi_table_lapic*) header;
-		printk(KERN_INFO PREFIX "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
+		Dprintk(KERN_INFO PREFIX "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
 			p->acpi_id, p->id, p->flags.enabled?"enabled":"disabled");
 	}
 		break;
@@ -127,7 +134,7 @@
 	{
 		struct acpi_table_ioapic *p =
 			(struct acpi_table_ioapic*) header;
-		printk(KERN_INFO PREFIX "IOAPIC (id[0x%02x] address[0x%08x] global_irq_base[0x%x])\n",
+		Dprintk(KERN_INFO PREFIX "IOAPIC (id[0x%02x] address[0x%08x] global_irq_base[0x%x])\n",
 			p->id, p->address, p->global_irq_base);
 	}
 		break;
@@ -136,7 +143,7 @@
 	{
 		struct acpi_table_int_src_ovr *p =
 			(struct acpi_table_int_src_ovr*) header;
-		printk(KERN_INFO PREFIX "INT_SRC_OVR (bus[%d] irq[0x%x] global_irq[0x%x] polarity[0x%x] trigger[0x%x])\n",
+		Dprintk(KERN_INFO PREFIX "INT_SRC_OVR (bus[%d] irq[0x%x] global_irq[0x%x] polarity[0x%x] trigger[0x%x])\n",
 			p->bus, p->bus_irq, p->global_irq, p->flags.polarity, p->flags.trigger);
 	}
 		break;
@@ -145,7 +152,7 @@
 	{
 		struct acpi_table_nmi_src *p =
 			(struct acpi_table_nmi_src*) header;
-		printk(KERN_INFO PREFIX "NMI_SRC (polarity[0x%x] trigger[0x%x] global_irq[0x%x])\n",
+		Dprintk(KERN_INFO PREFIX "NMI_SRC (polarity[0x%x] trigger[0x%x] global_irq[0x%x])\n",
 			p->flags.polarity, p->flags.trigger, p->global_irq);
 	}
 		break;
@@ -154,7 +161,7 @@
 	{
 		struct acpi_table_lapic_nmi *p =
 			(struct acpi_table_lapic_nmi*) header;
-		printk(KERN_INFO PREFIX "LAPIC_NMI (acpi_id[0x%02x] polarity[0x%x] trigger[0x%x] lint[0x%x])\n",
+		Dprintk(KERN_INFO PREFIX "LAPIC_NMI (acpi_id[0x%02x] polarity[0x%x] trigger[0x%x] lint[0x%x])\n",
 			p->acpi_id, p->flags.polarity, p->flags.trigger, p->lint);
 	}
 		break;
@@ -163,7 +170,7 @@
 	{
 		struct acpi_table_lapic_addr_ovr *p =
 			(struct acpi_table_lapic_addr_ovr*) header;
-		printk(KERN_INFO PREFIX "LAPIC_ADDR_OVR (address[%p])\n",
+		Dprintk(KERN_INFO PREFIX "LAPIC_ADDR_OVR (address[%p])\n",
 			(void *) (unsigned long) p->address);
 	}
 		break;
@@ -172,7 +179,7 @@
 	{
 		struct acpi_table_iosapic *p =
 			(struct acpi_table_iosapic*) header;
-		printk(KERN_INFO PREFIX "IOSAPIC (id[0x%x] global_irq_base[0x%x] address[%p])\n",
+		Dprintk(KERN_INFO PREFIX "IOSAPIC (id[0x%x] global_irq_base[0x%x] address[%p])\n",
 			p->id, p->global_irq_base, (void *) (unsigned long) p->address);
 	}
 		break;
@@ -181,7 +188,7 @@
 	{
 		struct acpi_table_lsapic *p =
 			(struct acpi_table_lsapic*) header;
-		printk(KERN_INFO PREFIX "LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
+		Dprintk(KERN_INFO PREFIX "LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
 			p->acpi_id, p->id, p->eid, p->flags.enabled?"enabled":"disabled");
 	}
 		break;
@@ -190,7 +197,7 @@
 	{
 		struct acpi_table_plat_int_src *p =
 			(struct acpi_table_plat_int_src*) header;
-		printk(KERN_INFO PREFIX "PLAT_INT_SRC (polarity[0x%x] trigger[0x%x] type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] global_irq[0x%x]\n",
+		Dprintk(KERN_INFO PREFIX "PLAT_INT_SRC (polarity[0x%x] trigger[0x%x] type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] global_irq[0x%x]\n",
 			p->flags.polarity, p->flags.trigger, p->type, p->id, p->eid, p->iosapic_vector, p->global_irq);
 	}
 		break;
-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
