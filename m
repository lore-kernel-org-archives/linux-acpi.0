From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Date: Wed, 6 Apr 2005 17:22:21 -0400 (EDT)
Message-ID: <20050406212221.75716.qmail@web88010.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262331AbVDFVWZ@vger.kernel.org>
In-Reply-To: 6667
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org


Yeah, I can do that, I don't need angry programmers
chasing after me :-)

Shawn.

--- Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > So nobody minds if I make this into a CONFIG
> option marked as Deprecated? :)
> 
> Actually it should probably go through
> 
> Documentation/feature-removal-schedule.txt
> 
> ...and give it *long* timeout, since it is API
> change.
> 									Pavel
> -- 
> People were complaining that M$ turns users into
> beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb
> yvxr vg gung jnl!
> 
