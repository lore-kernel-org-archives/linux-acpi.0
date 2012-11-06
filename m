From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/3] gpio / ACPI: add ACPI support
Date: Tue, 6 Nov 2012 11:39:04 +0200
Message-ID: <20121106093904.GM24532@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <4684026.MA6h34pt1X@vostro.rjw.lan>
 <CACRpkdbRWPYHBwLVTm-TDRVyp9Kmoaxw0uZg0schn7i0koDKJw@mail.gmail.com>
 <2396674.M1Yl70Z09T@vostro.rjw.lan>
 <CACRpkda6jNsKwowdJZ6d7kua5uBPH2tZT8Ka9vheEiPjvEJuUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63239 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab2KFJhD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Nov 2012 04:37:03 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkda6jNsKwowdJZ6d7kua5uBPH2tZT8Ka9vheEiPjvEJuUg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, linux-acpi@vger.kernel.org

On Mon, Nov 05, 2012 at 03:40:14PM +0100, Linus Walleij wrote:
> > I forgot to mention that we want to hook up _existing_ drivers to those things,
> > and they already use the global GPIO numbers, don't they?
> 
> Yes they do, usually this is either passed from the platform using platform
> data or handled by device tree lookups to individual drivers.
> 
> So you will have to modify each such existing driver to do ACPI
> probe akin to the DT codepath and call acpi_get_gpio() on every pin they
> need going forward. But that is the plan I guess.

Yes, that's the plan.

Do you think it is OK to go with this implementation (acpi_get_gpio()) for
now? We will try to make sure that the gpio_get() (or whatever it will be
called that time) supports ACPI as well.
