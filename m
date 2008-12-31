From: Len Brown <lenb@kernel.org>
Subject: Re: state of some x86 acpi patches
Date: Wed, 31 Dec 2008 18:38:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812311821110.3854@localhost.localdomain>
References: <4947FF4C.80706@goop.org> <20081216192534.GB843@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56004 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYLaXiS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2008 18:38:18 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KCR006RULLIYV12@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 31 Dec 2008 17:36:55 -0600 (CST)
In-reply-to: <20081216192534.GB843@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org

On Tue, 16 Dec 2008, Ingo Molnar wrote:

> 
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Hi Len,
> >
> > Have you seen these three patches?  Do they look OK to you?
> >
> > Yinghai Lu improve the third patch ("acpi: remove final __acpi_map_table 
> > mapping before setting acpi_gbl_permanent_mmap"), which I think Ingo 
> > sent you instead.
> 
> Len,
> 
> i asked about these patches before too - and if that's fine with you we'd 
> just queue them up in the x86 tree (like we did before the .28 merge 
> window). Most of the impact will be on x86. So an Acked-by from you would 
> be fine to start this.

Sorry for the delay.
I recall reading your e-mail on this and thought I replied to it,
but for some reason I found neither your original message nor
my reply when I searched my archives today.

But I did recall Ingo making a branch for this one, and so looking
at remotes/origin/acpi-for-len in ingo's tree...

It isn't immediately clear to me what problem this patch series solves,
and thus it is hard to judge how important this is.

It touches a lot of files, and it is going to run into a bunch of merge 
conflicts.

I'm not thrilled that the first part of the series makes changes
which are then undone by the later part of the series --
that doesn't help w/ conflict resolution...

The change to tbxface.c is an ACPICA API change.
It looks reasonable and it might be the right change,
but it is extra work -- we should sync with Bob
when he gets back from break.

So, this one is sort of a headache, how important is it?

thanks,
-- Len Brown, Intel Open Source Technology Center

