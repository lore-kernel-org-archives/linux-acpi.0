From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before entering
	S3
Date: Mon, 18 May 2009 15:25:07 +0800
Message-ID: <1242631507.16529.107.camel@rzhang-dt>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	 <200905131616.27334.rjw@sisk.pl> <20090514094249.GG6417@elf.ucw.cz>
	 <200905151636.01318.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27056 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755693AbZERHYd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 May 2009 03:24:33 -0400
In-Reply-To: <200905151636.01318.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, 2009-05-15 at 22:36 +0800, Rafael J. Wysocki wrote:
> On Thursday 14 May 2009, Pavel Machek wrote:
> > 
> > > > > That really depends on the distrubution.  (open)SUSE always syncs before
> > > > > suspend/hibernation AFAICS, but I don't know about the other distros.
> > > > 
> > > > This doesn't address the real question: Should the system be allowed to 
> > > > go into S3 without doing a sync first?
> > > > 
> > > > Whether the sync is initiated by userspace or by the kernel doesn't 
> > > > make any difference.  Likewise, it doesn't matter if there are two 
> > > > syncs (because the second will be very fast, as Pavel said).
> > > > 
> > > > If you really wanted to speed up the suspend transition then you would
> > > > leave out the sync entirely.  But IMO this would be a mistake; the risk
> > > > of data loss is too great.  Which means the time overhead is necessary,
> > > > one way or another.  If userspace does a sync first then the suspend
> > > > transition will be faster, but this is just an accounting artifact (do
> > > > you count the time required for the sync toward the time required for
> > > > the suspend or not).
> > > 
> > > My point was in fact that if we left the syncing to the user space, then the
> > > user would be able to decide not to sync risking data loss.  At the moment the
> > > user has no choice. :-)
> > 
agree, and this is the purpose of my original post.

> > Well, if you can add the choice, without adding anything ugly and with
> > staying back-compatible, why not. (sync has to stay by default). I
> > believe ioctls() on /dev/snapshot may already enable you to do s2ram
> > without sync; if not they could be extended.
> > 
> > But remember there are even in-kernel s2ram triggers, for example on
> > zaurus when battery goes critical.
> > 

Take ACPI for example, ACPI defines two ACPI battery states, one is
"low" and another is "critical".
OS enters S3/S4 when battery is low, while it performs an emergency
shutdown when battery is in critical state. (ACPI spec 3.0b 3.9.4)
So I'm wondering if it's right to enter S3 when we know that the system
may lost power at anytime.

> > (And s2ram without sync _is_ "wrong": writeback timeouts are not
> > honored).
> 
any kind of suspend can't meet this requirement. Even sys_sync is
called, there is a small window that some pages are dirtied, but are not
synced to disk in max expire interval, right?

thanks,
rui

> OK, so I think the answer is we need the sync() as long as our filesystems
> don't support suspend-resume directly.
> 
> Thanks,
> Rafael

