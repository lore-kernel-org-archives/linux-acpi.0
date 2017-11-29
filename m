From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/6] gpiolib: acpi: Don't contaminate return parameter
 in case of error
Date: Wed, 29 Nov 2017 13:28:53 +0100
Message-ID: <CACRpkdb1xr60e+8ygj=6h3=SmNVGD=jpag4__fQjqB_YJvxadw@mail.gmail.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com> <20171110134033.85461-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:43351 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdK2M2y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Nov 2017 07:28:54 -0500
Received: by mail-io0-f175.google.com with SMTP id s37so3471977ioe.10
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2017 04:28:54 -0800 (PST)
In-Reply-To: <20171110134033.85461-2-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Nov 10, 2017 at 2:40 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> If error occurs, leave lookup parameter untouched.
>
> There is no functional change, since all current callers just bail out
> in case of error without using the assigned pieces.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
