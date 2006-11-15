From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Wed, 15 Nov 2006 10:46:48 -0800
Message-ID: <200611151046.49066.david-b@pacbell.net>
References: <200611142303.47325.david-b@pacbell.net> <200611150248.12578.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:45931 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161745AbWKOVoN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Nov 2006 16:44:13 -0500
In-Reply-To: <200611150248.12578.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Tuesday 14 November 2006 11:48 pm, Len Brown wrote:
> On Wednesday 15 November 2006 02:03, David Brownell wrote:
> > dmesg reports to me stuff like
> > 
> > ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
> > ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPC0.BAT1._BIF] (Node ffff8100020368d0), AE_TIME
> > ACPI Exception (acpi_battery-0148): AE_TIME, Evaluating _BIF [20060707]
> > ACPI: read EC, IB not empty
> > ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
> > ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE_TIME
> 
> AE_TIME is generally used for timeout situations -- ie didn't get a semaphore within a certain period.
> 
> Any change if you boot with "ec_intr=0"?

That does seem to get rid of the AE_TIME messages; thanks!

Next I'll try that "ec1.patch" from Alex, without overriding ec_intr.

- Dave


> 
> thanks,
> -Len
> 
> > It never used to complain at all.  This is an amd64 laptop, and related symptoms
> > include
> > 
> >  - kpowersave not being able to monitor the batter or AC adapter correctly;
> >    leading to catastrophes like laptop powering itself off with no warning,
> >    loss of work, filesystem needing log recovery, and so forth.
> > 
> >  - Serious fan action.  Recent kernels seemed to finally be doing sane things
> >    so that e.g. just editing text kept the CPU cool ... but now it's on almost
> >    all the time, CPU is very hot.
> > 
> > What's an AE_TIME?
> > 
> > I'm not quite sure where these problems crept in, but I never saw such stuff with
> > 2.6.18 at all.
> > 
> > - Dave
> > 
> > 
