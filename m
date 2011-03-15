From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] merge 32 and 64 realmode wakeup code
Date: Tue, 15 Mar 2011 20:31:06 +0100
Message-ID: <20110315193106.GA2379@ucw.cz>
References: <4D7D3F4B.2070801@free.fr>
 <201103132331.57536.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:60432 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932212Ab1COTbQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Mar 2011 15:31:16 -0400
Content-Disposition: inline
In-Reply-To: <201103132331.57536.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: matthieu castet <castet.matthieu@free.fr>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>

Hi!

> > -#ifdef CONFIG_SMP
> > -
> >  	.section ".x86_trampoline","a"
> >  	.balign PAGE_SIZE
> >  	.code16
> > @@ -79,5 +77,3 @@ ENTRY(trampoline_status)
> >  
> >  .globl trampoline_end
> >  trampoline_end:
> > -
> > -#endif /* CONFIG_SMP */
> 
> Apart from the remarks above it looks good.

Looks ok to me, too...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
