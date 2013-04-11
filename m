From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] gpiolib-acpi: introduce acpi_get_gpio_by_index() helper
Date: Thu, 11 Apr 2013 10:29:12 +0300
Message-ID: <20130411072912.GE1283@intel.com>
References: <1364986614-15711-1-git-send-email-mika.westerberg@linux.intel.com>
 <15166969.9Sfs2U7qQb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38341 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab3DKHZD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 03:25:03 -0400
Content-Disposition: inline
In-Reply-To: <15166969.9Sfs2U7qQb@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-acpi@vger.kernel.org

On Wed, Apr 03, 2013 at 01:04:26PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, April 03, 2013 01:56:54 PM Mika Westerberg wrote:
> > Instead of open-coding ACPI GPIO resource lookup in each driver, we provide
> > a helper function analogous to Device Tree version that allows drivers to
> > specify which GPIO resource they are interested (using an index to the GPIO
> > resources). The function then finds out the correct resource, translates
> > the ACPI GPIO number to the corresponding Linux GPIO number and returns
> > that.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Grant and Linus W,

Do you have any comments on this patch? Could it still be merged for 3.10?

Thanks.
