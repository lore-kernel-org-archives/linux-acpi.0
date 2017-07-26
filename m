From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/3] mfd: Add new mfd device TPS68470
Date: Wed, 26 Jul 2017 09:23:04 +0100
Message-ID: <20170726082304.7j4lbvsuyyu7owqy@dell>
References: <1500506426-3047-1-git-send-email-rajmohan.mani@intel.com>
 <1500506426-3047-2-git-send-email-rajmohan.mani@intel.com>
 <20170720090300.ayx5pz5l4yntefpt@dell>
 <6F87890CF0F5204F892DEA1EF0D77A59725DD60A@FMSMSX114.amr.corp.intel.com>
 <20170725091012.3hpxihekht2j35xb@dell>
 <CAHp75VeGqWNyDO644V+mje4sWsODDhyxRJ8cQ-HDV_e1hAUP3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36435 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdGZIXI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2017 04:23:08 -0400
Received: by mail-wr0-f177.google.com with SMTP id y43so128323506wrd.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2017 01:23:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHp75VeGqWNyDO644V+mje4sWsODDhyxRJ8cQ-HDV_e1hAUP3g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>

On Tue, 25 Jul 2017, Andy Shevchenko wrote:

> On Tue, Jul 25, 2017 at 12:10 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Fri, 21 Jul 2017, Mani, Rajmohan wrote:
> >> > On Wed, 19 Jul 2017, Rajmohan Mani wrote:
> 
> >> > > + /* Force software reset */
> >> > > + ret = regmap_write(regmap, TPS68470_REG_RESET,
> >> > TPS68470_REG_RESET_MASK);
> >> > > + if (ret < 0)
> >> >
> >> > Will 'if (!ret)' do?
> >> >
> >>
> >> We intend to check error conditions and bail out. So, if (ret < 0) works for this.
> >
> > Yes, 'if (!ret)' does that too.
> 
> Did you mean
> 
> if (ret)
>  return ret;
> 
> ?

Yes, I just noticed!

Apologies for the confusion.

> I briefly checked few ->read() and ->write() implementations and
> didn't find any evidence of positive numbers that can be returned.
> Documentation (kernel doc) doesn't shed a light on that. So, to me it
> sounds unspecified.
> 
> So, for now (until documentation will be fixed) I would rely on
> if (ret < 0)

It's not unspecified.  The regmap methods call into regcache_write(),
where the kerneldoc is clear.  Perhaps we can also change the regmap
kerneldoc headers too to match, which might lessen the disparity.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
