Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD348343D72
	for <linux-acpi@vger.kernel.org>; Sun, 20 Sep 2026 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789869322; cv=none; b=YEerwq6OrRPRC8/qaWojcQC9XDbvfAzooy/53XaPbyd4oq1pV60D47/RVsEVBn7wGNsSn5or5Wg9futMYqFCW7s1qVIyolYUiWj2WiZtDM2qSUppxsSU/Wesm61fJ1g0PA2ufkNYPfkW9aYBZsBEagev/HbwS4gDGSrLU5PiuBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789869322; c=relaxed/simple;
	bh=poh4F5PXaukyjnPCZwS2DZS1b7KW7Q1Rye+o7VN3FUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9uljAas82A+auE0bqV5Vw8DtR1nxky2wo0SLzt9IA+fQ4Q8kFVtxqqKt/3i5R1QvKVq57ARnW9J2+Q6yXThUd6mimQ5vcDB9p3FnUNLkzWWb0aN2S5QISN1LOW20a7qqypv8hCQlXaSj1PFceViscrxo1LQunLI3/iWB9kA2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVtHZmix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVtHZmix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4DA1F0089D
	for <linux-acpi@vger.kernel.org>; Sun, 20 Sep 2026 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789869319;
	bh=ZNm9/wfZV2nkjLVmx1aDomWnEvwBzNkqe3H+bh4IP4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AVtHZmix3W7A8DtuyBAfrawZn6OAce7ZJCk6VeBFfr3AqPMCDsyRHWL2V/q9wlXOe
	 Y8pNzwSUiHVZJA1Eo1uS9BFHjshKjgfEr4h+W+egrwHnst4GU5jr1bZ6rOoNvPe2D6
	 pudAr9uvyjKbuRWk/6Q7+BI9Wd8Qjfwh7N2wUnV5+mCYIOYT5OAiqfYwN0WAZrQPN8
	 mYwiCYUtAYd6ApsNypnR213uAqlLISzRRse/WL/85nEmwpYQ+41QDTqD3VpZD4/blm
	 md/9JEYU1FRtBEmX0nlaK4BGaCG6khAEAyaGxI53A09mzPysi6tWn+WtbzSgz0w4r+
	 wpHImRriDEaOQ==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so2973462a12.3
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 18:55:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByvsvsNbDNRTxYyz1JMizuzvx2qBEHoDVM21y63wHtP/wrGqXdfh+7u/HJC4xQqLc2aHEm/kZtQeYUv@vger.kernel.org
X-Gm-Message-State: AFuF++lfU6VohY1zUVWXg+Vf7VXiDnsB2LXkUYCrmOVhQsBv2STKH9iC
	eT9HJNpWjnC/KPMbaaWRoTLEZpNrlK7Uhg4/M3e15iMI6+2bDGc5hyHrH+FWUPXDTVjIWLyApVO
	UxGh/NGtg81XRhIX5ug686oZZaUyQ+4s=
X-Received: by 2002:a05:6402:46cb:b0:6aa:734a:a082 with SMTP id
 4fb4d7f45d1cf-6aa734aa228mr1588205a12.25.1789869317961; Sat, 19 Sep 2026
 18:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915032627.2796747-1-maobibo@loongson.cn> <20260915032627.2796747-4-maobibo@loongson.cn>
 <CAAhV-H71irZnQ2hYmsewC6_fZEjnwBm6VJVcKqTsjJGW2xZDBA@mail.gmail.com> <f83f4c74-07c4-237e-de4f-337c39380377@loongson.cn>
In-Reply-To: <f83f4c74-07c4-237e-de4f-337c39380377@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 20 Sep 2026 09:55:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4wY6OTmyUCbqfA=swfkj_oHANtMAO0Khh93-87y7CRTg@mail.gmail.com>
X-Gm-Features: AcwNN1UgsVNhvhRTfCGWJunJf5O4e4WVTYZlG_uj9JyEjbekPvqve9xTg_UDqzM
Message-ID: <CAAhV-H4wY6OTmyUCbqfA=swfkj_oHANtMAO0Khh93-87y7CRTg@mail.gmail.com>
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

On Sun, Sep 20, 2026 at 9:24=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/9/19 =E4=B8=8B=E5=8D=8810:18, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Tue, Sep 15, 2026 at 11:34=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>
> >> acpi_iommu_configure_id() currently supports only IORT and VIOT. Add
> >> support for IOVT as well.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> >> ---
> >>   drivers/acpi/loongarch/iovt.c | 61 +++++++++++++++++++++++++++++++++=
++
> >>   drivers/acpi/scan.c           |  3 ++
> >>   include/linux/acpi_iovt.h     | 13 ++++++++
> >>   3 files changed, 77 insertions(+)
> >>   create mode 100644 include/linux/acpi_iovt.h
> >>
> >> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/io=
vt.c
> >> index 302ca6a75905..df14ce48eac6 100644
> >> --- a/drivers/acpi/loongarch/iovt.c
> >> +++ b/drivers/acpi/loongarch/iovt.c
> >> @@ -1,6 +1,7 @@
> >>   // SPDX-License-Identifier: GPL-2.0-only
> >>
> >>   #include <linux/acpi.h>
> >> +#include <linux/acpi_iovt.h>
> >>   #include <linux/pci.h>
> >>   #include "init.h"
> >>
> >> @@ -217,3 +218,63 @@ void __init acpi_iovt_late_init(void)
> >>          iovt_init_devices(hdr);
> >>          acpi_put_table(hdr);
> >>   }
> >> +
> >> +static int iovt_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, =
void *data)
> >> +{
> >> +       u32 sbdf;
> >> +       struct iovt_fwnode *np;
> >> +       struct device *aliased_dev =3D data;
> >> +       u32 domain =3D pci_domain_nr(pdev->bus);
> >> +       struct iovt_device_entry *entry;
> >> +       bool found =3D false;
> >> +
> >> +       list_for_each_entry(np, &iovt_fwnode_list, list) {
> >> +               if (domain !=3D np->segment)
> >> +                       continue;
> >> +
> >> +               /* We're not translating ourself */
> >> +               if (dev_id =3D=3D np->devid)
> >> +                       return -EINVAL;
> >> +
> >> +               if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT) {
> >> +                       found =3D true;
> >> +                       break;
> >> +               }
> >> +
> >> +               list_for_each_entry(entry, &np->ep_list, list) {
> >> +                       if (dev_id < entry->start_devid)
> >> +                               continue;
> >> +
> >> +                       if (dev_id > entry->end_devid)
> >> +                               continue;
> >> +
> >> +                       found =3D true;
> >> +                       break;
> >> +               }
> >> +
> >> +               if (found)
> >> +                       break;
> >> +       }
> >> +
> >> +       if (!found)
> >> +               return -ENODEV;
> >> +
> >> +       sbdf =3D (domain << 16) + dev_id;
> >> +       return acpi_iommu_fwspec_init(aliased_dev, sbdf, np->fwnode);
> >> +}
> >> +
> >> +/*
> >> + * iovt_iommu_configure_id - Set-up IOMMU configuration for a device.
> >> + *
> >> + * @dev: device to configure
> >> + * @id_in: optional input id const value pointer
> >> + *
> >> + * Returns: 0 on success, <0 on failure
> >> + */
> >> +int iovt_iommu_configure_id(struct device *dev, const u32 *id_in)
> >> +{
> >> +       if (!dev_is_pci(dev))
> >> +               return -ENODEV;
> >> +
> >> +       return pci_for_each_dma_alias(to_pci_dev(dev), iovt_pci_dev_io=
mmu_init, dev);
> >> +}
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index 163a3cccf197..f2f155a65ea9 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -13,6 +13,7 @@
> >>   #include <linux/kernel.h>
> >>   #include <linux/acpi.h>
> >>   #include <linux/acpi_iort.h>
> >> +#include <linux/acpi_iovt.h>
> >>   #include <linux/acpi_rimt.h>
> >>   #include <linux/acpi_viot.h>
> >>   #include <linux/iommu.h>
> >> @@ -1628,6 +1629,8 @@ static int acpi_iommu_configure_id(struct device=
 *dev, const u32 *id_in)
> >>                  err =3D rimt_iommu_configure_id(dev, id_in);
> >>          if (err && err !=3D -EPROBE_DEFER)
> >>                  err =3D viot_iommu_configure(dev);
> >> +       if (err && err !=3D -EPROBE_DEFER)
> >> +               err =3D iovt_iommu_configure_id(dev, id_in);
> > We call our acpi_arch_late_init() before acpi_viot_init(), so I think
> > it is better to also call iovt_iommu_configure_id() before
> > viot_iommu_configure().
> Yes, it should be the same order, good catch.
>
> It is both OK for me to put acpi_arch_late_init() after
> acpi_viot_init(), or put iovt_iommu_configure_id() before
> viot_iommu_configure().
I think it is better to put iovt_iommu_configure_id() before
viot_iommu_configure().

Huacai
>
> Regards
> Bibo Mao
> >
> >
> > Huacai
> >>
> >>          mutex_unlock(&iommu_probe_device_lock);
> >>
> >> diff --git a/include/linux/acpi_iovt.h b/include/linux/acpi_iovt.h
> >> new file mode 100644
> >> index 000000000000..25a846b96260
> >> --- /dev/null
> >> +++ b/include/linux/acpi_iovt.h
> >> @@ -0,0 +1,13 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +
> >> +#ifndef __ACPI_IOVT_H__
> >> +#define __ACPI_IOVT_H__
> >> +
> >> +#if defined(CONFIG_IOMMU_API) && defined(CONFIG_ACPI_IOVT)
> >> +int iovt_iommu_configure_id(struct device *dev, const u32 *id_in);
> >> +#else
> >> +static inline int iovt_iommu_configure_id(struct device *dev, const u=
32 *id_in)
> >> +{ return -ENODEV; }
> >> +#endif
> >> +
> >> +#endif
> >> --
> >> 2.39.3
> >>
>
