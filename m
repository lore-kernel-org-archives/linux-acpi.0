From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: [PATCH] Handle disabled local apic better
Date: Wed, 24 Mar 2004 05:27:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040324052724.56e57709.ak@suse.de>
References: <20040323213551.4789bbae.ak@suse.de>
	<1080112373.18504.67.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080112373.18504.67.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 24 Mar 2004 02:12:54 -0500
Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, 2004-03-23 at 15:35, Andi Kleen wrote:
> > When a kernel is compiled with local and io apic code, but the local APIC
> > is disabled before ACPI starts ACPI gets confused.  The situation
> > can occur in a mainline kernel too, e.g. when a dmi_scan entry disables
> > the local apic early.
> > 
> > The problem is that the ACPI code will do all the setup assuming there
> > is a IO-APIC because the IO-APIC is not disabled, but the machine really runs in 
> > PIC mode. This usually leads to lost network (devices get an unreachable interrupt) 
> > or IDE hangs or other problems.
> > 
> > This patch adds checks for local apic enabled to all paths that need it
> > (basically everybody who has a #ifdef CONFIG_X86_LOCAL_APIC needs this
> > check instead)
> 
> oof, and there are lots of CONFIG_X86_LOCAL_APIC uses apparently
> un-guarded at run-time...

I thought I catched most of them?
 
> Looks like i386 lacks the parse_cmdline_early() check for "nolapic" to
> make this test effective.


Yes. But dmi scan is done that early.

For command line and APIC failures later it probably needs more work, agreed.

BTW if that is all cleaned up I would suggest just to get rid of the CONFIGs
and always use runtime defaults. This would make these parts more maintainable
I think and is the right thing to do for distributions.

> (why the heck is the parse_args() so late, anyway?)
> 
> Looks like x86_64 has it, but then does it again at __setup() time --
> which should probably be removed; along with the redundant variable
> "disable_apic".

The x86-64 disable_apic was there first. I just had to add the new
variable because of the new incestuous sharing of acpi/boot.c to avoid
link errors.
 
> >  
> > diff -u linux/arch/i386/kernel/apic.c-o linux/arch/i386/kernel/apic.c
> > --- linux/arch/i386/kernel/apic.c-o	2004-03-23 17:32:22.000000000 +0100
> > +++ linux/arch/i386/kernel/apic.c	2004-03-23 18:01:21.000000000 +0100
> > @@ -41,6 +41,8 @@
> >  
> >  #include "io_ports.h"
> >  
> > +extern int enable_local_apic;
> > +
> 
> how about declare in asm/apic.h instead?

Sure. I was just lazy.

> >  /* This value is set up by the early boot code to point to the value
> >     immediately after the boot time page tables.  It contains a *physical*
> >     address, and must not be in the .bss segment! */
> > @@ -917,6 +925,7 @@
> >  	acpi_reserve_bootmem();
> >  #endif
> >  #ifdef CONFIG_X86_FIND_SMP_CONFIG
> > +	if (enable_local_apic >= 0) 
> >  	/*
> >  	 * Find and reserve possible boot-time SMP configuration:
> >  	 */
> 
> Here we're disabling MPS with "nolapic" -- something that "maxcpus=0"
> and "nosmp" never effectively did before...

MPS without local APIC is useless.

>
> >  /*
> >   * This initializes the IO-APIC and APIC hardware if this is
> > @@ -1009,12 +1010,14 @@
> >  
> >  static __init int setup_disableapic(char *str) 
> >  { 
> > +	enable_local_apic = -1;
> >  	disable_apic = 1;
> >  	return 0;
> >  } 
> >  
> >  static __init int setup_nolapic(char *str) 
> >  { 
> > +	enable_local_apic = -1;
> >  	disable_apic = 1;
> >  	return 0;
> >  } 
> 
> these routines should be deleted, since they duplicate the earlier
> parse_cmdline_early().  the ambiguous "disable_lapic" should go also,
> since "enable_local_apic" is on the scene, yes?

No, even when you parse in parse_cmdline_early() you need a __setup,
otherwise the normal __setup parser will complain about unknown 
options.

In 2.7 i hope this all will get up cleared up with a __early_setup()

-Andi



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
