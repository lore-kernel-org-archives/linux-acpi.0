From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors
 against platfrom specific ECAM quirks
Date: Mon, 13 Jun 2016 11:47:11 -0400
Message-ID: <575ED57F.6050503@codeaurora.org>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
To: Dongdong Liu <liudongdong3@huawei.com>, helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com, tn@semihalf.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

Hi Dongdong,

On 06/13/2016 09:02 AM, Dongdong Liu wrote:
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index d3c3e85..49612b3 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -22,6 +22,10 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
> +
> +/* Root pointer to the mapped MCFG table */
> +static struct acpi_table_mcfg *mcfg_table;
> =20
>  /* Structure to hold entries from the MCFG table */
>  struct mcfg_entry {
> @@ -35,6 +39,38 @@ struct mcfg_entry {
>  /* List to save mcfg entries */
>  static LIST_HEAD(pci_mcfg_list);
> =20
> +extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
> +extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
> +
> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> +{
> +	int bus_num =3D root->secondary.start;
> +	int domain =3D root->segment;
> +	struct pci_cfg_fixup *f;
> +
> +	if (!mcfg_table)
> +		return &pci_generic_ecam_ops;
> +
> +	/*
> +	 * Match against platform specific quirks and return corresponding
> +	 * CAM ops.
> +	 *
> +	 * First match against PCI topology <domain:bus> then use OEM ID an=
d
> +	 * OEM revision from MCFG table standard header.
> +	 */
> +	for (f =3D __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f+=
+) {
> +		if ((f->domain =3D=3D domain || f->domain =3D=3D PCI_MCFG_DOMAIN_A=
NY) &&
> +		    (f->bus_num =3D=3D bus_num || f->bus_num =3D=3D PCI_MCFG_BUS_A=
NY) &&
> +		    (!strncmp(f->oem_id, mcfg_table->header.oem_id,
> +			      ACPI_OEM_ID_SIZE)) &&
> +		    (!strncmp(f->oem_table_id, mcfg_table->header.oem_table_id,
> +			      ACPI_OEM_TABLE_ID_SIZE)))

This would just be a small convenience, but if the character count used=
 here were

min(strlen(f->oem_id), ACPI_OEM_ID_SIZE)

then the parameters to DECLARE_ACPI_MCFG_FIXUP macro could be substring=
s and
wouldn't need to be padded out to the full length.

> +			return f->ops;
> +	}
> +	/* No quirks, use ECAM */
> +	return &pci_generic_ecam_ops;
> +}

> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 7d63a66..088a1da 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -25,6 +25,7 @@ static inline acpi_status pci_acpi_remove_pm_notifi=
er(struct acpi_device *dev)
>  extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
> =20
>  extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource *bus_=
res);
> +extern struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *r=
oot);
> =20
>  static inline acpi_handle acpi_find_root_bridge_handle(struct pci_de=
v *pdev)
>  {
> @@ -72,6 +73,25 @@ struct acpi_pci_root_ops {
>  	int (*prepare_resources)(struct acpi_pci_root_info *info);
>  };
> =20
> +struct pci_cfg_fixup {
> +	struct pci_ecam_ops *ops;
> +	char *oem_id;
> +	char *oem_table_id;
> +	int domain;
> +	int bus_num;
> +};
> +
> +#define PCI_MCFG_DOMAIN_ANY	-1
> +#define PCI_MCFG_BUS_ANY	-1
> +
> +/* Designate a routine to fix up buggy MCFG */
> +#define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, oem_table_id, dom, bus)=
	\
> +	static const struct pci_cfg_fixup				\
> +	__mcfg_fixup_##oem_id##oem_table_id##dom##bus			\

I'm not entirely sure that this is the right fix--I'm pretty blindly
following a GCC documentation suggestion [1]--but removing the first tw=
o
preprocessor concatenation operators "##" solved the following build er=
ror
for me.

include/linux/pci-acpi.h:90:2: error: pasting "__mcfg_fixup_" and ""QCO=
M"" does not give a valid preprocessing token
  __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
  ^
arch/arm64/kernel/pci.c:225:1: note: in expansion of macro =91DECLARE_A=
CPI_MCFG_FIXUP=92
 DECLARE_ACPI_MCFG_FIXUP(&pci_32b_ecam_ops, "QCOM", "QDF2432", PCI_MCFG=
_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
 ^
arch/arm64/kernel/pci.c:225:44: error: pasting ""QCOM"" and ""QDF2432""=
 does not give a valid preprocessing token
 DECLARE_ACPI_MCFG_FIXUP(&pci_32b_ecam_ops, "QCOM", "QDF2432", PCI_MCFG=
_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
                                            ^
include/linux/pci-acpi.h:90:17: note: in definition of macro =91DECLARE=
_ACPI_MCFG_FIXUP=92
  __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
                 ^
arch/arm64/kernel/pci.c:225:52: error: pasting ""QDF2432"" and "PCI_MCF=
G_DOMAIN_ANY" does not give a valid preprocessi
ng token
 DECLARE_ACPI_MCFG_FIXUP(&pci_32b_ecam_ops, "QCOM", "QDF2432", PCI_MCFG=
_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
                                                    ^
include/linux/pci-acpi.h:90:25: note: in definition of macro =91DECLARE=
_ACPI_MCFG_FIXUP=92
  __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
                         ^
arch/arm64/kernel/pci.c:225:44: error: expected =91=3D=92, =91,=92, =91=
;=92, =91asm=92 or =91__attribute__=92 before string constant
 DECLARE_ACPI_MCFG_FIXUP(&pci_32b_ecam_ops, "QCOM", "QDF2432", PCI_MCFG=
_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
                                            ^
include/linux/pci-acpi.h:90:17: note: in definition of macro =91DECLARE=
_ACPI_MCFG_FIXUP=92
  __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
                 ^
make[1]: *** [arch/arm64/kernel/pci.o] Error 1
make: *** [arch/arm64/kernel] Error 2

1. https://gcc.gnu.org/onlinedocs/cpp/Concatenation.html#Concatenation

> +	__used	__attribute__((__section__(".acpi_fixup_mcfg"),		\
> +				aligned((sizeof(void *))))) =3D		\
> +	{ ops, oem_id, oem_table_id, dom, bus };
> +
>  extern int acpi_pci_probe_root_resources(struct acpi_pci_root_info *=
info);
>  extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *ro=
ot,
>  					    struct acpi_pci_root_ops *ops,
>=20

Thanks,
Cov

--=20
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
