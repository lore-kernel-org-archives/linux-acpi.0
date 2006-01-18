From: Greg KH <greg@kroah.com>
Subject: Re: [Pcihpd-discuss] [patch 2/4]  acpiphp: handle dock bridges
Date: Tue, 17 Jan 2006 21:11:40 -0800
Message-ID: <20060118051140.GB7493@kroah.com>
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy> <43CDA761.5040707@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:24451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030237AbWARFMd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 00:12:33 -0500
Content-Disposition: inline
In-Reply-To: <43CDA761.5040707@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>, linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@ucw.cz

On Wed, Jan 18, 2006 at 11:26:41AM +0900, Kenji Kaneshige wrote:
> Hi,
> 
> > +static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
> > +					struct pci_dev *dev)
> > +{
> > +	struct list_head *l;
> > +	struct acpiphp_func *func;
> > +	struct pci_bus *bus = slot->bridge->pci_bus;
> > +
> > +	list_for_each (l, &slot->funcs) {
> > +		func = list_entry(l, struct acpiphp_func, sibling);
> > +		if (pci_get_slot(bus, PCI_DEVFN(slot->device,
> > +					func->function)) == dev)
> > +			return func;
> > +	}
> 
> This seems to leak reference counter of pci_dev. I think you
> must call pci_dev_put() also.

Yes, good catch.

thanks,

greg k-h
