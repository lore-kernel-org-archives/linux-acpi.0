From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
Date: Tue, 5 Apr 2005 15:24:18 +0200
Message-ID: <20050405132417.GD6885@stusta.de>
References: <fa.gcqu6i7.1o6qrhn@ifi.uio.no> <42524D83.1080104@reub.net> <20050405121444.GB6885@stusta.de> <6.2.3.0.2.20050406002812.04393a30@tornado.reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261725AbVDENYh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6.2.3.0.2.20050406002812.04393a30@tornado.reub.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Reuben Farrelly <reuben-lkml@reub.net>, len.brown@intel.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 06, 2005 at 12:32:52AM +1200, Reuben Farrelly wrote:
> Hi again
> 
> At 12:14 a.m. 6/04/2005, Adrian Bunk wrote:
> >On Tue, Apr 05, 2005 at 08:34:11PM +1200, Reuben Farrelly wrote:
> >
> >> Hi,
> >
> >Hi Reuben,
> >
> >>...
> >> Hrm. Something changed between the last -mm release which compiled
> >> through, and this one..
> >>...
> >>   LD      .tmp_vmlinux1
> >> arch/i386/kernel/built-in.o(.init.text+0x1823): In function `setup_arch':
> >> : undefined reference to `acpi_boot_table_init'
> >> arch/i386/kernel/built-in.o(.init.text+0x1828): In function `setup_arch':
> >> : undefined reference to `acpi_boot_init'
> >> make: *** [.tmp_vmlinux1] Error 1
> >> [root@tornado linux-2.6]#
> >>
> >> Backing out bk-acpi.patch works around it..
> >
> >Please send your .config .
> 
> Have just figured out that it seems to be caused by having ACPI 
> disabled in .config, once I re-enabled ACPI the build problem went away.
> 
> Config attached anyway, I imagine the problem is quite reproduceable..

Ah, this was the working .config .
fter setting CONFIG_ACPI=n I started seeing different but most likely 
related problems.


@Len:
ACPI=y and ACPI_BOOT=n seems to be a legal configuration (with 
X86_HT=y), but it breaks into pieces if you try the compilation.

The first error I get is:

<--  snip  -->

  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:96: error: parse error before "acpi_sci_flags"
arch/i386/kernel/setup.c:96: warning: type defaults to `int' in 
declaration of `acpi_sci_flags'
arch/i386/kernel/setup.c:96: warning: data definition has no type or 
storage class
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:811: error: request for member `trigger' in 
something not a structure or union
arch/i386/kernel/setup.c:814: error: request for member `trigger' in 
something not a structure or union
arch/i386/kernel/setup.c:817: error: request for member `polarity' in 
something not a structure or union
arch/i386/kernel/setup.c:820: error: request for member `polarity' in 
something not a structure or union
arch/i386/kernel/setup.c: In function `setup_arch':
arch/i386/kernel/setup.c:1571: warning: implicit declaration of function 
`acpi_boot_table_init'
arch/i386/kernel/setup.c:1572: warning: implicit declaration of function 
`acpi_boot_init'
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make: *** [arch/i386/kernel] Error 2

<--  snip  -->


> Reuben

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
