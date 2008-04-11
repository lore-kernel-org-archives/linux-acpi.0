From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Thu, 10 Apr 2008 22:13:47 -0700
Message-ID: <200804102213.47756.david-b@pacbell.net>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com> <200804090313.34805.david-b@pacbell.net> <1207825723.8704.26.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:34348 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750743AbYDKFNt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 01:13:49 -0400
In-Reply-To: <1207825723.8704.26.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Thursday 10 April 2008, Zhao Yakui wrote:
> At the same time there is another question about this.
> alm.enabled is related with AIE flag. When alarm is fired, the AIE fl=
ag
> won't be cleared automatically.

Are you sure?  I thought that bug was fixed... alarms
should be one-shot, not periodic.


> If we want to set alarm again, should we=20
> turn off the alarm firstly? =A0

As a rule, yes.  We want to present a portable model for
RTC alarms, which fire exactly once.  The PC/AT model,
with wildcarding for hh:mm:ss (and maybe MM:DD, allowed by
ACPI extensions) is not very portable.

(By the way, if someone wants to take rtc-cmos off my
hands, I'd be glad to offload it ... my interest was
just to try to get the PC platform to play in the same
RTC space the other Linux platforms do!)


> > That's a fair question. =A0I don't think there's a good answer
> > to that with today's infrastructure. =A0Arguably, there should
> > be the notion of a number of clients, each of which get told
> > when the alarm they request fires. =A0But today, there's only
> > a single alarm, and a single client.
>=20
> Agree. Now there is only one alarm and current infrastruture can't
> support more than two clients.

I don't see how it could be claimed to support two
clients.  The second one clobbers the first ...

Now, there *ARE* some RTCs that support multiple
alarms.  It's common in discrete I2C and SPI chips.
But that's a capability that's not currently exposed
by Linux; one of many, as noted in the current rtc(4)
man page (dated 2006-11-26 in my copy).

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
