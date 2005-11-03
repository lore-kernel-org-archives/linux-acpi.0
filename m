From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/4] pci: store PCI_INTERRUPT_PIN in pci_dev
Date: Wed, 02 Nov 2005 16:24:32 -0800
Message-ID: <1130977472.8321.39.camel@whizzy>
References: <20051103001540.365407000@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030216AbVKCAYl@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

plain text document attachment (patch-interrupt-pin)
Store the value of the INTERRUPT_PIN in the pci_dev structure
so that it can be retrieved later.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
 
 drivers/pci/probe.c |    1 +
 include/linux/pci.h |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6.13/drivers/pci/probe.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/probe.c
+++ linux-2.6.13/drivers/pci/probe.c
@@ -571,6 +571,7 @@ static void pci_read_irq(struct pci_dev 
 	unsigned char irq;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
+	dev->pin = irq;
 	if (irq)
 		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	dev->irq = irq;
Index: linux-2.6.13/include/linux/pci.h
===================================================================
--- linux-2.6.13.orig/include/linux/pci.h
+++ linux-2.6.13/include/linux/pci.h
@@ -98,6 +98,7 @@ struct pci_dev {
 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 	u8		rom_base_reg;	/* which config register controls the ROM */
+	u8		pin;  		/* which interrupt pin this device uses */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this

--
