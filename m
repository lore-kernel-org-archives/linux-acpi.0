From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Tue, 18 Mar 2008 11:14:50 +0800
Message-ID: <1205810090.11199.1.camel@sli10-desk.sh.intel.com>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com>
	 <1205725210.27560.9.camel@segulix.localdomain>
	 <1205789993.6918.30.camel@segulix.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21228 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbYCRDNy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Mar 2008 23:13:54 -0400
In-Reply-To: <1205789993.6918.30.camel@segulix.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <gregkh@suse.de>


On Mon, 2008-03-17 at 21:39 +0000, Sergio Monteiro Basto wrote:
> On Mon, 2008-03-17 at 03:40 +0000, Sergio Monteiro Basto wrote:
> > On Fri, 2008-03-14 at 11:49 +0800, Shaohua Li wrote:
> > > asus_hides_smbus_lpc_ich6() is called with interrupt disabled in
> > > resume
> > > time, but ioremap_nocache() and iounmap() can't be called with
> > > interrupt
> > > disabled. Below is my debug fix. If you have better fix, please
> > > speak. 
> > 
> > yap , I have a better fix for my laptop 
> > I have a Compaq nx , and this quirk is applied ,
> > 
> > I simply remove the quirk like I had write 
> > http://lkml.org/lkml/2007/3/9/516
> > 
> > Especially if we don't an ASUS, which may need the quirk.
> > 
> > I have been working almost an year without the quirk on my laptop and
> > things seems that work better 
> 
> Btw I am running  2.6.24.3-12 fedora kernel , I recompile from the
> src.rpm and apply with 2 patches one: 
> http://bugzilla.kernel.org/show_bug.cgi?id=9642
> this one seems that I don't need anymore on 2.6.25-rc 
> and remove this quirk.
> And enable ACPI_DEBUG.
> 
> And I am very happy with it , hibernation, suspend works very well and
> don't loose ACPI events after resume, backlight also works always fine,
> ACPI events always on, resume from ram don't have to go to console to
> have screen .
> I just use git Intel drive. 
> 
> Which make me think, will not updates kernels for a very long time :)  
> Regards, 
Sure, you can remove the quirk without any problem if you don't want to
use the smbus device.

Thanks,
Shaohua

