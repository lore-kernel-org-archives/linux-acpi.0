Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586546D2C1
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660872; cv=none; b=NqiuSIVrIzTr59M6/UBC2VfC2kwpuCXV5C0gspy8+ZOYKy8acpIPbvzslDsEbzQ+0mFZArcYaHNxDP+qXbBh3+Bo2zxOuTryIs7tJsM7X9gCQOtf5un9feba0QFnqUc+qLvxGcTGdaXXJl8GbTwCYXVDoTAKctT8sAqD/jlLXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660872; c=relaxed/simple;
	bh=4tscBzJRZUgYvFBQ2Ez5nEJRmnnnNOwGe2pX21ahzsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8SbhP/1pZLmo2w5IXgGKCKDpfZq3Vnyzh/YbYUXFdHgC9MQGaWKWJ/uz6OwOXLzkvwgDyMggOvHhXQ+/s1wPsxJmb8yBCofyMf+y5mrx21JtEJWRnx4gUzEMKunp0ha9euqbq8GdTbXbRqAZuTnJRtF+n1azzRfCi90gVW+qK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8MArcLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8MArcLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E321F00A3F
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660869;
	bh=mY/U83vwkvbX7tXXW/e0fMaqcVSx08EyQlycU/zxvjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I8MArcLmoSDoh/Kvxr2f7QQqNEhT29Xq6ToGPuF0OMBT5IQMCkwTBo8W0+D4XE2P9
	 RsOyjekqAW9PkAecmJJ0aNN5FaMTfzkaux4ChanTEibnc60dpjoSKNX3C1WovHpmaT
	 ThzW/qhR30LifEf/OHfzNpE0mnK+7Q37mVvHDTIMs4iNaUdf/wwWqTLs06EpEmkuzw
	 oFWsv2eEo/n1h01439GJl6PFeNJm1pbQ33HnlbuAPQVjGDKLyE9glkYEcAgWJw9STT
	 AAtyl2pYrqAqZzCTdr5NVMNr5IK62qwuVz2TnQzeks6yRsawE1ZtVR1a9VjJ4iXv8H
	 cDIef/rHWSuxw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b01cb18515so11201003e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:07:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoKAy/PfeCvsaTYTC4WUQDOg568OL3cDn0r7oDQLItZsCE3QpLEti3p1bhHFrST7WtNWRJflMb90FQR@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0bjX5VBHqwnspzvkU7WX4ru2hJ4CTWwUuTlwOuV8so3TX4cj
	2BusRGXyP8PvonJWYFjypNQe2u0IyQibTuYYU05dlXVe6gID0TqWQbVIzoToKJu3fxBv5C+YHkV
	XeLeK2aTO58i8VVBcRrz5Qr40tRrfZzc=
X-Received: by 2002:a05:6512:2398:b0:5ae:bb4b:9357 with SMTP id
 2adb3069b0e04-5b28f9930e4mr4206431e87.27.1784660868128; Tue, 21 Jul 2026
 12:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717063713.3638059-1-maobibo@loongson.cn> <20260717063713.3638059-4-maobibo@loongson.cn>
In-Reply-To: <20260717063713.3638059-4-maobibo@loongson.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 21:07:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gupBWfJu-Mh73N8AjgBBHXBirhzKE9Byc=Cp+ULZNVkA@mail.gmail.com>
X-Gm-Features: AUfX_mzAE98KbZL8elWTwvXZukto__3D8X1U89kF73ZK73S8pr01QGvatVVTcqU
Message-ID: <CAJZ5v0gupBWfJu-Mh73N8AjgBBHXBirhzKE9Byc=Cp+ULZNVkA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ACPI: scan: Add support for LoongArch in acpi_iommu_configure_id()
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 8:44=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> acpi_iommu_configure_id() currently supports only IORT and VIOT. Add
> support for IOVT as well.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

The one-liner in scan.c is fine with me, so

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # ACPI core

for this one, but conditional on the acceptance of the Loongarch-specific p=
arts.

Thanks!

> ---
>  drivers/acpi/loongarch/iovt.c | 61 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/scan.c           |  3 ++
>  include/linux/acpi_iovt.h     | 13 ++++++++
>  3 files changed, 77 insertions(+)
>  create mode 100644 include/linux/acpi_iovt.h
>
> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.=
c
> index fb384664ba78..09fcf09e0f85 100644
> --- a/drivers/acpi/loongarch/iovt.c
> +++ b/drivers/acpi/loongarch/iovt.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>
>  #include <linux/acpi.h>
> +#include <linux/acpi_iovt.h>
>  #include <linux/pci.h>
>  #include "init.h"
>
> @@ -217,3 +218,63 @@ void __init acpi_iovt_late_init(void)
>         iovt_init_devices(hdr);
>         acpi_put_table(hdr);
>  }
> +
> +static int iovt_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, voi=
d *data)
> +{
> +       u32 sbdf;
> +       struct iovt_fwnode *np;
> +       struct device *aliased_dev =3D data;
> +       u32 domain =3D pci_domain_nr(pdev->bus);
> +       struct iovt_device_entry *entry;
> +       bool found =3D false;
> +
> +       list_for_each_entry(np, &iovt_fwnode_list, list) {
> +               if (domain !=3D np->segment)
> +                       continue;
> +
> +               /* We're not translating ourself */
> +               if (dev_id =3D=3D np->devid)
> +                       return -EINVAL;
> +
> +               if (np->flag & ACPI_IOVT_MAGAGE_BY_SEGMENT) {
> +                       found =3D true;
> +                       break;
> +               }
> +
> +               list_for_each_entry(entry, &np->ep_list, list) {
> +                       if (dev_id < entry->start_devid)
> +                               continue;
> +
> +                       if (dev_id > entry->end_devid)
> +                               continue;
> +
> +                       found =3D true;
> +                       break;
> +               }
> +
> +               if (found)
> +                       break;
> +       }
> +
> +       if (!found)
> +               return -ENODEV;
> +
> +       sbdf =3D (domain << 16) + dev_id;
> +       return acpi_iommu_fwspec_init(aliased_dev, sbdf, np->fwnode);
> +}
> +
> +/*
> + * iovt_iommu_configure_id - Set-up IOMMU configuration for a device.
> + *
> + * @dev: device to configure
> + * @id_in: optional input id const value pointer
> + *
> + * Returns: 0 on success, <0 on failure
> + */
> +int iovt_iommu_configure_id(struct device *dev, const u32 *id_in)
> +{
> +       if (!dev_is_pci(dev))
> +               return -ENODEV;
> +
> +       return pci_for_each_dma_alias(to_pci_dev(dev), iovt_pci_dev_iommu=
_init, dev);
> +}
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9a7ac2eb9ce0..508575f25e10 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_iovt.h>
>  #include <linux/acpi_rimt.h>
>  #include <linux/acpi_viot.h>
>  #include <linux/iommu.h>
> @@ -1629,6 +1630,8 @@ static int acpi_iommu_configure_id(struct device *d=
ev, const u32 *id_in)
>                 err =3D rimt_iommu_configure_id(dev, id_in);
>         if (err && err !=3D -EPROBE_DEFER)
>                 err =3D viot_iommu_configure(dev);
> +       if (err && err !=3D -EPROBE_DEFER)
> +               err =3D iovt_iommu_configure_id(dev, id_in);
>
>         mutex_unlock(&iommu_probe_device_lock);
>
> diff --git a/include/linux/acpi_iovt.h b/include/linux/acpi_iovt.h
> new file mode 100644
> index 000000000000..25a846b96260
> --- /dev/null
> +++ b/include/linux/acpi_iovt.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ACPI_IOVT_H__
> +#define __ACPI_IOVT_H__
> +
> +#if defined(CONFIG_IOMMU_API) && defined(CONFIG_ACPI_IOVT)
> +int iovt_iommu_configure_id(struct device *dev, const u32 *id_in);
> +#else
> +static inline int iovt_iommu_configure_id(struct device *dev, const u32 =
*id_in)
> +{ return -ENODEV; }
> +#endif
> +
> +#endif
> --
> 2.39.3
>
