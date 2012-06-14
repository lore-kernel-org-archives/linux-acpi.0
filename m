From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] usb : Add sysfs files to control usb port's power
Date: Thu, 14 Jun 2012 07:35:59 -0700
Message-ID: <20120614143559.GA13449@kroah.com>
References: <20120613214641.GB9051@kroah.com>
 <Pine.LNX.4.44L0.1206140947410.1701-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50786 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab2FNOgG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2012 10:36:06 -0400
Received: by pbbrp8 with SMTP id rp8so3891214pbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jun 2012 07:36:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1206140947410.1701-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, sarah.a.sharp@linux.intel.com, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jun 14, 2012 at 09:57:37AM -0400, Alan Stern wrote:
> On Wed, 13 Jun 2012, Greg KH wrote:
> 
> > On Wed, Jun 13, 2012 at 05:15:08PM -0400, Alan Stern wrote:
> > > On Wed, 13 Jun 2012, Greg KH wrote:
> > > 
> > > > > +	struct device_attribute	port_control_attr;
> > > > > +	struct device_attribute	port_state_attr;
> > > > > +	enum port_power_policy port_power_policy;
> > > > 
> > > > Why do you need an attribute per port here?  Shouldn't they just be
> > > > static variables?  Why duplicate them for every port?
> > > 
> > > If they were static, there would be no way for the store and show
> > > methods to know which port they were called for.  That's because the
> > > ports aren't separate kobjects; all these port attributes are bound to
> > > the hub device.
> > 
> > Ports should be a struct device if we are going to hang attributes off
> > of them, otherwise userspace can get very confused.
> 
> Is that really appropriate?  Ports don't have their own driver, they
> can't be probed or removed, they can't be suspended or resumed, you
> can't do I/O to them, they don't have resources, they don't have 
> children...

Ah, but they can have "children" if we want to move the devices attached
to them there.  But that's something to consider in the future, not for
now.

As for the other things, if we applied those rules to all other parts of
the device tree, well, it would be a lot smaller :)

You are showing something "logical" in the tree, that exists, and has
attributes (power, etc.).  Because of that, userspace needs to be
notified of them, as it should be doing things with them.  So, make them
a device so that userspace can actually see them.  Otherwise things
break down really quickly, and you can not use the "standard" userspace
tools to control them (i.e. libusb and friends.)

thanks,

greg k-h
