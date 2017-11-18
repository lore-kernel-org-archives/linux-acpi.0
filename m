From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/6] gpiolib: acpi: Assign polarity when call
 acpi_populate_gpio_lookup()
Date: Sat, 18 Nov 2017 18:45:10 +0200
Message-ID: <1511023510.25007.308.camel@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
         <3386279.Ob0QzBfdKF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:21120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422919AbdKRQpO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 18 Nov 2017 11:45:14 -0500
In-Reply-To: <3386279.Ob0QzBfdKF@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Sat, 2017-11-18 at 15:55 +0100, Rafael J. Wysocki wrote:
> On Friday, November 10, 2017 2:40:28 PM CET Andy Shevchenko wrote:

> I'm assuming that this series is targeted at the GPIO subsystem.

That's correct.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
