From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI error messages
Date: Fri, 04 Jun 2010 09:03:24 +0800
Message-ID: <1275613404.19052.1028.camel@rzhang1-desktop>
References: <Pine.LNX.4.44L0.1006021105590.1992-100000@iolanthe.rowland.org>
	 <1275527406.9119.8724.camel@rzhang1-desktop>
	 <20100603141643.GA768@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3796 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757044Ab0FDBC5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Jun 2010 21:02:57 -0400
In-Reply-To: <20100603141643.GA768@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2010-06-03 at 22:16 +0800, Matthew Garrett wrote:
> On Thu, Jun 03, 2010 at 09:10:06AM +0800, Zhang Rui wrote:
> 
> > This is a BIOS bug to me. The code runs in this way:
> > 
> > if (not Win7)
> >   good BIOS code
> > else
> >   buggy BIOS code
> > 
> > This is a regression because ACPI declares it's win7 compatible in
> > 2.6.31. I'm afraid we can do nothing in Linux kernel to fix/workaround
> > it. IMO, we should ping Asus to fix it in their new BIOS release.
> 
> So if you install Windows 7 on these machines, backlight control doesn't 
> work?
> 
I've heard that win7 prefers the ACPI wmi driver instead of ACPI video
driver for backlight control. But not sure if win7 prefers the platform
driver as well.

Alan,
can you help me verify if the backlight control works well when you boot
w/ acpi_backlight=vendor and w/o acpi_osi="!Windwos 2009"?

thanks,
rui



