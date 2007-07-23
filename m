From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 00/17] PNP Lindent
Date: Mon, 23 Jul 2007 15:49:09 -0700
Message-ID: <20070723154909.55862883.akpm@linux-foundation.org>
References: <20070723212757.122218147@ldl.fc.hp.com>
	<20070723150852.9c6fb23d.akpm@linux-foundation.org>
	<200707231639.57796.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60281 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393AbXGWWuE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 18:50:04 -0400
In-Reply-To: <200707231639.57796.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: helgaas@ldl.fc.hp.com, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

On Mon, 23 Jul 2007 16:39:57 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Monday 23 July 2007 04:08:52 pm Andrew Morton wrote:
> > On Mon, 23 Jul 2007 15:27:57 -0600
> > helgaas@ldl.fc.hp.com wrote:
> > 
> > > Run PNP files through Lindent.  These patches are all completely
> > > independent and contain no functional changes.  Object files before
> > > and after are identical.
> > > 
> > > These are against current upstream.  If you prefer a different base
> > > or drop some of these due to conflicts with things already in -mm,
> > > let me know and I can regenerate them.
> > > 
> > 
> > eep, this is the worst time for me to merge this stuff: I get to carry
> > large diffs against lots of files for two months.
> > 
> > The best time to do this would be late(ish) in the 2.6.24 merge window.
> > 
> > Can we do it then?
> 
> Sure.  I never know what the right time is.  Would that be after 2.6.23
> has come out, your big bunch-o-patches has gone to Linus, and shortly
> before 2.6.24-rc1?
> 

Yes, that works.  I was carrying a Lindent-UFS patch for a month and it
broke regularly.  But it was trivial to fix: I'd just rerun `Lindent
fs/ufs/*.c' to regenerate it.  Then reapply the manual-post-lindent-fixups
patch on top of that, and fix any remaining rejects.


