From: David Weinehall <tao@acc.umu.se>
Subject: Re: acpiphp makes noise on every lid close/open
Date: Tue, 7 Nov 2006 21:44:09 +0100
Message-ID: <20061107204409.GA37488@vasa.acc.umu.se>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.acc.umu.se ([130.239.18.156]:52462 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1753196AbWKGUoO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Nov 2006 15:44:14 -0500
Content-Disposition: inline
In-Reply-To: <20061106092117.GB2175@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Mon, Nov 06, 2006 at 10:21:17AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
> > > > info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
> > > > (-mm1 behaves the same).
> > > 
> > > Looks like acpi is sending a BUS_CHECK notification to acpiphp on the 
> > > PCI Root Bridge whenever the lid opens up.
> > > 
> > > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > > it has no hotpluggable slots.
> > 
> > How about the docking station?
> 
> "Dock" for x60 only contains cdrom slot and aditional slots, no PCI or
> PCMCIA slots.

Well, when I press the undock button on the dock without the acpiphp
module loaded, I never get the green light that confirms that removing
the laptop is safe.  If acpiphp is loaded, things work just fine.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
