From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 4/4] ACPI / gpio: Add support for naming GPIOs
Date: Mon, 24 Oct 2016 01:45:24 +0200
Message-ID: <CACRpkdZgV3qNYU064WFFZ3iYx69om+cnVLSAK7tnzKUeZWD_xg@mail.gmail.com>
References: <20161021142132.80539-1-mika.westerberg@linux.intel.com> <20161021142132.80539-5-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35716 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbcJWXpZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Oct 2016 19:45:25 -0400
Received: by mail-qk0-f176.google.com with SMTP id z190so214833836qkc.2
        for <linux-acpi@vger.kernel.org>; Sun, 23 Oct 2016 16:45:25 -0700 (PDT)
In-Reply-To: <20161021142132.80539-5-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 21, 2016 at 4:21 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Now that we have the new helper function that sets nice names for GPIO
> lines based on "gpio-line-names" device property, we can take advantage of
> this in acpi_gpiochip_add().
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Sweet!

Patch applied.

Yours,
Linus Walleij
