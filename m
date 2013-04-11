From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] gpiolib-acpi: introduce acpi_get_gpio_by_index() helper
Date: Fri, 12 Apr 2013 00:43:54 +0200
Message-ID: <91057740.Ix5vA2gAR4@vostro.rjw.lan>
References: <1364986614-15711-1-git-send-email-mika.westerberg@linux.intel.com> <CACRpkdZKnLJbEqiWBmmTC+9yeSYgXryG0Na3BXqo1We1mRyTAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56573 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881Ab3DKWgH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 18:36:07 -0400
In-Reply-To: <CACRpkdZKnLJbEqiWBmmTC+9yeSYgXryG0Na3BXqo1We1mRyTAg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, April 12, 2013 12:33:55 AM Linus Walleij wrote:
> On Wed, Apr 3, 2013 at 12:56 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > Instead of open-coding ACPI GPIO resource lookup in each driver, we provide
> > a helper function analogous to Device Tree version that allows drivers to
> > specify which GPIO resource they are interested (using an index to the GPIO
> > resources). The function then finds out the correct resource, translates
> > the ACPI GPIO number to the corresponding Linux GPIO number and returns
> > that.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Patch applied with Rafael's ACK and pushed.

Thanks a lot Linus!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
