From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 7/7] gpio: Use unsigned int for of_gpio_n_cells
Date: Wed, 2 Aug 2017 14:14:11 +0200
Message-ID: <CACRpkdY5zxLhrUe7NHXhM-fb4p3a4hHTw1ndztu_Jmrr8gBhJQ@mail.gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com> <20170724145728.7662-7-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34896 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbdHBMON (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Aug 2017 08:14:13 -0400
Received: by mail-io0-f174.google.com with SMTP id m88so19523174iod.2
        for <linux-acpi@vger.kernel.org>; Wed, 02 Aug 2017 05:14:13 -0700 (PDT)
In-Reply-To: <20170724145728.7662-7-thierry.reding@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jul 24, 2017 at 4:57 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> The cell count for GPIO specifiers can never be negative, so make the
> field unsigned.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied.

Yours,
Linus Walleij
