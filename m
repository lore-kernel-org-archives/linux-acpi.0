From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [ACPI] Re: [Pcihpd-discuss] RE: [patch 2/2] acpi: add ability
	to derive irq when doing a surpriseremoval of an adapter
Date: Fri, 21 Oct 2005 14:28:34 -0700
Message-ID: <1129930114.5932.6.camel@whizzy>
References: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406>
	 <1129053267.15526.9.camel@whizzy> <1129679877.30588.5.camel@whizzy>
	 <200510190929.06728.bjorn.helgaas@hp.com>
	 <1129740711.31966.21.camel@whizzy>  <20051019165940.GA2177@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965172AbVJUV2q@vger.kernel.org>
In-Reply-To: <20051019165940.GA2177@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Shah, Rajesh" <rajesh.shah@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patch will allow the acpi code to correctly disable the irq when an
adapter has been "surprise" removed.  The INTERRUPT_PIN value is stored
in the pci_dev structure at probe time, and if the acpi code attempts to
read the INTERRUPT_PIN from config space and detects that the adapter is
not present, it will use the stored value instead.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
I've re-worked this patch as you suggested.  the INTERRUPT_PIN was read
in many different places in the code, so I hope that this is the right
place to save off the value.  Thanks for taking a look.

 drivers/acpi/pci_irq.c |   10 ++++++++++
 drivers/pci/probe.c    |    1 +
 include/linux/pci.h    |    1 +
 3 files changed, 12 insertions(+)

Index: linux-2.6.13/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.13.orig/drivers/acpi/pci_irq.c
+++ linux-2.6.13/drivers/acpi/pci_irq.c
@@ -504,6 +504,16 @@ void acpi_pci_irq_disable(struct pci_dev
 		return_VOID;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+
+	/*
+	 * If a device has been "surprise" removed via
+	 * hotplug, the pin value will be invalid
+	 * In this case, we should use the stored
+	 * pin value from the pci_dev structure
+	 */
+	if (pin == 0xff)
+		pin = dev->pin;
+
 	if (!pin)
 		return_VOID;
 	pin--;
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
