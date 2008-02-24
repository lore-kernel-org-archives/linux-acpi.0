From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: Introduce PM_EVENT_HIBERNATE (was: Re: i915 hibernation patch (was: Re: 2.6.25-rc2 System no longer ...))
Date: Sun, 24 Feb 2008 09:29:18 +0100
Message-ID: <20080224082917.GA4784@ucw.cz>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org> <b6a2187b0802222036i33d5bcc2n4e3bafd6d846cc09@mail.gmail.com> <200802231913.27592.rjw@sisk.pl> <alpine.LFD.1.00.0802231041510.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2059 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751573AbYBXI33 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Feb 2008 03:29:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802231041510.21332@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Chua <jeff.chua.linux@gmail.com>, Jesse Barnes <jesse.barnes@intel.com>, Romano Giannetti <romano@dea.icai.upcomillas.es>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Hi!

> Thanks, applied. 
> 
> With this, I also find that I dislike the use of suspend/resume for 
> freezing for STD a lot less. It's still too easy to get confused, but at 
> least now drivers always have total knowledge about what is really going 
> on. I'd not like this interface as a driver writer, but now it's not 
> fundamentally broken any more, just slightly confusing.

Heh, thanks :-).
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
