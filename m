From: Pavel Machek <pavel@suse.cz>
Subject: Re: Why is arch/x86/kernel/acpi/sleep.c:temp_stack 10k?
Date: Thu, 9 Oct 2008 10:56:49 +0200
Message-ID: <20081009085649.GC29957@atrey.karlin.mff.cuni.cz>
References: <1222819957.13453.15.camel@calx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33673 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbYJII4u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 04:56:50 -0400
Content-Disposition: inline
In-Reply-To: <1222819957.13453.15.camel@calx>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org


> We've got:
> 
> #if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
> static char temp_stack[10240];
> #endif
> 
> and:
> 
> #ifdef CONFIG_SMP
>         stack_start.sp = temp_stack + 4096;
> #endif
> 
> ..which suggests we use at most 4k of the stack?

I guess someone (probably me) was "playing it safe" -- not exactly
remembering if stack grows down or up. I guess it should be safe to
change it... will do that.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
