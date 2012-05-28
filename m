From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH resend] rtc-cmos: report wakeup event on ACPI RTC alarm
Date: Mon, 28 May 2012 16:51:55 -0600
Message-ID: <CAMLZHHQq-vxbmm2-qK1ZH5D8Rii1btuUR-HFu_p0_7qP1hA74w@mail.gmail.com>
References: <20120509231845.0301C9D401E@zog.reactivated.net>
	<201205102206.42891.rjw@sisk.pl>
	<4FBADFFE.7030508@linaro.org>
	<201205221712.07797.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56410 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2E1Wvz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 May 2012 18:51:55 -0400
In-Reply-To: <201205221712.07797.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: John Stultz <john.stultz@linaro.org>, Len Brown <lenb@kernel.org>, a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, pgf@laptop.org

On Tue, May 22, 2012 at 9:12 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Seems reasonable. Although could this maybe be done more generically at
>> the rtc infrastructure level instead of in the rtc-cmos driver?
>
> I think it could, but it can be moved to the RTC layer later too.

I don't think there is much you can win by making it generic - the
event has to be caught via the ACPI subsystem.

Instead of calling pm_wakeup_event() directly you could add a generic
RTC function to do the exact same thing, but I don't see the need to
hide wakeup event generation in a RTC-level API.

Rafael, is this OK for 3.5?

Thanks,
Daniel
