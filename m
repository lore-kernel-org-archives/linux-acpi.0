Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783429;
	b=u53447M9YeCgnIu4k8DEc+JWMvLhQyOLm9DTsk1wfZCRLwXsxfBr8v6VSGpPl/PRkuwp
	 iiFfNsPaqDLtA84ovTQp1in0X6FuEiJfhGSh9goaDHwjZLY6bk05HQil/mUnyF7pfnJvG
	 urcNBEgG88YEKo65iIuOEJchvjOGuMmLprxlnqoyZkfCnAJzGFECRoGVmYK1OZXryZSN5
	 75YX2f/+L50DtR80CZDTuxMO9XZ65WQP+0TJXrhnE8/DmtJaRocTNYOwsbAkBJUiDXkzu
	 JG+0FQ7SlbNkyktrj3tXkOVd5w9dCCTqbqE5E89TQSUEVH/JxO7Lkcp5QN+uSMygEXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783429;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K6o4WaCNvFl65LaFVXvDMyujQeRr+C1WwE1TeM0hXMg=;
	b=iMKkjq2Jgh34aI2aTcNrZ+dQlWI21gaEKbBrbMzqqbJxhHiF94xBCP1NEGWT4OJHxNpJ
	 eGzAqHgVNyCcvscDfpqfibmChpJTkr/g8kLF90haVLSTXiqpWWNV6lc+mH0GOCmHXv+Ca
	 hQlO48YRc2juvvVWWhkNmuzjtaa47T7yHPFbEyoauMD8foSjhLX3/YWOoT/AHDVhnLqe6
	 Dc02D0xDmliX3coyHlS6yup2aZimigxsUObZSEgC64rsE8Ah8cqY4RIklHJQqVV2dC1+4
	 b7eZjSODjv6hcrswB1Bg3b7jo0H2OhJDAR+C2MNDwOgLz/NyDej5uDN/GX/I+uE324g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fI+QM2x7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89366606A31C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fI+QM2x7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8851F0089C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783428;
	bh=K6o4WaCNvFl65LaFVXvDMyujQeRr+C1WwE1TeM0hXMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fI+QM2x7RQDoI8jx8FwkXMiMnpYC3j8dnpIp0/9Mi6tjsI74YJLI95WtjXDgLDO+E
	 25cm9xSnitKp4OT7duf2Xfp20RRy9+D6lys8jJltp0jQLq5aBMm74O7pjEYz2A2IMR
	 gP9CsbEpOzgqKIY1uq0tKa+zG4CyBdfAknJ4/BmlrtxyXcQHQbrYC0vGiW/ERm2PtC
	 x1ZEOdiGB6ErIXNv+dr/Peif4mx8GG8GPXegdsI8M41q/pJdU+JeYxzDgXyBGttYwA
	 I+po/IC3DP+V9xUF/5zUu82Ge9QzLCZvTH92vF2UfSydYdF2ToE1DJmP+o4uSaeXQH
	 HDb8FBIT8Qxfw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ae0d0b9db2so74332511fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 04:43:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGPG+trT9Vj8vq7j3AP4CtxBR9wO56e4nyGrSoenVEOtpk3Yk+3zLLWpL7NCBTkDmdJunghGlIH3i0V@vger.kernel.org
X-Gm-Message-State: APuU4Z/5SXyBVgTAWyQ12fNkiNYlw1VrWFUYOl+L6QpD5yjH9S8P7kza
	g4b6A1ZVvoRYTSd72SThw+csB7wRbboW/4ky0uLYxJY7wdgy91E8HK92AnqFUXIFoE36nRZL3jz
	nThUGHn+VPmlgHvPUXwXo0bKYboJw5dA=
X-Received: by 2002:a05:6512:1049:b0:5c3:3ec5:8ee3 with SMTP id
 2adb3069b0e04-5c33ec59054mr467719e87.37.1795783427175; Fri, 27 Nov 2026
 04:43:47 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120161020.297735-1-paul.cercueil@bootlin.com>
 <20261120161020.297735-2-paul.cercueil@bootlin.com> <CAJZ5v0jeJSx3C8hdU8iAtje-NGNz4DdaVGhE_T3WpVrODuwemg@mail.gmail.com>
 <80b96fc3f728b59b26ebde1378f4222cf4b359b0.camel@bootlin.com>
In-Reply-To: <80b96fc3f728b59b26ebde1378f4222cf4b359b0.camel@bootlin.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 13:43:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g3e26eZG1_yRQzMfPvPYiiv0cHZE70V+_U+NR4kxEpJg@mail.gmail.com>
X-Gm-Features: Aa3M54p-QXCDrJN7873U0bKzfmK7fh9R56kFv3lmFnJS-C0uYHQdc-4p9sWsq8I
Message-ID: <CAJZ5v0g3e26eZG1_yRQzMfPvPYiiv0cHZE70V+_U+NR4kxEpJg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] ACPI: platform: Add basic support for ACPI 6.5
 fixed clock resources
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 11:05=E2=80=AFAM Paul Cercueil
<paul.cercueil@bootlin.com> wrote:
>
> Hi Rafael,
>
> Le mercredi 25 novembre 2026 =C3=A0 21:22 +0100, Rafael J. Wysocki (Intel=
) a =C3=A9crit :
> > On Fri, Nov 20, 2026 at 5:10=E2=80=AFPM Paul Cercueil <paul.cercueil@bo=
otlin.com>
> > wrote:
> > >
> > > ACPI 6.5 introduced a clock input resource descriptor, which allows t=
o
> > > specify in the ACPI tables what clocks are connected to a given devic=
e.
> > >
> > > This patch adds support for the most basic clock resource, which is t=
he
> > > one that represents a fixed clock. The new code will then create a
> > > clk_hw for each fixed clock resource, which is then made available to
> > > the device drivers, that can obtain it through a regular call to
> > > clk_get(NULL).
> > >
> > > Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
> > > ---
> > >
> > > v5: Register fixed clock as "<ACPI_ID>-clkX" because we need a
> > >     system-wide identifier there, and we don't have the 16-characters
> > >     limit there.
> > >     Register the first clock to clkdev without a name, so that
> > >     clk_get(NULL) will obtain it.
> > >     Register every other clock for that ACPI device with a "acpi-clkX=
"
> > >     name.
> > >
> > > v4: Change clock names to "acpi-clkX", because ACPI devices names can=
 be
> > >     up to 17 characters long, and our clock name must be 16 character=
s
> > >     max.
> > >
> > > v3: No change
> > >
> > > v2:
> > > - Use the calculated clock name in devm_clk_hw_register_fixed_rate()
> > >   instead of the device name
> > > - Make sure clkres->scale is <=3D 2. The field is 2 bits but the valu=
e
> > >   clkres->scale =3D=3D 3 is not defined in the spec.
> > > - Compute the fraction numerator using 64-bit math, to make sure it
> > >   won't overflow on 32-bit systems.
> > > - Initialize clocks only when the device_type matches
> > >   ACPI_BUS_TYPE_DEVICE.
> > > - Use a shorter name for clocks as the hard limit is 16 characters
> > >   including the terminator.
> > > ---
> > >  drivers/acpi/acpi_platform.c | 75 ++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 75 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platfor=
m.c
> > > index 80ea7121744d..b4f2ccf3e51f 100644
> > > --- a/drivers/acpi/acpi_platform.c
> > > +++ b/drivers/acpi/acpi_platform.c
> > > @@ -10,17 +10,27 @@
> > >
> > >  #include <linux/acpi.h>
> > >  #include <linux/bits.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/clkdev.h>
> > >  #include <linux/device.h>
> > >  #include <linux/err.h>
> > >  #include <linux/ioport.h>
> > > +#include <linux/kconfig.h>
> > >  #include <linux/kernel.h>
> > > +#include <linux/list.h>
> > >  #include <linux/module.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/units.h>
> > >
> > >  #include "internal.h"
> > >
> > > +struct acpi_clk_data {
> > > +       struct device *dev;
> > > +       unsigned int idx;
> > > +};
> > > +
> > >  /* Exclude devices that have no _CRS resources provided */
> > >  #define ACPI_ALLOW_WO_RESOURCES                BIT(0)
> > >
> > > @@ -130,6 +140,68 @@ static unsigned int acpi_platform_resource_count=
(struct
> > > acpi_resource *ares, voi
> > >         return AE_CTRL_TERMINATE;
> > >  }
> >
> > First off, will clocks only be needed for platform devices?  If not,
> > acpi_add_fixed_clock() should be defined in drivers/acpi/resource.c.
> >
> > > +static int acpi_add_fixed_clock(struct acpi_resource *res, void *d)
> > > +{
> > > +       static const unsigned long clk_scale[] =3D { 1, HZ_PER_KHZ, H=
Z_PER_MHZ
> > > };
> > > +       struct acpi_resource_clock_input *clkres;
> > > +       struct acpi_clk_data *data =3D d;
> > > +       struct device *dev =3D data->dev;
> > > +       const char *name =3D NULL;
> > > +       struct clk_hw *clk;
> > > +       unsigned long rate;
> > > +       unsigned int idx;
> > > +       char buf[64];
> > > +       int err;
> > > +
> > > +       if (res->type =3D=3D ACPI_RESOURCE_TYPE_CLOCK_INPUT) {
> >
> > Maybe
> >
> > if (res->type !=3D ACPI_RESOURCE_TYPE_CLOCK_INPUT)
> >         return 1;
> >
> > > +               clkres =3D &res->data.clock_input;
> > > +
> > > +               if (clkres->mode) {
> > > +                       dev_warn(dev, "Only fixed rate clocks support=
ed for
> > > now.\n");
> >
> > _warn() is likely overkill here and it would be better to print this
> > relative to an ACPI handle, so use acpi_handle_info().
> >
> > > +                       return 1; /* keep going */
> > > +               }
> > > +
> > > +               if (clkres->frequency_divisor =3D=3D 0 || clkres->sca=
le > 2)
> > > +                       return -EINVAL;
> >
> > This is firmware providing bad data, so not -EINVAL.
>
> Right, that's a -EFAULT.
>
> >
> > > +
> > > +               rate =3D DIV_ROUND_UP_ULL((u64)clkres->frequency_nume=
rator *
> > > clk_scale[clkres->scale],
> > > +                                       clkres->frequency_divisor);
> > > +
> > > +               idx =3D data->idx++;
> > > +
> > > +               /* When registering a clk_hw the name must be unique =
across
> > > all devs */
> > > +               snprintf(buf, sizeof(buf), "%s-clk%u", dev_name(dev),=
 idx);
> > > +
> > > +               clk =3D devm_clk_hw_register_fixed_rate(dev, buf, NUL=
L, 0,
> > > rate);
> >
> > Why devm_?  This is called at the device creation time, not in probe,
> > so how/when is clk going to be unregistered?
> >
> > Also, devm_ doesn't work with struct acpi_device which are never
> > probed and drivers are never removed from them.
>
> Ah, good point. That's going to complicate things.
>
> > > +               if (IS_ERR(clk))
> > > +                       return PTR_ERR(clk);
> > > +
> > > +               if (idx > 0) {
> > > +                       /* When registering a clkdev the name must be=
 <=3D 16
> > > characters */
> > > +                       snprintf(buf, sizeof(buf), "acpi-clk%u", idx)=
;
> > > +                       name =3D buf;
> > > +               }
> > > +
> > > +               err =3D devm_clk_hw_register_clkdev(dev, clk, name,
> > > dev_name(dev));
> >
> > Same thing about devm_.
> >
> > > +               if (err)
> > > +                       return err;
> > > +       }
> > > +
> > > +       return 1;
> > > +}
> > > +
> > > +static void acpi_platform_init_clocks(struct acpi_device *adev)
> > > +{
> > > +       struct device *dev =3D &adev->dev;
> >
> > Note that &adev->dev is not a real device.  It is a "firmware node",
> > quite like a DT one, but I guess it may be used for registering
> > clocks.
> >
> > How is a platform device driver going to use those clocks though?
>
> They just use clk_get(). It searches the clock by device name, which work=
s here,

And they would pass the platform device as dev I suppose?

> I guess because the "firmware node" device has the same name as the real =
device.

For platform devices created by acpi_create_platform_device(), yes, it
does, but if that is going to be relied on, that assumption needs to
be documented in a very visible way.

Generally speaking though, they should rather pass the ACPI companion
of the platform device as dev, in which case that the name equality
doesn't matter, and so the clkdev could be created during the struct
acpi_device registration (and the corresponding cleanup would occur
during the struct acpi_device removal which is rare).
