From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 3/3] usb : Add sysfs files to control usb port's power
Date: Wed, 13 Jun 2012 17:15:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206131711060.3821-100000@iolanthe.rowland.org>
References: <20120613193323.GB6312@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120613193323.GB6312-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 13 Jun 2012, Greg KH wrote:

> > +	struct device_attribute	port_control_attr;
> > +	struct device_attribute	port_state_attr;
> > +	enum port_power_policy port_power_policy;
> 
> Why do you need an attribute per port here?  Shouldn't they just be
> static variables?  Why duplicate them for every port?

If they were static, there would be no way for the store and show
methods to know which port they were called for.  That's because the
ports aren't separate kobjects; all these port attributes are bound to
the hub device.

> > +static ssize_t show_port_power_state(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct usb_device *udev = to_usb_device(dev->parent);
> > +	struct usb_hub_port *hub_port = container_of(attr,
> > +		struct usb_hub_port, port_state_attr);

You can see it here.  The only way to get the port is by seeing where
the attribute is stored.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
