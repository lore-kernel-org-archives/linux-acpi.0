From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation region driver
Date: Wed, 7 Jun 2017 16:37:12 +0300
Message-ID: <CAHp75Ve1GnJZH0KJDMdjHiEjNtpcsZgF6WnBHz+Bb9CDX2zYaQ@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com> <20170607120730.GZ1019@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33236 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdFGNhO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2017 09:37:14 -0400
In-Reply-To: <20170607120730.GZ1019@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Wed, Jun 7, 2017 at 3:07 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:

>> +static int ti_tps68470_pmic_get_power(struct regmap *regmap, int reg,
>> +                                    int bitmask, u64 *value)
>> +{
>> +     int data;
>
> Shouldn't you use unsigned int here? Same in the functions below.

+1, regmap_read() returns unsigned int.

>> +static acpi_status ti_pmic_common_handler(u32 function,
> +                                       acpi_physical_address address,
> +                                       u32 bits, u64 *value,
> +                                       void *handler_context,

> handler_context is unused.

>> +                                                  int, int, u64 *),
>> +                                       int (*update)(struct regmap *,
>> +                                                     int, int, u64),
>> +                                       struct ti_pmic_table *table,
>> +                                       int table_size)

I would even split this to have separate update() and get() paths
instead of having such a monster of parameters.

>> +static acpi_status ti_pmic_clk_freq_handler(u32 function,
>> +                                         acpi_physical_address address,
>> +                                         u32 bits, u64 *value,
>> +                                         void *handler_context,
>> +                                         void *region_context)
>> +{
>> +     return ti_pmic_common_handler(function, address, bits, value,
>> +                             handler_context, region_context,
>> +                             ti_tps68470_pmic_get_clk_freq,
>> +                             ti_tps68470_regmap_update_bits,
>> +                             (struct ti_pmic_table *) &clk_freq_table,
>
> You shouldn't use an explicit cast here. Instead make the function argument
> const as well and you're fine.

+1.

-- 
With Best Regards,
Andy Shevchenko
