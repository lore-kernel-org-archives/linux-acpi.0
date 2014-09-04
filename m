From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v5 1/2] Mailbox: Add support for Platform
 Communication Channel
Date: Thu, 4 Sep 2014 15:07:51 -0400
Message-ID: <CAJ5Y-eYg4aKT2adN8NaxFUtC_RnxhL8XWwcFi+=b=tkYojPhoQ@mail.gmail.com>
References: <1409782760-3958-1-git-send-email-ashwin.chaugule@linaro.org>
	<5470309.KpxVtJyk9p@wuerfel>
	<CAJ5Y-eYj4vv3rmyaEiO5e9fmbeHX0eM1S9OuNn5R=9dPza_39Q@mail.gmail.com>
	<4354903.8scPjxmpFT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:55093 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbaIDTHx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 15:07:53 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so10452262wgg.21
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 12:07:52 -0700 (PDT)
In-Reply-To: <4354903.8scPjxmpFT@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 4 September 2014 15:00, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 September 2014 13:24:25 Ashwin Chaugule wrote:
>> On 4 September 2014 04:56, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> >> +     /* Write to the shared comm region. */
>> >> +     iowrite16(cmd, &generic_comm_base->command);
>> >> +
>> >> +     /* Write Subspace MAGIC value so platform can identify destination. */
>> >> +     iowrite32((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
>> >> +
>> >> +     /* Flip CMD COMPLETE bit */
>> >> +     iowrite16(0, &generic_comm_base->status);
>> >
>> > using writel_relaxed/writew_relaxed should be more efficient here.
>> >
>>
>> x86 doesn't seem to have the write*_relaxed variants? They seem to
>> have read*_relaxed though.
>
> That sounds highly inconsistent and should probably be fixed.
>
> You could also use writew here, which would be the same as iowrite16
> on ARM, but more efficient on x86.

Used writel/writew in v6 of the patch.

Thanks,
Ashwin
