From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [11/12] acpi: acpi pci bridge driver
Date: Fri, 24 Nov 2006 13:32:45 +0800
Message-ID: <1164346365.5768.24.camel@localhost.localdomain>
References: <1158918689.11985.84.camel@localhost.localdomain>
	 <200611232239.34046.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16516 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1756381AbWKXF3T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:29:19 -0500
In-Reply-To: <200611232239.34046.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thu, 2006-11-23 at 22:39 -0500, Len Brown wrote:
> > Index: linux-2.6.18-rc7/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-2.6.18-rc7.orig/drivers/acpi/scan.c	2006-09-19 19:55:25.000000000 +0800
> > +++ linux-2.6.18-rc7/drivers/acpi/scan.c	2006-09-19 19:55:52.000000000 +0800
> > @@ -865,12 +865,13 @@ static int acpi_bus_remove(struct acpi_d
> >  
> >  	if (!rmdevice)
> >  		return 0;
> > -
> > +	/* FIXME: device_release_driver will automically call unbind, is this ok */
> > +#if 0
> >  	if (dev->flags.bus_address) {
> >  		if ((dev->parent) && (dev->parent->ops.unbind))
> >  			dev->parent->ops.unbind(dev);
> >  	}
> > -
> > +#endif
> 
> eh?
Code here should never be executed.
all the acpi-pci bridges(except root bridge) are managed by this acpi-
pci bridge driver . The bind and unbind methods are called automatically
in the .add/.remove method now.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
