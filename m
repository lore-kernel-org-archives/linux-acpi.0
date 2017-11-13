From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 6/6] gpiolib: acpi: Introduce NO_RESTRICTION quirk
Date: Mon, 13 Nov 2017 13:55:54 +0200
Message-ID: <20171113115554.GY18997@lahna.fi.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
 <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:57383 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdKMMAU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Nov 2017 07:00:20 -0500
Content-Disposition: inline
In-Reply-To: <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Fri, Nov 10, 2017 at 03:40:33PM +0200, Andy Shevchenko wrote:
> Allow to relax IoRestriction for certain cases.
> 
> One of the use case is incorrectly cooked ACPI table where interrupt pin is
> defined with GpioIo() macro with IoRestrictionOutputOnly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think you should include user of this quirk in the patch series as
well. Otherwise it is pretty pointless to add random quirks without
real issues they are supposed to solve ;-)

Anyway looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
