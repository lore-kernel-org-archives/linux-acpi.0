From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Sun, 11 Jun 2017 22:43:31 +0300
Message-ID: <CAHp75VcyPy5kO+Ra-fPqaXZOp66sTe=L6W4UF00JWA6LP_KGeQ@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
 <CAHp75Vc6PSDqc=Vxj2z-d49p+E-7tciunhki=8a7HPjQGuSwXQ@mail.gmail.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF110@FMSMSX114.amr.corp.intel.com>
 <20170611113007.GV1019@valkosipuli.retiisi.org.uk> <CAHp75VeJaQjWb1834Nt7178GL72rcym=d3zV8tPpvJ5qKDuM_Q@mail.gmail.com>
 <20170611165028.GA12407@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170611165028.GA12407@valkosipuli.retiisi.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 11, 2017 at 7:50 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> On Sun, Jun 11, 2017 at 04:40:16PM +0300, Andy Shevchenko wrote:
>> On Sun, Jun 11, 2017 at 2:30 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:

>> > Again, I'm not really worried about this driver, but the ACPI tables. How
>> > does the difference show there?
>>
>> Same way. You will have common numbering over the chip [0, 9]. It will
>> be just an abstraction inside the driver.
>
> Oh, in that case that should be a non-issue.

>> Above states the opposite, so, it's clear to me that abstraction of 2
>> GPIO chips over 1 can be utilized here.
>
> Sounds fine to me, taken that this does not add complications to ACPI
> tables.

They just need to share the same ACPI_HANDLE (it might require to do
this in generic way in gpiolib) and have a continuous numbering (easy
to achieve with carefully chosen bases).

-- 
With Best Regards,
Andy Shevchenko
