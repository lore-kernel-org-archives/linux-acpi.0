From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull request] ACPI patches for 2.6.34-rc6
Date: Fri, 7 May 2010 14:06:53 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071402080.901@i5.linux-foundation.org>
References: <alpine.LFD.2.00.1005062216430.10792@localhost.localdomain> <alpine.LFD.2.00.1005061926460.901@i5.linux-foundation.org> <20100507061203.GA8779@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43066 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755849Ab0EGVIz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 May 2010 17:08:55 -0400
In-Reply-To: <20100507061203.GA8779@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>



On Fri, 7 May 2010, Matthew Garrett wrote:
> 
> The spec says we can't. I've posted a patch to do so if it's still not 
> set after we've tried doing it the right way, but I'm not keen on 
> pushing it into a release at this point.

I'm ok with the "release at this point".

But the "spec says we can't" is utter GARBAGE. We _know_ the ACPI spec is 
broken, and almost no BIOSes really follow it. So "spec says" is not a 
game we play. 

The ACPI spec is toilet paper compared to "real world". And anybody who 
looks at the current DMI tables for "oh, do this" realizes that this is 
_not_ an uncommon thing, and should damn well realize that this means that 
clearly Windows doesn't honor the spec _either_.

At that point, the spec isn't just toilet paper, it's toilet paper that MS 
has wiped their butt on. So f*ck "spec says". 

> > There is _no_ reason not to force it. If the BIOS set it, it's a no-op. If 
> > the BIOS didn't set it, it's a bug that _must_ be fixed.
> 
> Kind of. The "correct" way to do it is to write to an ioport, and doing 
> that usually triggers an SMI.

The "correct" way to do it is to basically do what works, and that in turn 
generally means "do what Winddows does, because that's the only thing 
that ever got tested".

I'm perfectly happy with "try to do it the right way, and check the end 
result: and if SCI_EN still isn't set, do it by hand".

So I don't think we need to do the write _unconditionally_, but it sure as 
hell shouldn't be conditional on some DMI table. Because all the DMI table 
tells is is that we do it _wrong_ right now, since clearly Windows doesn't 
have this issue.

		Linus
