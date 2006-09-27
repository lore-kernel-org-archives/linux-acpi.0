From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: Wed, 27 Sep 2006 13:35:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271329080.3952@g5.osdl.org>
References: <200609271424.47824.eike-kernel@sf-tec.de>
 <pan.2006.09.27.17.56.13.80913@automagically.de> <20060927184037.GA3306@athena.road.mcmartin.ca>
 <p73fyedje0f.fsf@verdi.suse.de> <Pine.LNX.4.64.0609271320580.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:45286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030780AbWI0Ufy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 16:35:54 -0400
In-Reply-To: <Pine.LNX.4.64.0609271320580.3952@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@osdl.org



On Wed, 27 Sep 2006, Linus Torvalds wrote:
> 
> On Wed, 27 Sep 2006, Andi Kleen wrote:
> > 
> > I expect this patch to fix it.
> 
> Andrew, Kyle, can you verify?

Not that it really matters. Andi sure as hell pinpointed a real problem 
with the new and broken inline asm. That's almost certainly the bug that 
crept in during the recent rewrite.

HOWEVER, now that I look more closely at the rewrite, I'm really wondering 
whether the rewrite was worth it at all. It generates smaller code, but at 
the expense of

 - the actual cache-footprint is bigger
 - the branch will now be mis-predicted by default

Since the "smaller code" really only tends to matter from a cache 
usage standpoint, I don't know if I'm at all convinced.

The fact that rewinders have problems is fairly immaterial. Maybe we 
should just take this as a hint that all the stupid rewinding code was 
wrong in the first place, and we should stop doing that? We can go back 
to just printing out our stacktrace guesses, that has worked for us for a 
long time, and the stack unwinding simply looks _fundamentally_ flawed.

So I have a real urge to just revert that change anyway.

Are there any _real_ advantages to this broken unwinding code that has had 
more bugs that Windows XP?

		Linus
