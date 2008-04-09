From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC] [PATCH 2/3] Call RTC wake_on hook function when alarm is
	enabled
Date: Thu, 10 Apr 2008 01:29:13 +0800
Message-ID: <1207762153.4056.53.camel@yakui_zhao.sh.intel.com>
References: <1207722894.5997.18.camel@yakui_zhao.sh.intel.com>
	 <200804090048.52808.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33061 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbYDIJig (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 05:38:36 -0400
In-Reply-To: <200804090048.52808.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Wed, 2008-04-09 at 00:48 -0700, David Brownell wrote:
> On Tuesday 08 April 2008, Zhao Yakui wrote:
> > +       if (t->enabled)
> > +               if (cmos->wake_on)
> > +                       cmos->wake_on(dev);
> 
> That looks ugly (bracketing) ... and suspicious in
> terms of conformance to the RTC interface.
> 
> Shouldn't it be:
> 
> 	if (t->enabled) {
> 		if (cmos->wake_on)
> 			cmos->wake_on(dev);
> 	} else {
> 		if (cmos->wake_off)
> 			cmos->wake_off(dev);
> 	}
> 
> instead?  Else I don't see what would disable the
> alarm when it's supposed to be disabled.  Plus, if
> that's done here, I suspect it also needs to be
> done in rtc_ioctl() for RTC_AIE_{ON,OFF} and *NOT*
> done in cmos_{suspend,resume)() ... very odd for a
> wakeup hook, since none of those presume the system
> is entering a state from which it could wake!
If alarm is only used as the wake event source from sleeping state, it
is enough to call hook function in suspend/resume.
But if the system is booted with acpi enabled , I suspect whether RTC
alarm can trigger RTC IRQ. If the RTC alarm is dedicated as the wake
event source, it will be also OK to call the hook function when the
alarm is enabled. 
> But in general this raises the question of how
> to properly hook up to ACPI.  If ACPI's hook is for
> normal alarm behavior (supplanting the RTC IRQ),
> that's odd ... and it shouldn't fit into a hook
> designed to ensure only that wake-from-sleep works.
> 
> At any rate, this patch clearly can't merge as-is.
> 
> - Dave

