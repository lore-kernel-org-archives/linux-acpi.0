From: Richard <tuxbox.guru@gmail.com>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Wed, 30 Apr 2008 11:23:01 +0100
Message-ID: <48184885.2090703@gmail.com>
References: <48144209.7080203@gmail.com>	 <1209476717.1784.853.camel@queen.suse.de>  <4817457C.6000103@gmail.com>	 <1209493771.1784.892.camel@queen.suse.de>  <4817B0E1.7080102@zytor.com> <1209544792.29352.78.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:22342 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088AbYD3KXJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 06:23:09 -0400
Received: by mu-out-0910.google.com with SMTP id g7so77576muf.1
        for <linux-acpi@vger.kernel.org>; Wed, 30 Apr 2008 03:23:05 -0700 (PDT)
In-Reply-To: <1209544792.29352.78.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, "Langsdorf, Mark" <mark.langsdorf@amd.com>, andreas.herrmann3@amd.com

Thomas Renninger wrote:
> On Tue, 2008-04-29 at 16:36 -0700, H. Peter Anvin wrote:
>  =20
>> Thomas Renninger wrote:
>>    =20
>>>>>  =20
>>>>>          =20
>>>> Thanks a Million..
>>>> noapictimer works perfectly ... BUT  .. only on 64Bit.  acpi_pm is=
 not=20
>>>> present on 32bit as a clocksource and it defaulted to jiffies. (ts=
c was=20
>>>> marked as imreliable)
>>>>
>>>> I am really surprised that this Sempron notebook actually had 64Bi=
t CPU=20
>>>> compatibility :D
>>>>        =20
>>> This one helps for my Turion.
>>> AFAIK, another Turion (very similar) does not need this, but I do n=
ot
>>> know for sure.
>>>
>>>      =20
>> Is the common denominator here the Turion (and if so, what model=20
>> number), or is it the mainboard or BIOS?  If the latter, it should b=
e=20
>> keyed on a DMI signature instead of the CPU.
>>    =20
>
> noapictimer is needed on machines with C1E (when all cores issue C1, =
the
> BIOS may decide to shut down more things, like the apic timer...).
> Therefore the checking for C1E (in arch/x86/setup_64.c
> amd_apic_timer_broken(..)). The check for C1E is done for K8 RevF, K1=
0
> and K11. I now expect it simply has been forgotten that K8 RevE=EF=BB=
=BF CPUs
> may also have C1E (maybe only mobile Turion and Semprons, could the
> check below be enhanced to only check mobile CPUs?)?
>
> This patch should also check for RevE with more than one core. It's
> untested, but should compile. Does this one work for you Richard?
>
>
> Also check for broken apic timer for RevE multi core machines
>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
>
> Index: linux-2.6/arch/x86/kernel/setup_64.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/x86/kernel/setup_64.c
> +++ linux-2.6/arch/x86/kernel/setup_64.c
> @@ -686,7 +686,7 @@ static void __cpuinit early_init_amd_mc(
>  #define CPUID_XFAM_10H		0x00100000
>  #define CPUID_XFAM_11H		0x00200000
>  #define CPUID_XMOD		0x000f0000
> -#define CPUID_XMOD_REV_F	0x00040000
> +#define CPUID_XMOD_REV_E	0x00020000
> =20
>  /* AMD systems with C1E don't have a working lAPIC timer. Check for =
that. */
>  static __cpuinit int amd_apic_timer_broken(void)
> @@ -695,7 +695,9 @@ static __cpuinit int amd_apic_timer_brok
> =20
>  	switch (eax & CPUID_XFAM) {
>  	case CPUID_XFAM_K8:
> -		if ((eax & CPUID_XMOD) < CPUID_XMOD_REV_F)
> +		if ((eax & CPUID_XMOD) < CPUID_XMOD_REV_E)
> +			break;
> +		if (num_online_cpus() < 2)
>  			break;
>  	case CPUID_XFAM_10H:
>  	case CPUID_XFAM_11H:
>
>
>
>
>  =20


Hi there,

The results are in.. and the patch done nothing on my notebook. The=20
symptoms are exactly the same as before. Kernel loads, INIT starts and=20
then the machine shuts down a few seconds later. noapictimer still fixe=
s=20
it tho'=20

<insert twilight zone music here>

Thanks a million,
Richard




--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
