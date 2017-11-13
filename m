From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 3/6] gpiolib: acpi: Move adev member to struct
 acpi_gpio_info
Date: Mon, 13 Nov 2017 13:23:49 +0200
Message-ID: <20171113112349.GU18997@lahna.fi.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
 <20171110134033.85461-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:23289 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752267AbdKMLXx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Nov 2017 06:23:53 -0500
Content-Disposition: inline
In-Reply-To: <20171110134033.85461-3-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Fri, Nov 10, 2017 at 03:40:30PM +0200, Andy Shevchenko wrote:
> The further improvements are based on this change since
> struct acpi_gpio_lookup is not available in some cases.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
