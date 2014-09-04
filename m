From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v5 1/2] Mailbox: Add support for Platform Communication Channel
Date: Thu, 4 Sep 2014 13:24:25 -0400
Message-ID: <CAJ5Y-eYj4vv3rmyaEiO5e9fmbeHX0eM1S9OuNn5R=9dPza_39Q@mail.gmail.com>
References: <1409782760-3958-1-git-send-email-ashwin.chaugule@linaro.org>
	<1409782760-3958-2-git-send-email-ashwin.chaugule@linaro.org>
	<5470309.KpxVtJyk9p@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:34111 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbaIDRY3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 13:24:29 -0400
Received: by mail-we0-f177.google.com with SMTP id u56so10404865wes.8
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 10:24:26 -0700 (PDT)
In-Reply-To: <5470309.KpxVtJyk9p@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>

On 4 September 2014 04:56, Arnd Bergmann <arnd@arndb.de> wrote:

>> +     /* Write to the shared comm region. */
>> +     iowrite16(cmd, &generic_comm_base->command);
>> +
>> +     /* Write Subspace MAGIC value so platform can identify destination. */
>> +     iowrite32((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
>> +
>> +     /* Flip CMD COMPLETE bit */
>> +     iowrite16(0, &generic_comm_base->status);
>
> using writel_relaxed/writew_relaxed should be more efficient here.
>

x86 doesn't seem to have the write*_relaxed variants? They seem to
have read*_relaxed though.

Ashwin
