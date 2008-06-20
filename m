From: Len Brown <lenb@kernel.org>
Subject: [PATCH 50/70] PNP: define PNP-specific IORESOURCE_IO_* flags alongside
 IRQ, DMA, MEM
Date: Fri, 20 Jun 2008 03:43:52 -0400
Message-ID: <c93eb9184a26e676b8d02fa85af14aee0df0e8f1.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40470 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYFTHo4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:56 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00EJQ46K14B2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:46 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

PNP previously defined PNP_PORT_FLAG_16BITADDR and PNP_PORT_FLAG_FIXED
in a private header file, but put those flags in struct resource.flags
fields.  Better to make them IORESOURCE_IO_* flags like the existing
IRQ, DMA, and MEM flags.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/interface.c        |    2 +-
 drivers/pnp/isapnp/core.c      |    4 ++--
 drivers/pnp/pnpacpi/rsparser.c |   10 +++++-----
 drivers/pnp/pnpbios/rsparser.c |    4 ++--
 include/linux/ioport.h         |    4 ++++
 include/linux/pnp.h            |    3 ---
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 239923a..c172b6d 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -57,7 +57,7 @@ static void pnp_print_port(pnp_info_buffer_t * buffer, char *space,
 		   "%sport 0x%x-0x%x, align 0x%x, size 0x%x, %i-bit address decoding\n",
 		   space, port->min, port->max,
 		   port->align ? (port->align - 1) : 0, port->size,
-		   port->flags & PNP_PORT_FLAG_16BITADDR ? 16 : 10);
+		   port->flags & IORESOURCE_IO_16BIT_ADDR ? 16 : 10);
 }
 
 static void pnp_print_irq(pnp_info_buffer_t * buffer, char *space,
diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index ca4457e..c5b9252 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -486,7 +486,7 @@ static void __init isapnp_parse_port_resource(struct pnp_dev *dev,
 	port->max = (tmp[4] << 8) | tmp[3];
 	port->align = tmp[5];
 	port->size = tmp[6];
-	port->flags = tmp[0] ? PNP_PORT_FLAG_16BITADDR : 0;
+	port->flags = tmp[0] ? IORESOURCE_IO_16BIT_ADDR : 0;
 	pnp_register_port_resource(dev, option, port);
 }
 
@@ -507,7 +507,7 @@ static void __init isapnp_parse_fixed_port_resource(struct pnp_dev *dev,
 	port->min = port->max = (tmp[1] << 8) | tmp[0];
 	port->size = tmp[2];
 	port->align = 0;
-	port->flags = PNP_PORT_FLAG_FIXED;
+	port->flags = IORESOURCE_IO_FIXED;
 	pnp_register_port_resource(dev, option, port);
 }
 
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 595252b..46069e6 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -180,7 +180,7 @@ static void pnpacpi_parse_allocated_ioresource(struct pnp_dev *dev, u64 start,
 	u64 end = start + len - 1;
 
 	if (io_decode == ACPI_DECODE_16)
-		flags |= PNP_PORT_FLAG_16BITADDR;
+		flags |= IORESOURCE_IO_16BIT_ADDR;
 	if (len == 0 || end >= 0x10003)
 		flags |= IORESOURCE_DISABLED;
 
@@ -485,7 +485,7 @@ static __init void pnpacpi_parse_port_option(struct pnp_dev *dev,
 	port->align = io->alignment;
 	port->size = io->address_length;
 	port->flags = ACPI_DECODE_16 == io->io_decode ?
-	    PNP_PORT_FLAG_16BITADDR : 0;
+	    IORESOURCE_IO_16BIT_ADDR : 0;
 	pnp_register_port_resource(dev, option, port);
 }
 
@@ -503,7 +503,7 @@ static __init void pnpacpi_parse_fixed_port_option(struct pnp_dev *dev,
 	port->min = port->max = io->address;
 	port->size = io->address_length;
 	port->align = 0;
-	port->flags = PNP_PORT_FLAG_FIXED;
+	port->flags = IORESOURCE_IO_FIXED;
 	pnp_register_port_resource(dev, option, port);
 }
 
@@ -609,7 +609,7 @@ static __init void pnpacpi_parse_address_option(struct pnp_dev *dev,
 		port->min = port->max = p->minimum;
 		port->size = p->address_length;
 		port->align = 0;
-		port->flags = PNP_PORT_FLAG_FIXED;
+		port->flags = IORESOURCE_IO_FIXED;
 		pnp_register_port_resource(dev, option, port);
 	}
 }
@@ -946,7 +946,7 @@ static void pnpacpi_encode_io(struct pnp_dev *dev,
 
 	if (pnp_resource_enabled(p)) {
 		/* Note: pnp_assign_port copies pnp_port->flags into p->flags */
-		io->io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR) ?
+		io->io_decode = (p->flags & IORESOURCE_IO_16BIT_ADDR) ?
 		    ACPI_DECODE_16 : ACPI_DECODE_10;
 		io->minimum = p->start;
 		io->maximum = p->end;
diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
index 01f0c3d..489fec3 100644
--- a/drivers/pnp/pnpbios/rsparser.c
+++ b/drivers/pnp/pnpbios/rsparser.c
@@ -310,7 +310,7 @@ static __init void pnpbios_parse_port_option(struct pnp_dev *dev,
 	port->max = (p[5] << 8) | p[4];
 	port->align = p[6];
 	port->size = p[7];
-	port->flags = p[1] ? PNP_PORT_FLAG_16BITADDR : 0;
+	port->flags = p[1] ? IORESOURCE_IO_16BIT_ADDR : 0;
 	pnp_register_port_resource(dev, option, port);
 }
 
@@ -326,7 +326,7 @@ static __init void pnpbios_parse_fixed_port_option(struct pnp_dev *dev,
 	port->min = port->max = (p[2] << 8) | p[1];
 	port->size = p[3];
 	port->align = 0;
-	port->flags = PNP_PORT_FLAG_FIXED;
+	port->flags = IORESOURCE_IO_FIXED;
 	pnp_register_port_resource(dev, option, port);
 }
 
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index c6801bf..39db059 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -88,6 +88,10 @@ struct resource_list {
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
 
+/* PnP I/O specific bits (IORESOURCE_BITS) */
+#define IORESOURCE_IO_16BIT_ADDR	(1<<0)
+#define IORESOURCE_IO_FIXED		(1<<1)
+
 /* PCI ROM control bits (IORESOURCE_BITS) */
 #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
 #define IORESOURCE_ROM_SHADOW		(1<<1)	/* ROM is copy at C000:0 */
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 86e0e1d..b690edb 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -182,9 +182,6 @@ static inline int pnp_dma_valid(struct pnp_dev *dev, unsigned int bar)
 }
 
 
-#define PNP_PORT_FLAG_16BITADDR	(1<<0)
-#define PNP_PORT_FLAG_FIXED	(1<<1)
-
 struct pnp_port {
 	unsigned short min;	/* min base number */
 	unsigned short max;	/* max base number */
-- 
1.5.6

