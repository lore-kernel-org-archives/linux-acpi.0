From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ACPI_VIDEO and BACKLIGHT_CLASS_DEVICE
Date: Fri, 12 Nov 2010 16:26:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011121624440.21040-100000@netrider.rowland.org>
References: <20101112034614.GB7407@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53607 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756960Ab0KLV0Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Nov 2010 16:26:16 -0500
In-Reply-To: <20101112034614.GB7407@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 12 Nov 2010, Matthew Garrett wrote:

> On Thu, Nov 11, 2010 at 10:00:03PM -0500, Alan Stern wrote:
> 
> > But my computer doesn't have an LCD display.  It's a desktop, not a
> > laptop.  So why do I need BACKLIGHT_CLASS_DEVICE to be enabled?
> 
> Well, in the near future ddc-ci will be hooked up and you'll have 
> backlight control over VGA if your monitor supports it, so even if we 
> fix this up now you'll just end up getting it back in the near future 
> because we can't tell that at build-time...
> 
> > Are you saying I don't need ACPI_VIDEO if the machine doesn't have an
> > integrated LCD display?  That doesn't agree with the Kconfig help
> > message.
> 
> But to that, yes. The only reason to use ACPI_VIDEO is to get EDID from 
> firmware (which isn't relevant on desktops) or to control backlights. 
> Every other theoretical feature it has is useless in the real world.

Thanks for the information.  Why does the help text for ACPI_VIDEO 
mention defining the POST device or setting up a video output if the 
driver doesn't do these things?

Alan Stern

