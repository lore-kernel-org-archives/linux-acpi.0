From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Date: Wed, 21 Oct 2015 12:02:01 +0100
Message-ID: <20151021110201.GE3394@e106497-lin.cambridge.arm.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <562761A1.4020306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <562761A1.4020306@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 21, 2015 at 11:57:53AM +0200, Tomasz Nowicki wrote:
> On 14.10.2015 08:29, Jiang Liu wrote:
> >Introduce common interface acpi_pci_root_create() and related data
> >structures to create PCI root bus for ACPI PCI host bridges. It will
> >be used to kill duplicated arch specific code for IA64 and x86. It m=
ay
> >also help ARM64 in future.
> >
> >Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Tested-by: Tony Luck <tony.luck@intel.com>
> >Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> >Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
> >---
> >  drivers/acpi/pci_root.c  |  204 ++++++++++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/pci-acpi.h |   24 ++++++
> >  2 files changed, 228 insertions(+)
> >
>=20
> [...]
>=20
> >+
> >+struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >+				     struct acpi_pci_root_ops *ops,
> >+				     struct acpi_pci_root_info *info,
> >+				     void *sysdata)
> >+{
> >+	int ret, busnum =3D root->secondary.start;
> >+	struct acpi_device *device =3D root->device;
> >+	int node =3D acpi_get_node(device->handle);
> >+	struct pci_bus *bus;
> >+
> >+	info->root =3D root;
> >+	info->bridge =3D device;
> >+	info->ops =3D ops;
> >+	INIT_LIST_HEAD(&info->resources);
> >+	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
> >+		 root->segment, busnum);
> >+
> >+	if (ops->init_info && ops->init_info(info))
> >+		goto out_release_info;
> >+	if (ops->prepare_resources)
> >+		ret =3D ops->prepare_resources(info);
> >+	else
> >+		ret =3D acpi_pci_probe_root_resources(info);
> >+	if (ret < 0)
> >+		goto out_release_info;
> >+
> >+	pci_acpi_root_add_resources(info);
> >+	pci_add_resource(&info->resources, &root->secondary);
> >+	bus =3D pci_create_root_bus(NULL, busnum, ops->pci_ops,
> >+				  sysdata, &info->resources);
>=20
> Thank a lot for this cleanup!!
>=20
> I recall you already considered passing segment (domain nr) to
> pci_create_root_bus, right? Can you please remind me why we gave up o=
n this?
>=20
> I am asking because currently I can not find the way to retrieve doma=
in
> number from pci_bus_assign_domain_nr (for those platforms which choos=
e
> PCI_DOMAINS_GENERIC and want to use segment nr from MCFG table) which=
 is the
> part of pci_create_root_bus.

Not sure I fully understand your question, but pci_bus_assign_domain_nr=
() will
put the assigned domain number in bus->domain_nr if you chose PCI_DOMAI=
NS_GENERIC.
Do you want to override that value with the segment nr from MCFG?

Best regards,
Liviu

>=20
> Regards,
> Tomasz
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
