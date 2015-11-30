From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] x86/PCI: Fix regression caused by commit 4d6b4e69a245
Date: Mon, 30 Nov 2015 17:39:42 +0000
Message-ID: <20151130173941.GA25958@localhost.localdomain>
References: <5655B392.7070701@intel.com>
 <8206751.4eTpiUuo7l@vostro.rjw.lan>
 <565BA446.7080003@linux.intel.com>
 <2099144.E7yRfeyfk4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12175 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbbK3Rjn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 12:39:43 -0500
Content-Disposition: inline
In-Reply-To: <2099144.E7yRfeyfk4@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Hans de Bruin <jmdebruin@xmsnet.nl>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Arthur Marsh <arthur.marsh@internode.on.net>

On Mon, Nov 30, 2015 at 03:11:14AM +0100, Rafael J. Wysocki wrote:
> On Monday, November 30, 2015 09:20:06 AM Jiang Liu wrote:
> > Hi Rafael,
> > 	I have removed following changes against the original patch
> > posted at Nov 16.
> >  	       bus);
> > 
> >  	/* already added by acpi ? */
> > -	resource_list_for_each_entry(window, resources)
> > +	resource_list_for_each_entry(window, &info->resources)
> >  		if (window->res->flags & IORESOURCE_BUS) {
> >  			found = true;
> >  			break;
> >  		}
> > -
> >  	if (!found)
> >  		pci_add_resource(resources, &info->busn);
> > 
> > And I only refined the commit message based on the test patch
> > I sent to Authur as an attachment at Nov 25.
> 
> OK, thanks.
> 
> Keith, Hans, can you test this version too please?

Thanks, works for me!

Tested-by: Keith Busch <keith.busch@intel.com>
 
> Bjorn, any more comments from you on this one?
