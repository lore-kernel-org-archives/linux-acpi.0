From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] PNPACPI: fix types when decoding ACPI resources [resend]
Date: Wed, 3 Aug 2005 12:29:05 -0600
Message-ID: <200508031229.05343.bjorn.helgaas@hp.com>
References: <200508020955.54844.bjorn.helgaas@hp.com> <42F0185A.7060901@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42F0185A.7060901-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 02 August 2005 7:05 pm, Kenji Kaneshige wrote:
> This breaks the following patch that is already included into -mm
> tree.
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=7844247&forum_id=6102
> 
> I think we need to check if acpi_register_gsi() succeeded or not.

You're absolutely right.  I was just based off a Linus tree, non -mm,
and didn't notice that your patch conflicted.  How about the following
(based on 2.6.13-rc4-mm1)?  I moved the acpi_register_gsi() into
pnpacpi_parse_allocated_irqresource(), which I think is nice because
the test for failure is right next to the call.



PNPACPI: fix types when decoding ACPI resources

Use types that match the ACPI resource structures.  Previously
the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
which corrupts the value.

This is one of the things that prevents 8250_pnp from working
on HP ia64 boxes.  After 8250_pnp works, we will be able to
remove 8250_acpi.c.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work-mm/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-mm.orig/drivers/pnp/pnpacpi/rsparser.c	2005-08-02 09:39:25.000000000 -0600
+++ work-mm/drivers/pnp/pnpacpi/rsparser.c	2005-08-03 09:31:05.000000000 -0600
@@ -73,25 +73,28 @@
 }
 
 static void
-pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 gsi,
+	int edge_level, int active_high_low)
 {
 	int i = 0;
+	int irq;
 	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
 			i < PNP_MAX_IRQ)
 		i++;
 	if (i < PNP_MAX_IRQ) {
 		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET flag
+		irq = acpi_register_gsi(gsi, edge_level, active_high_low);
 		if (irq < 0) {
 			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->irq_resource[i].start =(unsigned long) irq;
-		res->irq_resource[i].end = (unsigned long) irq;
+		res->irq_resource[i].start = irq;
+		res->irq_resource[i].end = irq;
 	}
 }
 
 static void
-pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, u32 dma)
 {
 	int i = 0;
 	while (i < PNP_MAX_DMA &&
@@ -103,14 +106,14 @@
 			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->dma_resource[i].start =(unsigned long) dma;
-		res->dma_resource[i].end = (unsigned long) dma;
+		res->dma_resource[i].start = dma;
+		res->dma_resource[i].end = dma;
 	}
 }
 
 static void
 pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
-	int io, int len)
+	u32 io, u32 len)
 {
 	int i = 0;
 	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
@@ -122,14 +125,14 @@
 			res->port_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->port_resource[i].start = (unsigned long) io;
-		res->port_resource[i].end = (unsigned long)(io + len - 1);
+		res->port_resource[i].start = io;
+		res->port_resource[i].end = io + len - 1;
 	}
 }
 
 static void
 pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
-	int mem, int len)
+	u64 mem, u64 len)
 {
 	int i = 0;
 	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
@@ -141,8 +144,8 @@
 			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->mem_resource[i].start = (unsigned long) mem;
-		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+		res->mem_resource[i].start = mem;
+		res->mem_resource[i].end = mem + len - 1;
 	}
 }
 
@@ -156,10 +159,10 @@
 	case ACPI_RSTYPE_IRQ:
 		if ((res->data.irq.number_of_interrupts > 0) &&
 			valid_IRQ(res->data.irq.interrupts[0])) {
-			pnpacpi_parse_allocated_irqresource(res_table, 
-				acpi_register_gsi(res->data.irq.interrupts[0],
-					res->data.irq.edge_level,
-					res->data.irq.active_high_low));
+			pnpacpi_parse_allocated_irqresource(res_table,
+				res->data.irq.interrupts[0],
+				res->data.irq.edge_level,
+				res->data.irq.active_high_low);
 			pcibios_penalize_isa_irq(res->data.irq.interrupts[0], 1);
 		}
 		break;
@@ -167,10 +170,10 @@
 	case ACPI_RSTYPE_EXT_IRQ:
 		if ((res->data.extended_irq.number_of_interrupts > 0) &&
 			valid_IRQ(res->data.extended_irq.interrupts[0])) {
-			pnpacpi_parse_allocated_irqresource(res_table, 
-				acpi_register_gsi(res->data.extended_irq.interrupts[0],
-					res->data.extended_irq.edge_level,
-					res->data.extended_irq.active_high_low));
+			pnpacpi_parse_allocated_irqresource(res_table,
+				res->data.extended_irq.interrupts[0],
+				res->data.extended_irq.edge_level,
+				res->data.extended_irq.active_high_low);
 			pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0], 1);
 		}
 		break;


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
