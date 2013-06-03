From: Tony Luck <tony.luck@gmail.com>
Subject: Re: Add CMOS RTC Operation Region handler support
Date: Mon, 3 Jun 2013 11:13:17 -0700
Message-ID: <CA+8MBbJE7SKpDZRcX-0TipoQYeitq8eG3Eph+dDgsO5TpF5jdw@mail.gmail.com>
References: <CA+8MBb+kgsOoM5UHTwJSivNW8Lsc96mTT-mM37vRQLBtrmh6+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:48569 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041Ab3FCSNS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jun 2013 14:13:18 -0400
Received: by mail-vb0-f43.google.com with SMTP id e15so1345572vbg.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jun 2013 11:13:17 -0700 (PDT)
In-Reply-To: <CA+8MBb+kgsOoM5UHTwJSivNW8Lsc96mTT-mM37vRQLBtrmh6+w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Oops - major Monday brain-fade on the linux-acpi address!

On Mon, Jun 3, 2013 at 11:11 AM, Tony Luck <tony.luck@gmail.com> wrote:
> Building linux-next with tag "next-20130603" on ia64 I see these errors:
>
> In file included from drivers/acpi/acpi_cmos_rtc.c:17:
> include/asm-generic/rtc.h: In function 'rtc_is_updating':
> include/asm-generic/rtc.h:40: error: implicit declaration of function
> 'CMOS_READ'
> include/asm-generic/rtc.h: In function '__get_rtc_time':
> include/asm-generic/rtc.h:85: error: 'RTC_ALWAYS_BCD' undeclared
> (first use in this function)
> include/asm-generic/rtc.h:85: error: (Each undeclared identifier is
> reported only once
> include/asm-generic/rtc.h:85: error: for each function it appears in.)
> include/asm-generic/rtc.h: In function '__set_rtc_time':
> include/asm-generic/rtc.h:165: error: 'RTC_ALWAYS_BCD' undeclared
> (first use in this function)
> include/asm-generic/rtc.h:175: error: implicit declaration of function
> 'CMOS_WRITE'
>
> Maybe we just need to exclude this from being built for ia64?
> Otherwise some extensive surgery is needed as ia64 doesn't
> have CMOS_READ() etc.
>
> -Tony
