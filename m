From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 2/5] gpiolib / ACPI: convert to gpiod interfaces
Date: Wed, 9 Oct 2013 09:36:50 -0700
Message-ID: <CAAVeFuK4dwfOs_vxuC7wG4icCq-wbGhN5sCzYy+Z+rb0A2djJQ@mail.gmail.com>
References: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
 <1380639537-23406-3-git-send-email-mika.westerberg@linux.intel.com>
 <CAAVeFuJZ3TwozZzpuHcYPDLjEsb2D_qvQADf85s3-eywYYHs8A@mail.gmail.com>
 <20131008084508.GI3521@intel.com> <CAAVeFu+_EUCs+70+WzCq530JUesrHzULi34mCf7-pRVVP1WV7g@mail.gmail.com>
 <20131009075830.GS3521@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20131009075830.GS3521@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, rjw@rjwysocki.net, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 9, 2013 at 12:58 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Oct 08, 2013 at 09:24:50AM -0700, Alexandre Courbot wrote:
>> On Tue, Oct 8, 2013 at 1:45 AM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>> > On Mon, Oct 07, 2013 at 09:54:13PM -0700, Alexandre Courbot wrote:
>> >> > +struct gpio_desc *acpi_get_gpiod(char *path, int pin)
>> >> >  {
>> >> >         struct gpio_chip *chip;
>> >> >         acpi_handle handle;
>> >> > @@ -48,18 +49,15 @@ int acpi_get_gpio(char *path, int pin)
>> >> >
>> >> >         status =3D acpi_get_handle(NULL, path, &handle);
>> >> >         if (ACPI_FAILURE(status))
>> >> > -               return -ENODEV;
>> >> > +               return ERR_PTR(-ENODEV);
>> >> >
>> >> >         chip =3D gpiochip_find(handle, acpi_gpiochip_find);
>> >> >         if (!chip)
>> >> > -               return -ENODEV;
>> >> > +               return ERR_PTR(-ENODEV);
>> >> >
>> >> > -       if (!gpio_is_valid(chip->base + pin))
>> >> > -               return -EINVAL;
>> >> > -
>> >> > -       return chip->base + pin;
>> >> > +       return gpio_to_desc(chip->base + pin);
>> >>
>> >> I think you want to avoid using gpio_to_desc(). It is just a
>> >> convenience function provided to ease the transition for consumer=
s
>> >> that still need to rely on GPIO numbers for some reason. The same
>> >> applies to desc_to_gpio(), although the usage you are making of i=
t
>> >> (implemented fallbacks for the integer space) is the one that is
>> >> intended.
>> >>
>> >> The last line could be changed to "return &chip->desc[pin];" afte=
r
>> >> checking that 0 <=3D pin <=3D chip->ngpio.
>> >
>> > I tried that but it doesn't compile anymore :-(
>> >
>> > drivers/gpio/gpiolib-acpi.c: In function =E2=80=98acpi_get_gpiod=E2=
=80=99:
>> > drivers/gpio/gpiolib-acpi.c:61:2: error: invalid use of undefined =
type =E2=80=98struct gpio_desc=E2=80=99
>> > drivers/gpio/gpiolib-acpi.c:61:20: error: dereferencing pointer to=
 incomplete type
>>
>> Ah right, there is no way to know the size of a gpio_desc from here.=
=2E.
>> Maybe I should make a gpiochip_get_desc(index) function accessible t=
o
>> drivers only that takes care of this. Another possibility would be t=
o
>> move this function into gpiolib.c but there are probably too many
>> dependencies with ACPI for that.
>>
>> In the long term I would like to see gpio_to_desc()/desc_to_gpio()
>> disappear from the consumer interface as they allow unsafe use of GP=
IO
>> descriptors.
>>
>> > The DT version also uses gpio_to_desc().
>>
>> That seems to speak in favor of that gpiochip_get_desc() function I
>> talked about earlier.
>
> OK, I can convert the ACPI code to use that once such function exists=
=2E I
> the meanwhile, can I use gpio_to_desc() in the next revision of the
> patches?

Sure, please do so - anyway that's the only way you have at the
moment. I will add gpiochip_get_desc() to v2 of gpiod and we'll
convert your code either before or after it is merged, depending on
our timing.
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
