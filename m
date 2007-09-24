From: Len Brown <lenb@kernel.org>
Subject: Re: cpuidle
Date: Sun, 23 Sep 2007 22:28:30 -0400
Message-ID: <200709232228.30768.lenb@kernel.org>
References: <20070923175706.74afa5bf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36358 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090AbXIXC3N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 22:29:13 -0400
In-Reply-To: <20070923175706.74afa5bf.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Pallipadi, Venki" <venkatesh.pallipadi@intel.com>

On Sunday 23 September 2007 20:57, Andrew Morton wrote:
> 
> Whaaaaa?  Seems that the cpuidle patches all got dropped, but the x86_64
> dynticks patches were fairly heavily dependent upon them.  (iow: I'm
> screwed).
> 
> I can go back to the old version of git-acpi and retain the dynticks
> patches or I can drop the dynticks patches.  (Either way I remain screwed).
> 
> What's happening?

Yes, I dropped cpuidle on Friday with plans to re-merge it Monday.

The reason is because I re-wrote my test tree Friday in prep for 2.6.24.
As cpuidle had been merged multiple times, I needed to re-merge it and
deal with the conflicts, and I ran out of time.

What we should end up with on Monday is a single cpuidle patch
that sits on top of 2.6.22, and a single patch that merges it up to 2.6.23.

sorry for the disruption,
-Len
