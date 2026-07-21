Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8646EC68
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660963; cv=none; b=PZ7NPYM285r5Z5ik0NzFXs4aZ0aQ6wbmNce48VUfQEzOwm6B281gG2EqKZ8FUd9UQSYHE0IfGZJFKOrGOsZASQiMQf662ovrDF9AOfSKcRl7rsiCFMVrn+hQ6ZQjQYxcsQ2hhqQyjvMezNqZd1J2zLYywcZG9lFG2hklHgvvAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660963; c=relaxed/simple;
	bh=B2bO/ylacpXeLrLyPbOPBpMQaIGIAfNMjB+4LIciy24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTHzBSBVC0s/Tx5OkLL836Dr5CzFyl56yzCAX9j6le5oKDmOURvflCV41uzEy7LMAyFO9k8xvKubpYnES48Nm07PrQNDyF8zMJxWvY8gxv9jjyJIwFEpWmD/ENP02myB+qs/IR4kXq3ikvpkypnpaMAX0wj4gjMpyZFCuDGTrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSdgmk5h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSdgmk5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF1C1F00ADF
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660960;
	bh=bGZFOYlsORlrSTjZVICnASl+QefjWaVxreMkVIoHXps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cSdgmk5hGawAzA+ays8IiL7LzpRK98hrSQVtBaF7peLS3A5/6Ck49LZY5oUMPEG9D
	 Avcz9YTrhPyf3ioiuuHCQNbbBGmku0pWaS58JEXQ0bKTcpxhNI7zqA7pN3dQ4WVHyL
	 uLa7OwlAM1Qw/qu4jueF7PvJ4HGKtd9SI2sRVeasyS3Zf/qGTecpxRsCTm23/Mc4v2
	 llfASGBVNf5oiw1P6fdUTbd6gdbrIERS1DaQAxru5SZ83xogXLHbfLMGJPbOMMBhMd
	 XFVpthe+PdJEvcoz8T3ScyZ2xnzo6sT+Xoy3YHvWQxsXPMMlMRGLj8A8YQh2gKIYJ7
	 0K00RBRWKsaOA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso10176825e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:09:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpMmqAqXWqh8EEqk0bi0+WR9KNC3JEg+5lmxXOEFnIgxOcbnlOo0uSYViBZWupiB68+j9jufk9A2FFE@vger.kernel.org
X-Gm-Message-State: AOJu0YwwGgi9FiH8NMvEw40dYVI4LN0gE8+J7aXSFEqajsJt+gVN2s5l
	pwQoDDcymAwZNcwfC7KJdp12bWg625uh6v6izpMO+oUgFegtUjzAadLAe6r2dlb9teTmnPxI3rb
	5XQcaCStYbxtX42tEZgejqar38QEs2go=
X-Received: by 2002:a05:6512:1094:b0:5ae:b765:ac58 with SMTP id
 2adb3069b0e04-5b28f84a1b4mr3795047e87.5.1784660959284; Tue, 21 Jul 2026
 12:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717063713.3638059-1-maobibo@loongson.cn> <20260717063713.3638059-3-maobibo@loongson.cn>
In-Reply-To: <20260717063713.3638059-3-maobibo@loongson.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 21:09:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iN6qP0WMXRoC5AXTN8RLG=ZQpnen_2HbbAXvTx=0jfVQ@mail.gmail.com>
X-Gm-Features: AUfX_mxOGbuToJw7yap3snRY3KKSs4pH1v_T_YmhvaEnMDZ5tlAseBm6ssfp1Ng
Message-ID: <CAJZ5v0iN6qP0WMXRoC5AXTN8RLG=ZQpnen_2HbbAXvTx=0jfVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ACPI: LoongArch: Add IOVT device entry table scanning
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
> Similar with acpi_arch_init()/acpi_arch_late_init(), here function
> acpi_iovt_init()/acpi_iovt_late_init() is added. Function
> acpi_iovt_init() is to enable PCI ACS function if IOMMU device exists
> in IOVT table, and function acpi_iovt_late_init() is to scan IOVT
> table, add IOMMU devices.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/acpi/Kconfig            |   4 +
>  drivers/acpi/loongarch/Kconfig  |   7 +
>  drivers/acpi/loongarch/Makefile |   1 +
>  drivers/acpi/loongarch/init.c   |   5 +
>  drivers/acpi/loongarch/init.h   |   5 +
>  drivers/acpi/loongarch/iovt.c   | 219 ++++++++++++++++++++++++++++++++
>  include/acpi/actbl2.h           |   3 +

The actbl2.h change should go through upstream ACPICA, shouldn't it?

>  7 files changed, 244 insertions(+)
>  create mode 100644 drivers/acpi/loongarch/Kconfig
>  create mode 100644 drivers/acpi/loongarch/init.h
>  create mode 100644 drivers/acpi/loongarch/iovt.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f165d14cf61a..192e6f18eda1 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -550,6 +550,10 @@ if ARM64
>  source "drivers/acpi/arm64/Kconfig"
>  endif
>
> +if LOONGARCH
> +source "drivers/acpi/loongarch/Kconfig"
> +endif
> +
>  if RISCV
>  source "drivers/acpi/riscv/Kconfig"
>  endif
> diff --git a/drivers/acpi/loongarch/Kconfig b/drivers/acpi/loongarch/Kcon=
fig
> new file mode 100644
> index 000000000000..91ba3c35b9bf
> --- /dev/null
> +++ b/drivers/acpi/loongarch/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# ACPI Configuration for LOONGARCH
> +#
> +
> +config ACPI_IOVT
> +       bool
> diff --git a/drivers/acpi/loongarch/Makefile b/drivers/acpi/loongarch/Mak=
efile
> index d3764139dfaf..c338d3102fc1 100644
> --- a/drivers/acpi/loongarch/Makefile
> +++ b/drivers/acpi/loongarch/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y                                  +=3D init.o
> +obj-$(CONFIG_ACPI_IOVT)                        +=3D iovt.o
> diff --git a/drivers/acpi/loongarch/init.c b/drivers/acpi/loongarch/init.=
c
> index b11aa5c7d928..e7272ee197c7 100644
> --- a/drivers/acpi/loongarch/init.c
> +++ b/drivers/acpi/loongarch/init.c
> @@ -1,11 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>
>  #include <linux/acpi.h>
> +#include "init.h"
>
>  void __init acpi_arch_init(void)
>  {
> +       if (IS_ENABLED(CONFIG_ACPI_IOVT))
> +               acpi_iovt_init();
>  }
>
>  void __init acpi_arch_late_init(void)
>  {
> +       if (IS_ENABLED(CONFIG_ACPI_IOVT))
> +               acpi_iovt_late_init();
>  }
> diff --git a/drivers/acpi/loongarch/init.h b/drivers/acpi/loongarch/init.=
h
> new file mode 100644
> index 000000000000..85e5197553ad
> --- /dev/null
> +++ b/drivers/acpi/loongarch/init.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#include <linux/init.h>
> +
> +void __init acpi_iovt_init(void);
> +void __init acpi_iovt_late_init(void);
> diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.=
c
> new file mode 100644
> index 000000000000..fb384664ba78
> --- /dev/null
> +++ b/drivers/acpi/loongarch/iovt.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/acpi.h>
> +#include <linux/pci.h>
> +#include "init.h"
> +
> +struct iovt_device_entry {
> +       struct list_head list;
> +       int start_devid;
> +       int end_devid;
> +};
> +
> +struct iovt_fwnode {
> +       struct list_head list;
> +       struct fwnode_handle *fwnode;
> +       int flag;
> +       int segment;
> +       int devid;
> +       int nid;
> +       struct list_head ep_list;
> +};
> +
> +/* Root pointer to the mapped IOVT table */
> +static LIST_HEAD(iovt_fwnode_list);
> +static DEFINE_SPINLOCK(iovt_fwnode_lock);
> +
> +#ifdef CONFIG_PCI
> +static void __init iovt_enable_acs(struct acpi_iovt_iommu *iommu)
> +{
> +       static bool acs_enabled __initdata;
> +
> +       if (acs_enabled)
> +               return;
> +
> +       /* IOMMU V1 only supports PCI device management */
> +       if ((iommu->header.type =3D=3D ACPI_IOVT_IOMMU_V1) ||
> +               (iommu->flags & (ACPI_IOVT_PCI_DEVICE | ACPI_IOVT_MAGAGE_=
BY_SEGMENT))) {
> +               pci_request_acs();
> +               acs_enabled =3D true;
> +       }
> +}
> +#else
> +static inline void iovt_enable_acs(struct acpi_iovt_iommu *iommu) { }
> +#endif
> +
> +static int __init iovt_get_pci_iommu_fwnode(struct iovt_fwnode *np, u16 =
segment, u16 bdf)
> +{
> +       struct pci_dev *pdev;
> +       struct fwnode_handle *fwnode;
> +
> +       pdev =3D pci_get_domain_bus_and_slot(segment, PCI_BUS_NUM(bdf), b=
df & 0xff);
> +       if (!pdev) {
> +               pr_err("No PCI IOMMU found for segment 0x%x bdf 0x%x\n", =
segment, bdf);
> +               return -ENODEV;
> +       }
> +
> +       fwnode =3D dev_fwnode(&pdev->dev);
> +       if (!fwnode) {
> +               /*
> +                * PCI devices aren't necessarily described by ACPI. Crea=
te a
> +                * fwnode so the IOMMU subsystem can identify this device=
.
> +                */
> +               fwnode =3D acpi_alloc_fwnode_static();
> +               if (!fwnode) {
> +                       pci_dev_put(pdev);
> +                       return -ENOMEM;
> +               }
> +               set_primary_fwnode(&pdev->dev, fwnode);
> +       }
> +
> +       np->fwnode =3D dev_fwnode(&pdev->dev);
> +       if (np->flag & ACPI_IOVT_PXM_VALID)
> +               set_dev_node(&pdev->dev, np->nid);
> +       pci_dev_put(pdev);
> +       return 0;
> +}
> +
> +static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
> +{
> +       struct iovt_fwnode *np;
> +       struct fwnode_handle *fwnode;
> +       struct acpi_iovt_device_entry *ep;
> +       struct iovt_device_entry *entry;
> +       int i, ret, start_devid;
> +       bool is_start =3D false;
> +
> +       np =3D kzalloc_obj(struct iovt_fwnode, GFP_ATOMIC);
> +       if (WARN_ON(!np))
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&np->list);
> +       np->flag =3D iommu->flags;
> +       np->segment =3D iommu->segment;
> +       if (np->flag & ACPI_IOVT_PXM_VALID)
> +               np->nid =3D pxm_to_node(iommu->proximity_domain);
> +
> +       if (np->flag & ACPI_IOVT_PCI_DEVICE) {
> +               np->devid =3D iommu->device_id;
> +               ret =3D iovt_get_pci_iommu_fwnode(np, np->segment, np->de=
vid);
> +               if (ret) {
> +                       kfree(np);
> +                       return ret;
> +               }
> +
> +       } else {
> +               fwnode =3D acpi_alloc_fwnode_static();
> +               if (!fwnode) {
> +                       kfree(np);
> +                       return -ENOMEM;
> +               }
> +
> +               np->fwnode =3D fwnode;
> +       }
> +
> +       /* All devices in the segment are managed by this IOMMU */
> +       if (np->flag & ACPI_IOVT_MAGAGE_BY_SEGMENT)
> +               goto skip;
> +
> +       INIT_LIST_HEAD(&np->ep_list);
> +       ep =3D ACPI_ADD_PTR(struct acpi_iovt_device_entry, iommu, iommu->=
device_entry_offset);
> +       for (i =3D 0; i < iommu->device_entry_num; i++) {
> +               switch (ep->type) {
> +               case ACPI_IOVT_DEVICE_ENTRY_START:
> +                       is_start =3D true;
> +                       start_devid =3D ep->device_id;
> +                       break;
> +               case ACPI_IOVT_DEVICE_ENTRY_END:
> +                       if (!is_start)
> +                               break;
> +
> +                       entry =3D kzalloc_obj(struct iovt_device_entry, G=
FP_ATOMIC);
> +                       if (!entry)
> +                               return -ENOMEM;
> +
> +                       entry->start_devid =3D start_devid;
> +                       entry->end_devid =3D ep->device_id;
> +                       list_add_tail(&entry->list, &np->ep_list);
> +                       is_start =3D false;
> +                       break;
> +               case ACPI_IOVT_DEVICE_ENTRY_SINGLE:
> +                       entry =3D kzalloc_obj(struct iovt_device_entry, G=
FP_ATOMIC);
> +                       if (!entry)
> +                               return -ENOMEM;
> +
> +                       entry->start_devid =3D ep->device_id;
> +                       entry->end_devid =3D ep->device_id;
> +                       list_add_tail(&entry->list, &np->ep_list);
> +                       is_start =3D false;
> +                       break;
> +               default:
> +                       break;
> +               }
> +               ep =3D ACPI_ADD_PTR(struct acpi_iovt_device_entry, ep, ep=
->length);
> +       }
> +
> +skip:
> +       spin_lock(&iovt_fwnode_lock);
> +       list_add_tail(&np->list, &iovt_fwnode_list);
> +       spin_unlock(&iovt_fwnode_lock);
> +       return 0;
> +}
> +
> +static void __init iovt_init_devices(struct acpi_table_header *header)
> +{
> +       struct acpi_iovt_iommu *iommu;
> +       struct acpi_table_iovt *iovt;
> +       int i;
> +
> +       /* Get the first IOVT node */
> +       iovt =3D (struct acpi_table_iovt *)header;
> +       iommu =3D ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_=
offset);
> +       for (i =3D 0; i < iovt->iommu_count; i++) {
> +               iovt_add_iommu(iommu);
> +               iommu =3D ACPI_ADD_PTR(struct acpi_iovt_iommu, iommu, iom=
mu->header.length);
> +       }
> +}
> +
> +void __init acpi_iovt_init(void)
> +{
> +       acpi_status status;
> +       struct acpi_table_header *hdr;
> +       struct acpi_table_iovt *iovt;
> +       struct acpi_iovt_iommu *iommu;
> +       int i;
> +
> +       status =3D acpi_get_table(ACPI_SIG_IOVT, 0, &hdr);
> +       if (ACPI_FAILURE(status)) {
> +               if (status !=3D AE_NOT_FOUND)
> +                       pr_err("Failed to get table, %s\n", acpi_format_e=
xception(status));
> +
> +               return;
> +       }
> +
> +       iovt =3D (struct acpi_table_iovt *)&hdr;
> +       iommu =3D ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_=
offset);
> +       for (i =3D 0; i < iovt->iommu_count; i++) {
> +               iovt_enable_acs(iommu);
> +               iommu =3D ACPI_ADD_PTR(struct acpi_iovt_iommu, iommu, iom=
mu->header.length);
> +       }
> +
> +       acpi_put_table(hdr);
> +}
> +
> +void __init acpi_iovt_late_init(void)
> +{
> +       acpi_status status;
> +       struct acpi_table_header *hdr;
> +
> +       status =3D acpi_get_table(ACPI_SIG_IOVT, 0, &hdr);
> +       if (ACPI_FAILURE(status)) {
> +               if (status !=3D AE_NOT_FOUND)
> +                       pr_err("Failed to get table, %s\n", acpi_format_e=
xception(status));
> +
> +               return;
> +       }
> +
> +       iovt_init_devices(hdr);
> +       acpi_put_table(hdr);
> +}
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index baef525367b5..acc51a42c3ed 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -892,6 +892,9 @@ struct acpi_iovt_header {
>
>  /* Values for Type field above */
>
> +#define ACPI_IOVT_PCI_DEVICE           BIT(0)
> +#define ACPI_IOVT_PXM_VALID            BIT(1)
> +#define ACPI_IOVT_MAGAGE_BY_SEGMENT    BIT(2)
>  enum acpi_iovt_iommu_type {
>         ACPI_IOVT_IOMMU_V1 =3D 0x00,
>         ACPI_IOVT_IOMMU_RESERVED =3D 0x01 /* 1 and greater are reserved *=
/
> --
> 2.39.3
>
