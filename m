From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Wed, 8 Feb 2006 20:10:51 +0000
Message-ID: <20060208201050.GA2353@ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com> <fad2c7740602030759i65e45a6as29964b8e90aeecd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37643 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965239AbWBIRG0
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Feb 2006 12:06:26 -0500
Content-Disposition: inline
In-Reply-To: <fad2c7740602030759i65e45a6as29964b8e90aeecd7@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juhani Rautiainen <juhani.rautiainen@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, Joerg Sommrey <jo@sommrey.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tony@atomide.com, erik@slagter.name, alan@lxorguk.ukuu.org.uk

On Fri 03-02-06 17:59:38, Juhani Rautiainen wrote:
> On 2/3/06, Brown, Len <len.brown@intel.com> wrote:
> >
> >
> > Certainly the BIOS writer also had access to that document, plus
> > documents we do not see, yet they decided NOT to enable C2/C3.
> 
> This comes from AMD-768 reveision guide. In product errata there there
> is errata number
> 24 which seems to suggest that you can't enable POS, C2 or C3 states
> in single processor
> environments. This at the end of errata:
> ----- snip ----
> This workaround will not work for awaking from the C2/C3 state, since
> the operating
> system has full control.

As far as I read this: they suggest to disable it in BIOS because
workaround is needed during wakeup and Windows do not have that
workaround. IOW the patch is safe, as long as workaround is
included. Good.
								Pavel

-- 
Thanks, Sharp!
