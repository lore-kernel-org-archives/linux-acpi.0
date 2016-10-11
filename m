From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] ACPI / property: Allow holes in reference properties
Date: Tue, 11 Oct 2016 22:46:26 +0200
Message-ID: <CAJZ5v0jGCrwB+mC6r-DVo-BYmLX-5WeKMEUnZ8NNmLsYCB2mfg@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com> <20160929133944.158596-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160929133944.158596-2-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

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

The patch looks good to me and I don't see any reason to defer it, so
I'm queuing it up for the next ACPI pull request.

Thanks,
Rafael
