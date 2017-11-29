From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 6/6] gpiolib: acpi: Introduce NO_RESTRICTION quirk
Date: Wed, 29 Nov 2017 13:34:22 +0100
Message-ID: <CACRpkdb-8zVJNiPrBPjA9MigNcXO6pX3HGSZuDqZgJ2_H0CiRA@mail.gmail.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com> <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33793 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbdK2MeX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Nov 2017 07:34:23 -0500
Received: by mail-it0-f67.google.com with SMTP id m11so26165510iti.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2017 04:34:23 -0800 (PST)
In-Reply-To: <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Nov 10, 2017 at 2:40 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Allow to relax IoRestriction for certain cases.
>
> One of the use case is incorrectly cooked ACPI table where interrupt pin is
> defined with GpioIo() macro with IoRestrictionOutputOnly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
