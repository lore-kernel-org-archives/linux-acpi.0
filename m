From: "Frank Hale" <frankhale@gmail.com>
Subject: Re: ACPI on Averatec 2370
Date: Wed, 8 Aug 2007 23:52:37 +0000
Message-ID: <5ebbd9b50708081652h55c85f9avab4500391c6b7ee0@mail.gmail.com>
References: <Pine.LNX.4.64.0707301048460.5693@lancer.cnet.absolutedigital.net>
	 <Pine.LNX.4.64.0708071803570.28199@lancer.cnet.absolutedigital.net>
	 <20070808000631.GB7353@one.firstfloor.org>
	 <200708081642.00581.joachim.deguara@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:2864 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757224AbXHHXwi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Aug 2007 19:52:38 -0400
Received: by an-out-0708.google.com with SMTP id d31so59026and
        for <linux-acpi@vger.kernel.org>; Wed, 08 Aug 2007 16:52:37 -0700 (PDT)
In-Reply-To: <200708081642.00581.joachim.deguara@amd.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joachim Deguara <joachim.deguara@amd.com>
Cc: Andi Kleen <andi@firstfloor.org>, Cal Peake <cp@absolutedigital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Chuck Ebbert <cebbert@redhat.com>, Gabriel C <nix.or.die@googlemail.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel ACPI Mailing List <linux-acpi@vger.kernel.org>, len.brown@intel.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

I have the latest BIOS update for my laptop which is buggy I suppose.
There has been only one update this year if my memory serves me
correctly. Is there any hope to fix this or am I at the mercy of the
hardware vendor which apparenlty doesn't look like they will release
another patch this year. Please forgive me as I am not a kernel
developer but a concerned user. I've sacrificed ACPI in favor of SMP
at this point, I don't know what it's buying me but the kernel boots
and works fine with the draw back that I have no ACPI and I have to
manually power the computer down by pressing the power button when it
halts. I can live with that if that is the solution but I haven't
really tracked as far as the high level dev stuff goes in this thread
and don't know what the solution might be.

On 8/8/07, Joachim Deguara <joachim.deguara@amd.com> wrote:
> On Wednesday 08 August 2007 02:06:31 Andi Kleen wrote:
> > On Tue, Aug 07, 2007 at 06:15:37PM -0400, Cal Peake wrote:
> > > On Fri, 3 Aug 2007, Linus Torvalds wrote:
> > > > > MSR_K8_ENABLE_C1E lo == 0x04c14015
> > > > > MSR_K8_ENABLE_C1E hi == 0x00000000
> > > > > lo & ENABLE_C1E_MASK == 0
> > > >
> > > > And yeah, that claims that C1E is not on, but:
> > > > > amd_apic_timer_broken: forcing return value of 1
> > >
> > > So it seems my initial debugging report was, err, incomplete. I failed to
> > > notice that the amd_apic_timer_broken function was getting called twice,
> > > once for each core.
> > >
> > > The second call shows this:
> > >
> > >   MSR_K8_ENABLE_C1E == 0x14c14015
> >
> > Ah interesting. Ok finally that all starts making sense.
> >
> > Not sure why the MSR varies between cores though.
>
> This is a BIOS bug as the BIOS should have programmed the MSR the same for
> both cores.  See section 10.2.4 of the Rev F BKDG [1] (10.2.4.1 talks about
> the SMI case but a newer version of the doc not yet release has similar
> wording about both cores needing to have the bit set for the chipset case).
>
> -Joachim
>
> [1]
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf
>
>
>
