From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/5] gpiolib / ACPI: convert to gpiod interfaces
Date: Tue, 8 Oct 2013 11:45:08 +0300
Message-ID: <20131008084508.GI3521@intel.com>
References: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
 <1380639537-23406-3-git-send-email-mika.westerberg@linux.intel.com>
 <CAAVeFuJZ3TwozZzpuHcYPDLjEsb2D_qvQADf85s3-eywYYHs8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22530 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab3JHIjm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Oct 2013 04:39:42 -0400
Content-Disposition: inline
In-Reply-To: <CAAVeFuJZ3TwozZzpuHcYPDLjEsb2D_qvQADf85s3-eywYYHs8A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, rjw@rjwysocki.net, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Oct 07, 2013 at 09:54:13PM -0700, Alexandre Courbot wrote:
> > +struct gpio_desc *acpi_get_gpiod(char *path, int pin)
> >  {
> >         struct gpio_chip *chip;
> >         acpi_handle handle;
> > @@ -48,18 +49,15 @@ int acpi_get_gpio(char *path, int pin)
> >
> >         status =3D acpi_get_handle(NULL, path, &handle);
> >         if (ACPI_FAILURE(status))
> > -               return -ENODEV;
> > +               return ERR_PTR(-ENODEV);
> >
> >         chip =3D gpiochip_find(handle, acpi_gpiochip_find);
> >         if (!chip)
> > -               return -ENODEV;
> > +               return ERR_PTR(-ENODEV);
> >
> > -       if (!gpio_is_valid(chip->base + pin))
> > -               return -EINVAL;
> > -
> > -       return chip->base + pin;
> > +       return gpio_to_desc(chip->base + pin);
>=20
> I think you want to avoid using gpio_to_desc(). It is just a
> convenience function provided to ease the transition for consumers
> that still need to rely on GPIO numbers for some reason. The same
> applies to desc_to_gpio(), although the usage you are making of it
> (implemented fallbacks for the integer space) is the one that is
> intended.
>=20
> The last line could be changed to "return &chip->desc[pin];" after
> checking that 0 <=3D pin <=3D chip->ngpio.

I tried that but it doesn't compile anymore :-(

drivers/gpio/gpiolib-acpi.c: In function =E2=80=98acpi_get_gpiod=E2=80=99=
:
drivers/gpio/gpiolib-acpi.c:61:2: error: invalid use of undefined type =
=E2=80=98struct gpio_desc=E2=80=99
drivers/gpio/gpiolib-acpi.c:61:20: error: dereferencing pointer to inco=
mplete type

Since struct gpio_desc is internal to gpiolib.c we can't dereference it
outside.

The DT version also uses gpio_to_desc().

> This minor issue apart, I really like the fact you are moving this
> under the gpiolib APIs (also appreciate the testing of the new API
> this patchset provides!).
>=20
> I also wonder whether you could also avoid exporting acpi_get_gpiod*
> (which allow GPIO consumers to shortcut gpiolib) by implementing
> acpi_get_gpio* into the C file (maybe even using gpiod_get()). I see =
a
> "char *path" parameter though, so maybe that would not be possible at
> the moment.

Good point, I'll check if we can do that.

> Once the gpio_to_desc() issue mentioned above is fixed I think I can =
give my
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks!

>=20
> on patches 2-5.
>=20
> Thanks,
> Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
