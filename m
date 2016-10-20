From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/4] ACPI / property: Allow holes in reference properties
Date: Thu, 20 Oct 2016 14:00:06 +0200
Message-ID: <CACRpkdaT11YGmS5-a5s7e7p6tbyManX+YmxQBdR0ndQnG+NQEA@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com> <20160929133944.158596-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35582 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbcJTMAI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Oct 2016 08:00:08 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so89244247qkc.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Oct 2016 05:00:08 -0700 (PDT)
In-Reply-To: <20160929133944.158596-2-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Sep 29, 2016 at 3:39 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> DT allows holes or empty phandles for references. This is used for example
> in SPI subsystem where some chip selects are native and others are regular
> GPIOs. In ACPI _DSD we currently do not support this but instead the
> preceding reference consumes all following integer arguments.
>
> For example we would like to support something like the below ASL fragment
> for SPI:
>
>   Package () {
>       "cs-gpios",
>       Package () {
>           ^GPIO, 19, 0, 0, // GPIO CS0
>           0,               // Native CS
>           ^GPIO, 20, 0, 0, // GPIO CS1
>       }
>   }
>
> The zero in the middle means "no entry" or NULL reference. To support this
> we change acpi_data_get_property_reference() to take firmware node and
> num_args as argument and rename it to __acpi_node_get_property_reference().
> The function returns -ENOENT if the given index resolves to "no entry"
> reference and -ENODATA when there are no more entries in the property.
>
> We then add static inline wrapper acpi_node_get_property_reference() that
> passes MAX_ACPI_REFERENCE_ARGS as num_args to support the existing
> behaviour which some drivers have been relying on.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
