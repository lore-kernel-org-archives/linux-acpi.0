From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] ACPI: reduce code size, clean up, fix validator message
Date: Mon, 26 Jun 2006 18:35:44 +0200
Message-ID: <20060626163543.GB3257@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6CF0D04@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2195 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750775AbWFZQgb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Jun 2006 12:36:31 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6CF0D04@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>, michal.k.k.piotrowski@gmail.com, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Arjan van de Ven <arjan@infradead.org>

Hi!

> Thanks for the quick reply.
> 
> An Andrew's advice a while back, Bob already got rid
> of the allocate part -- it just isn't upstream yet.
> 
> Re: changing ACPICA code (sub-directories of drivers/acpi/) like this:
> 
> >-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
> >+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
> 
> I can't do that without either
> 1. diverging between Linux and ACPICA
> or
> 2. getting a license back from you to Intel such that Intel can
>    re-distrubute such a change under the Intel license on the file
>    and
>    inventing spin_lock_irqsave() on about 9 other operating systems.
> 
> #1 is all pain and no gain, unless the 244 net fewer bytes counts as
> gain.
> #2 wouldn't make sense either.

Well, gain here is that code actually becomes readable/linux
like/something.

Feel free to put GPL/BSD license in ACPICA code, saying that by
default contributed code is under both licenses.... or something, but
having linux-like code under drivers/acpi would be great.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
