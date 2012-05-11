From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 15:14:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205111504130.1865-100000@iolanthe.rowland.org>
References: <20120511180352.GC18754@xanatos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47572 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759873Ab2EKTOi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 15:14:38 -0400
In-Reply-To: <20120511180352.GC18754@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Dan Williams <dcbw@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 11 May 2012, Sarah Sharp wrote:

> > That reminds me...  I think this should not be so closely linked with
> > ACPI.  There's a perfectly good USB Clear-Feature request for turning
> > off port power; that's what we should use.  If hooks are required for
> > interfacing with platform-specific code (such as ACPI), they can be
> > added at the appropriate places.
> 
> So would you rather userspace issue a clear port power feature request
> to the roothub through libusb than have a sysfs file per port in
> /sys/bus/usb/devices/../power/ ?  Or are you just saying that the sysfs
> interface should issue the request to the hub (which may be the
> roothub), and the xHCI driver can just implement the ACPI calls in its
> roothub control method?

The latter.  Except that the ACPI calls may need to occur in more
places than just xhci-hcd (ehci-hcd, for example).  And what about
ports on the USB-2 "rate-matching" hubs that Intel now builds into its
chipsets?

For that matter, is it really necessary to involve ACPI in port power
changes at all?  Why can't xhci-hcd simply set the PP bit in the PORTSC
register, and rely on the PPC bit in the HCCPARAMS register to indicate
whether or not port power control is supported?  In other words, what 
advantage does ACPI have over USB native power control?

Alan Stern

