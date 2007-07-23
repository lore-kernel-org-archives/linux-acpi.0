From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 00/17] PNP Lindent
Date: Mon, 23 Jul 2007 16:53:21 -0600
Message-ID: <200707231653.21937.bjorn.helgaas@hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com> <200707231639.57796.bjorn.helgaas@hp.com> <20070723154909.55862883.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:50080 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbXGWWxt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 18:53:49 -0400
In-Reply-To: <20070723154909.55862883.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: helgaas@ldl.fc.hp.com, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

On Monday 23 July 2007 04:49:09 pm Andrew Morton wrote:
> On Mon, 23 Jul 2007 16:39:57 -0600
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > On Monday 23 July 2007 04:08:52 pm Andrew Morton wrote:
> > > eep, this is the worst time for me to merge this stuff: I get to carry
> > > large diffs against lots of files for two months.
> > > 
> > > The best time to do this would be late(ish) in the 2.6.24 merge window.
> > > 
> > > Can we do it then?
> > 
> > Sure.  I never know what the right time is.  Would that be after 2.6.23
> > has come out, your big bunch-o-patches has gone to Linus, and shortly
> > before 2.6.24-rc1?
> > 
> 
> Yes, that works.  I was carrying a Lindent-UFS patch for a month and it
> broke regularly.  But it was trivial to fix: I'd just rerun `Lindent
> fs/ufs/*.c' to regenerate it.  Then reapply the manual-post-lindent-fixups
> patch on top of that, and fix any remaining rejects.

It sounds like it'd be more convenient for you if I made a single
Lindent-PNP patch plus a post-lindent-fixups patch, rather than
separating things by files.  I'll try to remember to do that after
2.6.23 comes out.

Bjorn
