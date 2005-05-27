From: Alexander Nyberg <alexn@telia.com>
Subject: Re: [PATCH] VIA IRQ quirk for 2.6.12-rc5
Date: Fri, 27 May 2005 12:27:05 +0200
Message-ID: <1117189625.949.9.camel@localhost.localdomain>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262418AbVE0K1M@vger.kernel.org>
In-Reply-To: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, torvalds@osdl.org, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

> Linus,
> Please apply this patch to 2.6.12-rc5.
> It fixes a 2.6.11 regression in the VIA IRQ quirk
> on machines with mixed vendor chip-sets.
> 
> thanks,
> Len
> 
> 
> Delete quirk_via_bridge(), restore quirk_via_irqpic() --
> but now improved to be invoked upon device ENABLE, and
> now only for VIA devices -- not all devices behind VIA bridges.

Please drop the __devinit on quirk_via_irqpic() or apply the patch I'm
putting at the bottom. Also there seems to be a completely unrelated
acpi chunk at the bottom of your patch...

quirk_via_irqpic can't be __devinit for swsuspend

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: linux-2.6/drivers/pci/quirks.c
===================================================================
--- linux-2.6.orig/drivers/pci/quirks.c	2005-05-27 12:15:17.000000000 +0200
+++ linux-2.6/drivers/pci/quirks.c	2005-05-27 12:17:10.000000000 +0200
@@ -492,7 +492,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-static void __devinit quirk_via_irqpic(struct pci_dev *dev)
+static void quirk_via_irqpic(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
 
