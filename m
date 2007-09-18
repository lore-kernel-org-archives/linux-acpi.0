From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Tue, 18 Sep 2007 10:07:18 -0700
Message-ID: <20070918100718.3d510356.akpm@linux-foundation.org>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org>
	<200709181121.41368.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49108 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756050AbXIRRIM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 13:08:12 -0400
In-Reply-To: <200709181121.41368.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Tue, 18 Sep 2007 11:21:41 -0400 Len Brown <lenb@kernel.org> wrote:

> On Tuesday 18 September 2007 00:12, Andrew Morton wrote:
> > 
> > It suspends OK, then during resume it gets partway through it, then everything
> > just stops.
> 
> Hmmm, i thought your vaio resume problems were in linus' tree --
> did that go away -- or maybe it was in -mm and not in linus' tree all along?

It got fixed in Linus's tree by tglx's recent timers merge.

This breakage in git-acpi is new, I think.  Four or five days ago, git-acpi
_fixed_ suspend/resume on Linus's tree.  Now it breaks it.

But I don't think there have been changes in got-acpi since then, so
perhaps the breakage is due to interaction with Thomas's recent merge.

> > Would prefer not to have to bisect this one - I've done enough bisecting this
> > week to last a lifetime, and bisecting git-acpi is painful due to build bustage
> > at various points (cpuidle).
> 
> bisecting the acpi git three should work well, because it uses topic branches.
> This includes cpuidle.  ie.  unless the breakage is within the cpuidle branch itself,
> the whole cpuidle topic can be removed by skipping the single merge commit that
> pulls it in.

The breakage is within the cpuidle branch.

> If you like, I can build the topic branch heads and export plain patches
> for you to try.  Also, I'll probably be re-writing the test branch history
> later today -- so let me know if you dig into it and i'll delay that until
> you're done.

I won't be doing anything here for a day or so.

I think what needs to happen is that the commits in the cpuidle code need
to be folded together.  iirc the first couple of commits don't compile, and
the third one fixes them.  Or something like that.


