From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 7/8] usb: add usb_device_allow_power_off() and
 usb_device_prevent_power_off() function.
Date: Tue, 22 Jan 2013 10:09:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1301221007150.1510-100000@iolanthe.rowland.org>
References: <50FE9B30.8050004@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34807 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753799Ab3AVPJT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2013 10:09:19 -0500
In-Reply-To: <50FE9B30.8050004@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, lenb@kernel.org, sarah.a.sharp@linux.intel.com, rjw@sisk.pl, oneukum@suse.de, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 22 Jan 2013, Lan Tianyu wrote:

> >> +/**
> >> + * usb_device_control_power_off - Allow or prohibit power off device.
> >> + * @udev: target usb device
> >> + * @allow: choice of allow or prohibit
> >> + *
> >> + * Call pm_runtime_get/put_sync(portdev) to allow or prohibit target
> >> + * usb device to be powered off in the kernel. The operations of setting
> >> + * true and false should be couple. The default status is allowed.
> >> + */
> >> +int usb_device_control_power_off(struct usb_device *udev, bool allow)
> >
> > Ick, again with the boolean variables.  Please don't do this, just make
> > two different functions:
> > 	usb_device_allow_power_off()
> > 	usb_device_forbid_power_off()
> > that makes it much easier to understand when you see the function being
> > called, right?
> Ok. I will do it.

Greg and Tianyu:

You both missed the fact that Tianyu already did this.  It is in the 
submitted patch.  The two functions Greg asked for are defined as 
inline routines.

Alan Stern

