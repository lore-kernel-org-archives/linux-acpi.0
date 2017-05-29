From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 03/12] gpio: acpi: Do sanity check for GpioInt in acpi_find_gpio()
Date: Mon, 29 May 2017 11:17:28 +0200
Message-ID: <CACRpkdbp0RtkRKzGPUq7TgVUSBxD+_y0ZyVNQmv5ezp3LyzJ=Q@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com> <20170523170327.18055-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36659 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdE2JR3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 May 2017 05:17:29 -0400
Received: by mail-it0-f44.google.com with SMTP id o5so24094695ith.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 May 2017 02:17:29 -0700 (PDT)
In-Reply-To: <20170523170327.18055-4-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Check that we don't ask for output direction on GpioInt resource
> in cases with or without _DSD defined.
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
