From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 4/6] gpiolib: acpi: Consolidate debug output in
 acpi_gpio_update_gpiod_flags()
Date: Mon, 13 Nov 2017 13:25:28 +0200
Message-ID: <20171113112528.GV18997@lahna.fi.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
 <20171110134033.85461-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16803 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752474AbdKMLZc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Nov 2017 06:25:32 -0500
Content-Disposition: inline
In-Reply-To: <20171110134033.85461-4-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Fri, Nov 10, 2017 at 03:40:31PM +0200, Andy Shevchenko wrote:
> We have the duplicated debug strings printed whenever
> acpi_gpio_update_gpiod_flags() fails. Instead of doing this by callers,
> move the debug output inside function.
> 
> In one case convert almost useless pr_debug() to dev_dbg() where
> actual consumer of GPIO resource is disclosed.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
