From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/6] gpiolib: acpi: Don't contaminate return parameter
 in case of error
Date: Mon, 13 Nov 2017 13:15:10 +0200
Message-ID: <20171113111510.GT18997@lahna.fi.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
 <20171110134033.85461-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28709 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbdKMLVq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Nov 2017 06:21:46 -0500
Content-Disposition: inline
In-Reply-To: <20171110134033.85461-2-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Fri, Nov 10, 2017 at 03:40:29PM +0200, Andy Shevchenko wrote:
> If error occurs, leave lookup parameter untouched.
> 
> There is no functional change, since all current callers just bail out
> in case of error without using the assigned pieces.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
