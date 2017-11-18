From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/6] gpiolib: acpi: Assign polarity when call acpi_populate_gpio_lookup()
Date: Sat, 18 Nov 2017 15:55:50 +0100
Message-ID: <3386279.Ob0QzBfdKF@aspire.rjw.lan>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59580 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762811AbdKRO4H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 18 Nov 2017 09:56:07 -0500
In-Reply-To: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Friday, November 10, 2017 2:40:28 PM CET Andy Shevchenko wrote:
> There is no need, since we preserve firmware settings, to override
> polarity for GpioInt() resources.
> 
> While Documentation/gpio-properties.txt refers to any from GpioIo() /
> GpioInt() resources, the active_low flag has been introduced to fill the
> gap only for GpioIo() which lacks of that information.
> 
> Moreover, in case of GpioInt() existed solution was broken anyway, it
> overrides only in one direction, i.e. from 0 to 1, otherwise it would be
> still 1 as defined in the resource macro.
> 
> So, move the assignment to a right place and forbid to (semi-)override
> polarity for GpioInt() type of resources.

I'm assuming that this series is targeted at the GPIO subsystem.

Please let me know if that's not the case.

Thanks,
Rafael

