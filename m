From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 5/6] gpiolib: acpi: Add quirks field to struct acpi_gpio_mapping
Date: Wed, 29 Nov 2017 13:32:41 +0100
Message-ID: <CACRpkdZvp-3sxSpL2n_eTxyZFtbxpJzrm=1bCjEXcmpUBc9xng@mail.gmail.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com> <20171110134033.85461-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:45992 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdK2Mcm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Nov 2017 07:32:42 -0500
Received: by mail-io0-f181.google.com with SMTP id e204so3478398iof.12
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2017 04:32:42 -0800 (PST)
In-Reply-To: <20171110134033.85461-5-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Nov 10, 2017 at 2:40 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Some broken ACPI tables might require quirks in the OS.
> Introduce quirks field in struct acpi_gpio_mapping.
>
> Propagate them to struct acpi_gpio_info for further use.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
