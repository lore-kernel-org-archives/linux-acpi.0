From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/8] gpio: acpi: Make it working
Date: Tue, 28 Mar 2017 15:24:59 +0200
Message-ID: <CACRpkdaF=+toeuUGkYz1y-09b8Dp476vp_hf6A6D6an0GrmZFQ@mail.gmail.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:35168 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbdC1NZD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2017 09:25:03 -0400
Received: by mail-it0-f48.google.com with SMTP id y18so111893580itc.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Mar 2017 06:25:02 -0700 (PDT)
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Mar 23, 2017 at 8:46 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Currently GPIO ACPI library provides an API to get a GPIO resources
> (IO or interrupt) from ACPI tables for the individual drivers.
>
> This library has few flaws which makes some devices not working:
>  - the library allows to abuse ACPI by using a _CRS fallback mechanism
>  - the library neglects flags of the resource
>
> In this series:
>  - the _CRS fallback is forbidden
>  - the pin configuration follows what firmware wants to
>  - the documentation is updated in order to clarify corner cases
>
> After this series it's possible to use GPIO pins for input (interrupt)
> which were configured as output by BIOS by some reason. It's a crucial
> functionality for IoT open connected boards where user may choose any of
> available pin for almost any of available function, including GPIO input
> (interrupt).
>
> Current bad behaviour was first reported by Jarkko Nikula few months ago.

I see there are some outstanding comments in the patches but it looks
OK overall to me, waiting for a v2 before applying, please collect ACKs
and relevant Tested-by:s.

Yours,
Linus Walleij
