From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 6/6] gpiolib: acpi: Introduce NO_RESTRICTION quirk
Date: Wed, 29 Nov 2017 13:35:18 +0100
Message-ID: <CACRpkdY64u0T+BW_ACzZEr7cB+W1aixsn4ZB50EsBUJZttpMaw@mail.gmail.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
 <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
 <20171113115554.GY18997@lahna.fi.intel.com> <1510578648.25007.166.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1510578648.25007.166.camel@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 13, 2017 at 2:10 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2017-11-13 at 13:55 +0200, Mika Westerberg wrote:
>> On Fri, Nov 10, 2017 at 03:40:33PM +0200, Andy Shevchenko wrote:
>> > Allow to relax IoRestriction for certain cases.
>> >
>> > One of the use case is incorrectly cooked ACPI table where interrupt
>> > pin is
>> > defined with GpioIo() macro with IoRestrictionOutputOnly.
>> >
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> I think you should include user of this quirk in the patch series as
>> well. Otherwise it is pretty pointless to add random quirks without
>> real issues they are supposed to solve ;-)
>
> Something like below?

I bet this patch is already somewhere in my mailbox else just send
it separately. All these patches are applied.

Yours,
Linus Walleij
