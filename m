From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] gpiolib-acpi: introduce acpi_get_gpio_by_index() helper
Date: Fri, 12 Apr 2013 09:57:11 +0300
Message-ID: <20130412065710.GM1283@intel.com>
References: <1364986614-15711-1-git-send-email-mika.westerberg@linux.intel.com>
 <15166969.9Sfs2U7qQb@vostro.rjw.lan>
 <20130411072912.GE1283@intel.com>
 <CACRpkdYiNOLVAgZVhZG3OaJw5ZZ4OM8RPafCxPPfMWo2gVM=dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14747 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab3DLGxA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Apr 2013 02:53:00 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYiNOLVAgZVhZG3OaJw5ZZ4OM8RPafCxPPfMWo2gVM=dg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Apr 12, 2013 at 12:35:05AM +0200, Linus Walleij wrote:
> On Thu, Apr 11, 2013 at 9:29 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > Grant and Linus W,
> >
> > Do you have any comments on this patch? Could it still be merged for 3.10?
> 
> No and yes.
> 
> Applied and pushed for linux-next now.

Thanks!

> Sorry for taking so long, I was confused by the discussion.

np. We probably need to add another ACPI GPIO helper function to get all
the GPIOs but I guess we can do that once a need emerges. For a single GPIO
(like the patch here does) we know already from internal discussion that it
will be needed.

> I had to use some fuzzing to apply the patch, please check the
> result in linux-next.

Looks good to me.
