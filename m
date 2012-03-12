From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH 3/4] usb: Bind devices to ACPI devices when possible
Date: Mon, 12 Mar 2012 20:56:16 +0000
Message-ID: <20120312205616.GB22929@srcf.ucam.org>
References: <1331596735-3690-3-git-send-email-mjg@redhat.com>
 <Pine.LNX.4.44L0.1203121631230.1216-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1203121631230.1216-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 12, 2012 at 04:38:57PM -0400, Alan Stern wrote:
> On Mon, 12 Mar 2012, Matthew Garrett wrote:
> 
> > Built-in USB devices will typically have a representation in the system
> > ACPI tables. Add support for binding the two together so the USB code can
> > make use of the associated methods.
> 
> > +static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
> > +{
> > +	struct usb_device *udev = to_usb_device(dev);
> > +	struct device *parent = dev->parent;
> > +	acpi_handle *parent_handle = DEVICE_ACPI_HANDLE(parent);
> > +
> > +	if (!parent_handle)
> > +		return -ENODEV;
> > +
> > +	*handle = acpi_get_child(parent_handle, udev->portnum);
> > +
> > +	if (!*handle)
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct acpi_bus_type usb_acpi_bus = {
> > +	.bus = &usb_bus_type,
> > +	.find_bridge = NULL,
> > +	.find_device = usb_acpi_find_device,
> > +};
> 
> I don't understand exactly how this is supposed to work.  Does this 
> mean that the ACPI core will call usb_acpi_find_device() for every ACPI 
> device whose underlying real device is registered on the usb_bus_type?  
> If so, when does this call take place?

Kind of? platform_notify gets called whenever a device is registered, 
and on ACPi systems that'll be acpi_platform_notify. It'll take the 
registered device and, if there are glue functions for that bus type, 
pass it to the callback functions. The idea is that we have two 
disparate device trees, the Linux one and the ACPI one. This just gives 
us an opportunity to glue some of the devices together.

> Or does it work some other way?
> 
> Bear in mind that USB devices aren't the only things registered with 
> usb_bus_type.  We also register device structures representing USB 
> interfaces and endpoints.  Hence the to_usb_device() call above might 
> not always do what you want.

Ugh. Is there any clean way to distinguish from the device structure? If 
not, the easiest would seem to be to just add another bus type 
structure, even if the members are identical.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
