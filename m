From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 1/4] ACPI / gpio: Allow holes in list of GPIOs for a device
Date: Mon, 24 Oct 2016 01:36:14 +0200
Message-ID: <CACRpkdZY+YM9WgP=87duOvjxs_=nwfgQcziYsYXSWaQC34Es7A@mail.gmail.com>
References: <20161021142132.80539-1-mika.westerberg@linux.intel.com> <20161021142132.80539-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33807 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbcJWXgP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Oct 2016 19:36:15 -0400
Received: by mail-qk0-f179.google.com with SMTP id x11so7107292qka.1
        for <linux-acpi@vger.kernel.org>; Sun, 23 Oct 2016 16:36:14 -0700 (PDT)
In-Reply-To: <20161021142132.80539-2-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 21, 2016 at 4:21 PM, Mika Westerberg
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
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Patch applied.

Yours,
Linus Walleij
