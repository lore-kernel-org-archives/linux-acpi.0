From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] mfd: Add new mfd device TPS68470
Date: Mon, 12 Jun 2017 12:45:41 +0300
Message-ID: <CAHp75Ve+fPR95D8Fbee1HCDd=CegAN9TZ3zEbUZShyaoEZ-gHw@mail.gmail.com>
References: <1497259612-38401-1-git-send-email-rajmohan.mani@intel.com> <1497259612-38401-2-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36132 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdFLJpn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2017 05:45:43 -0400
In-Reply-To: <1497259612-38401-2-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Mon, Jun 12, 2017 at 12:26 PM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:
> The TPS68470 device is an advanced power management
> unit that powers a Compact Camera Module (CCM),
> generates clocks for image sensors, drives a dual
> LED for Flash and incorporates two LED drivers for
> general purpose indicators.
>
> This patch adds support for TPS68470 mfd device.

> +#include <linux/i2c.h>

If you are going to ignore reviewers' comments you may delay the patch
upstreaming for quite a bit.

P.S. For now I don't see any priority to review v3.
I noted more issues that weren't addressed.

Sorry.

-- 
With Best Regards,
Andy Shevchenko
