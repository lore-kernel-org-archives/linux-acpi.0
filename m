From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 00/17] PNP Lindent
Date: Wed, 25 Jul 2007 14:53:22 -0700
Message-ID: <20070725145322.3ad5bd41.akpm@linux-foundation.org>
References: <20070723212757.122218147@ldl.fc.hp.com>
	<200707231653.21937.bjorn.helgaas@hp.com>
	<20070723160007.d40b42a3.akpm@linux-foundation.org>
	<200707251224.44567.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42325 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754254AbXGYVzA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 17:55:00 -0400
In-Reply-To: <200707251224.44567.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, helgaas@ldl.fc.hp.com, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

On Wed, 25 Jul 2007 12:24:44 -0400
Len Brown <lenb@kernel.org> wrote:

> 
> > > > > > The best time to do this would be late(ish) in the 2.6.24 merge window.
> > > > > > 
> > > > > > Can we do it then?
> > > > > 
> > > > > Sure.  I never know what the right time is.  Would that be after 2.6.23
> > > > > has come out, your big bunch-o-patches has gone to Linus, and shortly
> > > > > before 2.6.24-rc1?
> > > > > 
> > > > 
> > > > Yes, that works.  I was carrying a Lindent-UFS patch for a month and it
> > > > broke regularly.  But it was trivial to fix: I'd just rerun `Lindent
> > > > fs/ufs/*.c' to regenerate it.  Then reapply the manual-post-lindent-fixups
> > > > patch on top of that, and fix any remaining rejects.
> > > 
> > > It sounds like it'd be more convenient for you if I made a single
> > > Lindent-PNP patch plus a post-lindent-fixups patch, rather than
> > > separating things by files.
> > 
> > yup
> > 
> > >  I'll try to remember to do that after
> > > 2.6.23 comes out.
> > 
> > thanks.
> > 
> > We could do it now if it's more convenient for you - there's not usually
> > much happening in that area.
> 
> I agree it would be make-work to carry Lindent patches in -mm.
> 
> I think it is also a PITA to push them to Linus before RC1
> because that is when a huge torrent of functional patches go in.
> 
> I think that between RC1 and RC2 (now) is as good a time as any
> to push a Lindent cleanup to Linus.  If you guys agree, I'll
> be happy to Lindent pnp and push it right now.  Heck, I try
> to keep acpi Lindent-clean, so I could do that at the same time.
> 
> Bjorn, did you have to do any manual fix-ups to Lindent, or
> did it actually get it right automatically?
> Over time, I've actually changed some of the syntax of the ACPI code
> so that it wouldn't confuse subsequent Lindent passes:-)
> In particular, it didn't like macros that included their own ';'s.
> 

Yes, the best time for large code-motion patches and large
whitespace-wrangling patches is shortly before or shortly after -rc1.

Pleae ensure that the PNP whitespace-wrangling makes no change in code
generation.  Let's get it done?

