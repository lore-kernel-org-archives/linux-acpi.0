From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Sat, 18 Nov 2006 14:09:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611181408320.3692@woody.osdl.org>
References: <B41635854730A14CA71C92B36EC22AAC5AD47B@mssmsx411>
 <Pine.LNX.4.64.0611180912090.3618@woody.osdl.org> <200611181105.15421.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:3976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755264AbWKRWNO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Nov 2006 17:13:14 -0500
In-Reply-To: <200611181105.15421.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org



On Sat, 18 Nov 2006, David Brownell wrote:
> 
> Running right now with a patch reverting the update which
> made trouble on Linus' machine, but without Alexey's two
> tweaks to the EC interrupt handler.  So far so good, even
> after doing things which had previously caused AE_TIME
> errors pretty quickly.  But then, the errors weren't what
> I'd call reproducible either.

Ok, goodie. 

Adrian, that means that there's one less regression on your list, unless 
David reports that he can reproduce it again (I don't think he will be 
able to: all the other ACPI changes looked relatively harmless, at least 
in the particular area of ACPI changes I looked at)

		Linus
