From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/3] gpio: merrifield: Add support of ACPI enabled platforms
Date: Tue, 9 Jan 2018 14:37:37 +0100
Message-ID: <CACRpkdZqgwtQ+xvV4iqUhiPZnyXufOShC0s7Um=vEM377sBWxw@mail.gmail.com>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com> <20180105160935.48588-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:42212 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757825AbeAINhi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jan 2018 08:37:38 -0500
Received: by mail-it0-f67.google.com with SMTP id p139so11637971itb.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jan 2018 05:37:38 -0800 (PST)
In-Reply-To: <20180105160935.48588-3-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Jan 5, 2018 at 5:09 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The driver needs the pin control device name for ACPI.
>
> We are looking through ACPI namespace and return first found device
> based on ACPI HID for Intel Merrifield FLIS (pin control device).
>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks neat and clean.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Rafael: feel free to pick this up with the series.

Yours,
Linus Walleij
