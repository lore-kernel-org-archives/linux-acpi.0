From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI power down problem
Date: Thu, 13 Dec 2007 16:13:38 -0500
Message-ID: <200712131613.38456.lenb@kernel.org>
References: <20071207011852.GA2827@sbase.snet> <200712062251.01746.lenb@kernel.org> <20071212224053.GA3349@sbase.snet>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59168 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622AbXLMVNy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 16:13:54 -0500
In-Reply-To: <20071212224053.GA3349@sbase.snet>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephan Seidl <stephan.seidl@tu-dresden.de>
Cc: linux-acpi@vger.kernel.org

On Wednesday 12 December 2007 17:40, Stephan Seidl wrote:
> Dear Len,
> 2.6.17.4 with "maxcpus=1" does not switch off the power (still bad).
> 2.6.23.9 does switch off the power (works fine).
> So I am not sure what should be the next step,
> perhaps a simple Debian bug report.

Yes, since latest upstream stable kernel works fine,
it is a debian specific (and/or old upstream) issue.

You might try some of the older upstream kernels
to give the debian folks an idea of how much
newer than 2.6.18 they need to go to get the fix.

thanks,
-Len


> On Thu, Dec 06, 2007 at 10:51:01PM -0500, Len Brown wrote:
> > On Thursday 06 December 2007 20:18, Stephan Seidl wrote:
> > > Hi,
> > > I would like to ask two questions, but firstly some history.
> > > Normally Debian Sarge is running with the kernel 2.6.14.3 with several
> > > patches and all works fine since Dec 2005. In Jul, 2006, I tried another
> > > kernel, 2.6.17.4, again with several patches, and again all worked fine
> > > with the exception of the fact that the machine did not switch off the
> > > power on `/sbin/shutdown -t5 -h -P now'. So I rejected the kernel
> > > 2.6.17.4 hoping that the problems would disappear by itself with the time.
> > > But, it did not.
> > > In Aug 2007, Debian 4.0 r1 appeared with a kernel 2.6.18..., still
> > > having the power down problem. Obviously, the problem has been introduced
> > > between 2.6.14.3 and 2.6.17.4 and I am the only who has it. The concerning
> > > board can be described by
> > > 
> > >   Award Medallion BIOS v6.0, An Energy Star Ally
> > >   ASUS P4B ACPI BIOS Revision 1013 Beta 004
> > >   Award Plug and Play BIOS Extension v1.0A
> > > 
> > > This week, to tackle the problem, I addionally applied the patches
> > > in the attachment to have the console messages somewhat longer on the screen.
> > > I got the same output with the two kernels, 2.6.14.3 and 2.6.17.4, namely
> > > 
> > >   Power down.
> > >   acpi_power_off called
> > >    hwsleep-0284 [01] enter_sleep_state     : Entering sleep state [S5]
> > > 
> > > whereat the line numer 0284 changed to 0283 for 2.6.17.4.
> > > What in fact happens after the above has been seen for 20 seconds is that
> > > the same machine switches off in case of 2.6.14.3, and wrongly reboots in
> > > case of 2.6.17.4. Now the questions, firstly,
> > > is that a kernel bug ? From my point of view, yes, it seems to be one.
> > > Secondly, if I would more or less stupidly put the debugging into execution,
> > > is there anyone who could guide me, because in the ACPI kernel environment,
> > 
> > yes, it is a bug.
> > please try linux-2.6.23.stable and see if it still resets on poweroff there.
> > 
> > see if there is any difference when you boot with "maxcpus=1".
> > 
> > cheers,
> > -Len
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
