From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ACPI_VIDEO and BACKLIGHT_CLASS_DEVICE
Date: Thu, 11 Nov 2010 22:00:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011112156570.2098-100000@netrider.rowland.org>
References: <1289527627.8148.1462.camel@rui>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:39948 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754631Ab0KLDAG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Nov 2010 22:00:06 -0500
In-Reply-To: <1289527627.8148.1462.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 12 Nov 2010, Zhang Rui wrote:

> On Thu, 2010-11-11 at 06:02 +0800, Alan Stern wrote:
> > Rui:
> > 
> > Why does CONFIG_ACPI_VIDEO depend on BACKLIGHT_CLASS_DEVICE?  Doesn't
> > ACPI_VIDEO apply to any sort of video adapter, including plain old VGA
> > adapters attached to a non-LCD device?
> > 
> There is an ACPI device node (an ACPI video bus device) for the VGA
> controller and another ACPI device node (an ACPI video output device)
> for the LCD display.
> And ACPI_VIDEO knows how to switch the backlight of this integrated
> LCD. :)

But my computer doesn't have an LCD display.  It's a desktop, not a
laptop.  So why do I need BACKLIGHT_CLASS_DEVICE to be enabled?

Are you saying I don't need ACPI_VIDEO if the machine doesn't have an
integrated LCD display?  That doesn't agree with the Kconfig help
message.

Alan Stern

