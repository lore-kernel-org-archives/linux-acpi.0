From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [RESEND patch 2.6.25] ACPI uses device_may_wakeup() policy inputs
Date: Tue, 29 Apr 2008 16:38:30 -0700
Message-ID: <200804291638.30469.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0804280941440.3566-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:48702 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754342AbYD2Xie (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 19:38:34 -0400
In-Reply-To: <Pine.LNX.4.44L0.0804280941440.3566-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

On Monday 28 April 2008, Alan Stern wrote:
> On Mon, 28 Apr 2008, Zhang Rui wrote:
> 
> > This may cause some "regressions", something like system resumes
> > immediately after enter S3. This should rather be a driver/device
> > problem which rises a wake up event when it's suspend.
> > The right thing to do is to disable the wake up flag for this device.
> > The patch was dropped for this reason last time it's merged and we
> > should take good care of it this time. :)

Actually that oversimplifies the problem.  The system that
was issuing wake events should not have been issuing them.

That seemed to me at the time, and still does seem to me,
like an ACPI problem ... especially since most other systems
behaved just fine.  I have one observation I'll share in a
separate message, which _might_ shed some light on this.


> Indeed, it's easy to imagine a situation where somebody suspends their 
> laptop and then unplugs a USB mouse, thereby causing a wakeup event.

It's also easy to imagine getting used to unplugging
such devices *first* ... :)


> I suspect many PCI devices should be disabled for remote wakeup during 
> system sleeps.

I wouldn't say that it's "PCI devices".  Remember, these
patches only change ACPI behavior ... making it act more
like non-ACPI systems.  If there's any change, in defaults
it should not be a global "for all PCI devices" one ... it
should be limited (and temporary!) for some ACPI devices.

The situation is that *currently* ACPI is configured so
that it's acts unlike non-ACPI systems:  wakeup isn't
enabled.  And in at least some systems, it doesn't work
when it's enabled either.

One can argue about how to deal with that breakage.  It
seems likely to me that -- since this ACPI wakeup code
has hardly ever been used on Linux -- using it will turn
up bugs in the ACPI stack.  At which point a significant
question is:  how are those bugs ever going to be found
and fixed, if ACPI never actually turns on its wakeup
mechanisms?

- Dave

