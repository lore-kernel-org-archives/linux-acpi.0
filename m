From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI-based floppy controller enumeration
Date: Mon, 16 Aug 2004 12:25:01 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408161225.01359.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Adrian,

I hate to ask for more favors, but it'd be great if you could give
this patch a whirl.  It would be very interesting to validate that
it works for you, both with the floppies enabled and disabled in
the BIOS.  If you try both those configurations, I'd like to see
the full dmesg logs.

This has a little more potential to break things than the previous
patch, because it will actually use I/O port addresses, IRQs, and
DMA channels from ACPI _CRS, instead of the previous hard-coded
values.  Linux has previously ignored the _CRS for floppies, but
hopefully Windows has shaken out most of the BIOS bugs there...

This is against current BK, and depends on this recent ACPI update:
http://linux.bkbits.net:8080/linux-2.5/cset%404117a4f5ujfiLt9Paj-V1vwM1-2QFA


===== drivers/block/floppy.c 1.103 vs edited =====
--- 1.103/drivers/block/floppy.c	2004-08-02 02:00:45 -06:00
+++ edited/drivers/block/floppy.c	2004-08-16 11:36:40 -06:00
@@ -181,6 +181,11 @@
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
 
+#ifdef CONFIG_ACPI_BUS
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+#endif
+
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
  * It's been recommended that take about 1/4 of the default speed
@@ -4222,10 +4227,121 @@
 	return get_disk(disks[drive]);
 }
 
+#ifdef CONFIG_ACPI_BUS
+static int acpi_floppies;
+
+struct floppy_resources {
+	unsigned int port;
+	unsigned int nr_ports;
+	unsigned int irq;
+	unsigned int dma_channel;
+};
+
+static acpi_status acpi_floppy_resource(struct acpi_resource *res, void *data)
+{
+	struct floppy_resources *floppy = (struct floppy_resources *) data;
+	struct acpi_resource_io *io;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_ext_irq *ext_irq;
+	struct acpi_resource_dma *dma;
+
+	if (res->id == ACPI_RSTYPE_IO) {
+		io = &res->data.io;
+		if (io->range_length) {
+			floppy->port = io->min_base_address;
+			floppy->nr_ports = io->range_length;
+		}
+	} else if (res->id == ACPI_RSTYPE_IRQ) {
+		irq = &res->data.irq;
+		if (irq->number_of_interrupts > 0)
+			floppy->irq = acpi_register_gsi(irq->interrupts[0],
+				irq->edge_level, irq->active_high_low);
+	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
+		ext_irq = &res->data.extended_irq;
+		if (ext_irq->number_of_interrupts > 0)
+			floppy->irq = acpi_register_gsi(ext_irq->interrupts[0],
+				ext_irq->edge_level, ext_irq->active_high_low);
+	} else if (res->id == ACPI_RSTYPE_DMA) {
+		dma = &res->data.dma;
+		if (dma->number_of_channels > 0)
+			floppy->dma_channel = dma->channels[0];
+	}
+	return AE_OK;
+}
+
+static int acpi_floppy_add(struct acpi_device *device)
+{
+	struct floppy_resources floppy;
+	acpi_status status;
+
+	memset(&floppy, 0, sizeof(floppy));
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+		acpi_floppy_resource, &floppy);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	printk("%s: controller ACPI %s at I/O 0x%x-0x%x irq %d dma channel %d\n",
+		DEVICE_NAME, device->pnp.bus_id,
+		floppy.port, floppy.port + floppy.nr_ports - 1,
+		floppy.irq, floppy.dma_channel);
+
+	/*
+	 * The driver assumes I/O port regions like 0x3f0-0x3f5, but it
+	 * ignores the first two (i.e., 0x3f0 and 0x3f1), which are for
+	 * PS/2 systems.  Since no PS/2 systems have ACPI, we should get
+	 * a region like 0x3f2-0x3f5, so we adjust it down to what the
+	 * driver expects.
+	 */
+	acpi_floppies++;
+	if (acpi_floppies == 1) {
+		FDC1 = floppy.port - 2;
+		FLOPPY_IRQ = floppy.irq;
+		FLOPPY_DMA = floppy.dma_channel;
+	} else if (acpi_floppies == 2) {
+		FDC2 = floppy.port - 2;
+		if (floppy.irq != FLOPPY_IRQ || floppy.dma_channel != FLOPPY_DMA)
+			printk(KERN_WARNING "%s: different IRQ/DMA info for %s; may not work\n",
+				DEVICE_NAME, device->pnp.bus_id);
+	} else {
+		printk(KERN_ERR "%s: only 2 controllers supported; %s ignored\n",
+			DEVICE_NAME, device->pnp.bus_id);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int acpi_floppy_remove(struct acpi_device *device, int type)
+{
+	printk(KERN_ERR "%s: remove ACPI %s not supported\n", DEVICE_NAME,
+		device->pnp.bus_id);
+	return -EINVAL;
+}
+
+static struct acpi_driver acpi_floppy_driver = {
+	.name	= "floppy",
+	.ids	= "PNP0700",
+	.ops	= {
+		.add	= acpi_floppy_add,
+		.remove	= acpi_floppy_remove,
+	},
+};
+
+static int acpi_floppy_init(void)
+{
+	return acpi_bus_register_driver(&acpi_floppy_driver);
+}
+#endif
+
 int __init floppy_init(void)
 {
 	int i, unit, drive;
 	int err, dr;
+
+#ifdef CONFIG_ACPI_BUS
+	if (acpi_floppy_init() == 0)
+		return -ENODEV;
+#endif
 
 	raw_cmd = NULL;
 


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
