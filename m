From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [RFC] [PATCH 2/3] Call RTC wake_on hook function when alarm is
	enabled
Date: Thu, 10 Apr 2008 10:15:45 +0800
Message-ID: <1207793745.27304.27.camel@acpi-hp-zz.sh.intel.com>
References: <1207722894.5997.18.camel@yakui_zhao.sh.intel.com>
	 <200804090048.52808.david-b@pacbell.net>
	 <1207762153.4056.53.camel@yakui_zhao.sh.intel.com>
	 <200804090308.40537.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49422 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbYDJCed (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 22:34:33 -0400
In-Reply-To: <200804090308.40537.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org


On Wed, 2008-04-09 at 18:08 +0800, David Brownell wrote:
> On Wednesday 09 April 2008, Zhao Yakui wrote:
> >
> > > instead?  Else I don't see what would disable the
> > > alarm when it's supposed to be disabled.  Plus, if
> > > that's done here, I suspect it also needs to be
> > > done in rtc_ioctl() for RTC_AIE_{ON,OFF} and *NOT*
> > > done in cmos_{suspend,resume)() ... very odd for a
> > > wakeup hook, since none of those presume the system
> > > is entering a state from which it could wake!
> >
> > If alarm is only used as the wake event source from sleeping state,
> it
> > is enough to call hook function in suspend/resume.
> 
> From what other state could it "wake" though ???
> It doesn't "wake" except from sleeping states...
> 
> 
> > But if the system is booted with acpi enabled , I suspect whether
> RTC
> > alarm can trigger RTC IRQ.
> 
> That is, you just "suspect" it won't work?  That seems
> like a weak reason to change things.  And if RTC IRQs
> don't actually work at runtime, that'd seem wierd.
> 
> 
> > If the RTC alarm is dedicated as the wake
> > event source, it will be also OK to call the hook function when the
> > alarm is enabled.
> 
> Well, *today* the only client of that hook is ACPI.  But
> if there's no actual need to call those wake hooks for
> non-wake code paths, I'd sure rather avoid doing that...
Reasonable.
As the ACPI wakup event of RTC is useless at runtime, it's okay with me
to drop this patch.

thanks,
rui

