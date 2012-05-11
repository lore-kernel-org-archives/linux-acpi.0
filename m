From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 11:03:52 -0700
Message-ID: <20120511180352.GC18754@xanatos>
References: <20120510211156.GA18754@xanatos>
 <Pine.LNX.4.44L0.1205111005370.1865-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45301 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096Ab2EKSD4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 14:03:56 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1205111005370.1865-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dan Williams <dcbw@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, May 11, 2012 at 10:08:33AM -0400, Alan Stern wrote:
> On Thu, 10 May 2012, Sarah Sharp wrote:
> 
> > Also, setting the port power off via ACPI may not actually cut power,
> > because port power might be ganged.  Once we signal via ACPI that all
> > the ports that are ganged together can be powered off, they will.  So
> > there's no guarantees that you can power off the buggy modem unless you
> > power off the other ganged ports as well.
> 
> That reminds me...  I think this should not be so closely linked with
> ACPI.  There's a perfectly good USB Clear-Feature request for turning
> off port power; that's what we should use.  If hooks are required for
> interfacing with platform-specific code (such as ACPI), they can be
> added at the appropriate places.

So would you rather userspace issue a clear port power feature request
to the roothub through libusb than have a sysfs file per port in
/sys/bus/usb/devices/../power/ ?  Or are you just saying that the sysfs
interface should issue the request to the hub (which may be the
roothub), and the xHCI driver can just implement the ACPI calls in its
roothub control method?

Sarah Sharp
