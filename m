From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
Date: Thu, 22 Jan 2004 10:23:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <88056F38E9E48644A0F562A38C64FB6082D0B8@scsmsx403.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
content-class: urn:content-classes:message
To: Mikael Pettersson <mikpe@csd.uu.se>, Linus Torvalds <torvalds@osdl.org>
Cc: Karol Kozimor <sziwan@hell.org.pl>, "Georg C. F. Greve" <greve@gnu.org>, "Nakajima, Jun" <jun.nakajima@intel.com>, Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org


This was how the APIC_TIMER_BASE_DIV was originally added there.
http://www.ussg.iu.edu/hypermail/linux/kernel/9907.1/0608.html


Thanks,
Venkatesh



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Mikael Pettersson
> Sent: Thursday, January 22, 2004 9:49 AM
> To: Linus Torvalds
> Cc: Karol Kozimor; Georg C. F. Greve; Nakajima, Jun; Martin 
> Loschwitz; linux-kernel@vger.kernel.org; Brown, Len; 
> acpi-devel@lists.sourceforge.net
> Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
> 
> 
> Linus Torvalds writes:
>  > 
>  > 
>  > On Thu, 22 Jan 2004, Mikael Pettersson wrote:
>  > 
>  > > Karol Kozimor writes:
>  > >  > 
>  > >  > diff -Bru linux-2.6.0-test8/arch/i386/kernel/apic.c 
> patched/arch/i386/kernel/apic.c
>  > >  > --- linux-2.6.0-test8/arch/i386/kernel/apic.c	
> 2003-10-18 05:43:36.000000000 +0800
>  > >  > +++ patched/arch/i386/kernel/apic.c	2003-10-30 
> 23:17:50.000000000 +0800
>  > >  > @@ -836,8 +836,8 @@
>  > >  >  {
>  > >  >  	unsigned int lvtt1_value, tmp_value;
>  > >  >  
>  > >  > -	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
>  > >  > -			APIC_LVT_TIMER_PERIODIC | 
> LOCAL_TIMER_VECTOR;
>  > >  > +	lvtt1_value = APIC_LVT_TIMER_PERIODIC | 
> LOCAL_TIMER_VECTOR;
>  > >  > +
>  > >  >  	apic_write_around(APIC_LVTT, lvtt1_value);
>  > > 
>  > > What is the purpose of this change?
>  > > I don't remember seeing this before on LKML. (I don't 
> have time to read bugzilla.)
>  > 
>  > Hmm.. It does seem to fix things for a couple of people, 
> so it looks 
>  > interesting.
>  > 
>  > As far as I can tell, the _only_ thing it does is to 
> change the timer base
>  > from "DIV" to "CLKIN". I seem to have misplaced my ia-32 
> "volume 3" thing, 
>  > but I have an old one for a pentium, and that one doesn't actually
>  > haev the timer-base thing at all - and marks those bits as 
> "reserved".
>  > 
>  > So it is entirely possible that the only safe value to 
> write there is 0.
> 
> Confirmed. Those bits (18 and 19 in LVTT) are marked reserved in the
> latest IA32 Volume 3. I have no idea where this APIC_TIMER_BASE came
> from (maybe some ancient discrete LAPIC thing?), but we 
> almost certainly
> shouldn't write anything but zero to them.
> 
>  > So I'm inclined to apply the patch, but it would be better 
> if somebody who 
> 
> I agree. The patch should be applied.
> 
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
