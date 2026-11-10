Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331102;
	b=DNyavd+28xbynYxJaL+fLEP2C/P4o6nyd7Bpq93qEsorH+R2XtWZWFVidrxK5fkcsE0L
	 0EqxORvmYa8Nt6cMGLEKRUPwU/oI1m4kNzvQ80XBnDogYlkdBw5lcb67z3PSxvM1rWslJ
	 Rz4X5/cunz8zPplcgsuowyEZ+WpwA2uQ4CdOnqYnReDB5eZfWS9pa43Qfp/l49F3NfBnn
	 ekAPsmvSmue8kitzC42y1k2GkHCP9RVn2UPWdIoaaBNyeEDtvvwbQoHplQhTxH6CwLPh2
	 Mr8zlKCllJaBkZHrbn3MujhhxtI8xDXfGM6eW1uVMt9n6Qvaiy9K4odhpJcukZKXTCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331102;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j8FQxXo6FZUSPml10ShMZBraDuh0DWA615xV0ciloLk=;
	b=dwK8mvryAbvDaCkGVf+DrDMOiKRvGWeisE3VYuxu52RvG9CMQdWT23MqsQTmJxV1xIas
	 GEyl6PLHjMDZ9W9OajUwhlJhH1YkLd8o9Q4mCK5nkk43/ogKM+GVEoYxNbntIBvG8nVHz
	 zcK+SoW7jcCUvKqa+rCtOTHhZXWCImmth9VqjB9Stlq5uYgVvXzXhvOa20iBQUHulD44H
	 HyP5diAFIXh1zUWE9uBOYJODg2IhzaK0xd54Xghj9sitktgr/GhnOXVD7OZxFCltAcUux
	 v9wYypbGEACCi/qx5Y3gBxQ4y7smoPIqWQtejEAz04J+BebQ1zH3LLYaL6a8MpalQ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jG+BSeHj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FC606A31C
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jG+BSeHj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C071F008A1
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331101;
	bh=j8FQxXo6FZUSPml10ShMZBraDuh0DWA615xV0ciloLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jG+BSeHjSHYbttSCCymAJ3DaRyR9zliWw87phwR6/zmYgWs76EuEntVdQod9FPCfB
	 0zyNmvS4m4o+263qcmt7ggEpQtR5g2oo0jiCXdZwYqHpmMqV3IMgvgaLdGREOIsYqK
	 LrLn5fsxHN5fkXqyty7hczX+2aDbeSDr6fv/1N6uw/7pZFMCqZGjnjb1NrZBdbhG4v
	 fJ1SUMZaAlbWc4BEe6m5xZGyuc6qGfOGDN80RG0OIDf8RS/463QBxHf368Ezki072k
	 5Y/sVhOuIHHkonK0aRdGxS08jTZzUI1xfUGayaStzNv/ikg7a485fFXmA83Tmw3oNA
	 h78lr397HabLA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c1593fd141so863419e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 09:18:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHrkLkp/xS5bZ/jRZ1ymfL6x6vLHww9aR4p3cYwNStbkayhkJgyZV8XvinG5JssT+RbzFYoiJSEGjsp@vger.kernel.org
X-Gm-Message-State: APuU4Z9/lGKB+34wXrtJ7I4BAVuCIWUOxLq2bWhfE8I8skOesAYdTDe1
	7OU7DS4YnvZ3TDdohyHxaBuEXk75uKdP3A0TGFiqLdHGhQ/AijENv+UwoxsFpl4lMXm6wM6CLsn
	hpZ9C+SsaZWNB7/xffNv1jzy3LyEbLfc=
X-Received: by 2002:ac2:4e11:0:b0:5bf:d26e:7992 with SMTP id
 2adb3069b0e04-5c156e98223mr999573e87.28.1794331100266; Tue, 10 Nov 2026
 09:18:20 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103084718.8222-1-paul.cercueil@bootlin.com>
In-Reply-To: <20261103084718.8222-1-paul.cercueil@bootlin.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 18:18:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hi_+FCGCXqV71GwgPDpymNZsUv9jRwjLK2BFJV3sqmiA@mail.gmail.com>
X-Gm-Features: AclHuK-lgsf-2gKRSMJHDvvVaIgTtJKozCmDx_eo2YPCTpCkHxspQOm0_gh4sqM
Message-ID: <CAJZ5v0hi_+FCGCXqV71GwgPDpymNZsUv9jRwjLK2BFJV3sqmiA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform: Add basic support for ACPI 6.5 fixed
 clock resources
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:47=E2=80=AFAM Paul Cercueil <paul.cercueil@bootlin=
.com> wrote:
>
> ACPI 6.5 introduced a clock input resource descriptor, which allows to
> specify in the ACPI tables what clocks are connected to a given device.
>
> This patch adds support for the most basic clock resource, which is the
> one that represents a fixed clock. The new code will then create a
> clk_hw for each fixed clock resource, which is then made available to
> the device drivers, that can obtain it through a regular call to
> clk_get(NULL).
>
> Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

You need to look at Sashiko's feedback on this:

https://sashiko.dev/#/patchset/20261103084718.8222-1-paul.cercueil%40bootli=
n.com

> ---
>  drivers/acpi/acpi_platform.c | 64 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 80ea7121744d..bae6a2eacd71 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -10,17 +10,27 @@
>
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/ioport.h>
> +#include <linux/kconfig.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/units.h>
>
>  #include "internal.h"
>
> +struct acpi_clk_data {
> +       struct device *dev;
> +       unsigned int idx;
> +};
> +
>  /* Exclude devices that have no _CRS resources provided */
>  #define ACPI_ALLOW_WO_RESOURCES                BIT(0)
>
> @@ -130,6 +140,57 @@ static unsigned int acpi_platform_resource_count(str=
uct acpi_resource *ares, voi
>         return AE_CTRL_TERMINATE;
>  }
>
> +static int acpi_add_fixed_clock(struct acpi_resource *res, void *d)
> +{
> +       static const unsigned long clk_scale[] =3D { 1, HZ_PER_KHZ, HZ_PE=
R_MHZ };
> +       struct acpi_resource_clock_input *clkres;
> +       struct acpi_clk_data *data =3D d;
> +       struct device *dev =3D data->dev;
> +       struct clk_hw *clk;
> +       unsigned long rate;
> +       char name[64];
> +       int err;
> +
> +       if (res->type =3D=3D ACPI_RESOURCE_TYPE_CLOCK_INPUT) {
> +               clkres =3D &res->data.clock_input;
> +
> +               if (clkres->mode) {
> +                       dev_warn(dev, "Only fixed rate clocks supported f=
or now.\n");
> +                       return 1; /* keep going */
> +               }
> +
> +               if (clkres->frequency_divisor =3D=3D 0)
> +                       return -EINVAL;
> +
> +               rate =3D DIV_ROUND_UP(clkres->frequency_numerator * clk_s=
cale[clkres->scale],
> +                                   clkres->frequency_divisor);
> +
> +               clk =3D devm_clk_hw_register_fixed_rate(dev, dev_name(dev=
), NULL, 0, rate);
> +               if (IS_ERR(clk))
> +                       return PTR_ERR(clk);
> +
> +               snprintf(name, sizeof(name), "%s-clk%u", dev_name(dev), d=
ata->idx++);
> +
> +               err =3D devm_clk_hw_register_clkdev(dev, clk, name, dev_n=
ame(dev));
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 1;
> +}
> +
> +static void acpi_platform_init_clocks(struct acpi_device *adev)
> +{
> +       struct device *dev =3D &adev->dev;
> +       struct acpi_clk_data data =3D { .dev =3D dev };
> +       LIST_HEAD(list);
> +       int ret;
> +
> +       ret =3D acpi_dev_get_resources(adev, &list, acpi_add_fixed_clock,=
 &data);
> +       if (ret < 0)
> +               dev_err(dev, "Failed to add clock resources: %d\n", ret);
> +}
> +
>  /**
>   * acpi_create_platform_device - Create platform device for ACPI device =
node
>   * @adev: ACPI device node to create a platform device for.
> @@ -217,6 +278,9 @@ struct platform_device *acpi_create_platform_device(s=
truct acpi_device *adev,
>         else
>                 pdevinfo.dma_mask =3D 0;
>
> +       if (IS_ENABLED(CONFIG_COMMON_CLK))
> +               acpi_platform_init_clocks(adev);
> +
>         pdev =3D platform_device_register_full(&pdevinfo);
>         if (IS_ERR(pdev))
>                 dev_err(&adev->dev, "platform device creation failed: %ld=
\n",
> --
