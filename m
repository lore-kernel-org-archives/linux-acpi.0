From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/3] mfd: Add new mfd device TPS68470
Date: Tue, 25 Jul 2017 13:29:15 +0300
Message-ID: <CAHp75VeGqWNyDO644V+mje4sWsODDhyxRJ8cQ-HDV_e1hAUP3g@mail.gmail.com>
References: <1500506426-3047-1-git-send-email-rajmohan.mani@intel.com>
 <1500506426-3047-2-git-send-email-rajmohan.mani@intel.com>
 <20170720090300.ayx5pz5l4yntefpt@dell> <6F87890CF0F5204F892DEA1EF0D77A59725DD60A@FMSMSX114.amr.corp.intel.com>
 <20170725091012.3hpxihekht2j35xb@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38343 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdGYK3R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jul 2017 06:29:17 -0400
In-Reply-To: <20170725091012.3hpxihekht2j35xb@dell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>

On Tue, Jul 25, 2017 at 12:10 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 21 Jul 2017, Mani, Rajmohan wrote:
>> > On Wed, 19 Jul 2017, Rajmohan Mani wrote:

>> > > + /* Force software reset */
>> > > + ret = regmap_write(regmap, TPS68470_REG_RESET,
>> > TPS68470_REG_RESET_MASK);
>> > > + if (ret < 0)
>> >
>> > Will 'if (!ret)' do?
>> >
>>
>> We intend to check error conditions and bail out. So, if (ret < 0) works for this.
>
> Yes, 'if (!ret)' does that too.

Did you mean

if (ret)
 return ret;

?

I briefly checked few ->read() and ->write() implementations and
didn't find any evidence of positive numbers that can be returned.
Documentation (kernel doc) doesn't shed a light on that. So, to me it
sounds unspecified.

So, for now (until documentation will be fixed) I would rely on
if (ret < 0)


-- 
With Best Regards,
Andy Shevchenko
