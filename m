From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib-acpi: introduce acpi_get_gpio_by_index() helper
Date: Fri, 12 Apr 2013 00:33:55 +0200
Message-ID: <CACRpkdZKnLJbEqiWBmmTC+9yeSYgXryG0Na3BXqo1We1mRyTAg@mail.gmail.com>
References: <1364986614-15711-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:56772 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3DKWdz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Apr 2013 18:33:55 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so1887098iad.10
        for <linux-acpi@vger.kernel.org>; Thu, 11 Apr 2013 15:33:55 -0700 (PDT)
In-Reply-To: <1364986614-15711-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Apr 3, 2013 at 12:56 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Instead of open-coding ACPI GPIO resource lookup in each driver, we provide
> a helper function analogous to Device Tree version that allows drivers to
> specify which GPIO resource they are interested (using an index to the GPIO
> resources). The function then finds out the correct resource, translates
> the ACPI GPIO number to the corresponding Linux GPIO number and returns
> that.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied with Rafael's ACK and pushed.

Thanks,
Linus Walleij
