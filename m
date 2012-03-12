From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/4] usb: Bind devices to ACPI devices when possible
Date: Mon, 12 Mar 2012 17:03:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203121702000.1216-100000@iolanthe.rowland.org>
References: <20120312205616.GB22929@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58174 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753551Ab2CLVDz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Mar 2012 17:03:55 -0400
In-Reply-To: <20120312205616.GB22929@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org

On Mon, 12 Mar 2012, Matthew Garrett wrote:

> > > +static struct acpi_bus_type usb_acpi_bus = {
> > > +	.bus = &usb_bus_type,
> > > +	.find_bridge = NULL,
> > > +	.find_device = usb_acpi_find_device,
> > > +};
> > 
> > I don't understand exactly how this is supposed to work.  Does this 
> > mean that the ACPI core will call usb_acpi_find_device() for every ACPI 
> > device whose underlying real device is registered on the usb_bus_type?  
> > If so, when does this call take place?
> 
> Kind of? platform_notify gets called whenever a device is registered, 
> and on ACPi systems that'll be acpi_platform_notify. It'll take the 
> registered device and, if there are glue functions for that bus type, 
> pass it to the callback functions. The idea is that we have two 
> disparate device trees, the Linux one and the ACPI one. This just gives 
> us an opportunity to glue some of the devices together.

Ah, okay.

> > Bear in mind that USB devices aren't the only things registered with 
> > usb_bus_type.  We also register device structures representing USB 
> > interfaces and endpoints.  Hence the to_usb_device() call above might 
> > not always do what you want.
> 
> Ugh. Is there any clean way to distinguish from the device structure? If 
> not, the easiest would seem to be to just add another bus type 
> structure, even if the members are identical.

Easy; just call is_usb_device() (defined in core/usb.h).

Alan Stern

