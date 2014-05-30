From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/2] ACPI: Add support for Platform Communication Channel
Date: Fri, 30 May 2014 11:17:04 +0100
Message-ID: <20140530101704.GS5099@sirena.org.uk>
References: <1401222599-12416-1-git-send-email-ashwin.chaugule@linaro.org>
 <1401222599-12416-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYoqghpzCwoKvQG2"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47638 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374AbaE3KRS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 May 2014 06:17:18 -0400
Content-Disposition: inline
In-Reply-To: <1401222599-12416-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, Jaswinder Singh <jaswinder.singh@linaro.org>


--TYoqghpzCwoKvQG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2014 at 04:29:58PM -0400, Ashwin Chaugule wrote:
> ACPI 5.0a+ spec defines a generic mode of communication
> between the OS and a platform such as the BMC. This medium
> (PCC) is typically used by CPPC (ACPI CPU Performance management),
> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
> states).
>=20
> This patch adds initial support for PCC to be usable by the
> aforementioned PCC clients.

This looks an awful lot like a mailbox - should it be integrated with
the mailbox system that Jassi (CCed) has been working on getting
upstream?  Not deleting any context for Jassi's benefit.

>=20
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/acpi/Kconfig  |  10 +++
>  drivers/acpi/Makefile |   2 +-
>  drivers/acpi/pcc.c    | 192 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 203 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/pcc.c
>=20
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ff5c83c..8f40e52 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -352,6 +352,16 @@ config ACPI_REDUCED_HARDWARE_ONLY
> =20
>  	If you are unsure what to do, do not enable this option.
> =20
> +config ACPI_PCC
> +	bool "ACPI Platform Communication Channel"
> +	def_bool n
> +	depends on ACPI
> +	help
> +	Enable this option if your platform supports PCC as defined in the
> +	ACPI spec 5.0a+. PCC is a generic mechanism for the OS to communicate
> +	with a platform such as a BMC. PCC is typically used by CPPC, RAS
> +	and MPST.
> +
>  source "drivers/acpi/apei/Kconfig"
> =20
>  config ACPI_EXTLOG
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index fc133d4..d8aa613 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -74,7 +74,7 @@ obj-$(CONFIG_ACPI_HED)		+=3D hed.o
>  obj-$(CONFIG_ACPI_EC_DEBUGFS)	+=3D ec_sys.o
>  obj-$(CONFIG_ACPI_CUSTOM_METHOD)+=3D custom_method.o
>  obj-$(CONFIG_ACPI_BGRT)		+=3D bgrt.o
> -
> +obj-$(CONFIG_ACPI_PCC)		+=3D pcc.o
>  # processor has its own "processor." module_param namespace
>  processor-y			:=3D processor_driver.o processor_throttling.o
>  processor-y			+=3D processor_idle.o processor_thermal.o
> diff --git a/drivers/acpi/pcc.c b/drivers/acpi/pcc.c
> new file mode 100644
> index 0000000..328ca93
> --- /dev/null
> +++ b/drivers/acpi/pcc.c
> @@ -0,0 +1,192 @@
> +/*
> + *	Copyright (C) 2014 Linaro Ltd.
> + *	Author:	Ashwin Chaugule <ashwin.chaugule@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/init.h>
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +#include <linux/ioctl.h>
> +#include <linux/vmalloc.h>
> +
> +#include <acpi/actbl.h>
> +
> +#define MAX_PCC_SUBSPACES	256
> +#define PCCS_SS_SIG_MAGIC	0x50434300
> +#define PCC_CMD_COMPLETE	0x1
> +#define PCC_VERSION			"0.1"
> +
> +struct pcc_ss_desc {
> +	struct acpi_pcct_subspace *pcc_ss_ptr;
> +	raw_spinlock_t lock;
> +};
> +
> +/* Array of Type 0 PCC Subspace descriptors */
> +struct pcc_ss_desc pcc_ss_arr[MAX_PCC_SUBSPACES];
> +
> +/* Total number of subspaces detected in PCCT. */
> +static int total_ss;
> +
> +/*
> + * PCC clients call this function to get a base address of their
> + * Communication channel
> + */
> +int get_pcc_comm_channel(u32 ss_idx, u64 __iomem *addr, int *len)
> +{
> +	struct acpi_pcct_subspace *pcct_subspace =3D
> +		pcc_ss_arr[ss_idx].pcc_ss_ptr;
> +
> +	if (pcct_subspace) {
> +		*addr =3D pcct_subspace->base_address;
> +		*len =3D pcct_subspace->length;
> +	} else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Send PCC cmd on behalf of this (subspace id) PCC client */
> +u16 send_pcc_cmd(u8 cmd, u8 sci, u32 ss_idx, u64 __iomem *base_addr)
> +{
> +	struct acpi_pcct_subspace *pcct_subspace =3D
> +		pcc_ss_arr[ss_idx].pcc_ss_ptr;
> +	struct acpi_pcct_shared_memory *generic_comm_base =3D
> +		(struct acpi_pcct_shared_memory *)base_addr;
> +	struct acpi_generic_address doorbell;
> +	u64 doorbell_preserve;
> +	u64 doorbell_val;
> +	u64 doorbell_write;
> +	/*
> +	 * Min time in usec that OSPM is expected to wait
> +	 * before sending the next PCC cmd.
> +	 */
> +	u16 cmd_delay =3D pcct_subspace->min_turnaround_time;
> +
> +	if (!generic_comm_base) {
> +		pr_err("No Generic Communication Channel provided.\n");
> +		return -EINVAL;
> +	}
> +
> +	raw_spin_lock(&pcc_ss_arr[ss_idx].lock);
> +
> +	/* Get doorbell details for this subspace. */
> +	doorbell =3D pcct_subspace->doorbell_register;
> +	doorbell_preserve =3D pcct_subspace->preserve_mask;
> +	doorbell_write =3D pcct_subspace->write_mask;
> +
> +	/* Loop until CMD complete bit is set. For prev cmds. */
> +	while (!(ioread16(&generic_comm_base->status) & PCC_CMD_COMPLETE))
> +		udelay(cmd_delay);
> +
> +	/* Write to the shared comm region. */
> +	iowrite16(cmd, &generic_comm_base->command);
> +
> +	/* Write Subspace MAGIC value so platform can identify destination. */
> +	iowrite32((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
> +
> +	/* Flip CMD COMPLETE bit */
> +	iowrite16(0, &generic_comm_base->status);
> +
> +	/* Sync notification from OSPM to Platform. */
> +	acpi_read(&doorbell_val, &doorbell);
> +	acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
> +			&doorbell);
> +
> +	/* Wait for Platform to consume. */
> +	while (!(ioread16(&generic_comm_base->status) & PCC_CMD_COMPLETE))
> +		udelay(cmd_delay);
> +
> +	raw_spin_unlock(&pcc_ss_arr[ss_idx].lock);
> +
> +	return generic_comm_base->status;
> +}
> +
> +static int parse_pcc_subspace(struct acpi_subtable_header *header,
> +		const unsigned long end)
> +{
> +	struct acpi_pcct_subspace *pcct_ss;
> +
> +	if (total_ss <=3D MAX_PCC_SUBSPACES) {
> +		pcct_ss =3D (struct acpi_pcct_subspace *) header;
> +
> +		if (pcct_ss->header.type !=3D ACPI_PCCT_TYPE_GENERIC_SUBSPACE) {
> +			pr_err("Incorrect PCC Subspace type detected\n");
> +			return -EINVAL;
> +		}
> +
> +		pcc_ss_arr[total_ss].pcc_ss_ptr =3D pcct_ss;
> +		raw_spin_lock_init(&pcc_ss_arr[total_ss].lock);
> +
> +		total_ss++;
> +	} else {
> +		pr_err("No more space for PCC subspaces.\n");
> +		return -ENOSPC;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init pcc_probe(void)
> +{
> +	acpi_status status =3D AE_OK;
> +	acpi_size pcct_tbl_header_size;
> +	struct acpi_table_pcct *pcct_tbl;
> +
> +	/* Search for PCCT */
> +	status =3D acpi_get_table_with_size(ACPI_SIG_PCCT, 0,
> +			(struct acpi_table_header **)&pcct_tbl,
> +			&pcct_tbl_header_size);
> +
> +	if (ACPI_SUCCESS(status) && !pcct_tbl) {
> +		pr_warn("PCCT header not found.\n");
> +		status =3D AE_NOT_FOUND;
> +		goto out_err;
> +	}
> +
> +	status =3D acpi_table_parse_entries(ACPI_SIG_PCCT,
> +			sizeof(struct acpi_table_pcct),
> +			ACPI_PCCT_TYPE_GENERIC_SUBSPACE,
> +			parse_pcc_subspace, MAX_PCC_SUBSPACES);
> +
> +	if (ACPI_SUCCESS(status))
> +		pr_err("Error parsing PCC subspaces from PCCT\n");
> +
> +	pr_info("Detected %d PCC Subspaces\n", total_ss);
> +
> +out_err:
> +	return ACPI_SUCCESS(status) ? 1 : 0;
> +}
> +
> +static int __init pcc_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	/* Check if PCC support is available. */
> +	ret =3D pcc_probe();
> +
> +	if (ret) {
> +		pr_debug("PCC probe failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +device_initcall(pcc_init);
> --=20
> 1.8.3.2
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

--TYoqghpzCwoKvQG2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiFqcAAoJELSic+t+oim9GMIP/jBrmaWOljBQTZQHZw61RKAW
9SPOfZfMjFASYs67WsuIUtSv0k4l3MXt4puVtVbxi7HeVQkhn4F3XFJw2YGI20Lh
lEGmlFOHI/vv5kYoXxQXYd4+SclSABFFHitx9N31FgYFNjsjJbjtpH9N+U6pvnVp
+tAYfDFs6XqKdx3f4/CJWHQbAIisJgL7kpdYuKc+T9S67SAQeTPzF0x3lnEsZPkY
t/fC5ni2IR32iuS/Fms/JDTK4B7q4MojJvPuBNwub4hAATXNMTtixSSobNJZVdAR
MO2e6ey5AMQXF3LUDPFCeMkxM4xiPqYJaptO3erwWh9n2Y1fO2naGpHM9BondC1T
TWaAP2zua0ujSwZcv5HH5u5gxbTehHGi0LX61g441bO9vyLS0Esh/ZU0iK6/Ep9Y
56gs/8UWexEtJ5wRPEQ1DHzsmpbr7NCIhKvMfZZSFMNFdM45E0Qcu5d41k3oaJ8I
WoMHmdmyW7toIpHDjJhY5/+Ovfkq1H8syWdp7sWKCgMNYp28Gz71cP6etjMQgMPN
gltflyJQBsyUtuKPdQqMuQsBudiWhzYk6CRcfP4/WBGL45AF9Dxv4I+4a+wa2JJT
PDj7+BCdBNtMmVgI29EOPvGODVCGdvmGNVAvUAFct1j1f+r8UYyOlwoHFlRzS9UW
q7l1rCSHo9Rekmis/rhn
=7aW/
-----END PGP SIGNATURE-----

--TYoqghpzCwoKvQG2--
