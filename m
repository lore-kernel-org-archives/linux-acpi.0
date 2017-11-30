From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 6/6] gpiolib: acpi: Introduce NO_RESTRICTION quirk
Date: Thu, 30 Nov 2017 10:57:26 +0100
Message-ID: <CACRpkdZ3rHjZZNwAL4KF_FtP6gQgATwk7F8-S8Y3VPZbJ2TdmQ@mail.gmail.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
 <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
 <20171113115554.GY18997@lahna.fi.intel.com> <1510578648.25007.166.camel@linux.intel.com>
 <CACRpkdY64u0T+BW_ACzZEr7cB+W1aixsn4ZB50EsBUJZttpMaw@mail.gmail.com> <1511962871.25007.485.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:39574 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdK3J51 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Nov 2017 04:57:27 -0500
Received: by mail-io0-f193.google.com with SMTP id h12so6921187iof.6
        for <linux-acpi@vger.kernel.org>; Thu, 30 Nov 2017 01:57:27 -0800 (PST)
In-Reply-To: <1511962871.25007.485.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Nov 29, 2017 at 2:41 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It
> would be nice if you can prepare immutable branch in case the subsystems
> would like to merge patches via their respective trees.

I have created a branch named "ib-gpio-acpi-quirks" in my tree
with the six patches from you, then merged that to my devel
branch.

You can point subsystem maintainers to that one.

Yours,
Linus Walleij
