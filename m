From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: Re: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
Date: Wed, 4 Jul 2018 15:00:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1807041459110.11004@fox.voss.local>
References: <93a290d7082ed2e4d3e2b91dc7f6e941c9242a41.1530600804.git.nikolaus.voss@loewensteinmedical.de> <CAHp75VcHDWFpxupECf+tgn7S1esJ6SyPtCXeKG93LDVKRv91mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcHDWFpxupECf+tgn7S1esJ6SyPtCXeKG93LDVKRv91mA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>
> Thanks for the patch, now I completely got it and agree on approach.
> Few comments below.
>
>> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
>> of_device_id table "compatible" strings in DSD, a pointer to the
>
> _DSD
>
>> corresponding DT table entry should be returned instead of a null
>> pointer. An acpi_device_id match still takes precedence.
>
>>  const void *acpi_device_get_match_data(const struct device *dev)
>>  {
>> -       const struct acpi_device_id *match;
>> +       const struct acpi_device_id *acpi_id = NULL;
>> +       const struct of_device_id *of_id = NULL;
>> +       const struct device_driver *drv = dev->driver;
>>
>> -       match = acpi_match_device(dev->driver->acpi_match_table, dev);
>> -       if (!match)
>
>> +       __acpi_match_device(acpi_companion_match(dev), drv->acpi_match_table,
>> +                           drv->of_match_table, &acpi_id, &of_id);
>
> Perhaps,
>
> bool match;
>
> match = __acpi_match_device(..);
> if (!match)
> return NULL;
>
> ...
>> +       if (acpi_id)
>> +               return (const void*)acpi_id->driver_data;
>> +       else if (of_id)
>> +               return (const void*)of_id->data;
>
> Actually (dbesides redundant 'else') there is no difference in which
> order you test these.
> Thus, perhaps
>
> if (of_id)
> return ...of_id...;
>
> return ...acpi_id...;
>
>> -       return (const void *)match->driver_data;
>>  }

Thanks for reviewing and feedback, posted v2...

Niko
