Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFA257827
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827509; cv=none; b=k1+QBT0WWwIrcFA5m4fgU1Xv6Sn+g3GnJnuHsVEqtfqnM1VGt5RLNPo23FEsTlv/KkKOks8W8ivUoRu6420/F5K6WXmBW8cWoJJu1fd4N4UTU9nPOgYKiiLfMuGIo2Yg6SU7Gz6cGIyyMp1aRxk4ym8kdJL94NJR8hBmO2aWlsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827509; c=relaxed/simple;
	bh=s9WEmNzJ7PugC/DnlPgjpnmqVNq+rDZInzavzbgSbhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SveG/g6kiHOzbSjpccxvWGT57vZnC3V+ttSrVoN6Ielw7cSuhvkiH1ysYSzHdPUuQue/DtFPRtBoM1M1ctlUPDMUolTvB4SCqKkBKS7rHrrMKlMZGRE01f+7DCfsMvU66dwfCboBPFPOYMZAE7ckbVbpYFrbk87hLY+xdabc88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgBNarYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgBNarYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24AA1F0089E
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789827507;
	bh=mZmhTSapLBy8zr+eL8Hk3MA6COYZAIlxVl61QR3Tv94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mgBNarYWfjhlA0GGZctJwWkSmimae+JQil1hmwHDE2Syps0opVNtDQaHGOte0nean
	 +crges24kzyJJ3utD6HHE4ugV4Cgern8kzVNLVXQldyrK+c8hUWlHVQ3puurtbeBxG
	 dPK7MO1y+eN4FTeRbxWsm4/ibTv+6/y8hYQGHMdOZhelXpEL+9+QoxiuU/YHTyneYu
	 tgmZpKXYn/jH5t0+R1iJGi8JdbDw16b3biuUp6a7EBBGC0FMgpjf5untZuRK5SGd2h
	 ZY1bvQU48XhU7LKSOqz+28NjlBPtLVZAR3krGM5ELgelr7jBn6o5XEyDYlrNxff+h1
	 8CuaH4X2k+S6Q==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so2102533a12.3
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 07:18:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxTc05l4yyW9/smjyH3K7roT6cDFmT9oKs4emMKtQmzuwbttRkw/+6ElD2C7TPgy4cMgUyFSxxeMDLU@vger.kernel.org
X-Gm-Message-State: AFuF++nlyh4WLUswK9VbFAzNkf+9nJEZCnWCb6rkyYn/S4FBr+mc7wAl
	U81mdKnZOtB+GTYovY52/KqCr36fA7M5jgX/6bKtdx2KxUuzrJzMWC3dXcZEUyCj0mdsiDrO9VV
	zX3+vQKXzI/m1aP/QdPe8sdmed5wqNO4=
X-Received: by 2002:a05:6402:320a:b0:6aa:fc6:f684 with SMTP id
 4fb4d7f45d1cf-6aa545f7720mr4366093a12.9.1789827506526; Sat, 19 Sep 2026
 07:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915032627.2796747-1-maobibo@loongson.cn> <20260915032627.2796747-4-maobibo@loongson.cn>
In-Reply-To: <20260915032627.2796747-4-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 19 Sep 2026 22:18:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H71irZnQ2hYmsewC6_fZEjnwBm6VJVcKqTsjJGW2xZDBA@mail.gmail.com>
X-Gm-Features: AcwNN1XVpEQjqs5UQSPxVXGpkwvoDUFcEbBrZM5YbTr3iIGSGV74GLw8Ro5J2RU
Message-ID: <CAAhV-H71irZnQ2hYmsewC6_fZEjnwBm6VJVcKqTsjJGW2xZDBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ACPI: scan: Add support for LoongArch in acpi_iommu_configure_id()
To: Bibo Mao <maobibo@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, Sep 15, 2026 at 11:34=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> acpi_iommu_configure_id() currently supports only IORT and VIOT. Add
> support for IOVT as well.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> ---
>  drivers/acpi/loongarch/iovt.c | 61 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/scan.c           |  3 ++
>  include/linux/acpi_iovt.h     | 13 ++++++++
>  3 files changed, 77 insertions(+)
>  create mode 100644 include/linux/acpi_iovt.h
>
> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.=
c
> index 302ca6a75905..df14ce48eac6 100644
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
> +               if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT) {
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
> index 163a3cccf197..f2f155a65ea9 100644
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
> @@ -1628,6 +1629,8 @@ static int acpi_iommu_configure_id(struct device *d=
ev, const u32 *id_in)
>                 err =3D rimt_iommu_configure_id(dev, id_in);
>         if (err && err !=3D -EPROBE_DEFER)
>                 err =3D viot_iommu_configure(dev);
> +       if (err && err !=3D -EPROBE_DEFER)
> +               err =3D iovt_iommu_configure_id(dev, id_in);
We call our acpi_arch_late_init() before acpi_viot_init(), so I think
it is better to also call iovt_iommu_configure_id() before
viot_iommu_configure().


Huacai
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
