From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/3] mfd: Add new mfd device TPS68470
Date: Wed, 26 Jul 2017 13:26:30 +0300
Message-ID: <CAHp75VfCvNt2TdGRZ77Gk-j7KQzQTAyuKmvsna9GU5yNesGMkw@mail.gmail.com>
References: <1500506426-3047-1-git-send-email-rajmohan.mani@intel.com>
 <1500506426-3047-2-git-send-email-rajmohan.mani@intel.com>
 <20170720090300.ayx5pz5l4yntefpt@dell> <6F87890CF0F5204F892DEA1EF0D77A59725DD60A@FMSMSX114.amr.corp.intel.com>
 <20170725091012.3hpxihekht2j35xb@dell> <CAHp75VeGqWNyDO644V+mje4sWsODDhyxRJ8cQ-HDV_e1hAUP3g@mail.gmail.com>
 <20170726082304.7j4lbvsuyyu7owqy@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38530 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbdGZK0b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2017 06:26:31 -0400
In-Reply-To: <20170726082304.7j4lbvsuyyu7owqy@dell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>

On Wed, Jul 26, 2017 at 11:23 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 25 Jul 2017, Andy Shevchenko wrote:
>> On Tue, Jul 25, 2017 at 12:10 PM, Lee Jones <lee.jones@linaro.org> wrote:

>> I briefly checked few ->read() and ->write() implementations and
>> didn't find any evidence of positive numbers that can be returned.
>> Documentation (kernel doc) doesn't shed a light on that. So, to me it
>> sounds unspecified.
>>
>> So, for now (until documentation will be fixed) I would rely on
>> if (ret < 0)
>
> It's not unspecified.  The regmap methods call into regcache_write(),
> where the kerneldoc is clear.

drivers/base/regmap/regcache.c:266

" * Return a negative value on failure, 0 on success."

I can hardly find this any cleaner than "unspecified".

>  Perhaps we can also change the regmap
> kerneldoc headers too to match, which might lessen the disparity.

I'm not familiar with the guts of regmap API, so, I would stick with
if (ret < 0) for now until documentation specifies positive return values.

-- 
With Best Regards,
Andy Shevchenko
