From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/15] ACPICA: move common private headers under
	kernel/acpi/acpica/
Date: Thu, 8 Jan 2009 11:03:04 -0500
Message-ID: <20090108160304.GA30619@infradead.org>
References: <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com> <c6b6f68232ab6da57e764c64b23b4649c4e7c463.1230719801.git.len.brown@intel.com> <20090102191451.GB14249@elte.hu> <alpine.LFD.2.00.0901021438060.3590@localhost.localdomain> <20090107221017.GD17917@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:43438 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbZAHQDL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 11:03:11 -0500
Content-Disposition: inline
In-Reply-To: <20090107221017.GD17917@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jan 07, 2009 at 11:10:17PM +0100, Ingo Molnar wrote:
> i still tend to regard kernel/* as the core Linux kernel, as code that can 
> be improved infinitely (only subject to the laws of physics), without 
> having to worry about how the ACPI spec wants certain things done.
> 
> The moment you bring in "this has to work on BSD, etc." arguments it will 
> be a never ending excuse for crap. Standards tend to create the _worst_ 
> possible code, because every vendor compromizes a bit on another vendor's 
> crap, just to be able to get in their own important crap. So the more 
> vendors there are in a standards group, the crappier the end result is 
> technically.
> 
> Also, ACPI is an environment/bootstrap detail well placed under 
> drivers/acpi/ - why should it move to kernel/acpi/ ? The fact that it's 
> used widely is immaterial - by that argument we could move arch/x86/ to 
> kernel/x86/, and we could move drivers/ata/ to kernel/ata/ as well. (they 
> are probably even more widely deployed than ACPI)

I agree.  acpi has no business under kernel/.

