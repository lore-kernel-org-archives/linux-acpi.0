From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Sat, 28 Jul 2007 01:07:42 +0200
Message-ID: <20070727230741.GD15129@stusta.de>
References: <200707251238.50218.lenb@kernel.org> <46A98FF9.8060801@l4x.org> <1185553512.3849.46.camel@noname>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1185553512.3849.46.camel@noname>
Sender: linux-ia64-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jan Dittmer <jdi@l4x.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org. Sam Ravnborg" <sam@ravnborg.org>, tony.luck@intel.com, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 27, 2007 at 06:25:12PM +0200, Thomas Renninger wrote:
> On Fri, 2007-07-27 at 08:26 +0200, Jan Dittmer wrote:
> > Len Brown wrote:
> > > Hi Linus,
> > > 
> > > please pull from: 
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> > 
> > This seems to break ia64 defconfig:
> > 
> >    Building modules, stage 2.
> >    MODPOST 157 modules
> > FATAL: drivers/acpi/button: sizeof(struct acpi_device_id)=20 is not a modulo of the size of section __mod_acpi_device_table=144.
> > Fix definition of struct acpi_device_id in mod_devicetable.h
> > make[2]: *** [__modpost] Error 1
> > make[1]: *** [modules] Error 2
> > make: *** [_all] Error 2
> > 
> > gcc 3.3.6, binutils 2.15.94
> > 
> > http://l4x.org/k/?d=32569
> 
> This is strange, I just compiled on a IA64 with button as module
> (defconfig), but with gcc version 4.1.2, all is fine.
> Anyone an idea how to run into that?

I don't have an idea how this happens, but it sounds like an alignment 
issue:

sizeof(struct acpi_device_id)=20
"struct acpi_device_id button_device_ids[]" contains 6 elements
144 = 6 * 24 = 6 * (3 * 8)

So it seems on ia64 with gcc 3.3.6 there's some 8 byte alignment of the 
array members?

Sam and the ia64 maintainers Cc'ed - they might know better what's going 
on here.

> I won't be able to detailed debug this before Monday, but be sure I will
> do so then.
> 
> Thanks,
> 
>     Thomas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

