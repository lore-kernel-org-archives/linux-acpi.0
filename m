From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: [PATCH] PNPACPI: Register disabled resources
Date: Fri, 24 Jun 2011 23:02:33 +0200
Message-ID: <4E04FB69.3000206@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:35290 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752753Ab1FXVCo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2011 17:02:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>

When parsing PnP resources, it may happen that some of these
are disabled.  The current solution is to skip these resources
completely - with the unfortunate side effect that they are not
registered despite the fact that they exist, after all.  The
downside of his is that these resources cannot be manipulated
programatically.  The kernel's APM implementation does not suffer
from this problem.

This patch fixes a problem with (at least) some vintage IBM
ThinkPad 600E (and most likely also on the 600, 600X, and 770X
which have a very similar layout) where some of its PnP devices
support options where either an IRQ or DMA is disabled.  The
manipulation of these resources is important because the 600E
has very special requirements.

The patch applies the idea to register disabled resources to
all types of resources, not just to IRQs and DMAs.

No regressions were observed on hardware that does not require
this patch.

The patch is applied against 2.6.39.


Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>


Index: linux/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- linux.orig/drivers/pnp/pnpacpi/rsparser.c
+++ linux/drivers/pnp/pnpacpi/rsparser.c
@@ -509,15 +509,15 @@ static __init void pnpacpi_parse_dma_opt
  					    struct acpi_resource_dma *p)
  {
  	int i;
-	unsigned char map = 0, flags;
+	unsigned char map = 0, flags = 0;

  	if (p->channel_count == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	for (i = 0; i < p->channel_count; i++)
  		map |= 1 << p->channels[i];

-	flags = dma_flags(dev, p->type, p->bus_master, p->transfer);
+	flags |= dma_flags(dev, p->type, p->bus_master, p->transfer);
  	pnp_register_dma_resource(dev, option_flags, map, flags);
  }

@@ -527,17 +527,17 @@ static __init void pnpacpi_parse_irq_opt
  {
  	int i;
  	pnp_irq_mask_t map;
-	unsigned char flags;
+	unsigned char flags = 0;

  	if (p->interrupt_count == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	bitmap_zero(map.bits, PNP_IRQ_NR);
  	for (i = 0; i < p->interrupt_count; i++)
  		if (p->interrupts[i])
  			__set_bit(p->interrupts[i], map.bits);

-	flags = irq_flags(p->triggering, p->polarity, p->sharable);
+	flags |= irq_flags(p->triggering, p->polarity, p->sharable);
  	pnp_register_irq_resource(dev, option_flags, &map, flags);
  }

@@ -547,10 +547,10 @@ static __init void pnpacpi_parse_ext_irq
  {
  	int i;
  	pnp_irq_mask_t map;
-	unsigned char flags;
+	unsigned char flags = 0;

  	if (p->interrupt_count == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	bitmap_zero(map.bits, PNP_IRQ_NR);
  	for (i = 0; i < p->interrupt_count; i++) {
@@ -564,7 +564,7 @@ static __init void pnpacpi_parse_ext_irq
  		}
  	}

-	flags = irq_flags(p->triggering, p->polarity, p->sharable);
+	flags |= irq_flags(p->triggering, p->polarity, p->sharable);
  	pnp_register_irq_resource(dev, option_flags, &map, flags);
  }

@@ -575,10 +575,10 @@ static __init void pnpacpi_parse_port_op
  	unsigned char flags = 0;

  	if (io->address_length == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	if (io->io_decode == ACPI_DECODE_16)
-		flags = IORESOURCE_IO_16BIT_ADDR;
+		flags |= IORESOURCE_IO_16BIT_ADDR;
  	pnp_register_port_resource(dev, option_flags, io->minimum, io->maximum,
  				   io->alignment, io->address_length, flags);
  }
@@ -587,11 +587,13 @@ static __init void pnpacpi_parse_fixed_p
  					unsigned int option_flags,
  					struct acpi_resource_fixed_io *io)
  {
+	unsigned char flags = 0;
+
  	if (io->address_length == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	pnp_register_port_resource(dev, option_flags, io->address, io->address,
-				   0, io->address_length, IORESOURCE_IO_FIXED);
+				   0, io->address_length, flags | IORESOURCE_IO_FIXED);
  }

  static __init void pnpacpi_parse_mem24_option(struct pnp_dev *dev,
@@ -601,10 +603,10 @@ static __init void pnpacpi_parse_mem24_o
  	unsigned char flags = 0;

  	if (p->address_length == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	if (p->write_protect == ACPI_READ_WRITE_MEMORY)
-		flags = IORESOURCE_MEM_WRITEABLE;
+		flags |= IORESOURCE_MEM_WRITEABLE;
  	pnp_register_mem_resource(dev, option_flags, p->minimum, p->maximum,
  				  p->alignment, p->address_length, flags);
  }
@@ -616,10 +618,10 @@ static __init void pnpacpi_parse_mem32_o
  	unsigned char flags = 0;

  	if (p->address_length == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	if (p->write_protect == ACPI_READ_WRITE_MEMORY)
-		flags = IORESOURCE_MEM_WRITEABLE;
+		flags |= IORESOURCE_MEM_WRITEABLE;
  	pnp_register_mem_resource(dev, option_flags, p->minimum, p->maximum,
  				  p->alignment, p->address_length, flags);
  }
@@ -631,10 +633,10 @@ static __init void pnpacpi_parse_fixed_m
  	unsigned char flags = 0;

  	if (p->address_length == 0)
-		return;
+		iflags |= IORESOURCE_DISABLED;

  	if (p->write_protect == ACPI_READ_WRITE_MEMORY)
-		flags = IORESOURCE_MEM_WRITEABLE;
+		flags |= IORESOURCE_MEM_WRITEABLE;
  	pnp_register_mem_resource(dev, option_flags, p->address, p->address,
  				  0, p->address_length, flags);
  }
@@ -655,18 +657,18 @@ static __init void pnpacpi_parse_address
  	}

  	if (p->address_length == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	if (p->resource_type == ACPI_MEMORY_RANGE) {
  		if (p->info.mem.write_protect == ACPI_READ_WRITE_MEMORY)
-			flags = IORESOURCE_MEM_WRITEABLE;
+			flags |= IORESOURCE_MEM_WRITEABLE;
  		pnp_register_mem_resource(dev, option_flags, p->minimum,
  					  p->minimum, 0, p->address_length,
  					  flags);
  	} else if (p->resource_type == ACPI_IO_RANGE)
  		pnp_register_port_resource(dev, option_flags, p->minimum,
  					   p->minimum, 0, p->address_length,
-					   IORESOURCE_IO_FIXED);
+					   flags | IORESOURCE_IO_FIXED);
  }

  static __init void pnpacpi_parse_ext_address_option(struct pnp_dev *dev,
@@ -677,18 +679,18 @@ static __init void pnpacpi_parse_ext_add
  	unsigned char flags = 0;

  	if (p->address_length == 0)
-		return;
+		flags |= IORESOURCE_DISABLED;

  	if (p->resource_type == ACPI_MEMORY_RANGE) {
  		if (p->info.mem.write_protect == ACPI_READ_WRITE_MEMORY)
-			flags = IORESOURCE_MEM_WRITEABLE;
+			flags |= IORESOURCE_MEM_WRITEABLE;
  		pnp_register_mem_resource(dev, option_flags, p->minimum,
  					  p->minimum, 0, p->address_length,
  					  flags);
  	} else if (p->resource_type == ACPI_IO_RANGE)
  		pnp_register_port_resource(dev, option_flags, p->minimum,
  					   p->minimum, 0, p->address_length,
-					   IORESOURCE_IO_FIXED);
+					   flags | IORESOURCE_IO_FIXED);
  }

  struct acpipnp_parse_option_s {
