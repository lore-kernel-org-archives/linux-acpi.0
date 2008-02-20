From: Thomas Renninger <trenn@suse.de>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 19:21:57 +0100
Message-ID: <1203531717.6019.324.camel@queen.suse.de>
References: <1203471860.3358.177.camel@linux-2bdv.site>
	 <20080220173248.GA22709@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:52431 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679AbYBTSV6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 13:21:58 -0500
In-Reply-To: <20080220173248.GA22709@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Wed, 2008-02-20 at 17:32 +0000, Matthew Garrett wrote:
> Let's look at this differently. Most hardware is produced by vendors who 
> don't care about Linux. We need to make that hardware work anyway.
Not really. If you buy machine noname XY, you have to face the fact that
HW may not work on Linux correctly. You can try fix to it, but you
cannot write a driver for WLAN card from vendor noname and card reader
from "never heard of that company". If you buy the wrong graphics card
you may end up without 3D and whatever else cool features the card
supports.

So at least since HP, Dell, Lenovo (also Acer?) are selling pre-loaded
Linux laptops, you should be smart enough to take such a thing where the
BIOS is adjusted to run on Linux or you pretty much have to reckon with
trouble.

So being Windows compatible is nice, but sticking to specifications is
more important (we are far away from and never will be Windows
compatibility in WMI implementation right?). Imagine a vendor using
if(linux) provides as a whole SSDT with all the fan and thermal
implementations perfectly fit to the ACPI specification and therefore
stick to the Linux kernel implementations?

Next point is that if vendors pre-load their model with a specific
distribution, they need such a knob.
Please do not think about what happens when I upgrade to the latest
kernel (which should still be no problem when they know how to use
this). Think about how these vendors should fix a complex Linux bug via
a BIOS hot-fix update ...

Think about a functional change they have to implement in their BIOS for
a Windows Vista SPX change. While the machine may still run fine with
the latest mainline kernel, the kernel they have to provide support for
will break. I see the problem with this scenario, but try to think from
Dell's/HP's/... point of view. They want to have such a thing.

>  The 
> only way we can achieve that is to be bug-compatible with Windows. 
> Therefore, any way in which Linux behaviour varies from Windows 
> behaviour is a bug. The only reason to export any indication that the 
> kernel is Linux is because our behaviour is not identical to Windows. 
Linux behaviour is not identical to Windows, never will be and after
vendors start pre-loading also do not need to be...
> But, given that that's a bug, the solution should be to fix Linux and 
> not to encourage vendors to put workarounds in their firmware.
I see it the other way round. Encourage vendors to fix their BIOSes,
instead of putting "Windows compatibility" workarounds into the kernel.

   Thomas

