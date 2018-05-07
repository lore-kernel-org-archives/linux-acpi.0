From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
Date: Mon, 7 May 2018 21:44:48 +0000
Message-ID: <BN6PR12MB1809A66A78024F2E519A1A34F79B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
 <1525688013-9928-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525688013-9928-2-git-send-email-akshu.agrawal@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "Koenig, Christian" <Christian.Koenig@amd.com>, "airlied@redhat.com" <airlied@redhat.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Agrawal, Akshu
> Sent: Monday, May 7, 2018 6:14 AM
> Cc: djkurtz@chromium.org; Agrawal, Akshu <Akshu.Agrawal@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>;
> mturquette@baylibre.com; sboyd@kernel.org; Koenig, Christian
> <Christian.Koenig@amd.com>; airlied@redhat.com; Liu, Shaoyun
> <Shaoyun.Liu@amd.com>; linux-kernel@vger.kernel.org; linux-
> clk@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; linux-
> acpi@vger.kernel.org
> Subject: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
>=20
> Stoney SoC provides oscout clock. This clock can support 25Mhz and 48Mhz
> of frequency.
> The clock is available for general system use.
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
> v2: config change, added SPDX tag and used clk_hw_register_.
> v3: Fix kbuild warning for checking of NULL pointer
> v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
>  drivers/clk/x86/Makefile             |  3 +-
>  drivers/clk/x86/clk-st.c             | 85
> ++++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/clk-st.h | 17 ++++++++
>  3 files changed, 104 insertions(+), 1 deletion(-)  create mode 100644
> drivers/clk/x86/clk-st.c  create mode 100644
> include/linux/platform_data/clk-st.h
>=20
> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile index
> 1367afb..00303bc 100644
> --- a/drivers/clk/x86/Makefile
> +++ b/drivers/clk/x86/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_PMC_ATOM)		+=3D clk-pmc-atom.o
> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+=3D clk-st.o
>  clk-x86-lpss-objs		:=3D clk-lpt.o
>  obj-$(CONFIG_X86_INTEL_LPSS)	+=3D clk-x86-lpss.o
> -obj-$(CONFIG_PMC_ATOM)		+=3D clk-pmc-atom.o
> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c new file=
 mode
> 100644 index 0000000..8a7795c
> --- /dev/null
> +++ b/drivers/clk/x86/clk-st.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0

Should this be MIT?  The original license was MIT.

Alex

> +/*
> + * clock framework for AMD Stoney based clocks
> + *
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_data/clk-st.h> #include
> +<linux/platform_device.h>
> +
> +/* Clock Driving Strength 2 register */
> +#define CLKDRVSTR2	0x28
> +/* Clock Control 1 register */
> +#define MISCCLKCNTL1	0x40
> +/* Auxiliary clock1 enable bit */
> +#define OSCCLKENB	2
> +/* 25Mhz auxiliary output clock freq bit */
> +#define OSCOUT1CLK25MHZ	16
> +
> +#define ST_CLK_48M	0
> +#define ST_CLK_25M	1
> +#define ST_CLK_MUX	2
> +#define ST_CLK_GATE	3
> +#define ST_MAX_CLKS	4
> +
> +static const char * const clk_oscout1_parents[] =3D { "clk48MHz",
> +"clk25MHz" };
> +
> +static int st_clk_probe(struct platform_device *pdev) {
> +	struct st_clk_data *st_data;
> +	struct clk_hw **hws;
> +
> +	st_data =3D dev_get_platdata(&pdev->dev);
> +	if (!st_data || !st_data->base)
> +		return -EINVAL;
> +
> +	hws =3D devm_kzalloc(&pdev->dev, sizeof(*hws) * ST_MAX_CLKS,
> GFP_KERNEL);
> +	if (!hws)
> +		return -ENOMEM;
> +
> +	hws[ST_CLK_48M] =3D clk_hw_register_fixed_rate(NULL, "clk48MHz",
> NULL, 0,
> +						     48000000);
> +	hws[ST_CLK_25M] =3D clk_hw_register_fixed_rate(NULL, "clk25MHz",
> NULL, 0,
> +						     25000000);
> +
> +	hws[ST_CLK_MUX] =3D clk_hw_register_mux(NULL, "oscout1_mux",
> +		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
> +		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0,
> NULL);
> +
> +	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
> +
> +	hws[ST_CLK_GATE] =3D clk_hw_register_gate(NULL, "oscout1",
> "oscout1_mux",
> +		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
> +		CLK_GATE_SET_TO_DISABLE, NULL);
> +
> +	clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
> +
> +	platform_set_drvdata(pdev, hws);
> +	return 0;
> +}
> +
> +static int st_clk_remove(struct platform_device *pdev) {
> +	struct clk_hw **hws;
> +	int i;
> +
> +	hws =3D platform_get_drvdata(pdev);
> +
> +	for (i =3D 0; i < ST_MAX_CLKS; i++)
> +		clk_hw_unregister(hws[i]);
> +	return 0;
> +}
> +
> +static struct platform_driver st_clk_driver =3D {
> +	.driver =3D {
> +		.name =3D "clk-st",
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe =3D st_clk_probe,
> +	.remove =3D st_clk_remove,
> +};
> +builtin_platform_driver(st_clk_driver);
> diff --git a/include/linux/platform_data/clk-st.h
> b/include/linux/platform_data/clk-st.h
> new file mode 100644
> index 0000000..188184d
> --- /dev/null
> +++ b/include/linux/platform_data/clk-st.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * clock framework for AMD Stoney based clock
> + *
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef __CLK_ST_H
> +#define __CLK_ST_H
> +
> +#include <linux/compiler.h>
> +
> +struct st_clk_data {
> +	void __iomem *base;
> +};
> +
> +#endif /* __CLK_ST_H */
> --
> 1.9.1
