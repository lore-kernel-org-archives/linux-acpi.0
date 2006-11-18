From: Adrian Bunk <bunk@stusta.de>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Sat, 18 Nov 2006 23:16:27 +0100
Message-ID: <20061118221627.GD31879@stusta.de>
References: <B41635854730A14CA71C92B36EC22AAC5AD47B@mssmsx411> <Pine.LNX.4.64.0611180912090.3618@woody.osdl.org> <200611181105.15421.david-b@pacbell.net> <Pine.LNX.4.64.0611181408320.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7185 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755268AbWKRWQ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Nov 2006 17:16:29 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611181408320.3692@woody.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Sat, Nov 18, 2006 at 02:09:56PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 18 Nov 2006, David Brownell wrote:
> > 
> > Running right now with a patch reverting the update which
> > made trouble on Linus' machine, but without Alexey's two
> > tweaks to the EC interrupt handler.  So far so good, even
> > after doing things which had previously caused AE_TIME
> > errors pretty quickly.  But then, the errors weren't what
> > I'd call reproducible either.
> 
> Ok, goodie. 
> 
> Adrian, that means that there's one less regression on your list, unless 
> David reports that he can reproduce it again (I don't think he will be 
> able to: all the other ACPI changes looked relatively harmless, at least 
> in the particular area of ACPI changes I looked at)

I had already removed it from my list based on David's email.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

