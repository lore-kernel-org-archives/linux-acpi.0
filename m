From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 5/5] x86 PCI: use dev_printk when possible
Date: Wed, 25 Jun 2008 23:48:32 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806252345460.3279@localhost.localdomain>
References: <20080613165209.507694130@ldl.fc.hp.com>
 <20080613165304.842091464@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-reply-to: <20080613165304.842091464@ldl.fc.hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

I guess the 'INTA#; rather than 'INTA' syntax I'm not fond of appears in 
this x86 patch too.  I think if we don't really have anything useful 
to say about polarity, then we should not add an active low symbol.

thanks,
-Len

-       printk(KERN_INFO "PCI: %s IRQ %d for device %s\n", msg, irq, 
pci_name(dev));
+       dev_info(&dev->dev, "%s PCI INT%c# -> IRQ %d\n", msg, 'A' + pin, 
irq);
