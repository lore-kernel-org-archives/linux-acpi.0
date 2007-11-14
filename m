From: Alex Chiang <achiang@hp.com>
Subject: Re: [Pcihpd-discuss] [PATCH 2/5] Construct one fakephp slot per
	pci slot
Date: Wed, 14 Nov 2007 07:17:55 -0700
Message-ID: <20071114141755.GA7523@ldl.fc.hp.com>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113001336.GC13341@ldl.fc.hp.com> <200711141339.31839.eike-hotplug@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel12.hp.com ([156.153.255.237]:36361 "EHLO palrel12.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625AbXKNOR5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 09:17:57 -0500
Content-Disposition: inline
In-Reply-To: <200711141339.31839.eike-hotplug@sf-tec.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Cc: pcihpd-discuss@lists.sourceforge.net, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, matthew@wil.cx, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Hi Eike,

* Rolf Eike Beer <eike-hotplug@sf-tec.de>:
> Alex Chiang wrote:
> > --- a/drivers/pci/hotplug/fakephp.c
> > +++ b/drivers/pci/hotplug/fakephp.c
> > @@ -93,6 +93,7 @@ static int add_slot(struct pci_dev *dev)
> >  	struct dummy_slot *dslot;
> >  	struct hotplug_slot *slot;
> >  	int retval = -ENOMEM;
> > +	static int count = 1;
> >
> >  	slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
> >  	if (!slot)
> > @@ -106,7 +107,8 @@ static int add_slot(struct pci_dev *dev)
> >  	slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
> >  	slot->info->cur_bus_speed = PCI_SPEED_UNKNOWN;
> >
> > -	slot->name = &dev->dev.bus_id[0];
> > +	slot->name = kmalloc(8, GFP_KERNEL);
> > +	sprintf(slot->name, "fake%d", count++);
> >  	dbg("slot->name = %s\n", slot->name);
> >
> >  	dslot = kmalloc(sizeof(struct dummy_slot), GFP_KERNEL);
> 
> This is ugly. Please do it the way we already do e.g. for
> acpiphp: add a char[8] to "struct dummy_slot" and just
> reference that here.

I took at look at the code in acpiphp you're talking about, and
I'm not sure why you think the above is "ugly". We're talking
about a runtime vs compile time storage for the name, and doing a
kmalloc/sprintf is a pretty standard idiom.

BTW, I did incorporate both Linas' and Willy's comments, by
changing the kmalloc size to an explicit 32, and using snprintf
instead.

In any case, for your particular comment, I think I'm going to
leave it alone for now, and let Greg weigh in with the final
recommendation.

Thanks for the review.

/ac

