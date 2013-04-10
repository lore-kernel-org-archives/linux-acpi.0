From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio / ACPI: Handle ACPI events in accordance with the spec
Date: Wed, 10 Apr 2013 23:06:48 +0200
Message-ID: <CACRpkdZ+Tj2tdQsY7dM+ZJHDeO=HdnYtQ8fWVAXRbP0zpG8ijA@mail.gmail.com>
References: <3043137.BtEKcMiXSu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:58219 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab3DJVGs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Apr 2013 17:06:48 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so857988iec.22
        for <linux-acpi@vger.kernel.org>; Wed, 10 Apr 2013 14:06:48 -0700 (PDT)
In-Reply-To: <3043137.BtEKcMiXSu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 9, 2013 at 3:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 0d1c28a (gpiolib-acpi: Add ACPI5 event model support to gpio.)
> that added support for ACPI events signalled through GPIO interrupts
> covered only GPIO pins whose numbers are less than or equal to 255.
> However, there may be GPIO pins with numbers greater than 255 and
> the ACPI spec (ACPI 5.0, Section 5.6.5.1) requires the _EVT method
> to be used for handling events corresponding to those pins.
>
> Moreover, according to the spec, _EVT is the default mechanism
> for handling all ACPI events signalled through GPIO interrupts,
> so if the _Exx/_Lxx method is not present for the given pin,
> _EVT should be used instead.  If present, though, _Exx/_Lxx take
> precedence over _EVT which shouldn't be executed in that case
> (ACPI 5.0, Section 5.6.5.3).
>
> Modify acpi_gpiochip_request_interrupts() to follow the spec as
> described above and add acpi_gpiochip_free_interrupts() needed
> to free interrupts associated with _EVT.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Patch applied with Mika's ACK, thanks!

It's not like I fully understand it, but I totally trust you guys.

Yours,
Linus Walleij
