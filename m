From: Pavel Machek <pavel@suse.cz>
Subject: Re: irqs_disabled() vs ACPI interpreter vs suspend
Date: Thu, 18 Dec 2008 17:55:25 +0100
Message-ID: <20081218165525.GE16115@elf.ucw.cz>
References: <20081125110508.GA1943@elf.ucw.cz> <200812170040.07977.rjw@sisk.pl> <alpine.LFD.2.00.0812180107150.17738@localhost.localdomain> <200812181732.18023.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38055 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbYLRQxg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2008 11:53:36 -0500
Content-Disposition: inline
In-Reply-To: <200812181732.18023.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>

Hi!

> > So it looks like we will indeed need something like the
> > patch to transform ACPI's use of GFP_KERNEL
> > to GFP_ATOMIC across late suspend
> > and early resume; to avoid warnings from
> > _GTS, _BFS, and irqrouter_resume use of kmalloc.
> 
> OK, so there are two possibilities, IMO.
> 
> Either we switch that in the suspend callbacks like in my patch #1, or we
> can add a bool variable that will be 'true' is the system is during

Do you mean acpi_gfp_flags? 

I think that's ugly, because not only gfp_flags need change during
late suspend (you may not sleep, for example). I'd prefer boolean.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
