From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH - 2.6.19 -0/2] Backport of psmouse suspend/shutdown cleanups
Date: Wed, 21 Feb 2007 20:52:03 +0100
Message-ID: <20070221195203.GF3732@elf.ucw.cz>
References: <1172077685.10619.101.camel@d36.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58362 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161147AbXBUTyI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Feb 2007 14:54:08 -0500
Content-Disposition: inline
In-Reply-To: <1172077685.10619.101.camel@d36.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Stable <Stable@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi!

I'm not input or stable maintainer, but...

> I like to ask for inclusion into stable series for these.
> 
> The original patch from Dmitry can be found here:
> http://bugzilla.kernel.org/show_bug.cgi?id=7689
> comment #64, #65.
> 
> The reason is:
>  - These patches fix a lot weird stuff on all recent
>    HP nc/nx series laptop models.

Well, I'd call that "work around hardware problems in broken HP
laptops". There's HP BIOS bugzilla somewhere, perhaps we should fix it
that way?

>  - The problem with the psmouse thing is, if you booted
>    a broken kernel, rebooting a fixed one will still result
>    in a broken system (things break (or get fixed) on shutdown
>    and survive the reboot).
>    Therefore the patch(es) should get into as much kernels
>    as possible to avoid further confusions on bug reports...

Yes, it is quite nasty problem, but:

1) Fix is non-trivial (>100 lines, which violates -stable rule IIRC)

2) Fix is very disconnected from the problem. "Deinitialize mouse so
that fans work after reboot". WTF?

3) AFAICT it is not a regression.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
