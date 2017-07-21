From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ACPI, APEI: Fixup incorrect 16-bit access width firmware bug
Date: Fri, 21 Jul 2017 12:56:17 +0300
Message-ID: <CAHp75Vf5wpM4BW3umG5c1gHgmBEgD_+paYyvo6NTLGeEr9JB_g@mail.gmail.com>
References: <1500630080-18234-1-git-send-email-liwei.song@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33032 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753762AbdGUJ4S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2017 05:56:18 -0400
In-Reply-To: <1500630080-18234-1-git-send-email-liwei.song@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Song liwei <liwei.song@windriver.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Fri, Jul 21, 2017 at 12:41 PM, Song liwei <liwei.song@windriver.com> wrote:

> [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0xb2/16/0/1/1]
>
> This is due to an 8-bit access width is specified for a 16-bit register,
> Do bit_width check just like what the original commit have done.

>         else if (bit_width == 64 && bit_offset == 0 && (*paddr & 0x07) == 0 &&
>             *access_bit_width < 64)
>                 *access_bit_width = 64;
> +       else if (bit_width == 16 && bit_offset == 0 && (*paddr & 0x01) == 0 &&
> +           *access_bit_width < 16)
> +               *access_bit_width = 16;

Wouldn't be better to rearrange that it will go in a sequence
(16,32,64 or 64,32,16) ?

or move bit_offset == 0 into external condion

    /* Fixup common BIOS bug */
    if (bit_offset == 0) {
      if (bit_width == 16 && (*paddr & 0x01) == 0 && *access_bit_width < 16)
               *access_bit_width = 16;
      else if (bit_width == 32 && (*paddr & 0x03) == 0 &&
*access_bit_width < 32)
               *access_bit_width = 32;
      else if (bit_width == 64 && (*paddr & 0x07) == 0 &&
*access_bit_width < 64)
               *access_bit_width = 64;
    }


It might be (I'm not sure it will make it better, just a side note)
considered to convert each internal conditional to

...if (bit_width == XX && (*paddr & YY) == 0)
               *access_bit_width = max(*access_bit_width, bit_width);

-- 
With Best Regards,
Andy Shevchenko
