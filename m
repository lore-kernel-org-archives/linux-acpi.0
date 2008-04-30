From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Wed, 30 Apr 2008 14:07:40 +0200
Message-ID: <1209557260.1784.905.camel@queen.suse.de>
References: <48144209.7080203@gmail.com>
	 <1209476717.1784.853.camel@queen.suse.de>  <4817457C.6000103@gmail.com>
	 <1209493771.1784.892.camel@queen.suse.de>  <4817B0E1.7080102@zytor.com>
	 <1209544792.29352.78.camel@linux-2bdv.site>  <48184885.2090703@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:47098 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341AbYD3MHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 08:07:42 -0400
In-Reply-To: <48184885.2090703@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, "Langsdorf, Mark" <mark.langsdorf@amd.com>, andreas.herrmann3@amd.com

On Wed, 2008-04-30 at 11:23 +0100, Richard wrote:
> Thomas Renninger wrote:
> > On Tue, 2008-04-29 at 16:36 -0700, H. Peter Anvin wrote:
> >  =20
> >> Thomas Renninger wrote:
> >>    =20
> >>>>>  =20
> >>>>>          =20
> >>>> Thanks a Million..
> >>>> noapictimer works perfectly ... BUT  .. only on 64Bit.  acpi_pm =
is not=20
> >>>> present on 32bit as a clocksource and it defaulted to jiffies. (=
tsc was=20
> >>>> marked as imreliable)
> >>>>
> >>>> I am really surprised that this Sempron notebook actually had 64=
Bit CPU=20
> >>>> compatibility :D
> >>>>        =20
> >>> This one helps for my Turion.
> >>> AFAIK, another Turion (very similar) does not need this, but I do=
 not
> >>> know for sure.
> >>>
> >>>      =20
> >> Is the common denominator here the Turion (and if so, what model=20
> >> number), or is it the mainboard or BIOS?  If the latter, it should=
 be=20
> >> keyed on a DMI signature instead of the CPU.
> >>    =20
> >
> > noapictimer is needed on machines with C1E (when all cores issue C1=
, the
> > BIOS may decide to shut down more things, like the apic timer...).
> > Therefore the checking for C1E (in arch/x86/setup_64.c
> > amd_apic_timer_broken(..)). The check for C1E is done for K8 RevF, =
K10
> > and K11. I now expect it simply has been forgotten that K8 RevE=EF=BB=
=BF CPUs
> > may also have C1E (maybe only mobile Turion and Semprons, could the
> > check below be enhanced to only check mobile CPUs?)?
> >
> > This patch should also check for RevE with more than one core. It's
> > untested, but should compile. Does this one work for you Richard?
> >
> >
> > Also check for broken apic timer for RevE multi core machines
> >
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> >
> > Index: linux-2.6/arch/x86/kernel/setup_64.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/arch/x86/kernel/setup_64.c
> > +++ linux-2.6/arch/x86/kernel/setup_64.c
> > @@ -686,7 +686,7 @@ static void __cpuinit early_init_amd_mc(
> >  #define CPUID_XFAM_10H		0x00100000
> >  #define CPUID_XFAM_11H		0x00200000
> >  #define CPUID_XMOD		0x000f0000
> > -#define CPUID_XMOD_REV_F	0x00040000
> > +#define CPUID_XMOD_REV_E	0x00020000
> > =20
> >  /* AMD systems with C1E don't have a working lAPIC timer. Check fo=
r that. */
> >  static __cpuinit int amd_apic_timer_broken(void)
> > @@ -695,7 +695,9 @@ static __cpuinit int amd_apic_timer_brok
> > =20
> >  	switch (eax & CPUID_XFAM) {
> >  	case CPUID_XFAM_K8:
> > -		if ((eax & CPUID_XMOD) < CPUID_XMOD_REV_F)
> > +		if ((eax & CPUID_XMOD) < CPUID_XMOD_REV_E)
{                         printk("RevD or lower\n");
> > +			break;
}
> > +		if (num_online_cpus() < 2)
{                         printk("Only detected %d online CPUs\n",
                          num_online_cpus());
> >  			break;
}
> >  	case CPUID_XFAM_10H:
> >  	case CPUID_XFAM_11H:
Also something at the C1E check which should come here then, does it
match?
Maybe it really is a RevE and the second CPU is not brought up yet?
> >
> >
> >  =20
>=20
>=20
> Hi there,
>=20
> The results are in.. and the patch done nothing on my notebook. The=20
> symptoms are exactly the same as before. Kernel loads, INIT starts an=
d=20
> then the machine shuts down a few seconds later. noapictimer still fi=
xes=20
> it tho'=20

Googled this:
Sempron 3600+ (CN),256K,rev.F2,62W,SocketAM2    ALL  0107
So this Sempron probably is RevF already but the C1E check does not
work?
Hope you still have the kernel compiled flying around?
Could you add a lot printks at the place (some examples above) where it
is checked for broken apic timer.
Maybe you can also just return that it's broken to check whether settin=
g
noapictimer variable at this place generally works for you...

Thanks,

    Thomas



PS: That i386 does not boot sounds related to:

Mobile AMD Sempron(tm) Processor 3500+ does not boot with i386 kernel
https://bugzilla.novell.com/show_bug.cgi?id=3D331960

If you don't mind you could post the timer things you found out there
and eventually we could have a look how to get the machine going with
i386, the reporter has handed over the machine to his girl friend,
therefore the bug got stuck...

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
