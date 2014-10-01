From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 05/15] gpio / ACPI: Add support for _DSD device properties
Date: Wed, 01 Oct 2014 10:03:38 +0200
Message-ID: <5364540.jzXqjZX0yp@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1852462.V1jlbi8OPt@vostro.rjw.lan> <4786851.38d7sjpzag@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4786851.38d7sjpzag-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 01 October 2014 04:12:41 Rafael J. Wysocki wrote:
> +       static const char * const suffixes[] = { "gpios", "gpio" };
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
>         struct acpi_gpio_info info;
>         struct gpio_desc *desc;
> +       char propname[32];
> +       int i;
>  
> -       desc = acpi_get_gpiod_by_index(dev, idx, &info);
> -       if (IS_ERR(desc))
> -               return desc;
> +       /* Try first from _DSD */
> +       for (i = 0; i < ARRAY_SIZE(suffixes); i++) {
> +               if (con_id && strcmp(con_id, "gpios")) {
> +                       snprintf(propname, sizeof(propname), "%s-%s",
> +                                con_id, suffixes[i]);
> +               } else {
> +                       snprintf(propname, sizeof(propname), "%s",
> +                                suffixes[i]);
> +               }

The general interface seems fine, but I'd be happier if you didn't
try to support all four of the possible syntaxes we have in DT.
It would be much better to have only "gpios" and not "gpio", and
the "foo-gpios" syntax should be replaced with whatever method you
use to name other subsystem specific links. For most subsystems
we now use something like "gpio-names", but unfortunately the GPIO
binding goes back to the time before we had come to that agreement.
The same applies to regulators.

This is ultimately up to the gpio maintainers though.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
