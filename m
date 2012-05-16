From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Wed, 16 May 2012 07:39:58 -0700
Message-ID: <20120516143958.GA612@kroah.com>
References: <4FB348AB.5050308@intel.com>
 <Pine.LNX.4.44L0.1205161033340.1852-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46856 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab2EPOkC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 May 2012 10:40:02 -0400
Received: by pbbrp8 with SMTP id rp8so1188604pbb.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 May 2012 07:40:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1205161033340.1852-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Dan Williams <dcbw@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, May 16, 2012 at 10:36:02AM -0400, Alan Stern wrote:
> On Wed, 16 May 2012, Lan Tianyu wrote:
> 
> > Ok. Let me reconfirm the meaning of these opinions.
> > 
> > "auto"
> > 	if port without device, turn off power directly.
> > 	if port with device, turn off power when the device is suspended.
> > 
> > "on"	the port's power must be on.
> > 
> > "off"	the port's power must be off.
> > 
> > Right?
> 
> Maybe the "auto" setting should be renamed "active".  Then "auto" can 
> be used for:
> 
> 	If the port has a device, turn the power on.
> 	If the port doesn't have a device, turn the power off.

And plugging a new device into a port that was powered off is going to
cause the power to come back on, right?

greg k-h
