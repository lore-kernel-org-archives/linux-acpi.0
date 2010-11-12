From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI_VIDEO and BACKLIGHT_CLASS_DEVICE
Date: Fri, 12 Nov 2010 03:46:15 +0000
Message-ID: <20101112034614.GB7407@srcf.ucam.org>
References: <1289527627.8148.1462.camel@rui> <Pine.LNX.4.44L0.1011112156570.2098-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53101 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab0KLDqW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Nov 2010 22:46:22 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1011112156570.2098-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 11, 2010 at 10:00:03PM -0500, Alan Stern wrote:

> But my computer doesn't have an LCD display.  It's a desktop, not a
> laptop.  So why do I need BACKLIGHT_CLASS_DEVICE to be enabled?

Well, in the near future ddc-ci will be hooked up and you'll have 
backlight control over VGA if your monitor supports it, so even if we 
fix this up now you'll just end up getting it back in the near future 
because we can't tell that at build-time...

> Are you saying I don't need ACPI_VIDEO if the machine doesn't have an
> integrated LCD display?  That doesn't agree with the Kconfig help
> message.

But to that, yes. The only reason to use ACPI_VIDEO is to get EDID from 
firmware (which isn't relevant on desktops) or to control backlights. 
Every other theoretical feature it has is useless in the real world.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
