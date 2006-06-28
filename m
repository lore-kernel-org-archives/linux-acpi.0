From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 02/18] acpi memory hotplug cannot manage _CRS with
 plural resoureces
Date: Tue, 27 Jun 2006 23:31:13 -0700
Message-ID: <20060627233113.006000d2.akpm@osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6DCECB0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:36832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423179AbWF1GbR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jun 2006 02:31:17 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6DCECB0@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com, kaneshige.kenji@jp.fujitsu.com

On Wed, 28 Jun 2006 02:13:26 -0400
"Brown, Len" <len.brown@intel.com> wrote:

> Andrew,
> Thanks for forwarding this series to Linus.
> 
> >btw, this is, by my count, the seventh time I've sent this patch.
> 
> what is your point?

That when someone sends someone else a patch, it's a request that it be
merged.  Or commented on.  Or nacked-with-reason.  Or acked.  Or something.
 The sender doesn't expect or want zero response from seven attempts across
three months!

> > The first was on March 21.
> 
> March 21st was the 1st day of the 2.6.17 integration window,
> so unless this series deserved very little testing, it
> missed 2.6.17 by definition.
> 
> Also, I couldn't apply this patch series because it depended
> on other changes in -mm.  Yes, I should have Acked it for you.
> However, when it didn't apply I stopped looking at it.

The patch was against the current acpi devel tree.  I always send patches
against the recipient's tree.  Perhaps there were earlier sent-to-you-also
patches in that series upon which it had dependencies.

> June 17th, 2.6.18 opened
> 
> You send this series to Linus today.
> So given the current process and the 8-week 2.6.17 cycle,
> this patch made it into Linus' tree within days of the speed of light.
> 
> I'm happy to work with you on improving the process.
> I think I could have acked this one for you, but that
> is about it.

When I send you a patch, unless I specifically mark it as for-review or
something then please treat is as a request to merge.  Unless it's urgent
(like a bugfix) then some action within a couple of weeks is fine.  Action
being merge, nack-with-reason, request-for-modification, please-merge-it-yourself
etc.  Something dispositive.

Thanks.
