From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 2/3] Call RTC wake_on hook function when alarm is enabled
Date: Wed, 9 Apr 2008 00:48:52 -0700
Message-ID: <200804090048.52808.david-b@pacbell.net>
References: <1207722894.5997.18.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:35568 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752406AbYDIHva (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Apr 2008 03:51:30 -0400
In-Reply-To: <1207722894.5997.18.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Tuesday 08 April 2008, Zhao Yakui wrote:
> +=A0=A0=A0=A0=A0=A0=A0if (t->enabled)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (cmos->wake_on)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
cmos->wake_on(dev);

That looks ugly (bracketing) ... and suspicious in
terms of conformance to the RTC interface.

Shouldn't it be:

	if (t->enabled) {
		if (cmos->wake_on)
			cmos->wake_on(dev);
	} else {
		if (cmos->wake_off)
			cmos->wake_off(dev);
	}

instead?  Else I don't see what would disable the
alarm when it's supposed to be disabled.  Plus, if
that's done here, I suspect it also needs to be
done in rtc_ioctl() for RTC_AIE_{ON,OFF} and *NOT*
done in cmos_{suspend,resume)() ... very odd for a
wakeup hook, since none of those presume the system
is entering a state from which it could wake!

But in general this raises the question of how
to properly hook up to ACPI.  If ACPI's hook is for
normal alarm behavior (supplanting the RTC IRQ),
that's odd ... and it shouldn't fit into a hook
designed to ensure only that wake-from-sleep works.

At any rate, this patch clearly can't merge as-is.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
