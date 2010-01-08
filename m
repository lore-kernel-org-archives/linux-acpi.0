From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/12] PCI PM: Make it possible to force using INTx for PCIe
 PME signaling
Date: Fri, 08 Jan 2010 15:08:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001081502010.4012@localhost.localdomain>
References: <200912272057.10443.rjw@sisk.pl>
 <20100106135625.14b37f10@jbarnes-piketon>
 <20100106220214.GA25366@srcf.ucam.org> <201001070000.41807.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-reply-to: <201001070000.41807.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Oliver Neukum <oliver@neukum.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Shaohua Li <shaohua.li@intel.com>, Francois Romieu <romieu@fr.zoreil.com>
List-Id: linux-acpi@vger.kernel.org

> > > This scares me a little... seems like we're not restoring some state on
> > > resume that's needed for MSIs to work?  Looks fine though.
> > 
> > Yeah, that was my concern. We debugged this a little on IRC and didn't 
> > get anywhere, though, so probably need to find someone who knows more 
> > about MSIs...
> 
> I'd rather say someone who knows more about ICH7. :-)
> 
> MSIs work just fine after resume for the other devices in the same box,
> so I'd say it's a chipset issue.

Hmmm, do all the ICH7 boxes behave the same way?

Yesterday MSI announced a netbook running Suse/Moblin,
so there is hope for more technical work w/ MSI to support Linux...

It is a bit worrysome to go out of the gate to need a DMI blacklist
for relatively new hardware.

cheers,
Len Brown, Intel Open Source Technology Center
