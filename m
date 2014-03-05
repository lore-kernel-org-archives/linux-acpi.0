From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/6] gpiolib: Allow GPIO chips to request their own GPIOs
Date: Wed, 5 Mar 2014 10:49:41 +0800
Message-ID: <CACRpkdZSdb_xn=swV3owEr0YwCiYVXp-90iyc=9yi-M_P=+L+Q@mail.gmail.com>
References: <1393257611-18031-1-git-send-email-mika.westerberg@linux.intel.com>
	<1393257611-18031-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61775 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbaCECtl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2014 21:49:41 -0500
Received: by mail-oa0-f46.google.com with SMTP id i7so449615oag.19
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2014 18:49:41 -0800 (PST)
In-Reply-To: <1393257611-18031-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lan Tianyu <tianyu.lan@intel.com>, Lv Zheng <lv.zheng@intel.com>, Alan Cox <alan.cox@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Feb 25, 2014 at 12:00 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Sometimes it is useful to allow GPIO chips themselves to request GPIOs they
> own through gpiolib API. One usecase is ACPI ASL code that should be able
> to toggle GPIOs through GPIO operation regions.
>
> We can't really use gpio_request() and its counterparts because it will pin
> the module to the kernel forever (as it calls module_get()). Instead we
> provide a gpiolib internal functions gpiochip_request/free_own_desc() that
> work the same as gpio_request() but don't manipulate module refrence count.
>
> Since it's the GPIO chip driver who requests the GPIOs in the first place
> we can be sure that it cannot be unloaded without the driver knowing about
> that. Furthermore we only limit this functionality to be available only
> inside gpiolib.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I fully trust you in doing the ACPI stuff in patches 2-n but on this patch
in particular I want Alexandre's review tag as well, as he's working
actively with the descriptor API and I don't want to add too many quirks
without his consent.

So Alexandre, what do you say about this?

Yours,
Linus Walleij
