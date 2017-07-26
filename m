From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ACPI, APEI: Fixup incorrect 16-bit access width firmware bug
Date: Wed, 26 Jul 2017 13:44:32 +0300
Message-ID: <CAHp75Vf2wSNwchQomTXntMXfJ0kMYjwadJqVGobxNpxFNuiwCw@mail.gmail.com>
References: <1500630080-18234-1-git-send-email-liwei.song@windriver.com>
 <CAHp75Vf5wpM4BW3umG5c1gHgmBEgD_+paYyvo6NTLGeEr9JB_g@mail.gmail.com> <597833A2.8090709@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33290 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdGZKod (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2017 06:44:33 -0400
In-Reply-To: <597833A2.8090709@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Liwei Song <liwei.song@windriver.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, Jul 26, 2017 at 9:16 AM, Liwei Song <liwei.song@windriver.com> wrote:
> On 07/21/2017 05:56 PM, Andy Shevchenko wrote:
>> On Fri, Jul 21, 2017 at 12:41 PM, Song liwei <liwei.song@windriver.com> wrote:

>>     /* Fixup common BIOS bug */
>>     if (bit_offset == 0) {
>>       if (bit_width == 16 && (*paddr & 0x01) == 0 && *access_bit_width < 16)
>>                *access_bit_width = 16;
>>       else if (bit_width == 32 && (*paddr & 0x03) == 0 &&
>> *access_bit_width < 32)
>>                *access_bit_width = 32;
>>       else if (bit_width == 64 && (*paddr & 0x07) == 0 &&
>> *access_bit_width < 64)
>>                *access_bit_width = 64;
>>     }

> Thanks for your suggestion, what about the condition like the following?
> The main bug in bios is bit_width is not comfortable with access_bit_width
> So check it first.
>
> if (*access_bit_width < bit_width && bit_offset == 0) {
>         if ((bit_width == 16 && (*paddr & 0x01) == 0) ||
>             (bit_width == 32 && (*paddr & 0x03) == 0) ||
>             (bit_width == 64 && (*paddr & 0x07) == 0))
>                 *access_bit_width = bit_width;
> }

Either works to me.

P.S. Less explicit case is to use bit operations to check those, i.e.
is_power_of_2(), fls().

-- 
With Best Regards,
Andy Shevchenko
