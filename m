From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Wed, 16 May 2012 11:12:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205161111261.1852-100000@iolanthe.rowland.org>
References: <4FB3BF95.50600@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54005 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754134Ab2EPPMR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 May 2012 11:12:17 -0400
In-Reply-To: <4FB3BF95.50600@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Dan Williams <dcbw@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, 16 May 2012, Lan Tianyu wrote:

> On 2012/5/16 22:39, Greg KH wrote:
> > On Wed, May 16, 2012 at 10:36:02AM -0400, Alan Stern wrote:
> >> On Wed, 16 May 2012, Lan Tianyu wrote:
> >>
> >>> Ok. Let me reconfirm the meaning of these opinions.
> >>>
> >>> "auto"
> >>> 	if port without device, turn off power directly.
> >>> 	if port with device, turn off power when the device is suspended.
> >>>
> >>> "on"	the port's power must be on.
> >>>
> >>> "off"	the port's power must be off.
> >>>
> >>> Right?
> >> Maybe the "auto" setting should be renamed "active".  Then "auto" can
> >> be used for:
> >>
> >> 	If the port has a device, turn the power on.
> >> 	If the port doesn't have a device, turn the power off.
> > And plugging a new device into a port that was powered off is going to
> > cause the power to come back on, right?
> When the port was powered off, the connect-change event will not be 
> detected and
> we don't know a device was plugged in. :(

Ah, yes.  Okay, then I guess we _don't_ want a setting like the one I 
suggested.  The original proposal was good.

Alan Stern

