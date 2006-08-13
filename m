From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Mon, 14 Aug 2006 00:33:19 +0200
Message-ID: <20060813223319.GE6231@elf.ucw.cz>
References: <200608091426.31762.rjw@sisk.pl> <200608092251.58062.rjw@sisk.pl> <20060810001232.GB4249@ucw.cz> <200608101415.21505.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35998 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751681AbWHMWdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Aug 2006 18:33:36 -0400
Content-Disposition: inline
In-Reply-To: <200608101415.21505.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Thu 2006-08-10 14:15:21, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday 10 August 2006 02:12, Pavel Machek wrote:
> > > > > > > It looks like the CMOS clock gets corrupted during the suspend to disk
> > > > > > > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > > > > > > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > > > > > > 
> > > > > > > Also, I've done some tests that indicate the corruption doesn't occur before
> > > > > > > saving the suspend image.  It rather happens when the box is powered off
> > > > > > > or rebooted (tested both cases).
> > > > > > > 
> > > > > > > Unfortunately, I have no more time to debug it further right now.
> > > > > > 
> > > > > > Do you have Linus' "please corrupt my cmos for debuggin" hack enabled?
> > > > > 
> > > > > Well, I know nothing about that. ;-)
> > > > 
> > > > CONFIG_PM_TRACE=y will scrog your CMOS clock each time you suspend.
> > > 
> > > Oh dear.  Of course it's set in my .config.  Thanks a lot for this hint. :-)
> > > 
> > > BTW, it's a dangerous setting, because some drivers get mad if the time after
> > > the resume appears to be earlier than the time before the suspend.  Also the
> > > timer .suspend/.resume routines aren't prepared for that.
> > 
> > Its config option should just go away. People comfortable using *that*
> > should just edit some header file. Rafael, could you do patch doing
> > something like that?
> 
> Just remove the option from Kconfig or the whole setting?

Removing it from Kconfig should be enough.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
