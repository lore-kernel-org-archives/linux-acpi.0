From: Liwei Song <liwei.song@windriver.com>
Subject: Re: [PATCH] ACPI, APEI: Fixup incorrect 16-bit access width firmware
 bug
Date: Wed, 26 Jul 2017 14:16:02 +0800
Message-ID: <597833A2.8090709@windriver.com>
References: <1500630080-18234-1-git-send-email-liwei.song@windriver.com> <CAHp75Vf5wpM4BW3umG5c1gHgmBEgD_+paYyvo6NTLGeEr9JB_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:48483 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdGZGP5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2017 02:15:57 -0400
In-Reply-To: <CAHp75Vf5wpM4BW3umG5c1gHgmBEgD_+paYyvo6NTLGeEr9JB_g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>



On 07/21/2017 05:56 PM, Andy Shevchenko wrote:
> On Fri, Jul 21, 2017 at 12:41 PM, Song liwei <liwei.song@windriver.com> wrote:
> 
>> [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0xb2/16/0/1/1]
>>
>> This is due to an 8-bit access width is specified for a 16-bit register,
>> Do bit_width check just like what the original commit have done.
> 
>>         else if (bit_width == 64 && bit_offset == 0 && (*paddr & 0x07) == 0 &&
>>             *access_bit_width < 64)
>>                 *access_bit_width = 64;
>> +       else if (bit_width == 16 && bit_offset == 0 && (*paddr & 0x01) == 0 &&
>> +           *access_bit_width < 16)
>> +               *access_bit_width = 16;
> 
> Wouldn't be better to rearrange that it will go in a sequence
> (16,32,64 or 64,32,16) ?
> 
> or move bit_offset == 0 into external condion
> 
>     /* Fixup common BIOS bug */
>     if (bit_offset == 0) {
>       if (bit_width == 16 && (*paddr & 0x01) == 0 && *access_bit_width < 16)
>                *access_bit_width = 16;
>       else if (bit_width == 32 && (*paddr & 0x03) == 0 &&
> *access_bit_width < 32)
>                *access_bit_width = 32;
>       else if (bit_width == 64 && (*paddr & 0x07) == 0 &&
> *access_bit_width < 64)
>                *access_bit_width = 64;
>     }
> 
> 
> It might be (I'm not sure it will make it better, just a side note)
> considered to convert each internal conditional to
> 
> ...if (bit_width == XX && (*paddr & YY) == 0)
>                *access_bit_width = max(*access_bit_width, bit_width);

Hi Andy,

Thanks for your suggestion, what about the condition like the following?
The main bug in bios is bit_width is not comfortable with access_bit_width
So check it first.

if (*access_bit_width < bit_width && bit_offset == 0) {
	if ((bit_width == 16 && (*paddr & 0x01) == 0) ||
	    (bit_width == 32 && (*paddr & 0x03) == 0) ||
	    (bit_width == 64 && (*paddr & 0x07) == 0))
		*access_bit_width = bit_width;
}


Thanks,
Liwei.


> 
