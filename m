From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 00/17] PNP Lindent
Date: Wed, 25 Jul 2007 12:24:44 -0400
Message-ID: <200707251224.44567.lenb@kernel.org>
References: <20070723212757.122218147@ldl.fc.hp.com> <200707231653.21937.bjorn.helgaas@hp.com> <20070723160007.d40b42a3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53998 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbXGYQ1R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 12:27:17 -0400
In-Reply-To: <20070723160007.d40b42a3.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, helgaas@ldl.fc.hp.com, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org


> > > > > The best time to do this would be late(ish) in the 2.6.24 merge window.
> > > > > 
> > > > > Can we do it then?
> > > > 
> > > > Sure.  I never know what the right time is.  Would that be after 2.6.23
> > > > has come out, your big bunch-o-patches has gone to Linus, and shortly
> > > > before 2.6.24-rc1?
> > > > 
> > > 
> > > Yes, that works.  I was carrying a Lindent-UFS patch for a month and it
> > > broke regularly.  But it was trivial to fix: I'd just rerun `Lindent
> > > fs/ufs/*.c' to regenerate it.  Then reapply the manual-post-lindent-fixups
> > > patch on top of that, and fix any remaining rejects.
> > 
> > It sounds like it'd be more convenient for you if I made a single
> > Lindent-PNP patch plus a post-lindent-fixups patch, rather than
> > separating things by files.
> 
> yup
> 
> >  I'll try to remember to do that after
> > 2.6.23 comes out.
> 
> thanks.
> 
> We could do it now if it's more convenient for you - there's not usually
> much happening in that area.

I agree it would be make-work to carry Lindent patches in -mm.

I think it is also a PITA to push them to Linus before RC1
because that is when a huge torrent of functional patches go in.

I think that between RC1 and RC2 (now) is as good a time as any
to push a Lindent cleanup to Linus.  If you guys agree, I'll
be happy to Lindent pnp and push it right now.  Heck, I try
to keep acpi Lindent-clean, so I could do that at the same time.

Bjorn, did you have to do any manual fix-ups to Lindent, or
did it actually get it right automatically?
Over time, I've actually changed some of the syntax of the ACPI code
so that it wouldn't confuse subsequent Lindent passes:-)
In particular, it didn't like macros that included their own ';'s.

cheers,
-Len

