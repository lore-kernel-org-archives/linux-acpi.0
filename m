From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Sun, 1 Apr 2007 16:30:31 +0000
Message-ID: <20070401163031.GA5762@ucw.cz>
References: <460E0158.7090705@goop.org> <200703311131.54704.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1034 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933605AbXDAQas (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Apr 2007 12:30:48 -0400
Content-Disposition: inline
In-Reply-To: <200703311131.54704.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi!

> > When I run 2.6.21-rc5 + Andi's x86 patches + paravirt_ops patches, I've
> > been getting my machine shut down with critical thermal shutdown messages:
> 
> Hmm, don't think there's anything either in x86 that would touch this code.
> But can you double check with plain rc5? 
> 
> > Mar 30 23:19:03 localhost kernel: ACPI: Critical trip point
> > Mar 30 23:19:03 localhost kernel: Critical temperature reached (128 C), shutting down.
> > Mar 30 23:19:03 localhost kernel: Critical temperature reached (128 C), shutting down.
> > Mar 30 23:19:03 localhost shutdown[19417]: shutting down for system halt
> > 
> > and the machine does feel pretty hot.
> 
> Pavel has been complaining about higher power consumption on his laptop versus
> .20 too.

Yep, sometimes it takes 30W instead of 12W... Anyway, this seems to
be measurement error. Notice how acpi claims 128C. I do not think cpu
can work at 128C and hardware should kill us before cpu is that hot.

Are you running lm_sensors?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
