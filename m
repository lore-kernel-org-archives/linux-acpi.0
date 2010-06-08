From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ACPI error messages
Date: Tue, 8 Jun 2010 14:42:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006081440210.1372-100000@iolanthe.rowland.org>
References: <1275873140.19052.9516.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41852 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751424Ab0FHSmI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2010 14:42:08 -0400
In-Reply-To: <1275873140.19052.9516.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 7 Jun 2010, Zhang Rui wrote:

> On Fri, 2010-06-04 at 22:52 +0800, Alan Stern wrote:
> > On Fri, 4 Jun 2010, Zhang Rui wrote:
> > 
> > > I've heard that win7 prefers the ACPI wmi driver instead of ACPI video
> > > driver for backlight control. But not sure if win7 prefers the platform
> > > driver as well.
> > > 
> > > Alan,
> > > can you help me verify if the backlight control works well when you boot
> > > w/ acpi_backlight=vendor and w/o acpi_osi="!Windwos 2009"?
> > 
> > I don't have the laptop with me here, so this will have to wait a 
> > little.
> > 
> okay.
> 
> > Also, I've never used the backlight control and I don't know how it 
> > works.  What should I do in order to test it?
> > 
> You can change the backlight by poking /sys/class/backlight/*/brightness

With acpi_backlight=vendor instead of acpi_osi="!Windows 2009", the 
backlight control still works.  And those error messages do not appear 
in the system log.

Which option should I use?

Alan Stern

