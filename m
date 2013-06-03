From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Add CMOS RTC Operation Region handler support
Date: Mon, 03 Jun 2013 21:29:33 +0200
Message-ID: <1702103.zGNy3bOjRH@vostro.rjw.lan>
References: <CA+8MBb+kgsOoM5UHTwJSivNW8Lsc96mTT-mM37vRQLBtrmh6+w@mail.gmail.com> <CA+8MBbJE7SKpDZRcX-0TipoQYeitq8eG3Eph+dDgsO5TpF5jdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57483 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989Ab3FCTUc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Jun 2013 15:20:32 -0400
In-Reply-To: <CA+8MBbJE7SKpDZRcX-0TipoQYeitq8eG3Eph+dDgsO5TpF5jdw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Monday, June 03, 2013 11:13:17 AM Tony Luck wrote:
> Oops - major Monday brain-fade on the linux-acpi address!
> 
> On Mon, Jun 3, 2013 at 11:11 AM, Tony Luck <tony.luck@gmail.com> wrote:
> > Building linux-next with tag "next-20130603" on ia64 I see these errors:
> >
> > In file included from drivers/acpi/acpi_cmos_rtc.c:17:
> > include/asm-generic/rtc.h: In function 'rtc_is_updating':
> > include/asm-generic/rtc.h:40: error: implicit declaration of function
> > 'CMOS_READ'
> > include/asm-generic/rtc.h: In function '__get_rtc_time':
> > include/asm-generic/rtc.h:85: error: 'RTC_ALWAYS_BCD' undeclared
> > (first use in this function)
> > include/asm-generic/rtc.h:85: error: (Each undeclared identifier is
> > reported only once
> > include/asm-generic/rtc.h:85: error: for each function it appears in.)
> > include/asm-generic/rtc.h: In function '__set_rtc_time':
> > include/asm-generic/rtc.h:165: error: 'RTC_ALWAYS_BCD' undeclared
> > (first use in this function)
> > include/asm-generic/rtc.h:175: error: implicit declaration of function
> > 'CMOS_WRITE'
> >
> > Maybe we just need to exclude this from being built for ia64?

Yes, we're going to do just that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
