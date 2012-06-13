From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] usb : Add sysfs files to control usb port's power
Date: Wed, 13 Jun 2012 14:46:41 -0700
Message-ID: <20120613214641.GB9051@kroah.com>
References: <20120613193323.GB6312@kroah.com>
 <Pine.LNX.4.44L0.1206131711060.3821-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42705 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2FMVqp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2012 17:46:45 -0400
Received: by pbbrp8 with SMTP id rp8so2857144pbb.19
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jun 2012 14:46:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1206131711060.3821-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, sarah.a.sharp@linux.intel.com, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Jun 13, 2012 at 05:15:08PM -0400, Alan Stern wrote:
> On Wed, 13 Jun 2012, Greg KH wrote:
> 
> > > +	struct device_attribute	port_control_attr;
> > > +	struct device_attribute	port_state_attr;
> > > +	enum port_power_policy port_power_policy;
> > 
> > Why do you need an attribute per port here?  Shouldn't they just be
> > static variables?  Why duplicate them for every port?
> 
> If they were static, there would be no way for the store and show
> methods to know which port they were called for.  That's because the
> ports aren't separate kobjects; all these port attributes are bound to
> the hub device.

Ports should be a struct device if we are going to hang attributes off
of them, otherwise userspace can get very confused.

> > > +static ssize_t show_port_power_state(struct device *dev,
> > > +	struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct usb_device *udev = to_usb_device(dev->parent);
> > > +	struct usb_hub_port *hub_port = container_of(attr,
> > > +		struct usb_hub_port, port_state_attr);
> 
> You can see it here.  The only way to get the port is by seeing where
> the attribute is stored.

Ick, that's nasty.

How about making a port a real device?  That should solve this problem,
right?  And I thought I recommended doing that a month or so ago, what
happened with that proposal?

thanks,

greg k-h
