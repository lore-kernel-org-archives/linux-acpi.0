From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Wed, 9 Aug 2006 14:30:52 +0200
Message-ID: <20060809123052.GB3808@elf.ucw.cz>
References: <200608091426.31762.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750720AbWHIMbK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200608091426.31762.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-acpi@vger.kernel.org

Hi!
> 
> It looks like the CMOS clock gets corrupted during the suspend to disk
> on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> AMD64-based and the x86_64 kernel doesn't have this problem on it.
> 
> Also, I've done some tests that indicate the corruption doesn't occur before
> saving the suspend image.  It rather happens when the box is powered off
> or rebooted (tested both cases).
> 
> Unfortunately, I have no more time to debug it further right now.

Do you have Linus' "please corrupt my cmos for debuggin" hack enabled?
:-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
