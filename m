From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [ACPI] Re: Video memory corruption during suspend
Date: Thu, 22 Jul 2004 23:28:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040722212803.GA18164@hell.org.pl>
References: <20040718225247.GA30971@hell.org.pl> <20040722161047.GB15145@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267285AbUGVV2C@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040722161047.GB15145@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Thus wrote Pavel Machek:
> > My setup is:
> > ASUS L3800C laptop, Radeon M7, i845 chipset, using DRI and radeonfb.
[...]
> So what happens on 2.6.7 with swsusp1? Can you try vesafb (and fbdev
> Xserver)?

I don't have 2.6.7-vanilla at hand, but if 2.6.7-mm6 counts then yes,
swsusp1 also triggers that. Note that it doesn't seem to occur when DRI is
not actively used -- the radeon driver code takes quite a long time (up to
4 secs.) to switch to a text VT depending on circumstances, namely when KDE
is up. A plain windowmaker dekstop takes much shorter to switch.

As I'm leaving tomorrow, I won't have time to test with vesafb / fbdev
until next week.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
