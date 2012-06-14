From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] usb : Add sysfs files to control usb port's power
Date: Thu, 14 Jun 2012 09:57:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206140947410.1701-100000@iolanthe.rowland.org>
References: <20120613214641.GB9051@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33763 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755985Ab2FNN5j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2012 09:57:39 -0400
In-Reply-To: <20120613214641.GB9051@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, sarah.a.sharp@linux.intel.com, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 13 Jun 2012, Greg KH wrote:

> On Wed, Jun 13, 2012 at 05:15:08PM -0400, Alan Stern wrote:
> > On Wed, 13 Jun 2012, Greg KH wrote:
> > 
> > > > +	struct device_attribute	port_control_attr;
> > > > +	struct device_attribute	port_state_attr;
> > > > +	enum port_power_policy port_power_policy;
> > > 
> > > Why do you need an attribute per port here?  Shouldn't they just be
> > > static variables?  Why duplicate them for every port?
> > 
> > If they were static, there would be no way for the store and show
> > methods to know which port they were called for.  That's because the
> > ports aren't separate kobjects; all these port attributes are bound to
> > the hub device.
> 
> Ports should be a struct device if we are going to hang attributes off
> of them, otherwise userspace can get very confused.

Is that really appropriate?  Ports don't have their own driver, they
can't be probed or removed, they can't be suspended or resumed, you
can't do I/O to them, they don't have resources, they don't have 
children...

In short, they don't qualify as separate devices.  All they do have is
a few attributes (power, ownership, and connectivity).

> How about making a port a real device?  That should solve this problem,
> right?  And I thought I recommended doing that a month or so ago, what
> happened with that proposal?

I argued against it, for the reasons listed above.

Alan Stern

