From: David Brownell <david-b@pacbell.net>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Sat, 18 Nov 2006 11:05:14 -0800
Message-ID: <200611181105.15421.david-b@pacbell.net>
References: <B41635854730A14CA71C92B36EC22AAC5AD47B@mssmsx411> <Pine.LNX.4.64.0611180912090.3618@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:9094 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753872AbWKRVdJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Nov 2006 16:33:09 -0500
In-Reply-To: <Pine.LNX.4.64.0611180912090.3618@woody.osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

> On Sat, 18 Nov 2006, Starikovskiy, Alexey Y wrote:
> 
> > Or may be because it fixes all the current AMD-HP notebooks? 

Whatever "it" is sure broke mine though... the one that's
currently on my lap!  :)


Running right now with a patch reverting the update which
made trouble on Linus' machine, but without Alexey's two
tweaks to the EC interrupt handler.  So far so good, even
after doing things which had previously caused AE_TIME
errors pretty quickly.  But then, the errors weren't what
I'd call reproducible either.

Linus' explanation of what went wrong looks compatible with
the symptoms I've seen, FWIW.

- Dave
