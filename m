From: jbarnes-sJ/iWh9BUns@public.gmane.org (Jesse Barnes)
Subject: Re: [DMESG] cpumask_t in action
Date: Thu, 6 Nov 2003 09:20:17 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031106172017.GA28613@sgi.com>
References: <20031105222202.GA24119@sgi.com> <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031106165159.GE26869-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 06, 2003 at 04:51:59PM +0000, Matthew Wilcox wrote:
> The arch/ia64 code is not the only offender; ACPI is terribly verbose too.
> I'm going to cc the acpi list too.  See comments below.
> 
> > ACPI: SRAT Processor (id[0x00] eid[0x00]) in proximity domain 0 enabled
[snip[
> > ACPI: SRAT Processor (id[0x20] eid[0x5e]) in proximity domain 47 enabled
> 
> ... for example ;-)  96 lines which honestly tell me nothing.
> 
> > ACPI: SRAT Memory (0x0000003000000000 length 0x0000001000000000 type 0x1) in proximity domain 0 enabled
> > ACPI: SRAT Memory (0x000000b000000000 length 0x0000001000000000 type 0x1) in proximity domain 1 enabled
> [ snip 44 lines ]
> > ACPI: SRAT Memory (0x0000173000000000 length 0x0000001000000000 type 0x1) in proximity domain 46 enabled
> > ACPI: SRAT Memory (0x000017b000000000 length 0x0000001000000000 type 0x1) in proximity domain 47 enabled

Here's one for those two.

Jesse

===== drivers/acpi/numa.c 1.5 vs edited =====
--- 1.5/drivers/acpi/numa.c	Tue Feb 18 12:56:05 2003
+++ edited/drivers/acpi/numa.c	Thu Nov  6 09:18:50 2003
@@ -31,6 +31,13 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 
+#undef ACPI_NUMA_DEBUG
+#ifdef ACPI_NUMA_DEBUG
+#define Dprintk(x...) printk(x)
+#else
+#define Dprintk(x...)
+#endif
+
 extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler);
 
 void __init
@@ -46,7 +53,7 @@
 	{
 		struct acpi_table_processor_affinity *p =
 			(struct acpi_table_processor_affinity*) header;
-		printk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+		Dprintk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
 		       p->apic_id, p->lsapic_eid, p->proximity_domain,
 		       p->flags.enabled?"enabled":"disabled");
 	}
@@ -56,7 +63,7 @@
 	{
 		struct acpi_table_memory_affinity *p =
 			(struct acpi_table_memory_affinity*) header;
-		printk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
+		Dprintk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
 		       p->base_addr_hi, p->base_addr_lo, p->length_hi, p->length_lo,
 		       p->memory_type, p->proximity_domain,
 		       p->flags.enabled ? "enabled" : "disabled",
