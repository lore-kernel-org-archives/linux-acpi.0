From: Pavel Machek <pavel@suse.cz>
Subject: Re: acpi_evaluate_integer broken by design
Date: Thu, 27 Nov 2008 14:56:51 +0100
Message-ID: <20081127135651.GA6104@atrey.karlin.mff.cuni.cz>
References: <20081125110508.GA1943@elf.ucw.cz> <20081126132050.cecb170b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33994 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbYK0N4w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 08:56:52 -0500
Content-Disposition: inline
In-Reply-To: <20081126132050.cecb170b.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

Hi!

> > Subject: acpi_evaluate_integer broken by design
> 
> Please don't give patches daft and not very meaningful titles.  It just
> means that someone else has to invent a useful title and then we get
> the same patch floating about with two different titles.

Sorry. I was kind of angry at that code because it does not contain
any remarks when it is okay to call it, etc.

> > Date: 	Tue, 25 Nov 2008 12:05:08 +0100
> > Sender: linux-kernel-owner@vger.kernel.org
> > User-Agent: Mutt/1.5.18 (2008-05-17)
> >
> > 
> > Now I know why I had strange "scheduling in atomic" problems:
> > acpi_evaluate_integer() does malloc(..., irqs_disabled() ? GFP_ATOMIC
> > : GFP_KERNEL)... which is (of course) broken.
> 
> That is kinda weird.  When did this all start happening?

With the HP LED driver... so this is "would be nice for 2.6.28, not
worth backporting" material.

> > There's no way to reliably tell if we need GFP_ATOMIC or not from
> > code, this one for example fails to detect spinlocks held.
> > 
> > Fortunately, allocation seems small enough to be done on stack.
> 
> It's 24 bytes in an x86_64 allmodconfig build.  Clearly it should be a
> local.

Yep.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
