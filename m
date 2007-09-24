From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: cpuidle
Date: Sun, 23 Sep 2007 19:39:25 -0700
Message-ID: <20070923193925.d75e7982.akpm@linux-foundation.org>
References: <20070923175706.74afa5bf.akpm@linux-foundation.org>
	<200709232228.30768.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59725 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753493AbXIXClG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 22:41:06 -0400
In-Reply-To: <200709232228.30768.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Pallipadi, Venki" <venkatesh.pallipadi@intel.com>

On Sun, 23 Sep 2007 22:28:30 -0400 Len Brown <lenb@kernel.org> wrote:

> On Sunday 23 September 2007 20:57, Andrew Morton wrote:
> > 
> > Whaaaaa?  Seems that the cpuidle patches all got dropped, but the x86_64
> > dynticks patches were fairly heavily dependent upon them.  (iow: I'm
> > screwed).
> > 
> > I can go back to the old version of git-acpi and retain the dynticks
> > patches or I can drop the dynticks patches.  (Either way I remain screwed).
> > 
> > What's happening?
> 
> Yes, I dropped cpuidle on Friday with plans to re-merge it Monday.
> 
> The reason is because I re-wrote my test tree Friday in prep for 2.6.24.
> As cpuidle had been merged multiple times, I needed to re-merge it and
> deal with the conflicts, and I ran out of time.
> 
> What we should end up with on Monday is a single cpuidle patch
> that sits on top of 2.6.22, and a single patch that merges it up to 2.6.23.
> 

I really don't know what I did, but for some reason the patches all
applied after I fiddled with something.  Maybe I broke something, dunno.

I did drop a few acpi patches which were dependent upon cpuidle:

-acpi-suspend-consolidate-handling-of-sx-states.patch
-acpi-suspend-consolidate-handling-of-sx-states-addendum.patch

but they were staged _after_ the dynticks patches so I dunno what's going
on.  I guess when I try to compile this lot I'll have a better idea...

ho hum.  I hope I haven't lost any patches during this little episode.
