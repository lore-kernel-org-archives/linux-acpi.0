From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Thu, 1 Jun 2017 17:29:30 +0200
Message-ID: <CACRpkdZ2u8mxCCCNCPpL3d6LACSjjHTCOyok9NWM0WuW0XY3HA@mail.gmail.com>
References: <20170524104216.23643-1-hdegoede@redhat.com> <CACRpkdan9Ayd6qGioQc2N+x9S2WxfXs2WGg4imAApLRxOwrfmQ@mail.gmail.com>
 <9fae1e2f-9d5b-2ba8-3bf5-4e1516e06332@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36433 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdFAP3c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2017 11:29:32 -0400
Received: by mail-io0-f178.google.com with SMTP id o12so38797351iod.3
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jun 2017 08:29:32 -0700 (PDT)
In-Reply-To: <9fae1e2f-9d5b-2ba8-3bf5-4e1516e06332@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Thu, Jun 1, 2017 at 5:20 PM, Hans de Goede <hdegoede@redhat.com> wrote:

>> So again, the reason this - which is not a GPIO controller at all -
>> should anyways
>> be in drivers/gpio/ is that some firmware person think it's convenien >
>> Shouldn't this rather be in drivers/platform/x86?
>
>
> That is where it started, I'm fine with putting it back there.
>
>> You can still use the gpio driver abstraction.
>
> Ack, if you're ok with using the gpio driver abstraction while
> putting the driver in drivers/platform/x86 that might be the
> best way to deal with this.

OK let's proceed like that.

I guess I could be hopeless and require that it reimplement
the ACPI parser and whatnot just because it's not GPIO but
code duplication is a greater evil and thus modelling this as a
"GPIO" is the lesser evil, so I just have to accept it as such.

Yours,
Linus Walleij
