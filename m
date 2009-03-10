From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] lenovo-sl-laptop : driver for review
Date: Tue, 10 Mar 2009 12:22:09 +0100
Message-ID: <20090310112209.GB1337@ucw.cz>
References: <20090216025918.66d7a466@leftboat.lan> <20090227132752.GG1482@ucw.cz> <20090228143711.GB17541@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39445 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbZCJLWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 07:22:22 -0400
Content-Disposition: inline
In-Reply-To: <20090228143711.GB17541@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexandre Rostovtsev <tetromino@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat 2009-02-28 11:37:11, Henrique de Moraes Holschuh wrote:
> On Fri, 27 Feb 2009, Pavel Machek wrote:
> > > +module_param(debug_ec, bool, S_IRUGO);
> > > +MODULE_PARM_DESC(debug_ec,
> > > +	"Present EC debugging interface in procfs. WARNING: writing to the "
> > > +	"EC can hang your system and possibly damage your hardware.");
> > 
> > Sounds dangerous and clearly does not belong to /proc. Please drop it.
> 
> ThinkPad ACPI also has one.  OTOH, we are fairly sure one cannot damage the
> standard ThinkPad hardware through the "IBM thinkpad-style" EC firmware, the
> EC sanity-checks things.  I suppose you could cause the box to go away for
> lunch and don't come back until a complete hardware reset, or hit one of the
> crash-the-EC-firmware bugs by accident, though.

Yeah but that interface still does not belong to /proc. Please drop it
from merge version at least. 

> > > +/*************************************************************************
> > > +    bluetooth sysfs - copied nearly verbatim from thinkpad_acpi.c
> > > + *************************************************************************/
> > 
> > That's quite a lot of code for verbatim copy; create shared helper?
> 
> Yeah, I am game.  But let's do it later on and not delay anything because of
> it, please.  I will start breaking thinkpad-acpi into multiple source files,
> and after that is done (should take a while, thinkpad-acpi is a big module
> with a LOT of subdriver interdependencies) we can look for the best way to
> reduce code duplication.

Well,  this monolith is quite long/hard to review. IMO it should be
split to make review easy. 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
