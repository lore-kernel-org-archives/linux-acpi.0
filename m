From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
Date: Fri, 24 Jan 2014 12:32:59 +0000
Message-ID: <20140124123259.GI814@e106331-lin.cambridge.arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
 <52E1AFE8.40601@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52E1AFE8.40601@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Patch Tracking <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 24, 2014 at 12:12:24AM +0000, Hanjun Guo wrote:
> Hi Linus,
>=20
> Sorry for the late reply.
>=20
> On 2014=E5=B9=B401=E6=9C=8822=E6=97=A5 16:26, Linus Walleij wrote:
> > On Fri, Jan 17, 2014 at 1:25 PM, Hanjun Guo <hanjun.guo@linaro.org>=
 wrote:
> >
> >> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >>
> >> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
> >> name from the ACPI timer table is matched with all the registered
> >> timer controllers and matching initialisation routine is invoked.
> >>
> >> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Actually I have a fat patch renaming CLOCKSOURCE_OF_DECLARE()
> > to TIMER_OF_DECLARE() and I think this macro, if needed, should
> > be named TIMER_ACPI_DECLARE().
> >
> > The reason is that "clocksource" is a Linux-internal name and this
> > macro pertains to the hardware name in respective system
> > description type.
>=20
> That make sense to me too, I will update in next version if
> this patch is still needed.
>=20
> >
> >> +#ifdef CONFIG_ACPI
> >> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)               =
      \
> >> +       static const struct acpi_device_id __clksrc_acpi_table_##n=
ame   \
> >> +               __used __section(__clksrc_acpi_table)             =
      \
> >> +                =3D { .id =3D compat,                            =
  \
> >> +                    .driver_data =3D (kernel_ulong_t)fn }
> >> +#else
> >> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)
> >> +#endif
> > This hammers down the world to compile one binary for ACPI
> > and one binary for device tree. Maybe that's fine, I don't know.
>=20
> This is a problem we can have some discussion on it.
> I prefer mutually exclusive ACPI and DT support.

A lot of work has been put into making a single kernel boot everywhere.
It's forced duplicated code to be factored out, and it's made the kerne=
l
more flexible. While it has been painful, it's forced a far higher
quality standard across the board(s).

Having a separate ACPI-capable or DT-capable kernels goes completely
against that, and it's completely broken:

* It doubles the testing effort required for a particular kernel. I can
  guarantee that we will miss bugs (even amazingly bad build bugs)
  because no-one will be able to test a full suite of kernels.

* It introduces the possibility of completely pointles arbitrary
  differences between the two. How long until we see the first bug-fix
  that only works in one configuration?

* It creates additional work for distributions, which need to build mor=
e
  kernels test them, distribute them, and document which platforms whic=
h
  kernels are supported on. This creates more pain for end-users too.
 =20
Eventually we _will_ get fed up with all of those, and we'll have to do
painful invasive work to make the kernel decide at runtime.

Having separate kernels is a lazy shortcut. It's painful for everyone,
leads to a greater maintenance overhead, it's not what we want now and
not what we want in future.

No thanks.

Either the kernel figures out whether or not to deal with ACPI at
runtime, or it doesn't deal with it at all.

Thanks,
Mark.
