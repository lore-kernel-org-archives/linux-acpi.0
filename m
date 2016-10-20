From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/4] ACPI / gpio: Allow holes in list of GPIOs for a device
Date: Thu, 20 Oct 2016 14:10:39 +0200
Message-ID: <CACRpkdZhWj8ZeEhZ06OFKq2BEZbVxcG5_zd9WcoOrn6vRACOwg@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com> <20160929133944.158596-5-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160929133944.158596-5-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 29, 2016 at 3:39 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Make it possible to have an empty GPIOs in a GPIO list for device. For
> example a SPI master may use both GPIOs and native pins as chip selects and
> we need to be able to distinguish between the two.
>
> This makes it mandatory to have exactly 3 arguments for GPIOs and then
> converts gpiolib to use of __acpi_node_get_property_reference() instead. In
> addition we make acpi_gpio_package_count() to handle holes as well (this
> matches the DT version).
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Looks OK.

Do I need someone's ACK to merge stuff under
Documentation/acpi/gpio-properties.txt?
Like Rafael?

Yours,
Linus Walleij
