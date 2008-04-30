From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Wed, 30 Apr 2008 10:39:52 +0200
Message-ID: <1209544792.29352.78.camel@linux-2bdv.site>
References: <48144209.7080203@gmail.com>
	 <1209476717.1784.853.camel@queen.suse.de>  <4817457C.6000103@gmail.com>
	 <1209493771.1784.892.camel@queen.suse.de>  <4817B0E1.7080102@zytor.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44995 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755223AbYD3Ijz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 04:39:55 -0400
In-Reply-To: <4817B0E1.7080102@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Richard <tuxbox.guru@gmail.com>, linux-acpi@vger.kernel.org, "Langsdorf, Mark" <mark.langsdorf@amd.com>, andreas.herrmann3@amd.com


On Tue, 2008-04-29 at 16:36 -0700, H. Peter Anvin wrote:
> Thomas Renninger wrote:
> >>>  =20
> >> Thanks a Million..
> >> noapictimer works perfectly ... BUT  .. only on 64Bit.  acpi_pm is=
 not=20
> >> present on 32bit as a clocksource and it defaulted to jiffies. (ts=
c was=20
> >> marked as imreliable)
> >>
> >> I am really surprised that this Sempron notebook actually had 64Bi=
t CPU=20
> >> compatibility :D
> >=20
> > This one helps for my Turion.
> > AFAIK, another Turion (very similar) does not need this, but I do n=
ot
> > know for sure.
> >=20
>=20
> Is the common denominator here the Turion (and if so, what model=20
> number), or is it the mainboard or BIOS?  If the latter, it should be=
=20
> keyed on a DMI signature instead of the CPU.

noapictimer is needed on machines with C1E (when all cores issue C1, th=
e
BIOS may decide to shut down more things, like the apic timer...).
Therefore the checking for C1E (in arch/x86/setup_64.c
amd_apic_timer_broken(..)). The check for C1E is done for K8 RevF, K10
and K11. I now expect it simply has been forgotten that K8 RevE=EF=BB=BF=
 CPUs
may also have C1E (maybe only mobile Turion and Semprons, could the
check below be enhanced to only check mobile CPUs?)?

This patch should also check for RevE with more than one core. It's
untested, but should compile. Does this one work for you Richard?

-- Unrelated --
Peter: You wrote the syslinux stuff, right? What kind of luck is that :=
)
There currently is a discussion about being able to override ACPI table=
s
via initrd. The discussion is a bit stuck because the data is needed
earlier than initrd is unpacked and the hacks to make it work are not
accepted by Linus. I thought about adding another binary image to i386
boot protocol, similar to initrd=3D which contains data for very early
kernel boot initialization, but this would be a heavy hammer (but IMO
still better than only do it for kexec, another suggestion...) , =EF=BB=
=BFI
better open a separate thread or pre-ask privately whether this makes
sense at all. It would be great if you could advise and possibly help t=
o
convince so that we finally may find a solution accepted mainline.
=EF=BB=BF-- Unrelated --


Also check for broken apic timer for RevE multi core machines

Signed-off-by: Thomas Renninger <trenn@suse.de>

Index: linux-2.6/arch/x86/kernel/setup_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/x86/kernel/setup_64.c
+++ linux-2.6/arch/x86/kernel/setup_64.c
@@ -686,7 +686,7 @@ static void __cpuinit early_init_amd_mc(
 #define CPUID_XFAM_10H		0x00100000
 #define CPUID_XFAM_11H		0x00200000
 #define CPUID_XMOD		0x000f0000
-#define CPUID_XMOD_REV_F	0x00040000
+#define CPUID_XMOD_REV_E	0x00020000
=20
 /* AMD systems with C1E don't have a working lAPIC timer. Check for th=
at. */
 static __cpuinit int amd_apic_timer_broken(void)
@@ -695,7 +695,9 @@ static __cpuinit int amd_apic_timer_brok
=20
 	switch (eax & CPUID_XFAM) {
 	case CPUID_XFAM_K8:
-		if ((eax & CPUID_XMOD) < CPUID_XMOD_REV_F)
+		if ((eax & CPUID_XMOD) < CPUID_XMOD_REV_E)
+			break;
+		if (num_online_cpus() < 2)
 			break;
 	case CPUID_XFAM_10H:
 	case CPUID_XFAM_11H:



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
