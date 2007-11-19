From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 0/4, v3] Physical PCI slot objects
Date: Mon, 19 Nov 2007 15:02:37 -0700
Message-ID: <20071119220237.GC32540@ldl.fc.hp.com>
References: <20071117182954.GA25003@ldl.fc.hp.com> <20071119094307.517411a2@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755992AbXKSWCz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071119094307.517411a2@appleyard>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Gary Hade <garyhade@us.ibm.com>, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Kristin,

* Kristen Carlson Accardi <kristen.c.accardi@intel.com>:
> Alex Chiang <achiang@hp.com> wrote:
> 
> > I have done quite a bit more testing, and verified that this
> > series plays nicely with acpiphp during all stages of the
> > series.  Notably, you can modprobe/rmmod acpiphp repeatedly
> > no matter where you are in the series, and no matter whether
> > you have CONFIG_ACPI_PCI_SLOT turned on. The correct entries
> > in /sys/bus/pci/slots/ will appear and disappear, and we
> > correctly register/deregister ACPI slots with the pci_hp
> > core. 
> 
> How does this patch play with non-acpi based hotplug such as
> the pciehp driver or the shpchp driver for example?

Thanks for asking these questions -- I fixed some bugs in patches
3/4 and 4/4 that should lead to a much better experience.

First, it turns out I did not modify the pciehp driver correctly
when using the new pci_hp_register interface. I fixed this bug,
and noticed a problem in the rpaphp driver (which I fixed as
well). I visually inspected the shpchp driver, and it *seems* to
be correct, so no change there. I will send these fixes as Patch
3/4, v4.

Second, I resolved the issue of what happens when two different
hp drivers try to claim the same PCI slot. Basically, whoever
registered the slot first wins, and second place gets a -EBUSY
return value. I *think* that is the correct behavior, as Willy
informs me that having two drivers try to claim the same slot is
badness. These fixes will be sent as Patch 4/4, v4.

I tested by modprobe/rmmod both acpiphp and pciehp multiple
times, and in differing orders. I also tested both
CONFIG_ACPI_PCI_SLOT turned on and off. In all cases, at least
what I intended to happen did happen.

Now whether my intentions were correct or misguided might be a
different story... ;) I'm wondering most about the -EBUSY thing,
but I don't see a better option.

Patches 1/4 and 2/4 had no changes so I will not resend them.

Thanks.

/ac
