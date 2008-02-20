From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 18:46:52 +0000
Message-ID: <20080220184651.GA23679@srcf.ucam.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <1203531717.6019.324.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:43500 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYBTSrF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 13:47:05 -0500
Content-Disposition: inline
In-Reply-To: <1203531717.6019.324.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Wed, Feb 20, 2008 at 07:21:57PM +0100, Thomas Renninger wrote:
> On Wed, 2008-02-20 at 17:32 +0000, Matthew Garrett wrote:
> > Let's look at this differently. Most hardware is produced by vendors who 
> > don't care about Linux. We need to make that hardware work anyway.
> Not really. If you buy machine noname XY, you have to face the fact that
> HW may not work on Linux correctly. 

No. You have failed. Do not pass go.

> You can try fix to it, but you
> cannot write a driver for WLAN card from vendor noname and card reader
> from "never heard of that company". If you buy the wrong graphics card
> you may end up without 3D and whatever else cool features the card
> supports.

That's fine. Some hardware support is difficult. Some hardware support 
is not difficult. The only possible situation in which exporting some 
sort of OSI value for Linux is helpful is when the firmware authors know 
what the difference between the Linux and Windows behaviours are. If we 
know that, we can fix it. Fixing it not only fixes the machine in 
question, it probably fixes a large number of other machines. This is a 
preferable solution.

> So at least since HP, Dell, Lenovo (also Acer?) are selling pre-loaded
> Linux laptops, you should be smart enough to take such a thing where the
> BIOS is adjusted to run on Linux or you pretty much have to reckon with
> trouble.

Argh. No. If the BIOS is adjusted to run on Linux, it indicates that 
we've failed. Completely. Utterly.

> So being Windows compatible is nice, but sticking to specifications is
> more important (we are far away from and never will be Windows
> compatibility in WMI implementation right?).

No! What's the point in sticking to specifications when there's only one 
implementation? Windows is the de-facto specification for ACPI, and we 
should follow it.

> Next point is that if vendors pre-load their model with a specific
> distribution, they need such a knob.

Fixing Linux is easier than fixing firmware in almost every single case. 
If vendors are installing Linux without working with the distribution 
vendor, then that's unfortunate and they're likely to have problems. I'm 
not going to prioritise them above the huge number of users buying 
hardware from vendors who aren't as foolish.

> Please do not think about what happens when I upgrade to the latest
> kernel (which should still be no problem when they know how to use
> this). Think about how these vendors should fix a complex Linux bug via
> a BIOS hot-fix update ...

They shouldn't. They should push out a software update.

> >  The 
> > only way we can achieve that is to be bug-compatible with Windows. 
> > Therefore, any way in which Linux behaviour varies from Windows 
> > behaviour is a bug. The only reason to export any indication that the 
> > kernel is Linux is because our behaviour is not identical to Windows. 
> Linux behaviour is not identical to Windows, never will be and after
> vendors start pre-loading also do not need to be...

Wrong.

> > But, given that that's a bug, the solution should be to fix Linux and 
> > not to encourage vendors to put workarounds in their firmware.
> I see it the other way round. Encourage vendors to fix their BIOSes,
> instead of putting "Windows compatibility" workarounds into the kernel.

By which you mean "Cater for a small market, rather than the large one"? 
No. That would be ridiculous. Our compatibility is sufficiently good 
that I'm not going to recommend users buy one of the tiny number of 
laptops available with a "supported" Linux install over buying a laptop 
that actually fits their needs.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
