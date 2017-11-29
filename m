From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/6] gpiolib: acpi: Assign polarity when call acpi_populate_gpio_lookup()
Date: Wed, 29 Nov 2017 13:27:34 +0100
Message-ID: <CACRpkdb3+GMZqi00BXgDcJZFRdNbQqe6gG14fzEL0W5e_+WDUQ@mail.gmail.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33063 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdK2M1f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Nov 2017 07:27:35 -0500
Received: by mail-it0-f67.google.com with SMTP id o130so26151858itg.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2017 04:27:35 -0800 (PST)
In-Reply-To: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Nov 10, 2017 at 2:40 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

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
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
