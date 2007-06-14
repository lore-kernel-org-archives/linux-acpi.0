From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Thu, 14 Jun 2007 19:56:59 +0000
Message-ID: <20070614195659.GE9442@ucw.cz>
References: <878xb35sje.fsf@goat.bogus.local> <20070612153102.GD5986@ucw.cz> <87fy4vmxva.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1832 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752294AbXFOMcN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jun 2007 08:32:13 -0400
Content-Disposition: inline
In-Reply-To: <87fy4vmxva.fsf@goat.bogus.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> >> resume from suspend to ram doesn't work for my laptop and never
> >> has. So, this is not a regression.
> [...]
> > Beeping patch? It is in -mm now. noapic nolapic and nosmp are useful,
> > too.
> 
> With the proprietary nvidia module, the laptop resumes, but the screen
> stays black. Meanwhile I tested the nvidiafb module, with identical
> results: machine comes back from suspend, but with a black screen. Now
> I cann ssh into it and do a proper shutdown or whatever. This is of
> course nonsatisfying and I'm still playing around.
> 
> I haven't tested noapic, nolapic so far. This is a UP kernel.

noapic/nolapic will not help with video issue. try s2ram from
suspend.sf.net.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
