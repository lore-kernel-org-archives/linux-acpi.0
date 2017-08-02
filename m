From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/7] docs: driver-api: Add GPIO section
Date: Wed, 2 Aug 2017 14:13:16 +0200
Message-ID: <CACRpkdb5+rBA5v8RKxKYS2CT6sOzAodFF-Y3dTpEsWspZ6fsZw@mail.gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com> <20170724145728.7662-6-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170724145728.7662-6-thierry.reding@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 24, 2017 at 4:57 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> This adds a section about the various parts of the GPIO subsystem to the
> driver API documentation. Note that this isn't exhaustive documentation,
> but rather focusses on pulling in the kerneldoc from various sources, in
> order to improve coverage of kerneldoc processing.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied, but...

> +sysfs helpers
> +=============
> +
> +.. kernel-doc:: drivers/gpio/gpiolib-sysfs.c
> +   :export:

I don't know about this. That is the legacy ABI, I am thinking about hiding
it so as not to encourage it. Yet the code is definately there, sigh.

Yours,
Linus Walleij
