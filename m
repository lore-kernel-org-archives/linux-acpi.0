From: "Joachim Deguara" <joachim.deguara@amd.com>
Subject: Re: ACPI on Averatec 2370
Date: Wed, 8 Aug 2007 16:41:59 +0200
Message-ID: <200708081642.00581.joachim.deguara@amd.com>
References: <Pine.LNX.4.64.0707301048460.5693@lancer.cnet.absolutedigital.net>
 <Pine.LNX.4.64.0708071803570.28199@lancer.cnet.absolutedigital.net>
 <20070808000631.GB7353@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:3906 "EHLO
	outbound4-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753582AbXHHOmV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Aug 2007 10:42:21 -0400
In-Reply-To: <20070808000631.GB7353@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Cal Peake <cp@absolutedigital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Chuck Ebbert <cebbert@redhat.com>, Gabriel C <nix.or.die@googlemail.com>, Frank Hale <frankhale@gmail.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel ACPI Mailing List <linux-acpi@vger.kernel.org>, len.brown@intel.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

On Wednesday 08 August 2007 02:06:31 Andi Kleen wrote:
> On Tue, Aug 07, 2007 at 06:15:37PM -0400, Cal Peake wrote:
> > On Fri, 3 Aug 2007, Linus Torvalds wrote:
> > > > MSR_K8_ENABLE_C1E lo == 0x04c14015
> > > > MSR_K8_ENABLE_C1E hi == 0x00000000
> > > > lo & ENABLE_C1E_MASK == 0
> > >
> > > And yeah, that claims that C1E is not on, but:
> > > > amd_apic_timer_broken: forcing return value of 1
> >
> > So it seems my initial debugging report was, err, incomplete. I failed to
> > notice that the amd_apic_timer_broken function was getting called twice,
> > once for each core.
> >
> > The second call shows this:
> >
> >   MSR_K8_ENABLE_C1E == 0x14c14015
>
> Ah interesting. Ok finally that all starts making sense.
>
> Not sure why the MSR varies between cores though.

This is a BIOS bug as the BIOS should have programmed the MSR the same for 
both cores.  See section 10.2.4 of the Rev F BKDG [1] (10.2.4.1 talks about 
the SMI case but a newer version of the doc not yet release has similar 
wording about both cores needing to have the bit set for the chipset case).

-Joachim

[1] 
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/32559.pdf


