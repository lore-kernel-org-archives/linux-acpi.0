From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v9 08/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
Date: Mon, 9 Mar 2015 15:01:19 +0000
Message-ID: <20150309150119.GG16268@e106497-lin.cambridge.arm.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kern>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 25, 2015 at 08:39:48AM +0000, Hanjun Guo wrote:
> CONFIG_ACPI depends CONFIG_PCI on x86 and ia64, in ARM64 server
> world we will have PCIe in most cases, but some of them may not,
> make CONFIG_ACPI depend CONFIG_PCI on ARM64 will satisfy both.
>=20
> With that case, we need some arch dependent PCI functions to
> access the config space before the PCI root bridge is created, and
> pci_acpi_scan_root() to create the PCI root bus. So introduce
> some stub function here to make ACPI core compile and revisit
> them later when implemented on ARM64.
>=20
> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/pci.h |  6 ++++++
>  arch/arm64/kernel/pci.c      | 25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pc=
i.h
> index 872ba93..fded096 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -24,6 +24,12 @@
>   */
>  #define PCI_DMA_BUS_IS_PHYS	(0)

Hanjun,

> =20
> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int ch=
annel)
> +{
> +	/* no legacy IRQ on arm64 */
> +	return -ENODEV;
> +}
> +

Could you explain to me what situation you encountered where you needed
to define this? I'm trying to figure out when this would be needed and =
the
only thing I can come up with would be for drivers/pnp/resource.c, but =
that
is guarded by #ifdef CONFIG_PCI, which would mean that you should move =
this
a bit further down in the file, but also contradicts the last comment o=
n
this patch (i.e. PCI on ACPI is not really implemented, so presumably
CONFIG_PCI is not enabled?)

Best regards,
Liviu


>  extern int isa_dma_bridge_buggy;
> =20
>  #ifdef CONFIG_PCI
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 6f93c24..4095379 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -10,6 +10,7 @@
>   *
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -46,3 +47,27 @@ int pcibios_add_device(struct pci_dev *dev)
> =20
>  	return 0;
>  }
> +
> +/*
> + * raw_pci_read/write - Platform-specific PCI config space access.
> + */
> +int raw_pci_read(unsigned int domain, unsigned int bus,
> +		  unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	return -ENXIO;
> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus,
> +		unsigned int devfn, int reg, int len, u32 val)
> +{
> +	return -ENXIO;
> +}
> +
> +#ifdef CONFIG_ACPI
> +/* Root bridge scanning */
> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> +{
> +	/* TODO: Should be revisited when implementing PCI on ACPI */
> +	return NULL;
> +}
> +#endif
> --=20
> 1.9.1
>=20
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
