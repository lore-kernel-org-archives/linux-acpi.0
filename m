Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AC37702C;
	Tue, 21 Jul 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653054; cv=none; b=IRbrN753ZjpCA6T7YfIGFgXQqlzhM5oKHGOyqgIberrgUUl4YTv4vlltVYk3W9KhvnSTSFf6XTNPRjaWXTKBRaW6zAnylOdo9vjQBdPKn/wja8udyl2TkweCLu2NpcFiXWAw6V40ZUDj2sAnuU2NuQ0w/B/8w933cqIvgPwNsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653054; c=relaxed/simple;
	bh=sRQJqlL3yg9NvL6hLUmUFuyccZ46xa1FqXuipZq20XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTRpO6GWF+/Z3XcrqW+onXnT52z6NKBPGiP4H7dzptJoFU3FopcaD+clu1527ZbYhbqX4zrIl/31mvSBxJGJsQm7BMb8GgmXFZimXs0r6L4AHyXAGSI1Q4aA9ZXogWs8fogBAa7nEwOQuFH7ts0l0u3mV6JJg7rsv9dhVSAYmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1YuF8HN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1YuF8HN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400481F000E9;
	Tue, 21 Jul 2026 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653052;
	bh=+Yvz1VbNlr+9jCpw+hwc12v+ZMFgJIMsPEyA15hJE1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R1YuF8HN/L+JYcvi+LWKIhjJAyttCWip5wZZoDbEwh9E++DtQG1FIANnZykXIl6v/
	 noNBP0TsBtEsaXlFGk6eFh4KHeR9ogjv88IcYM1X9MpJinbJ6YSEHx6IyhOV8poNFJ
	 3BBHJ2FK2aOohLgtAn1iPVAikwjkHamS+25wrcEh2NbgHH2M2IxYFWk85Je0pnIDQA
	 59TdLS/N17xc33HmNG6EtcnvVRHg29/y/tTFOEu3Et0cuJ0UUpUKByHtaFcYefEp/k
	 cZikFt3yp3OswMpyzrX6xOHVpM2GQCPCr9/VP5ARFD3IYil71uscMXOGQQ45Lfvwn8
	 MrwZUpnoeparg==
Date: Tue, 21 Jul 2026 17:57:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marco Giunta <marco_giunta@outlook.it>, tiwai@suse.com, perex@perex.cz,
	lgirdwood@gmail.com, LKML <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
	Hans de Goede <hansg@kernel.org>, linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, wangweidong.a@awinic.com,
	nadim@symbolic.software, imitoy@imitoy.top, munzirtaha@gmail.com,
	yakov.till@gmail.com
Subject: Re: [PATCH 1/8] ASoC: aw88399: extract shared device library
Message-ID: <dee6db83-7e09-4d72-91d7-c85ae1309550@sirena.org.uk>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
 <DS7PR19MB772415C485FAF74297673FD7FCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
 <68b8e29c-e7d4-ca19-2e40-ad3eade6d94d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FS0zc9MIoz7/weKh"
Content-Disposition: inline
In-Reply-To: <68b8e29c-e7d4-ca19-2e40-ad3eade6d94d@linux.intel.com>
X-Cookie: Love America -- or give it back.


--FS0zc9MIoz7/weKh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 06:21:04PM +0300, Ilpo J=E4rvinen wrote:
> On Fri, 17 Jul 2026, Marco Giunta wrote:
>=20
> > Extract the device-level functions from aw88399.c into a new shared
> > library module (aw88399-lib.c) with a shared header at
> > include/sound/aw88399.h, following the pattern established by CS35L41
> > (cs35l41-lib.c / include/sound/cs35l41.h) for chips that need both
> > ASoC and HDA drivers.
> >=20
> > The shared header at include/sound/aw88399.h contains the register
> > definitions, bit-field masks, hardware constants, device enums, the
> > struct aw88399 definition, and the library function declarations.
> > The ASoC-private header at sound/soc/codecs/aw88399.h is reduced to
> > ASoC-specific definitions (PCM formats/rates, ALSA kcontrol helpers,
> > calibration constants) and includes the shared header.
> >=20
> > The library contains the chip initialization, firmware loading,
> > playback start/stop sequences, and all their internal dependencies
> > (PLL checks, DSP management, volume control, calibration, CRC
> > verification, etc.). The ASoC codec driver retains the ALSA controls,
> > DAPM widgets, codec probe/remove, calibration service, and I2C bus
> > driver registration.
> >=20
> > A new Kconfig symbol SND_SOC_AW88399_LIB is introduced.
> > SND_SOC_AW88399 (the existing ASoC codec) selects it, ensuring no
> > change for current users. The HDA side codec driver (introduced
> > later in this series) selects the library without pulling in the
> > full ASoC codec module. This avoids a build-time dependency on the
> > full ASoC driver and follows the established pattern used by CS35L41
> > (SND_SOC_CS35L41_LIB) for chips with both ASoC and HDA drivers.
> >=20
> > Some library functions (DSP control, volume setting, mute,
> > calibration updates, profile management, and status helpers) are
> > used internally by the library's start/stop sequences but are also
> > called directly by the ASoC driver's remaining code.
> > These are exported from the library so the ASoC module can access them.
> >=20
> > This is a pure code movement with no functional changes. The moved
> > functions are identical to their originals in aw88399.c.
> >=20
> > Tested-by: Nadim Kobeissi <nadim@symbolic.software>
> > Tested-by: Xia Yun'an <imitoy@imitoy.top>
> > Tested-by: Munzir Taha <munzirtaha@gmail.com>
> > Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
> > ---
> >  include/sound/aw88399.h        |  618 ++++++++++++++
> >  sound/soc/codecs/Kconfig       |    5 +
> >  sound/soc/codecs/Makefile      |    2 +
> >  sound/soc/codecs/aw88399-lib.c | 1381 ++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/aw88399.c     | 1349 -------------------------------
> >  sound/soc/codecs/aw88399.h     |  582 +-------------
> >  6 files changed, 2008 insertions(+), 1929 deletions(-)
> >  create mode 100644 include/sound/aw88399.h
> >  create mode 100644 sound/soc/codecs/aw88399-lib.c
> >=20
> > diff --git a/include/sound/aw88399.h b/include/sound/aw88399.h
> > new file mode 100644
> > index 000000000000..3a2153f0ee92
> > --- /dev/null
> > +++ b/include/sound/aw88399.h
> > @@ -0,0 +1,618 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + *
> > + * linux/sound/aw88399.h --  Platform data for AW88399
> > + *
> > + * Copyright (c) 2023 AWINIC Technology CO., LTD
> > + *
> > + * Author: Weidong Wang <wangweidong.a@awinic.com>
> > + */
> > +
> > +#ifndef __SOUND_AW88399_H
> > +#define __SOUND_AW88399_H
> > +
> > +#include <linux/mutex.h>
> > +#include <linux/workqueue.h>
> > +
> > +/* registers list */
> > +#define AW88399_ID_REG			(0x00)
> > +#define AW88399_SYSST_REG		(0x01)
> > +#define AW88399_SYSINT_REG		(0x02)
> > +#define AW88399_SYSINTM_REG		(0x03)
> > +#define AW88399_SYSCTRL_REG		(0x04)
> > +#define AW88399_SYSCTRL2_REG		(0x05)
> > +#define AW88399_I2SCTRL1_REG		(0x06)
> > +#define AW88399_I2SCTRL2_REG		(0x07)
> > +#define AW88399_I2SCTRL3_REG		(0x08)
> > +#define AW88399_DACCFG1_REG		(0x09)
> > +#define AW88399_DACCFG2_REG		(0x0A)
> > +#define AW88399_DACCFG3_REG		(0x0B)
> > +#define AW88399_DACCFG4_REG		(0x0C)
> > +#define AW88399_DACCFG5_REG		(0x0D)
> > +#define AW88399_DACCFG6_REG		(0x0E)
> > +#define AW88399_DACCFG7_REG		(0x0F)
> > +#define AW88399_MPDCFG1_REG		(0x10)
> > +#define AW88399_MPDCFG2_REG		(0x11)
> > +#define AW88399_MPDCFG3_REG		(0x12)
> > +#define AW88399_MPDCFG4_REG		(0x13)
> > +#define AW88399_PWMCTRL1_REG		(0x14)
> > +#define AW88399_PWMCTRL2_REG		(0x15)
> > +#define AW88399_PWMCTRL3_REG		(0x16)
> > +#define AW88399_I2SCFG1_REG		(0x17)
> > +#define AW88399_DBGCTRL_REG		(0x18)
> > +#define AW88399_HAGCST_REG		(0x20)
> > +#define AW88399_VBAT_REG		(0x21)
> > +#define AW88399_TEMP_REG		(0x22)
> > +#define AW88399_PVDD_REG		(0x23)
> > +#define AW88399_ISNDAT_REG		(0x24)
> > +#define AW88399_VSNDAT_REG		(0x25)
> > +#define AW88399_I2SINT_REG		(0x26)
> > +#define AW88399_I2SCAPCNT_REG		(0x27)
> > +#define AW88399_ANASTA1_REG		(0x28)
> > +#define AW88399_ANASTA2_REG		(0x29)
> > +#define AW88399_ANASTA3_REG		(0x2A)
> > +#define AW88399_TESTDET_REG		(0x2B)
> > +#define AW88399_DSMCFG1_REG		(0x30)
> > +#define AW88399_DSMCFG2_REG		(0x31)
> > +#define AW88399_DSMCFG3_REG		(0x32)
> > +#define AW88399_DSMCFG4_REG		(0x33)
> > +#define AW88399_DSMCFG5_REG		(0x34)
> > +#define AW88399_DSMCFG6_REG		(0x35)
> > +#define AW88399_DSMCFG7_REG		(0x36)
> > +#define AW88399_DSMCFG8_REG		(0x37)
> > +#define AW88399_TESTIN_REG		(0x38)
> > +#define AW88399_TESTOUT_REG		(0x39)

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--FS0zc9MIoz7/weKh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpfpPYACgkQJNaLcl1U
h9BxUQf/VY4NV9txVgbL/xVoZWTQK42ZZf9Bvx1/gYkSUOgdULWJQdxwa+QgvxY7
AGmJ9518BfnupE9ijpZmJDNy8J8RyXkKliBf4Nt1eSdAiXLpIqqcskNh/fvgD7HH
qMlxjYPBuX3KgVQXn2LuDQvHJDr6mjmP8lf86U3wwTCgkGzapn4NfrlAcKgkK48u
izYF7tZtmv+leLA5hj0VR9H7UsjwxD94c7oloFljQ4ZoExSEFV6kPE4sICIX36EC
kDMmxBqEq7rzBTp971Vvna6MRkfJe+T/LercTnpz7ul13U/4xyJhPOPoXIyZ36I1
uQtyrHVOXSlvoJgNSG+3XSEbXChHbA==
=FdbR
-----END PGP SIGNATURE-----

--FS0zc9MIoz7/weKh--
