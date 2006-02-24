From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [Pcihpd-discuss] Re: [patch 2/3] acpiphp: add dock event
	handling
Date: Fri, 24 Feb 2006 09:29:37 -0800
Message-ID: <1140802177.2085.4.camel@whizzy>
References: <20060223195022.747891000@intel.com>
	 <1140724577.11750.17.camel@whizzy>
	 <87acchz3n6.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:52149 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932393AbWBXRYu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Feb 2006 12:24:50 -0500
In-Reply-To: <87acchz3n6.wl%muneda.takahiro@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, greg@kroah.com, len.brown@intel.com, pavel@ucw.cz

On Fri, 2006-02-24 at 15:12 +0900, MUNEDA Takahiro wrote:
> At Thu, 23 Feb 2006 11:56:17 -0800,
> Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> > 
> > @@ -828,11 +862,21 @@ static int acpiphp_bus_add(struct acpiph
> >  		dbg("no parent device, assuming NULL\n");
> >  		pdevice = NULL;
> >  	}
> > +	if (!acpi_bus_get_device(func->handle, &device)) {
> > +		dbg("bus exists... trim\n");
> > +		/* this shouldn't be in here, so remove
> > +		 * the bus then re-add it...
> > +		 */
> > +		ret_val = acpi_bus_trim(device, 1);
> > +		dbg("acpi_bus_trim return %x\n", ret_val);
> > +	}
> >  	ret_val = acpi_bus_add(&device, pdevice, func->handle,
> > -			ACPI_BUS_TYPE_DEVICE);
> > -	if (ret_val)
> > -		dbg("cannot add bridge to acpi list\n");
> > -
> > +		ACPI_BUS_TYPE_DEVICE);
> > +	if (ret_val) {
> > +		dbg("error adding bus, %x\n",
> > +			-ret_val);
> > +		goto acpiphp_bus_add_out;
> > +	}
> >  	/*
> >  	 * try to start anyway.  We could have failed to add
> >  	 * simply because this bus had previously been added
> 
> Hi Kristen,
> 
> Why don't you call acpi_bus_trim() when the device is
> removed. This time, eject_dock() or disable_device()?
> So you don't need to call acpi_bus_trim() as error case.
> 
> Thanks,
> MUNE
> 

MUNE,
I added this because I found that in some laptops the dsdt reported a
bus present that wasn't actually, so the bus would be added at boot
time, but the PRT not read if the laptop was booted undocked.  Initially
I tried to get a handle to the existing bus, and then if the bus already
was added, just call acpi_bus_start() - but this did not cause the PRT
to be read in this case - the only thing that worked for me was to
remove the bus and readd it.  If there's a better way to handle this,
I'd appreciate the suggestion.  

Kristen

