From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -next] PM: Simplify the new suspend/hibernation
	framework for devices
Date: Thu, 9 Oct 2008 19:12:52 +0200
Message-ID: <20081009171252.GC1370@ucw.cz>
References: <200810060055.07601.rjw@sisk.pl> <200810062246.06654.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46477 "EHLO UNKNOWN"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758973AbYJIRNG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2008 13:13:06 -0400
Content-Disposition: inline
In-Reply-To: <200810062246.06654.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Hannes Reinecke <hare@suse.de>

On Mon 2008-10-06 22:46:05, Rafael J. Wysocki wrote:
> On Monday, 6 of October 2008, Rafael J. Wysocki wrote:
> > Hi Greg,
> > 
> > I promised at the KS that I would simplify the new suspend/hibernation
> > framework for devices to avoid the confusion with two types of PM
> > operations and pointers to PM operations from too many places.
> > 
> > The appended patch is intended for this purpose.  Unfortunately, I can't
> > split it into subsystem-related patches, because compilation would be broken
> > between them.
> > 
> > The patch applies to linux-next, but it's trivial to make it apply to the
> > mainline.  It's been compiled on x86 (both 32-bit and 64-bit) and tested
> > on hp nx6325, doesn't appear to break anything.
> 
> This one had a checkpatch.pl problem, sorry for that.  Updated patch is
> appended.

Seems ok to me. ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
