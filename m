From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Thu, 12 Feb 2015 14:46:23 +0200
Message-ID: <20150212124623.GC18860@kuha.fi.intel.com>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com>
 <20150123112122.GD30522@kuha.fi.intel.com>
 <CAAVeFuJUdigJC+WcriOi+SEYDz0HCzU=KatDPfmzdA6ytBOd_A@mail.gmail.com>
 <16561596.EbsEtszXvm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51385 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201AbbBLMsf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Feb 2015 07:48:35 -0500
Content-Disposition: inline
In-Reply-To: <16561596.EbsEtszXvm@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Feb 10, 2015 at 04:10:04PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 10, 2015 06:32:46 PM Alexandre Courbot wrote:
> > On Fri, Jan 23, 2015 at 8:21 PM, Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > > Hi guys,
> > >
> > > On Thu, Jan 22, 2015 at 05:14:22PM +0100, Rafael J. Wysocki wrote=
:
> > >> On Thursday, January 22, 2015 11:57:55 AM Alexandre Courbot wrot=
e:
> > >> > If we decide to go ahead with the solution proposed by this pa=
tch for
> > >> > practical reasons (which are good reasons indeed), I still hav=
e one
> > >> > problem with its current form.
> > >> >
> > >> > As the discussion highlighted, this is an ACPI problem, so I'd=
 very
> > >> > much like it to be confined to the ACPI GPIO code, to be enabl=
ed only
> > >> > when ACPI is, and to use function names that start with acpi_g=
pio.
> > >>
> > >> I can agree with that.
> > >>
> > >> > The current implementation leverages platform lookup, making s=
aid lookup
> > >> > less efficient in the process and bringing confusion about its
> > >> > purpose. Although the two processes are indeed similar, they a=
re
> > >> > separate things: one is a legitimate way to map GPIOs, the oth=
er is a
> > >> > fixup for broken firmware.
> > >> >
> > >> > I suppose we all agree this is a hackish fix, so let's confine=
 it as
> > >> > much as we can.
> > >>
> > >> OK
> > >>
> > >> Heikki, any comments?
> > >
> > > I'm fine with that.
> > >
> > > That actually makes me think that we could then drop the lookup t=
ables
> > > completely and use device properties instead with the help of "ge=
neric
> > > property" (attached):
> > >
> > > We would just need to agree on the format how to describe a gpio
> > > property, document it and of course convert the current users as
> > > usual. The format could be something like this as an example (I'm
> > > writing this out of my head so don't shoot me if you can see it w=
ould
> > > not work. Just an example):
> > >
> > > static const u32 example_gpio[] =3D { <gpio>, <flags>,=E7=88=99;
> > >
> > > static struct dev_gen_prop example_prop[] =3D
> > >         {
> > >                 .type =3D DEV_PROP_U32,
> > >                 .name =3D "gpio,<con_id>",
> > >                 .nval =3D 2,
> > >                 .num =3D &example_gpio,
> > >         },
> > >         { },
> > > };
> > >
> > > static struct platform_device example_pdev =3D {
> > >         ...
> > >         .dev =3D {
> > >                 .gen_prop =3D &example_prop,
> > >         },
> > > }
> > >
> > >
> > > In gpiolib.c we would then, instead of going through the lookups,
> > > simply ask for that property:
> > >
> > >         ...
> > >         sprintf(propname, "gpio,%s", con_id);
> > >         device_property_read_u32_array(dev, propname, &val, 2);
> > >         ...
> > >         desc =3D gpio_to_desc(val[0]);
> > >         flags =3D val[1];
> > >         ...
> > >
> > >
> > > So this is just and idea. I think it would be relatively easy to
> > > implement. What do you guys think?
> >=20
> > At first sight, that looks like a very good idea and a great use of
> > the device properties API. Are you willing to explore it further?

Yes. If I get green light for the generic property idea, I can start
thinking about this.


Thanks,

--=20
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
