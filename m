From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before entering
	S3
Date: Fri, 22 May 2009 17:33:57 +0200
Message-ID: <20090522153356.GB27655@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org> <200905131616.27334.rjw@sisk.pl> <20090514094249.GG6417@elf.ucw.cz> <200905151636.01318.rjw@sisk.pl> <1242631507.16529.107.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54168 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbZEVPeD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2009 11:34:03 -0400
Content-Disposition: inline
In-Reply-To: <1242631507.16529.107.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Hi!

> > > But remember there are even in-kernel s2ram triggers, for example on
> > > zaurus when battery goes critical.
> > > 
> 
> Take ACPI for example, ACPI defines two ACPI battery states, one is
> "low" and another is "critical".
> OS enters S3/S4 when battery is low, while it performs an emergency
> shutdown when battery is in critical state. (ACPI spec 3.0b 3.9.4)
> So I'm wondering if it's right to enter S3 when we know that the system
> may lost power at anytime.

Well, battery only lasts like 30 hours in S3. So if you leave your
notebook unattended for 30 hours, you'll loose recent changes.

> > > (And s2ram without sync _is_ "wrong": writeback timeouts are not
> > > honored).

> any kind of suspend can't meet this requirement. Even sys_sync is
> called, there is a small window that some pages are dirtied, but are not
> synced to disk in max expire interval, right?

Not if you do sys_sync() after freeze of userspace. (I'm not 100% sure
there's no race in there somewhere, but I'd prefer not to make the
race bigger.)
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
