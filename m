From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 00/12] gpio: acpi: Make it working
Date: Mon, 29 May 2017 11:31:04 +0200
Message-ID: <CACRpkdZN33vNUg6of-2KdC0y1uB3DfY9NgeZnXtLTPVpW6e40Q@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35173 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdE2JbL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 May 2017 05:31:11 -0400
Received: by mail-it0-f45.google.com with SMTP id c15so24244633ith.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 May 2017 02:31:11 -0700 (PDT)
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This is second iteration of the fix of GPIO ACPI library to make it
> robust against different ACPI specification generations and thus
> firmwares.

I applied it all so we get some rotation.

Was a bit worried about hitting drivers/pnp/* but I suspect that is
actually your turf so I just applied it.

Yours,
Linus Walleij
