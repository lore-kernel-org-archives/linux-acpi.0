From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Tue, 10 Feb 2015 16:10:04 +0100
Message-ID: <16561596.EbsEtszXvm@vostro.rjw.lan>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com> <20150123112122.GD30522@kuha.fi.intel.com> <CAAVeFuJUdigJC+WcriOi+SEYDz0HCzU=KatDPfmzdA6ytBOd_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59794 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750833AbbBJOrB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 09:47:01 -0500
In-Reply-To: <CAAVeFuJUdigJC+WcriOi+SEYDz0HCzU=KatDPfmzdA6ytBOd_A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday, February 10, 2015 06:32:46 PM Alexandre Courbot wrote:
> On Fri, Jan 23, 2015 at 8:21 PM, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > Hi guys,
> >
> > On Thu, Jan 22, 2015 at 05:14:22PM +0100, Rafael J. Wysocki wrote:
> >> On Thursday, January 22, 2015 11:57:55 AM Alexandre Courbot wrote:
> >> > If we decide to go ahead with the solution proposed by this patc=
h for
> >> > practical reasons (which are good reasons indeed), I still have =
one
> >> > problem with its current form.
> >> >
> >> > As the discussion highlighted, this is an ACPI problem, so I'd v=
ery
> >> > much like it to be confined to the ACPI GPIO code, to be enabled=
 only
> >> > when ACPI is, and to use function names that start with acpi_gpi=
o.
> >>
> >> I can agree with that.
> >>
> >> > The current implementation leverages platform lookup, making sai=
d lookup
> >> > less efficient in the process and bringing confusion about its
> >> > purpose. Although the two processes are indeed similar, they are
> >> > separate things: one is a legitimate way to map GPIOs, the other=
 is a
> >> > fixup for broken firmware.
> >> >
> >> > I suppose we all agree this is a hackish fix, so let's confine i=
t as
> >> > much as we can.
> >>
> >> OK
> >>
> >> Heikki, any comments?
> >
> > I'm fine with that.
> >
> > That actually makes me think that we could then drop the lookup tab=
les
> > completely and use device properties instead with the help of "gene=
ric
> > property" (attached):
> >
> > We would just need to agree on the format how to describe a gpio
> > property, document it and of course convert the current users as
> > usual. The format could be something like this as an example (I'm
> > writing this out of my head so don't shoot me if you can see it wou=
ld
> > not work. Just an example):
> >
> > static const u32 example_gpio[] =3D { <gpio>, <flags>,=E7=88=99;
> >
> > static struct dev_gen_prop example_prop[] =3D
> >         {
> >                 .type =3D DEV_PROP_U32,
> >                 .name =3D "gpio,<con_id>",
> >                 .nval =3D 2,
> >                 .num =3D &example_gpio,
> >         },
> >         { },
> > };
> >
> > static struct platform_device example_pdev =3D {
> >         ...
> >         .dev =3D {
> >                 .gen_prop =3D &example_prop,
> >         },
> > }
> >
> >
> > In gpiolib.c we would then, instead of going through the lookups,
> > simply ask for that property:
> >
> >         ...
> >         sprintf(propname, "gpio,%s", con_id);
> >         device_property_read_u32_array(dev, propname, &val, 2);
> >         ...
> >         desc =3D gpio_to_desc(val[0]);
> >         flags =3D val[1];
> >         ...
> >
> >
> > So this is just and idea. I think it would be relatively easy to
> > implement. What do you guys think?
>=20
> At first sight, that looks like a very good idea and a great use of
> the device properties API. Are you willing to explore it further?

I guess Heikki is waiting for my feedback on his core patch that I'm
going to provide later today.

And yes, this is an interesting idea.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
