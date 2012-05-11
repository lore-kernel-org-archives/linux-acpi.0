From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 13:21:13 -0700
Message-ID: <20120511202113.GH18754@xanatos>
References: <20120511180352.GC18754@xanatos>
 <Pine.LNX.4.44L0.1205111504130.1865-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14163 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932805Ab2EKUVQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 16:21:16 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1205111504130.1865-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dan Williams <dcbw@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, May 11, 2012 at 03:14:37PM -0400, Alan Stern wrote:
> On Fri, 11 May 2012, Sarah Sharp wrote:
> 
> > > That reminds me...  I think this should not be so closely linked with
> > > ACPI.  There's a perfectly good USB Clear-Feature request for turning
> > > off port power; that's what we should use.  If hooks are required for
> > > interfacing with platform-specific code (such as ACPI), they can be
> > > added at the appropriate places.
> > 
> > So would you rather userspace issue a clear port power feature request
> > to the roothub through libusb than have a sysfs file per port in
> > /sys/bus/usb/devices/../power/ ?  Or are you just saying that the sysfs
> > interface should issue the request to the hub (which may be the
> > roothub), and the xHCI driver can just implement the ACPI calls in its
> > roothub control method?
> 
> The latter.  Except that the ACPI calls may need to occur in more
> places than just xhci-hcd (ehci-hcd, for example).

Only the xHCI host controller will have the port power off mechanism.

> And what about ports on the USB-2 "rate-matching" hubs that Intel now
> builds into its chipsets?

For the Intel platform that has the port power off mechanism, there are
EHCI host controllers, but the port switch over changes *all* the USB
ports under xHCI.

> For that matter, is it really necessary to involve ACPI in port power
> changes at all?  Why can't xhci-hcd simply set the PP bit in the PORTSC
> register, and rely on the PPC bit in the HCCPARAMS register to indicate
> whether or not port power control is supported?  In other words, what 
> advantage does ACPI have over USB native power control?

The port power off mechanism is controlled by some other chunk of
hardware outside the xHCI host controller.  I asked the architects why
they didn't just use the port power control bits in the port status
registers, but they had already made their design choices by then.  So
we're stuck with the ACPI method of powering off the ports.

Sarah Sharp
