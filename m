From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/6] gpiolib: acpi: Move adev member to struct acpi_gpio_info
Date: Wed, 29 Nov 2017 13:30:08 +0100
Message-ID: <CACRpkdaDoRhUMqvaixRkDeA2YhjLEgf3xf_1VkLo6Ci-70WgyA@mail.gmail.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com> <20171110134033.85461-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:33267 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdK2MaJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Nov 2017 07:30:09 -0500
Received: by mail-it0-f42.google.com with SMTP id o130so26157675itg.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2017 04:30:09 -0800 (PST)
In-Reply-To: <20171110134033.85461-3-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Nov 10, 2017 at 2:40 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The further improvements are based on this change since
> struct acpi_gpio_lookup is not available in some cases.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
