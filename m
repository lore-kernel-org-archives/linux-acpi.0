From: Mark Salter <msalter@redhat.com>
Subject: Re: [RFC PATCH v4 3/5] PCI: Check platform specific ECAM quirks
Date: Mon, 25 Jul 2016 17:56:05 -0400
Message-ID: <1469483765.3524.7.camel@redhat.com>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
	 <1467100442-28078-4-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467100442-28078-4-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org, gabriele.paoloni@huawei.com, jhugo@codeaurora.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2016-06-28 at 09:54 +0200, Tomasz Nowicki wrote:
> Some platforms may not be fully compliant with generic set of PCI con=
fig
> accessors. For these cases we implement the way to overwrite accessor=
s
> set. Algorithm traverses available quirk list (static array),
> matches against <oem_id, oem_table_id, rev, domain, bus number range>=
 and
> returns pci_config_window structure with fancy PCI config ops.
> oem_id, oem_table_id and rev come from MCFG table standard header.
>=20
> It is possible to define custom init call which is responsible for
> setting up PCI config access accordingly to quirk requirements.
> If no custom init call defined, use standard pci_acpi_setup_ecam_mapp=
ing().
>=20
> pci_generic_ecam_ops will be used for platforms free from quirks.
>=20
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
> =C2=A0drivers/pci/host/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A01 +
> =C2=A0drivers/pci/host/mcfg-quirks.c | 88 +++++++++++++++++++++++++++=
+++++++++++++++
> =C2=A0drivers/pci/host/mcfg-quirks.h | 20 ++++++++++
> =C2=A0include/linux/pci-acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A02 +
> =C2=A04 files changed, 111 insertions(+)
> =C2=A0create mode 100644 drivers/pci/host/mcfg-quirks.c
> =C2=A0create mode 100644 drivers/pci/host/mcfg-quirks.h
>=20
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 5bc0af2..e3d55a0 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) +=3D pci-thunde=
r-ecam.o
> =C2=A0obj-$(CONFIG_PCI_HOST_THUNDER_PEM) +=3D pci-thunder-pem.o
> =C2=A0obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
> =C2=A0obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
> +obj-$(CONFIG_ACPI_MCFG) +=3D mcfg-quirks.o
> diff --git a/drivers/pci/host/mcfg-quirks.c b/drivers/pci/host/mcfg-q=
uirks.c
> new file mode 100644
> index 0000000..fb2b184
> --- /dev/null
> +++ b/drivers/pci/host/mcfg-quirks.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright (C) 2016 Semihalf
> + *	Author: Tomasz Nowicki <tn@semihalf.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License, version 2, =
as
> + * published by the Free Software Foundation (the "GPL").
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0=C2=A0S=
ee the GNU
> + * General Public License version 2 (GPLv2) for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * version 2 (GPLv2) along with this source code.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
> +
> +#include "mcfg-quirks.h"
> +
> +struct pci_cfg_fixup {
> +	char *oem_id;
> +	char *oem_table_id;
> +	u32 oem_revision;
> +	struct resource domain_range;
> +	struct resource bus_range;
> +	struct pci_ops *ops;
> +	struct pci_config_window *(*init)(struct acpi_pci_root *root,
> +					=C2=A0=C2=A0struct pci_ops *ops);
> +};
> +
> +#define MCFG_DOM_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
> +						((end) - (start) + 1), NULL, 0)
> +#define MCFG_DOM_ANY			MCFG_DOM_RANGE(0x0, 0xffff)
> +#define MCFG_BUS_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
> +						((end) - (start) + 1),	\
> +						NULL, IORESOURCE_BUS)
> +#define MCFG_BUS_ANY			MCFG_BUS_RANGE(0x0, 0xff)
> +
> +static struct pci_cfg_fixup mcfg_qurks[] __initconst =3D {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^
mcfg_quirks

> +/*	{ OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, pci_ops, init_hoo=
k }, */
> +};
> +
> +static bool pci_mcfg_fixup_match(struct pci_cfg_fixup *f,
> +				=C2=A0struct acpi_table_header *mcfg_header)
> +{
> +	int olen =3D min_t(u8, strlen(f->oem_id), ACPI_OEM_ID_SIZE);
> +	int tlen =3D min_t(u8, strlen(f->oem_table_id), ACPI_OEM_TABLE_ID_S=
IZE);
> +
> +	return (!strncmp(f->oem_id, mcfg_header->oem_id, olen) &&
> +		!strncmp(f->oem_table_id, mcfg_header->oem_table_id, tlen) &&
> +		f->oem_revision =3D=3D mcfg_header->oem_revision);
> +}
> +
> +struct pci_config_window *pci_mcfg_match_quirks(struct acpi_pci_root=
 *root)
> +{
> +	struct resource dom_res =3D MCFG_DOM_RANGE(root->segment, root->seg=
ment);
> +	struct resource *bus_res =3D &root->secondary;
> +	struct pci_cfg_fixup *f =3D mcfg_qurks;
> +	struct acpi_table_header *mcfg_header;
> +	acpi_status status;
> +	int i;
> +
> +	status =3D acpi_get_table(ACPI_SIG_MCFG, 0, &mcfg_header);
> +	if (ACPI_FAILURE(status))
> +		return NULL;
> +
> +	/*
> +	=C2=A0* First match against PCI topology <domain:bus> then use OEM =
ID, OEM
> +	=C2=A0* table ID, and OEM revision from MCFG table standard header.
> +	=C2=A0*/
> +	for (i =3D 0; i < ARRAY_SIZE(mcfg_qurks); i++, f++) {
> +		if (resource_contains(&f->domain_range, &dom_res) &&
> +		=C2=A0=C2=A0=C2=A0=C2=A0resource_contains(&f->bus_range, bus_res) =
&&
> +		=C2=A0=C2=A0=C2=A0=C2=A0pci_mcfg_fixup_match(f, mcfg_header)) {
> +			pr_info("Handling %s %s r%d PCI MCFG quirks\n",
> +				f->oem_id, f->oem_table_id, f->oem_revision);
> +			return f->init ? f->init(root, f->ops) :
> +				pci_acpi_setup_ecam_mapping(root, f->ops);
> +		}
> +	}
> +	return pci_acpi_setup_ecam_mapping(root, &pci_generic_ecam_ops.pci_=
ops);
> +}
> diff --git a/drivers/pci/host/mcfg-quirks.h b/drivers/pci/host/mcfg-q=
uirks.h
> new file mode 100644
> index 0000000..45cbd16
> --- /dev/null
> +++ b/drivers/pci/host/mcfg-quirks.h
> @@ -0,0 +1,20 @@
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License, version 2, =
as
> + * published by the Free Software Foundation (the "GPL").
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0=C2=A0S=
ee the GNU
> + * General Public License version 2 (GPLv2) for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * version 2 (GPLv2) along with this source code.
> + */
> +
> +#ifndef __MCFG_QUIRKS_H__
> +#define __MCFG_QUIRKS_H__
> +
> +/* MCFG quirks initialize call list */
> +
> +#endif /* __MCFG_QUIRKS_H__ */
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index e9bfe00..28cdce4 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -25,6 +25,8 @@ static inline acpi_status pci_acpi_remove_pm_notifi=
er(struct acpi_device *dev)
> =C2=A0extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle hand=
le);
> =C2=A0
> =C2=A0extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource =
*bus_res);
> +extern struct pci_config_window *
> +pci_mcfg_match_quirks(struct acpi_pci_root *root);
> =C2=A0
> =C2=A0extern struct pci_config_window *
> =C2=A0pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root, struct =
pci_ops *ops);
