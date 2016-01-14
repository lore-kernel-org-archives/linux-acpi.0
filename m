From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH V3 20/21] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Thu, 14 Jan 2016 10:36:16 -0500
Message-ID: <1452785776.28109.22.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <1452691267-32240-21-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452691267-32240-21-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Wed, 2016-01-13 at 14:21 +0100, Tomasz Nowicki wrote:
> Some platforms may not be fully compliant with generic set of PCI con=
fig
> accessors. For these cases we implement the way to overwrite accessor=
s
> set prior to PCI buses enumeration. Algorithm traverses available qui=
rk
> list, matches against <platform ID (DMI), domain, bus number> tuple a=
nd
> returns corresponding accessors. All quirks can be defined using:
> DECLARE_ACPI_MCFG_FIXUP() and keep self contained. Example,
>=20
> static const struct dmi_system_id foo_dmi[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.ident =3D "<Platform ident string>",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.callback =3D <handler>,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.matches =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ }
> };
>=20
> static struct pci_ops foo_ecam_pci_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.map_bus =3D pci_mcfg=
_dev_base,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.read =3D foo_ecam_co=
nfig_read,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.write =3D foo_ecam_c=
onfig_write,
> };
> DECLARE_ACPI_MCFG_FIXUP(foo_dmi, NULL, &foo_ecam_pci_ops, <domain_nr>=
, <bus_nr>);
>=20
> More custom (non-DMI) matching can be done via an alternative call.
> Note that there is possibility to assign quirk related private data t=
o
> root->sysdata which will be available along read/wriate accessor, exa=
mple:
>=20
> static int boo_match(struct pci_mcfg_fixup *fixup, struct acpi_pci_ro=
ot *root)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return [condition] ? =
1 : 0;
> }
>=20
> int boo_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0int where, int size, u32 *val)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_pci_root =
*root =3D bus->sysdata;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct boo_priv_data =
*boo_data =3D root->sysdata;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[..]
> }
>=20
> static struct pci_ops boo_ecam_pci_ops =3D {
> 	.map_bus =3D pci_mcfg_dev_base,
> 	.read =3D boo_ecam_config_read,
> 	.write =3D boo_ecam_config_write,
> };
> DECLARE_ACPI_MCFG_FIXUP(NULL, boo_match, &boo_ecam_pci_ops, <domain_n=
r>, <bus_nr>);
>=20
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
> =C2=A0drivers/acpi/mcfg.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 33 +++++++++++++++++++++=
++++++++++--
> =C2=A0include/acpi/acpi_bus.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> =C2=A0include/asm-generic/vmlinux.lds.h |=C2=A0=C2=A07 +++++++
> =C2=A0include/linux/ecam.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 18 ++++++++++++++++++
> =C2=A04 files changed, 57 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
> index dfc2d14..ec5fe7b 100644
> --- a/drivers/acpi/mcfg.c
> +++ b/drivers/acpi/mcfg.c
> @@ -8,6 +8,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/acpi.h>
> +#include <linux/dmi.h>
> =C2=A0#include <linux/ecam.h>
> =C2=A0#include <linux/pci.h>
> =C2=A0#include <linux/pci-acpi.h>
> @@ -34,6 +35,29 @@ int __weak raw_pci_write(unsigned int domain, unsi=
gned int bus,
> =C2=A0	return PCIBIOS_DEVICE_NOT_FOUND;
> =C2=A0}
> =C2=A0
> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[];
> +extern struct pci_mcfg_fixup __end_acpi_mcfg_fixups[];
> +
> +static struct pci_ops *pci_mcfg_check_quirks(struct acpi_pci_root *r=
oot)
> +{
> +	struct pci_mcfg_fixup *f;
> +	int bus_num =3D root->secondary.start;
> +	int domain =3D root->segment;
> +
> +	/*
> +	=C2=A0* First match against PCI topology <domain:bus> then use DMI =
or
> +	=C2=A0* custom match handler.
> +	=C2=A0*/
> +	for (f =3D __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f+=
+) {
> +		if ((f->domain =3D=3D domain || f->domain =3D=3D PCI_MCFG_DOMAIN_A=
NY) &&
> +		=C2=A0=C2=A0=C2=A0=C2=A0(f->bus_num =3D=3D bus_num || f->bus_num =3D=
=3D PCI_MCFG_BUS_ANY) &&
> +		=C2=A0=C2=A0=C2=A0=C2=A0(f->system ? dmi_check_system(f->system) :=
 0 ||
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->match ? f->match(f, root) : 0))
> +			return f->ops;

I think this would be better as:

		=C2=A0=C2=A0=C2=A0=C2=A0(f->system ? dmi_check_system(f->system) : 1 =
&&
		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f->match ? f->match(f, root) : 1))
			return f->ops;

Otherwise, one has to call dmi_check_system() from f->match() if
access to root is needed.
=C2=A0=C2=A0
> +	}
> +	return NULL;
> +}
> +
> =C2=A0void __iomem *
> =C2=A0pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int =
offset)
> =C2=A0{
> @@ -56,10 +80,15 @@ static struct pci_ops default_pci_mcfg_ops =3D {
> =C2=A0
> =C2=A0struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> =C2=A0{
> +	struct pci_ops *pci_mcfg_ops_quirk;
> +
> =C2=A0	/*
> -	=C2=A0* TODO: Match against platform specific quirks and return
> -	=C2=A0* corresponding PCI config space accessor set.
> +	=C2=A0* Match against platform specific quirks and return correspon=
ding
> +	=C2=A0* PCI config space accessor set.
> =C2=A0	=C2=A0*/
> +	pci_mcfg_ops_quirk =3D pci_mcfg_check_quirks(root);
> +	if (pci_mcfg_ops_quirk)
> +		return pci_mcfg_ops_quirk;
> =C2=A0
> =C2=A0	return &default_pci_mcfg_ops;
> =C2=A0}
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ad0a5ff..ea4d2b5 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -554,6 +554,7 @@ struct acpi_pci_root {
> =C2=A0	struct pci_bus *bus;
> =C2=A0	u16 segment;
> =C2=A0	struct resource secondary;	/* downstream bus range */
> +	void *sysdata;
> =C2=A0
> =C2=A0	u32 osc_support_set;	/* _OSC state of support bits */
> =C2=A0	u32 osc_control_set;	/* _OSC state of control bits */
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/=
vmlinux.lds.h
> index c4bd0e2..c93fc97 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -298,6 +298,13 @@
> =C2=A0		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) =3D .;	\
> =C2=A0	}								\
> =C2=A0									\
> +	/* ACPI MCFG quirks */						\
> +	.acpi_fixup=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: AT(ADD=
R(.acpi_fixup) - LOAD_OFFSET) {	\
> +		VMLINUX_SYMBOL(__start_acpi_mcfg_fixups) =3D .;		\
> +		*(.acpi_fixup_mcfg)					\
> +		VMLINUX_SYMBOL(__end_acpi_mcfg_fixups) =3D .;		\
> +	}								\
> +									\
> =C2=A0	/* Built-in firmware blobs */					\
> =C2=A0	.builtin_fw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: A=
T(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
> =C2=A0		VMLINUX_SYMBOL(__start_builtin_fw) =3D .;			\
> diff --git a/include/linux/ecam.h b/include/linux/ecam.h
> index e0f322e..21215be 100644
> --- a/include/linux/ecam.h
> +++ b/include/linux/ecam.h
> @@ -20,6 +20,24 @@ struct pci_mmcfg_region {
> =C2=A0	bool hot_added;
> =C2=A0};
> =C2=A0
> +struct pci_mcfg_fixup {
> +	const struct dmi_system_id *system;
> +	int (*match)(struct pci_mcfg_fixup *, struct acpi_pci_root *);
> +	struct pci_ops *ops;
> +	int domain;
> +	int bus_num;
> +};
> +
> +#define PCI_MCFG_DOMAIN_ANY	-1
> +#define PCI_MCFG_BUS_ANY	-1
> +
> +/* Designate a routine to fix up buggy MCFG */
> +#define DECLARE_ACPI_MCFG_FIXUP(system, match, ops, dom, bus)		\
> +	static const struct pci_mcfg_fixup __mcfg_fixup_##system##dom##bus\
> +	=C2=A0__used	__attribute__((__section__(".acpi_fixup_mcfg"),		\
> +				aligned((sizeof(void *))))) =3D		\
> +	{ system, match, ops, dom, bus };
> +
> =C2=A0struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int b=
us);
> =C2=A0struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int st=
art,
> =C2=A0						=C2=A0=C2=A0=C2=A0int end, u64 addr);
