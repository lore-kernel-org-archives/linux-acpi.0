From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Bank screen after resume on Dell XPS M1330
Date: Mon, 4 May 2009 00:05:52 +0200
Message-ID: <20090503220552.GC20166@elf.ucw.cz>
References: <200905031111.50789.arvidjaar@mail.ru> <20090503105932.GA18170@srcf.ucam.org> <20090503215740.GG1368@ucw.cz> <20090503215935.GA27257@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57923 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZECWCw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 May 2009 18:02:52 -0400
Content-Disposition: inline
In-Reply-To: <20090503215935.GA27257@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun 2009-05-03 22:59:35, Matthew Garrett wrote:
> On Sun, May 03, 2009 at 11:57:41PM +0200, Pavel Machek wrote:
> > On Sun 2009-05-03 11:59:32, Matthew Garrett wrote:
> > > On Sun, May 03, 2009 at 11:11:47AM +0400, Andrey Borzenkov wrote:
> > > > 01:00.0 VGA compatible controller: nVidia Corporation GeForce 8400M GS 
> > > > (rev a1)
> > > 
> > > We don't know how to reinitialise nvidia graphics hardware.
> > 
> > s2ram tool and/or Xserver may be able to reinit the video....
> 
> Not for current nivida, except for some Thinkpads.

Ok, that's bad. There still should be chance to reverse-engineer the
BIOS or tweak the emulation in libx86 until it works with the nvidias,
but... that's a lot of work.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
