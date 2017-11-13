From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/6] gpiolib: acpi: Assign polarity when call
 acpi_populate_gpio_lookup()
Date: Mon, 13 Nov 2017 13:07:34 +0200
Message-ID: <20171113110734.GS18997@lahna.fi.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62603 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752254AbdKMLOL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Nov 2017 06:14:11 -0500
Content-Disposition: inline
In-Reply-To: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Fri, Nov 10, 2017 at 03:40:28PM +0200, Andy Shevchenko wrote:
> There is no need, since we preserve firmware settings, to override
> polarity for GpioInt() resources.
> 
> While Documentation/gpio-properties.txt refers to any from GpioIo() /
> GpioInt() resources, the active_low flag has been introduced to fill the
> gap only for GpioIo() which lacks of that information.
> 
> Moreover, in case of GpioInt() existed solution was broken anyway, it
> overrides only in one direction, i.e. from 0 to 1, otherwise it would be
> still 1 as defined in the resource macro.
> 
> So, move the assignment to a right place and forbid to (semi-)override
> polarity for GpioInt() type of resources.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
