From: Liviu.Dudau@arm.com
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
Date: Tue, 3 Nov 2015 16:28:14 +0000
Message-ID: <20151103162814.GR963@e106497-lin.cambridge.arm.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <20151028114940.GL963@e106497-lin.cambridge.arm.com>
 <20151103143214.GD3574@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151103143214.GD3574@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com, Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 03, 2015 at 02:32:14PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Oct 28, 2015 at 11:49:40AM +0000, Liviu.Dudau@arm.com wrote:
> > On Tue, Oct 27, 2015 at 05:38:42PM +0100, Tomasz Nowicki wrote:
>=20
> [...]
>=20
> > > +static int __init pcibios_assign_resources(void)
> > > +{
> > > +	if (acpi_disabled)
> > > +		return 0;
> > > +
> > > +	pci_assign_unassigned_resources();
> > > +	return 0;
> >=20
> > You can change this function into:
> > {
> > 	if (!acpi_disabled)
> > 		pci_assign_unassigned_resources();
> >=20
> > 	return 0;
> > }
> >=20
> > as the equivalent but shorter form.
>=20
> I do not think it is a matter of code style here, it is a matter
> of understanding when and if we want to reassign resources on ACPI
> systems, it is an open question on ARM64 that must be sorted out (ie =
we
> ignore FW/BARs set-up entirely).

I was reviewing the code here, not doing any technical guidance, I'm
leaving that to you as you are more involved around ACPI.

>=20
> > > +}
> > >  /*
> > > - * raw_pci_read/write - Platform-specific PCI config space acces=
s.
> > > + * rootfs_initcall comes after subsys_initcall and fs_initcall_s=
ync,
> > > + * so we know acpi scan and PCI_FIXUP_FINAL quirks have both run=
=2E
> > >   */
> > > -int raw_pci_read(unsigned int domain, unsigned int bus,
> > > -		  unsigned int devfn, int reg, int len, u32 *val)
> >=20
> > What happened with raw_pci_{read,write} ? Why do you remove them?
> >=20
> >=20
> > > +rootfs_initcall(pcibios_assign_resources);
> >=20
> > Would you be so kind and explain to me why you need this initcall?
> > Can you not set the PCI_REASSIGN_ALL_RSRC flag before calling
> > pci_scan_root_bus() ?
>=20
> On what basis ? BTW, PCI core code does not assign unassigned resourc=
es
> anyway even if that flag is set, so some policy has to be defined her=
e.

I was thinking that ACPI code can do that if they seem to depend on the=
 resources
being assigned during root bus scan. I was not implying that PCI core c=
ode enforces
that.

Best regards,
Liviu

>=20
> Thanks,
> Lorenzo
>=20
> > I haven't focused on ACPI before so I'm a bit hazy on the init orde=
r when
> > that is enabled. That being said, I don't like adding in the archit=
ecture
> > code initcall hooks just to fix up some dependency orders that coul=
d / should
> > be fixed some other way.
> >=20
> > > +
> > > +static void __iomem *
> > > +pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int o=
ffset)
> > >  {
> > > -	return -ENXIO;
> > > +	struct pci_mmcfg_region *cfg;
> > > +
> > > +	cfg =3D pci_mmconfig_lookup(pci_domain_nr(bus), bus->number);
> > > +	if (cfg && cfg->virt)
> > > +		return cfg->virt +
> > > +			(PCI_MMCFG_BUS_OFFSET(bus->number) | (devfn << 12)) +
> > > +			offset;
> > > +	return NULL;
> > >  }
> > > =20
> > > -int raw_pci_write(unsigned int domain, unsigned int bus,
> > > -		unsigned int devfn, int reg, int len, u32 val)
> > > +struct pci_ops pci_root_ops =3D {
> > > +	.map_bus =3D pci_mcfg_dev_base,
> > > +	.read =3D pci_generic_config_read,
> > > +	.write =3D pci_generic_config_write,
> > > +};
> > > +
> > > +#ifdef CONFIG_PCI_MMCONFIG
> > > +static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci=
)
> > >  {
> > > -	return -ENXIO;
> > > +	struct pci_mmcfg_region *cfg;
> > > +	struct acpi_pci_root *root;
> > > +	int seg, start, end, err;
> > > +
> > > +	root =3D ci->root;
> > > +	seg =3D root->segment;
> > > +	start =3D root->secondary.start;
> > > +	end =3D root->secondary.end;
> > > +
> > > +	cfg =3D pci_mmconfig_lookup(seg, start);
> > > +	if (cfg)
> > > +		return 0;
> > > +
> > > +	cfg =3D pci_mmconfig_alloc(seg, start, end, root->mcfg_addr);
> > > +	if (!cfg)
> > > +		return -ENOMEM;
> > > +
> > > +	err =3D pci_mmconfig_inject(cfg);
> > > +	return err;
> > >  }
> > > =20
> > > -#ifdef CONFIG_ACPI
> > > +static void pci_remove_mmconfig_region(struct acpi_pci_root_info=
 *ci)
> > > +{
> > > +	struct acpi_pci_root *root =3D ci->root;
> > > +	struct pci_mmcfg_region *cfg;
> > > +
> > > +	cfg =3D pci_mmconfig_lookup(root->segment, root->secondary.star=
t);
> > > +	if (cfg)
> > > +		return;
> > > +
> > > +	if (cfg->hot_added)
> > > +		pci_mmconfig_delete(root->segment, root->secondary.start,
> > > +				    root->secondary.end);
> > > +}
> > > +#else
> > > +static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci=
)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static void pci_remove_mmconfig_region(struct acpi_pci_root_info=
 *ci) { }
> > > +#endif
> > > +
> > > +static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci=
)
> > > +{
> > > +	return pci_add_mmconfig_region(ci);
> > > +}
> > > +
> > > +static void pci_acpi_root_release_info(struct acpi_pci_root_info=
 *ci)
> > > +{
> > > +	pci_remove_mmconfig_region(ci);
> > > +	kfree(ci);
> > > +}
> > > +
> > > +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_=
info *ci)
> > > +{
> > > +	struct resource_entry *entry, *tmp;
> > > +	int ret;
> > > +
> > > +	ret =3D acpi_pci_probe_root_resources(ci);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> > > +		struct resource *res =3D entry->res;
> > > +
> > > +		/*
> > > +		 * Special handling for ARM IO range
> >=20
> > There is nothing ARM specific here. It should apply to any memory m=
apped IO range.
> >=20
> > > +		 * TODO: need to move pci_register_io_range() function out
> > > +		 * of drivers/of/address.c for both used by DT and ACPI
> > > +		 */
> > > +		if (res->flags & IORESOURCE_IO) {
> > > +			unsigned long port;
> > > +			int err;
> > > +			resource_size_t length =3D res->end - res->start;
> > > +
> > > +			err =3D pci_register_io_range(res->start, length);
> > > +			if (err) {
> > > +				resource_list_destroy_entry(entry);
> > > +				continue;
> > > +			}
> > > +
> > > +			port =3D pci_address_to_pio(res->start);
> > > +			if (port =3D=3D (unsigned long)-1) {
> > > +				resource_list_destroy_entry(entry);
> > > +				continue;
> > > +			}
> > > +
> > > +			res->start =3D port;
> > > +			res->end =3D res->start + length - 1;
> > > +
> > > +			if (pci_remap_iospace(res, res->start) < 0)
> > > +				resource_list_destroy_entry(entry);
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct acpi_pci_root_ops acpi_pci_root_ops =3D {
> > > +	.pci_ops =3D &pci_root_ops,
> > > +	.init_info =3D pci_acpi_root_init_info,
> > > +	.release_info =3D pci_acpi_root_release_info,
> > > +	.prepare_resources =3D pci_acpi_root_prepare_resources,
> > > +};
> > > +
> > >  /* Root bridge scanning */
> > >  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> > >  {
> > > -	/* TODO: Should be revisited when implementing PCI on ACPI */
> > > -	return NULL;
> > > +	int node =3D acpi_get_node(root->device->handle);
> > > +	int domain =3D root->segment;
> > > +	int busnum =3D root->secondary.start;
> > > +	struct acpi_pci_root_info *info;
> > > +	struct pci_bus *bus;
> > > +
> > > +	if (domain && !pci_domains_supported) {
> > > +		pr_warn("PCI %04x:%02x: multiple domains not supported.\n",
> > > +			domain, busnum);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	info =3D kzalloc_node(sizeof(*info), GFP_KERNEL, node);
> > > +	if (!info) {
> > > +		dev_err(&root->device->dev,
> > > +			"pci_bus %04x:%02x: ignored (out of memory)\n",
> > > +			domain, busnum);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	bus =3D acpi_pci_root_create(root, &acpi_pci_root_ops, info, ro=
ot);
> > > +
> > > +	/* After the PCI-E bus has been walked and all devices discover=
ed,
> > > +	 * configure any settings of the fabric that might be necessary=
=2E
> > > +	 */
> > > +	if (bus) {
> > > +		struct pci_bus *child;
> > > +
> > > +		list_for_each_entry(child, &bus->children, node)
> > > +			pcie_bus_configure_settings(child);
> > > +	}
> > > +
> > > +	return bus;
> > >  }
> > >  #endif
> > > --=20
> > > 1.9.1
> > >=20
> >=20
> > --=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     =C2=AF\_(=E3=83=84)_/=C2=AF
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
