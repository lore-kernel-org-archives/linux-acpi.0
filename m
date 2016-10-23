From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/4] ACPI / gpio: Add hogging support
Date: Mon, 24 Oct 2016 01:38:24 +0200
Message-ID: <CACRpkdb6n+-XkWis9Z=HsjgG4JoyXdkpmmwsy+X863tV_s550A@mail.gmail.com>
References: <20161021142132.80539-1-mika.westerberg@linux.intel.com> <20161021142132.80539-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35272 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbcJWXiZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Oct 2016 19:38:25 -0400
Received: by mail-qt0-f170.google.com with SMTP id f6so121050511qtd.2
        for <linux-acpi@vger.kernel.org>; Sun, 23 Oct 2016 16:38:25 -0700 (PDT)
In-Reply-To: <20161021142132.80539-3-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 21, 2016 at 4:21 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> GPIO hogging means that the GPIO controller can "hog" and configure certain
> GPIOs without need for a driver or userspace to do that. This is useful in
> open-connected boards where BIOS cannot possibly know beforehand which
> devices will be connected to the board.
>
> This adds GPIO hogging mechanism to ACPI analogous to Device Tree.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Patch applied.

Fixed the small typo in the process. No need to resend.

Yours,
Linus Walleij
