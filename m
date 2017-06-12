From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/3] mfd: Add new mfd device TPS68470
Date: Mon, 12 Jun 2017 12:16:01 +0300
Message-ID: <CAHp75VfKpJEE9WDPsULF3FPEwH837iHS=ZXC=xAPLJjMaEUunQ@mail.gmail.com>
References: <1497161395-36504-1-git-send-email-rajmohan.mani@intel.com>
 <1497161395-36504-2-git-send-email-rajmohan.mani@intel.com>
 <CAHp75VdJh13-_cpk07v7Jp4LiOQa_OM7PPF6XR0ifBTRpX9hZg@mail.gmail.com> <6F87890CF0F5204F892DEA1EF0D77A59725BF43C@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35060 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdFLJQC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2017 05:16:02 -0400
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A59725BF43C@FMSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Mon, Jun 12, 2017 at 12:12 PM, Mani, Rajmohan
<rajmohan.mani@intel.com> wrote:

>> > +#include <linux/i2c.h>
>>
>> And this is for...?

> use by tps68470.c which uses i2c_driver and other such i2c defines.

It should be in C-file, not in the header which has nothing to do with I2C APIs.

-- 
With Best Regards,
Andy Shevchenko
