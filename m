From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 3/3] ACPI / PMIC: Add TI PMIC TPS68470 operation region driver
Date: Wed, 7 Jun 2017 16:40:13 +0300
Message-ID: <CAHp75Vef=c54O8Xd+aM+eWWVt7nLsczT48WbgrdiOVyWv6xMcg@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-4-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VcvV_AbLJCq9Rm_8yab3nViPm6ikxxme4oyw9vm4Kz7Gg@mail.gmail.com> <20170607121503.GA1019@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34515 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdFGNkU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2017 09:40:20 -0400
In-Reply-To: <20170607121503.GA1019@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Wed, Jun 7, 2017 at 3:15 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> On Tue, Jun 06, 2017 at 05:23:56PM +0300, Andy Shevchenko wrote:
>> Follow the pattern, please, I suppose
>> ti_pmic_tps68470.c
>
> This pattern is weird. "ti" in front of the file name is redundant, and in
> very few places the vendor prefix is used anyway. Especially when the chip
> has a proper name --- as this one does.
>
> I assume for the Intel PMICs it could be there for a couple of reasons which
> are
>
> 1) lack of a clearly unique chip ID and
>
> 2) the use of common frameworklet for Intel PMICs.
>
> There are also no other PMIC chips supported currently.
>
> The pmic_tps68470 naming is in line with the GPIO driver (apart from the
> dash / underscore difference).

Since

% git ls-files *pmic*

returns somewhat interesting results, I would even go further and use

tps68470.c here

and

s/ti_pmic/tps6840/g

inside the file.

Would it work for you?

-- 
With Best Regards,
Andy Shevchenko
