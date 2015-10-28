From: Liviu.Dudau@arm.com
Subject: Re: [PATCH V1 10/11] pci, acpi: Provide generic way to assign bus
 domain number.
Date: Wed, 28 Oct 2015 11:38:37 +0000
Message-ID: <20151028113837.GK963@e106497-lin.cambridge.arm.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-11-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445963922-22711-11-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com, Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 27, 2015 at 05:38:41PM +0100, Tomasz Nowicki wrote:
> Architectures which support PCI_DOMAINS_GENERIC (like ARM64)
> cannot call pci_bus_assign_domain_nr along ACPI PCI host bridge
> initialization since this function needs valid parent device referenc=
e
> to be able to retrieve domain number (aka segment).
>=20
> We can omit that blocker and pass down host bridge device via
> pci_create_root_bus parameter and then be able to evaluate _SEG metho=
d
> being in pci_bus_assign_domain_nr.
>=20
> Note that _SEG method is optional, therefore _SEG absence means
> that all PCI buses belong to domain 0.
>=20
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/pci_root.c |  2 +-
>  drivers/pci/pci.c       | 32 +++++++++++++++++++++++++++-----
>  2 files changed, 28 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 850d7bf..e682dc6 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -839,7 +839,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_=
pci_root *root,
> =20
>  	pci_acpi_root_add_resources(info);
>  	pci_add_resource(&info->resources, &root->secondary);
> -	bus =3D pci_create_root_bus(NULL, busnum, ops->pci_ops,
> +	bus =3D pci_create_root_bus(&device->dev, busnum, ops->pci_ops,
>  				  sysdata, &info->resources);

Not sure this change should be in this patch, I don't see the relation.

To put it differently: I think the patch should introduce the retrieval=
 of the
domain number from _SEG method and leave the passing of a valid host br=
idge device
to a more appropriate patch.


>  	if (!bus)
>  		goto out_release_info;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6a9a111..17d1857 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -25,6 +25,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/acpi.h>
>  #include <asm-generic/pci-bridge.h>
>  #include <asm/setup.h>
>  #include "pci.h"
> @@ -4501,7 +4502,7 @@ int pci_get_new_domain_nr(void)
>  void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *pa=
rent)
>  {
>  	static int use_dt_domains =3D -1;
> -	int domain =3D of_get_pci_domain_nr(parent->of_node);
> +	int domain;
> =20
>  	/*
>  	 * Check DT domain and use_dt_domains values.
> @@ -4523,14 +4524,35 @@ void pci_bus_assign_domain_nr(struct pci_bus =
*bus, struct device *parent)
>  	 * API and update the use_dt_domains value to keep track of method =
we
>  	 * are using to assign domain numbers (use_dt_domains =3D 0).
>  	 *
> +	 * IF ACPI, we expect non-DT method (use_dt_domains =3D=3D -1)
> +	 * and call _SEG method for corresponding host bridge device.
> +	 * If _SEG method does not exist, following ACPI spec (6.5.6)
> +	 * all PCI buses belong to domain 0.
> +	 *
>  	 * All other combinations imply we have a platform that is trying
> -	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr=
(),
> -	 * which is a recipe for domain mishandling and it is prevented by
> -	 * invalidating the domain value (domain =3D -1) and printing a
> -	 * corresponding error.
> +	 * to mix domain numbers obtained from DT, ACPI and
> +	 * pci_get_new_domain_nr(), which is a recipe for domain mishandlin=
g and
> +	 * it is prevented by invalidating the domain value (domain =3D -1)=
 and
> +	 * printing a corresponding error.
>  	 */
> +
> +	domain =3D of_get_pci_domain_nr(parent->of_node);

Not sure what you've got here by splitting the original line into two o=
ther than an increase
in the change count.

Otherwise, it looks sensible.

Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>


>  	if (domain >=3D 0 && use_dt_domains) {
>  		use_dt_domains =3D 1;
> +#ifdef CONFIG_ACPI
> +	} else if (!acpi_disabled && use_dt_domains =3D=3D -1) {
> +		struct acpi_device *acpi_dev =3D to_acpi_device(parent);
> +		unsigned long long segment =3D 0;
> +		acpi_status status;
> +
> +		status =3D acpi_evaluate_integer(acpi_dev->handle,
> +					       METHOD_NAME__SEG, NULL,
> +					       &segment);
> +		if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND)
> +			dev_err(&acpi_dev->dev,  "can't evaluate _SEG\n");
> +
> +		domain =3D segment;
> +#endif
>  	} else if (domain < 0 && use_dt_domains !=3D 1) {
>  		use_dt_domains =3D 0;
>  		domain =3D pci_get_new_domain_nr();
> --=20
> 1.9.1
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
