From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 3/4] gpio: Rework of_gpiochip_set_names() to use device
 property accessors
Date: Mon, 24 Oct 2016 01:42:38 +0200
Message-ID: <CACRpkdZYPrVP+QhOv9qaeLN4+aRE2XtzvbnQpRwuGHqjNMBqyw@mail.gmail.com>
References: <20161021142132.80539-1-mika.westerberg@linux.intel.com> <20161021142132.80539-4-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34167 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752978AbcJWXmk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Oct 2016 19:42:40 -0400
Received: by mail-qt0-f178.google.com with SMTP id q7so119179918qtq.1
        for <linux-acpi@vger.kernel.org>; Sun, 23 Oct 2016 16:42:39 -0700 (PDT)
In-Reply-To: <20161021142132.80539-4-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 21, 2016 at 4:21 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> In order to use "gpio-line-names" property in systems not having DT as
> their boot firmware, rework of_gpiochip_set_names() to use device property
> accessors. This reworked function is placed in a separate file making it
> clear it deals with universal device properties.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Exactly like this, thanks!

Patch applied.

Yours,
Linus Walleij
