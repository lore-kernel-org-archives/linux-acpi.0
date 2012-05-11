From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 16:26:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205111622420.1865-100000@iolanthe.rowland.org>
References: <20120511201507.GG18754@xanatos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47627 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760840Ab2EKU0G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 16:26:06 -0400
In-Reply-To: <20120511201507.GG18754@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Fri, 11 May 2012, Sarah Sharp wrote:

> On Fri, May 11, 2012 at 07:54:04PM +0000, Lan, Tianyu wrote:
> > On 2012/5/12 1:44, Alan Stern wrote:
> > > This doesn't matter.  Disconnections will be handled by 
> > > usb_reset_and_verify_device(), when it is called by 
> > > finish_port_resume().
> > This will cause the device to be re-enumerated. Just like
> > unplugged and plugged a device. I think this is not what
> > we want.  Disconnect and create the same device. device
> > num is also change.
> 
> Tianyu, do you have CONFIG_USB_PERSIST turned on?
> 
> Alan, do you know if that will that only help in this case after the
> host controller PCI device is in D3hot?

See check_port_resume_type() in hub.c.  It doesn't care what the reason
is for loss connectivity during suspend or what state the host
controller was in.

Alan Stern

