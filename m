From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Fri, 25 Dec 2009 18:09:44 +0100
Message-ID: <20091225170943.GB1581@ucw.cz>
References: <alpine.LFD.2.00.0912090728200.3560@localhost.localdomain> <Pine.LNX.4.44L0.0912091051450.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42783 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180AbZLYRJw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Dec 2009 12:09:52 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0912091051450.4120-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

Hi!

> > That's partly why I realy did suggest that we do the async stuff purely in 
> > the USB layer, rather than try to put it deeper in the device layer. And 
> > if we do support it "natively" in the device layer like Rafael's latest 
> > patch, I still think we should be very very nervous about making devices 
> > async unless there is a measured - and very noticeable - advantage.
> 
> Agreed.  Arjan's measurements indicated that USB was one of the biggest
> offenders; everything else other than the PS/2 mouse was much faster.  
> Given these results there isn't much incentive to do anything else
> asynchronously.
> 
> (However other devices not present on Arjan's machine may be a
> different story.  Spinning up multiple external disks is a good example 
> -- although here it may be necessary for the driver to take charge, 
> because spinning up a disk requires a lot of power and doing too many 
> of them at the same time could be bad.)

Well, system would better be able to supply enough current... because
usb disks auto-sleep on their own, and then something like async ls -l
/*/* would kill your machine...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
