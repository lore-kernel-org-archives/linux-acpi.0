From: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: PCI quirks update for 2.6.16
Date: Fri, 8 Dec 2006 16:42:08 +0100
Message-ID: <20061208154208.GB3356@stusta.de>
References: <20061207132430.GF8963@stusta.de> <20061207205420.15622d52.khali@linux-fr.org> <200612072145.56861.tomek@koprowski.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3230 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1425570AbWLHPmA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2006 10:42:00 -0500
Content-Disposition: inline
In-Reply-To: <200612072145.56861.tomek@koprowski.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomek Koprowski <tomek@koprowski.org>
Cc: Jean Delvare <khali@linux-fr.org>, Daniel Ritz <daniel.ritz@gmx.ch>, Daniel Drake <dsd@gentoo.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>, "John W. Linville" <linville@tuxdriver.com>, Bauke Jan Douma <bjdouma@xs4all.nl>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com, linux-acpi@vger.kernel.org

On Thu, Dec 07, 2006 at 09:45:56PM +0100, Tomek Koprowski wrote:
> On Thursday 07 of December 2006 20:54, Jean Delvare wrote:
> 
> > > Tomasz Koprowski (1):
> > >       PCI: SMBus unhide on HP Compaq nx6110
> >
> > Bug #6944 might be related to this one, so I'd not include it in
> > 2.6.16-stable.
> 
> Actually, the #6944 requires more investigation. I've noticed the 
> kacpid going to 100% cpu without the unhide patch applied as well. It 
> happens sometimes after dehibernation, putting the laptop to sleep
> and waking it up again resolves the issue. I can't figure out why.
> 
> To be on the safe side I'd suggest dumping the patch, but I really 
> don't think it should fix anything.

Thanks for this information, I've dropped it.

And this problem really be debugged and fixed in Linus' tree...

> Tomek

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

