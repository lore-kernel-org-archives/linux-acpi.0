From: David Brownell <david-b@pacbell.net>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Mon, 20 Nov 2006 10:46:06 -0800
Message-ID: <200611201046.07375.david-b@pacbell.net>
References: <B41635854730A14CA71C92B36EC22AAC5AD47B@mssmsx411> <200611181105.15421.david-b@pacbell.net> <200611182033.56332.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:5719 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966606AbWKTWPp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:45 -0500
In-Reply-To: <200611182033.56332.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Saturday 18 November 2006 8:33 pm, David Brownell wrote:
> On Saturday 18 November 2006 11:05 am, David Brownell wrote:
> > 
> > Running right now with a patch reverting the update which
> > made trouble on Linus' machine, but without Alexey's two
> > tweaks to the EC interrupt handler.  So far so good, even
> > after doing things which had previously caused AE_TIME
> > errors pretty quickly.  But then, the errors weren't what
> > I'd call reproducible either.
> 
> Hmm, well after a reboot to sort out some other patches,
> and at uptime of ~2 hours, I noticed confusion about
> whether AC or battery power was active, then the old:
> 
> ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
> ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
> ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE_TIME
> 
> So maybe that's not the entire story; sigh.

Whatever it is, it hasn't shown its ugly little face since then.
So while it doesn't seem completely fixed ... it's nowhere near
as broken as it was previously.

- Dave

