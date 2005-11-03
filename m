From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 4/4] pci: call pci_read_irq for bridges
Date: Wed, 02 Nov 2005 16:24:42 -0800
Message-ID: <1130977482.8321.42.camel@whizzy>
References: <20051103001540.365407000@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030224AbVKCAZJ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

Call pci_read_irq() for bridges too, this ensures that the pin
value is stored for later use for bridges that require interrupts.

 drivers/pci/probe.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.13/drivers/pci/probe.c
===================================================================
--- linux-2.6.13.orig/drivers/pci/probe.c
+++ linux-2.6.13/drivers/pci/probe.c
@@ -624,6 +624,7 @@ static int pci_setup_device(struct pci_d
 		/* The PCI-to-PCI bridge spec requires that subtractive
 		   decoding (i.e. transparent) bridge must have programming
 		   interface code of 0x01. */ 
+		pci_read_irq(dev);
 		dev->transparent = ((dev->class & 0xff) == 1);
 		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
 		break;

--
