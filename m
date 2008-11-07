From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.28-rc2-mm1: multiple BUG: scheduling while atomic:
	swapper, first in acpi_idle_enter_simple, then fbcon has problems
Date: Fri, 7 Nov 2008 11:44:20 +0100
Message-ID: <20081107104420.GB2146@elf.ucw.cz>
References: <20081106102309.GA334@atrey.karlin.mff.cuni.cz> <20081106093324.57d88a43.akpm@linux-foundation.org> <alpine.LFD.2.00.0811061354340.3106@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60034 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbYKGKmn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 05:42:43 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811061354340.3106@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, kernel list <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org

On Thu 2008-11-06 13:56:16, Len Brown wrote:
> 
> 
> > > ...kernel contains experimental version of HP accelerometer driver and
> > > new HP acclerometer LED, but hopefully they are not causing this?
> > > 
> > 
> > The trace is a bit of a mess, but we first hit problems around
> > acpi_idle(), so I'd be suspecting acpi, x86 or sched-type changes.
> 
> try "idle=poll" to run none of the ACPI idle code.
> or "idle=halt" to just flirt with the idle code.

I'll try that if the problem happens. I had problems twice on two
boots, but then it started to behave, so...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
