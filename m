From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI error messages
Date: Mon, 07 Jun 2010 09:12:20 +0800
Message-ID: <1275873140.19052.9516.camel@rzhang1-desktop>
References: <Pine.LNX.4.44L0.1006041050300.1794-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35437 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab0FGBLz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jun 2010 21:11:55 -0400
In-Reply-To: <Pine.LNX.4.44L0.1006041050300.1794-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2010-06-04 at 22:52 +0800, Alan Stern wrote:
> On Fri, 4 Jun 2010, Zhang Rui wrote:
> 
> > I've heard that win7 prefers the ACPI wmi driver instead of ACPI video
> > driver for backlight control. But not sure if win7 prefers the platform
> > driver as well.
> > 
> > Alan,
> > can you help me verify if the backlight control works well when you boot
> > w/ acpi_backlight=vendor and w/o acpi_osi="!Windwos 2009"?
> 
> I don't have the laptop with me here, so this will have to wait a 
> little.
> 
okay.

> Also, I've never used the backlight control and I don't know how it 
> works.  What should I do in order to test it?
> 
You can change the backlight by poking /sys/class/backlight/*/brightness

thanks,
rui

