Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488660;
	b=bYcYMISZ3sGcbPGqzMOMpJ2/7L4yUcmfVGZ1K55qxMoKPy5AV9W9KkTwzdr2rPNXhhJ7
	 ICQdKqZe5Z6L3FUQy3wdXiL8RWJUrIYfXS7B8BF8gXgv4aYwWqYKMunV5Qf5k54k6M1c/
	 n1IQxzb+ixu89iztrc+vcPii8ca057Gj9tiRSHh91FRHUwhIsH58+fIYhrgOQL6e0a/bh
	 faGWiAdyrqd+A+50AcEFdfMASPwQgEqWJP47kaWQCZXyHcKeaIxNAOgvcXRCNL7OvUIMJ
	 m904eVe1MxPXauoVgExVqC9iTYDYs9OVLeSDXH01Ba4aGLNWzW2YBHoJX93VDvY3Xyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488660;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=FazWs8jp3Tiswz7nCpkhqYJ6EHXn89P/WpbYmozbrYE=;
	b=PrMxl0ddlO1HwMTOXllXzq58iw0RB0XJ+I4fnlidm8EsJTTnTHUD5PNDORzz4baKzC7f
	 FneI5OtH2twmdTBEAlvDNuzzckxrF5sWwGRNom9KylDg3xXthDUWeRLCsNAyl4E4XmHNP
	 I4IhgBqv79j2Oo9iUTvcAkynqSjInlWTvXQhlI+63M7QLpknmRWa4n2+EK7z276sLn9ss
	 C3ItjRTAxumFnVuEEi/M4kxBfgklIf+xn/p1L/DcYgqUMWV58RQ9mOaov0q7HTnL/ji0D
	 eFMGqCGBu+uRI8EygIs0saG2UpkdI/VlUmNrfHYjLB22Q5FALYQ98iT+s4vwK47w8uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=L8vjgZzz;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBD606A32A;
	Thu, 12 Nov 2026 13:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDBD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=L8vjgZzz
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 140F74E4158C;
	Thu, 12 Nov 2026 13:04:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D5662601D5;
	Thu, 12 Nov 2026 13:04:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E477111BC0490;
	Thu, 12 Nov 2026 14:04:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794488657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FazWs8jp3Tiswz7nCpkhqYJ6EHXn89P/WpbYmozbrYE=;
	b=L8vjgZzzhUHlMXfPjZRzPq88Fvu9zCdjTzSBPbElh0dWXsdyZU+rvidedpfUDqZie9f6sM
	9VY1a0x9J4clWOrK999ZhNqd7jD51Ud9mlHt4A0QUEOAcGpUjI36f9NfBoSloWmd2mAes0
	6YVYV92IP41si+55QQXpYsVrTYxzS3DrIJ679QbDbT3KRVWxjgVJ6ZT/gog6HkdvkNcCfh
	YYIuO1whK4sWbnHtot5abPliWEfeZajiIqiPjHnj9KSSz1qbgD1zaChvitc0sklHozMcEO
	S9Peckw4UHT0UC2SoSj6GMfoE31sZNzsR2b1i1T9BeumKNukqmEviJgs0RyK3A==
Message-ID: <cf152e73eb4585fc0592bd59882a426ef5ea398d.camel@bootlin.com>
Subject: Re: [PATCH v2] ACPI: platform: Add basic support for ACPI 6.5 fixed
 clock resources
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni	 <thomas.petazzoni@bootlin.com>
Date: Thu, 12 Nov 2026 14:04:12 +0100
In-Reply-To: <20261111100736.98364-1-paul.cercueil@bootlin.com>
References: <20261111100736.98364-1-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi Rafael,

I see Sashiko complains about this patch:
https://sashiko.dev/#/patchset/20261111100736.98364-1-paul.cercueil%40bootl=
in.com

But its only complaint is addressed by a second patch that was sent in para=
llel:
https://lore.kernel.org/linux-arm-kernel/20261103084915.8405-1-paul.cercuei=
l@bootlin.com/T/

In retrospective I probably should have packed both into one patchset; I th=
ought
they were parallelizable enough to go each its own way, but that was withou=
t
thinking about Sashiko.

Cheers,
-Paul

Le mercredi 11 novembre 2026 =C3=A0 11:07 +0100, Paul Cercueil a =C3=A9crit=
=C2=A0:
> ACPI 6.5 introduced a clock input resource descriptor, which allows to
> specify in the ACPI tables what clocks are connected to a given device.
>=20
> This patch adds support for the most basic clock resource, which is the
> one that represents a fixed clock. The new code will then create a
> clk_hw for each fixed clock resource, which is then made available to
> the device drivers, that can obtain it through a regular call to
> clk_get(NULL).
>=20
> Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
>=20
> ---
>=20
> Related:
> https://lore.kernel.org/linux-arm-kernel/20261103084915.8405-1-paul.cercu=
eil@bootlin.com/T/
>=20
> v2:
> - Use the calculated clock name in devm_clk_hw_register_fixed_rate()
> =C2=A0 instead of the device name
> - Make sure clkres->scale is <=3D 2. The field is 2 bits but the value
> =C2=A0 clkres->scale =3D=3D 3 is not defined in the spec.
> - Compute the fraction numerator using 64-bit math, to make sure it
> =C2=A0 won't overflow on 32-bit systems.
> - Initialize clocks only when the device_type matches
> =C2=A0 ACPI_BUS_TYPE_DEVICE.
> - Use a shorter name for clocks as the hard limit is 16 characters
> =C2=A0 including the terminator.
> ---
> =C2=A0drivers/acpi/acpi_platform.c | 64 +++++++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 64 insertions(+)
>=20
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 80ea7121744d..71322cdcf0dd 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -10,17 +10,27 @@
> =C2=A0
> =C2=A0#include <linux/acpi.h>
> =C2=A0#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/ioport.h>
> +#include <linux/kconfig.h>
> =C2=A0#include <linux/kernel.h>
> +#include <linux/list.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/dma-mapping.h>
> =C2=A0#include <linux/pci.h>
> =C2=A0#include <linux/platform_device.h>
> +#include <linux/units.h>
> =C2=A0
> =C2=A0#include "internal.h"
> =C2=A0
> +struct acpi_clk_data {
> +	struct device *dev;
> +	unsigned int idx;
> +};
> +
> =C2=A0/* Exclude devices that have no _CRS resources provided */
> =C2=A0#define ACPI_ALLOW_WO_RESOURCES		BIT(0)
> =C2=A0
> @@ -130,6 +140,57 @@ static unsigned int acpi_platform_resource_count(str=
uct
> acpi_resource *ares, voi
> =C2=A0	return AE_CTRL_TERMINATE;
> =C2=A0}
> =C2=A0
> +static int acpi_add_fixed_clock(struct acpi_resource *res, void *d)
> +{
> +	static const unsigned long clk_scale[] =3D { 1, HZ_PER_KHZ, HZ_PER_MHZ
> };
> +	struct acpi_resource_clock_input *clkres;
> +	struct acpi_clk_data *data =3D d;
> +	struct device *dev =3D data->dev;
> +	struct clk_hw *clk;
> +	unsigned long rate;
> +	char name[64];
> +	int err;
> +
> +	if (res->type =3D=3D ACPI_RESOURCE_TYPE_CLOCK_INPUT) {
> +		clkres =3D &res->data.clock_input;
> +
> +		if (clkres->mode) {
> +			dev_warn(dev, "Only fixed rate clocks supported for
> now.\n");
> +			return 1; /* keep going */
> +		}
> +
> +		if (clkres->frequency_divisor =3D=3D 0 || clkres->scale > 2)
> +			return -EINVAL;
> +
> +		rate =3D DIV_ROUND_UP_ULL((u64)clkres->frequency_numerator *
> clk_scale[clkres->scale],
> +					clkres->frequency_divisor);
> +
> +		snprintf(name, sizeof(name), "%s-%u", dev_name(dev), data-
> >idx++);
> +
> +		clk =3D devm_clk_hw_register_fixed_rate(dev, name, NULL, 0,
> rate);
> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +
> +		err =3D devm_clk_hw_register_clkdev(dev, clk, name,
> dev_name(dev));
> +		if (err)
> +			return err;
> +	}
> +
> +	return 1;
> +}
> +
> +static void acpi_platform_init_clocks(struct acpi_device *adev)
> +{
> +	struct device *dev =3D &adev->dev;
> +	struct acpi_clk_data data =3D { .dev =3D dev };
> +	LIST_HEAD(list);
> +	int ret;
> +
> +	ret =3D acpi_dev_get_resources(adev, &list, acpi_add_fixed_clock,
> &data);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to add clock resources: %d\n", ret);
> +}
> +
> =C2=A0/**
> =C2=A0 * acpi_create_platform_device - Create platform device for ACPI de=
vice node
> =C2=A0 * @adev: ACPI device node to create a platform device for.
> @@ -196,6 +257,9 @@ struct platform_device *acpi_create_platform_device(s=
truct
> acpi_device *adev,
> =C2=A0			}
> =C2=A0			acpi_dev_free_resource_list(&resource_list);
> =C2=A0		}
> +
> +		if (IS_ENABLED(CONFIG_COMMON_CLK))
> +			acpi_platform_init_clocks(adev);
> =C2=A0	}
> =C2=A0
> =C2=A0	memset(&pdevinfo, 0, sizeof(pdevinfo));
