From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/3] mfd: Add new mfd device TPS68470
Date: Fri, 28 Jul 2017 12:16:11 +0300
Message-ID: <CAHp75VffOr0Bs9jXoyF_FACfZCgD+D+tyE7tE_cdVUgZxqQn1g@mail.gmail.com>
References: <1500506426-3047-1-git-send-email-rajmohan.mani@intel.com>
 <1500506426-3047-2-git-send-email-rajmohan.mani@intel.com>
 <20170720090300.ayx5pz5l4yntefpt@dell> <6F87890CF0F5204F892DEA1EF0D77A59725DD60A@FMSMSX114.amr.corp.intel.com>
 <20170725091012.3hpxihekht2j35xb@dell> <CAHp75VeGqWNyDO644V+mje4sWsODDhyxRJ8cQ-HDV_e1hAUP3g@mail.gmail.com>
 <20170726082304.7j4lbvsuyyu7owqy@dell> <CAHp75VfCvNt2TdGRZ77Gk-j7KQzQTAyuKmvsna9GU5yNesGMkw@mail.gmail.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725DF8D6@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A59725DF8D6@FMSMSX114.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 28, 2017 at 3:30 AM, Mani, Rajmohan <rajmohan.mani@intel.com> wrote:
>> On Wed, Jul 26, 2017 at 11:23 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Tue, 25 Jul 2017, Andy Shevchenko wrote:
>> >> On Tue, Jul 25, 2017 at 12:10 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> >> I briefly checked few ->read() and ->write() implementations and
>> >> didn't find any evidence of positive numbers that can be returned.
>> >> Documentation (kernel doc) doesn't shed a light on that. So, to me it
>> >> sounds unspecified.
>> >>
>> >> So, for now (until documentation will be fixed) I would rely on if
>> >> (ret < 0)
>> >
>> > It's not unspecified.  The regmap methods call into regcache_write(),
>> > where the kerneldoc is clear.
>>
>
> Since, we are interested in the regmap for the I2C bus here, I looked into the implementation of
>  __devm_regmap_init()
>         __regmap_init()
>                 regcache_init()
> for I2C bus.
>
> At the end of __devm_regmap_init() call from devm_regmap_init_i2c() inside tps68470_probe(), I see that both cache_bypass and defer_caching flags of i2c regmap struct are set. So, it looks regcache_write/read calls do not come into play here.
>
> So, regmap_write()
>         _regmap_write()
>                 map->reg_write (drivers/base/regmap/regmap.c:1665) translates to
>                 regmap_i2c_write(drivers/base/regmap/regmap-i2c.c:128)
>
> These checks in regmap_i2c_write() ensure all return values from i2c_master_send() other than the requested number of bytes to write, are converted into negative values.
>
>         if (ret == count)
>                 return 0;
>         else if (ret < 0)
>                 return ret;
>         else
>                 return -EIO;
>
> Similar argument goes for regmap_read() as well.
> With that, for regmap over I2C bus, it sounds like 'if (ret < 0)' looks to be a better choice. Please see if I missed anything here.

It prooves exactly the Lee's point.

So, perhaps the best approach is to move to
if (ret)
 return ret;

...if it will be a problem in the future, fix it accordingly.

-- 
With Best Regards,
Andy Shevchenko
