From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: kacpi_notify?
Date: Thu, 13 Jul 2006 08:00:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607130754480.5623@g5.osdl.org>
References: <B41635854730A14CA71C92B36EC22AAC0907F8@mssmsx411>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:4030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030223AbWGMPAk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jul 2006 11:00:40 -0400
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC0907F8@mssmsx411>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>



On Thu, 13 Jul 2006, Starikovskiy, Alexey Y wrote:
> 
> I'm terribly sorry that my patch broke on your machine.
> May I ask you to send me or attach to #5534 output of acpidump from this
> machine?

I'll send it in another email, since I already generated it for Len ;)

> Do you think that the whole idea is crap, or if I limit number of
> possible spawned threads and forsibly put current thread to sleep (which
> will release ACPICA executer mutex), as it happens in DSDT of nx6125 it
> will be possible to use it?

I don't think the _idea_ is crap per se, but it would at a minimum need a 
thread limit. But I think it's the wrong approach: especially if you put 
the current thread to sleep, you really don't want another thread at all, 
you are really just working around a problem that is totally internal to 
acpi (and the AML interpreter in particular).

So I think the problem really lies elsewhere, and that the whole thread 
approach was trying to paper over it. And having a limited set of threads 
is probably potentially _worse_ then what we have now.

Is there no way to have the AML interpreter have some state, and just push 
that current interrupted state back onto the "event queue", and just start 
executing the new one instead? That sounds like it should fix the _real_ 
problem - a kind of "mini-scheduler" for ACPI events?

		Linus
