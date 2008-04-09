From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 2/3] Call RTC wake_on hook function when alarm is enabled
Date: Wed, 9 Apr 2008 03:08:40 -0700
Message-ID: <200804090308.40537.david-b@pacbell.net>
References: <1207722894.5997.18.camel@yakui_zhao.sh.intel.com> <200804090048.52808.david-b@pacbell.net> <1207762153.4056.53.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:41589 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752525AbYDIKIm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 06:08:42 -0400
In-Reply-To: <1207762153.4056.53.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Wednesday 09 April 2008, Zhao Yakui wrote:
>=20
> > instead? =A0Else I don't see what would disable the
> > alarm when it's supposed to be disabled. =A0Plus, if
> > that's done here, I suspect it also needs to be
> > done in rtc_ioctl() for RTC_AIE_{ON,OFF} and *NOT*
> > done in cmos_{suspend,resume)() ... very odd for a
> > wakeup hook, since none of those presume the system
> > is entering a state from which it could wake!
>=20
> If alarm is only used as the wake event source from sleeping state, i=
t
> is enough to call hook function in suspend/resume.

=46rom what other state could it "wake" though ???
It doesn't "wake" except from sleeping states...


> But if the system is booted with acpi enabled , I suspect whether RTC
> alarm can trigger RTC IRQ.

That is, you just "suspect" it won't work?  That seems
like a weak reason to change things.  And if RTC IRQs
don't actually work at runtime, that'd seem wierd.


> If the RTC alarm is dedicated as the wake=20
> event source, it will be also OK to call the hook function when the
> alarm is enabled.

Well, *today* the only client of that hook is ACPI.  But
if there's no actual need to call those wake hooks for
non-wake code paths, I'd sure rather avoid doing that...

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
