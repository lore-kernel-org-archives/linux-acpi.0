From: Matt Mackall <mpm@selenic.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.22
Date: Mon, 30 Apr 2007 10:33:04 -0500
Message-ID: <20070430153304.GT11115@waste.org>
References: <200704290102.33533.lenb@kernel.org> <20070429010104.68c51d1a.akpm@linux-foundation.org> <20070429115244.GE11115@waste.org> <200704291417.02362.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:60059 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423399AbXD3PfV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Apr 2007 11:35:21 -0400
Content-Disposition: inline
In-Reply-To: <200704291417.02362.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Miles Lane <miles.lane@gmail.com>, lollul@wp.pl, Helge Hafting <helgehaf@aitel.hist.no>

On Sun, Apr 29, 2007 at 02:17:01PM +0200, Rafael J. Wysocki wrote:
> On Sunday, 29 April 2007 13:52, Matt Mackall wrote:
> > On Sun, Apr 29, 2007 at 01:01:04AM -0700, Andrew Morton wrote:
> > > On Sun, 29 Apr 2007 01:02:33 -0400 Len Brown <lenb@kernel.org> wrote:
> > > 
> > > > please pull from: 
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> > > > 
> > > > This batch mostly updates the platform-specific drivers that use ACPI.
> > > > The EC and sbs changes are primarily cleanups.
> > > > There are no changes to the ACPICA core, except a single bugfix
> > > > that was related to a 2.6.21 boot regression on some older machines.
> > > > And then the usual mix of random tweaks.
> > > 
> > > There might still be a few regressions in this lot:
> > > 
> > > - Miles Lane's "2.6.21-rc7-mm2 -- gnome-power-manager always shows the
> > >   power as coming from AC"
> > > 
> > > - "battery caching introduces a lock up"
> > >   http://bugzilla.kernel.org/show_bug.cgi?id=8351
> > > 
> > > These are older and might have been fixed:
> > > 
> > > - Mat Mackall's "Thinkpads not waking up on lid open with -rc6-mm1"
> > 
> > This seems to be related to suspend to disk. After the first suspend
> > to disk/resume, suspend to ram stops resuming from lid open and needs
> > me to hit the power button. As I just started using suspend to disk in
> > the past couple weeks, this may be a long-standing bug.
> > 
> > I think it's still present in -rc7-mm1 but I don't have my laptop
> > handy to double-check.
> 
> Can you please check if the appended debug patch helps?

Nope.

boot into new kernel
lid switch -> suspend
lid switch -> resume
power button -> hibernate
power button -> resume
lid switch -> suspend
lid switch -> nothing
power button -> resume
echo LID > /proc/acpi/wakeup -> "*disabled"
echo LID > /proc/acpi/wakeup -> "*enabled"
lid switch -> suspend
lid switch -> nothing

-- 
Mathematics is the supreme nostalgia of our time.
