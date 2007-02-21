From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH - 2.6.19 -0/2] Backport of psmouse suspend/shutdown cleanups
Date: Wed, 21 Feb 2007 21:44:40 +0100
Message-ID: <20070221204440.GK3732@elf.ucw.cz>
References: <1172077685.10619.101.camel@d36.suse.de> <20070221195203.GF3732@elf.ucw.cz> <d120d5000702211230s24b6ebdcja31ccb7359754931@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59131 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932564AbXBUUou (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Feb 2007 15:44:50 -0500
Content-Disposition: inline
In-Reply-To: <d120d5000702211230s24b6ebdcja31ccb7359754931@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, Stable <Stable@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Hi!

> On 2/21/07, Pavel Machek <pavel@ucw.cz> wrote:
> >
> >Yes, it is quite nasty problem, but:
> >
> >1) Fix is non-trivial (>100 lines, which violates -stable rule IIRC)
> >
> 
> The fix itself is only 30 lines (counting empty lines and comments)
> which is not too bad.

Well, one of stable rules is 

 - It cannot be bigger than 100 lines, with context.

I guess it meets all the other criteria... I think this is for stable
team to decide.

> >2) Fix is very disconnected from the problem. "Deinitialize mouse so
> >that fans work after reboot". WTF?
> 
> Can you imagine how I love this kind of bugs? ;)

Yep. But maybe we should force HP to fix their broken machines? They
even claim those machines are linux-certified (or suse-linux-certified
or something).... Shame on them.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
