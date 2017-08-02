From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/7] gpio: Cleanup kerneldoc
Date: Wed, 2 Aug 2017 14:04:43 +0200
Message-ID: <CACRpkdb28ndwQr1SjOKcoAWm+KccdhO_vFLejBOPX6xhtSiPgg@mail.gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com> <20170731110217.GK26667@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170731110217.GK26667@ulmo>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 31, 2017 at 1:02 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Jul 24, 2017 at 04:57:22PM +0200, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Some kerneldoc has become stale or wasn't quite correct from the outset.
>> Fix up the most serious issues to silence warnings when building the
>> documentation.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  drivers/gpio/gpiolib.c      | 82 +++++++++++++++++++++++++++++++++------------
>>  include/linux/gpio/driver.h |  3 +-
>>  2 files changed, 61 insertions(+), 24 deletions(-)
>
> Hi Linus,
>
> any chance we can get this merged? The GPIO IRQ chip and banked
> controller support patches that I'm working on depend on this, so I'd
> like for these to go in before I send out the former in order to
> decrease the dependency tracking for everyone involved.

I've been on vacation, sorry.

I'm churning the backlog now...

Yours,
Linus Walleij
