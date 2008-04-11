From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Thu, 10 Apr 2008 22:12:15 -0700
Message-ID: <200804102212.16151.david-b@pacbell.net>
References: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com> <200804102046.48082.david-b@pacbell.net> <1207917861.9448.42.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:38495 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752132AbYDKFMS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 01:12:18 -0400
In-Reply-To: <1207917861.9448.42.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Friday 11 April 2008, Zhao Yakui wrote:
>=20
> =A0 There is another question about the driver rtc and rtc-cmos.
> rtc driver is in drivers/char/ and rtc-cmos is in drivers/rtc/

A patch that's pending for 2.6.26 (in MM) makes sure that only
one of those can ever be configured.


> On some laptops the two drivers will share the same memory/irq resour=
ce,
> which will cause that rtc-cmos driver can't work well after the rtc
> driver is already loaded.(Of course RTC sys I/F isn't created in rtc
> driver.)

That's a configuration error.  If the new RTC framework is in
use, legacy drivers should not be used.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
