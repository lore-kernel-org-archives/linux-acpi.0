From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] gpio: acpi: work around false-positive -Wstring-overflow warning
Date: Wed, 6 Sep 2017 21:53:51 +0200
Message-ID: <CAK8P3a2RGZFc3_XpgyfuxwYy-vOoYkkamxQzma8JKwLjCCJasQ@mail.gmail.com>
References: <20170906154756.2133726-1-arnd@arndb.de> <1504713173.7546.3.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33588 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdIFTxx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2017 15:53:53 -0400
In-Reply-To: <1504713173.7546.3.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Sep 6, 2017 at 5:52 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2017-09-06 at 17:47 +0200, Arnd Bergmann wrote:

>> As suggested by Andy, this changes the format string to have a fixed length.
>> Since modifying the range check did not help, I also opened a bug against
>> gcc, see link below.
>
> The code has
>
>         int pin
>
> does changing pin to unsigned int matter?

No difference, see also the gcc bugzilla report.

        Arnd
