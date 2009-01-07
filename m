From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 03/15] ACPICA: move common private headers under
	kernel/acpi/acpica/
Date: Wed, 7 Jan 2009 23:10:17 +0100
Message-ID: <20090107221017.GD17917@elte.hu>
References: <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com> <c6b6f68232ab6da57e764c64b23b4649c4e7c463.1230719801.git.len.brown@intel.com> <20090102191451.GB14249@elte.hu> <alpine.LFD.2.00.0901021438060.3590@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:33814 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbZAGWKi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jan 2009 17:10:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901021438060.3590@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


* Len Brown <lenb@kernel.org> wrote:

> > If it goes there then IMHO the ACPI code needs to be cleaned up 
> > _significantly_ to not wrap native Linux calls like spinlocks, 
> > allocators, etc.
> 
> Are there different style guidelines for the src/kernel/
> directory versus other parts of the source tree?
> 
> The acpi/acpica/ sub-directory is a processed version of code that we 
> share with BSD, opensolaris, and every ACPI-capable OS on Earth besides 
> Microsoft's.  There is a huge commmon benefit to that sharing, and the 
> Linux community's tolerance of wrappers, shims, and other unconventional 
> things allows that sharing to work without an infinite amount of 
> additional make-work.

i still tend to regard kernel/* as the core Linux kernel, as code that can 
be improved infinitely (only subject to the laws of physics), without 
having to worry about how the ACPI spec wants certain things done.

The moment you bring in "this has to work on BSD, etc." arguments it will 
be a never ending excuse for crap. Standards tend to create the _worst_ 
possible code, because every vendor compromizes a bit on another vendor's 
crap, just to be able to get in their own important crap. So the more 
vendors there are in a standards group, the crappier the end result is 
technically.

Also, ACPI is an environment/bootstrap detail well placed under 
drivers/acpi/ - why should it move to kernel/acpi/ ? The fact that it's 
used widely is immaterial - by that argument we could move arch/x86/ to 
kernel/x86/, and we could move drivers/ata/ to kernel/ata/ as well. (they 
are probably even more widely deployed than ACPI)

	Ingo
