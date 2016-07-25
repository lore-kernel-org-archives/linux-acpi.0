From: wangyijing <wangyijing@huawei.com>
Subject: Re: [PATCH] PCI: release pci_host_bridge resource after remove root
 bus
Date: Mon, 25 Jul 2016 09:18:27 +0800
Message-ID: <579568E3.6010601@huawei.com>
References: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([119.145.14.52]:10820 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752098AbcGYBWL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Jul 2016 21:22:11 -0400
In-Reply-To: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bhelgaas@google.com
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

ping..

=E5=9C=A8 2016/6/23 19:42, Yijing Wang =E5=86=99=E9=81=93:
> pci_host_bridge holds the top resources(IO port/Mem/bus),
> now we release pci_host_bridge resources in
> acpi_pci_root_release_info() which would be called when
> pci_host_bridge device refcount reach 0. In some cases,
> pci_host_bridge refcount cannot reach 0 after we remove
> pci root bus in pci_remove_root_bus(). Then if we want to
> hot add pci root bus, we cannot use pci_host_bridge
> resources because of conflicts with old resources which are
> still in system. I think this is not reasonable.
>=20
> 1. For pci devices, we would release their resources in
>    pci_destroy_dev() regardless of pci device refcount.
> 2. When we try to remove pci root bus, there is no devices
>    need to use the pci_host_bridge resources again, release
>    pci_host_bridge resources is safe.
> 3. In some cases, users woule make mistake, for example,
>    user get a pci device(increase refcount), but forget to
>    put this device, then if we do hotplug pci root bus,
>    it would make all pci devices cannot work after hot add.
>=20
> I found this issue in the following case:
> 1. I have a raid pci device in my system;
> 2. I mount a disk which connect to this raid.
> 3. hot remove the pci root bus.
> 4. hot add the pci root bus.
> 5. found the resource conflicts for the children pci devices under th=
is root bus.
>=20
> pci_root_bus increase a refcount at pci_host_bridge.
> pci_root_bus decrease a refcount at pci_host_bridge in
>   release_pcibus_dev() when pci_root_bus device refcount reach 0.
>=20
> pci_dev increase a refcount at pci_bus in pci_alloc_dev().
> pci_dev decrease a refcount at pci_bus in pci_release_dev()
> when pci_dev refcount reach 0.
>=20
> If any pci device refcount cannot reach 0, then its pci_bus
> refcount cannot reach 0 too, the result is pci_host_bridge
> refcount cannot reach 0.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/acpi/pci_root.c   |   11 -----------
>  drivers/pci/host-bridge.c |   15 +++++++++++++++
>  drivers/pci/pci.h         |    2 +-
>  drivers/pci/remove.c      |    1 +
>  4 files changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d144168..c5142d0 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -839,17 +839,6 @@ static void __acpi_pci_root_release_info(struct =
acpi_pci_root_info *info)
> =20
>  static void acpi_pci_root_release_info(struct pci_host_bridge *bridg=
e)
>  {
> -	struct resource *res;
> -	struct resource_entry *entry;
> -
> -	resource_list_for_each_entry(entry, &bridge->windows) {
> -		res =3D entry->res;
> -		if (res->flags & IORESOURCE_IO)
> -			pci_unmap_iospace(res);
> -		if (res->parent &&
> -		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> -			release_resource(res);
> -	}
>  	__acpi_pci_root_release_info(bridge->release_data);
>  }
> =20
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 5f4a2e0..3594967 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -8,6 +8,21 @@
> =20
>  #include "pci.h"
> =20
> +void release_host_bridge_resources(struct pci_host_bridge *bridge)
> +{
> +	struct resource *res;
> +	struct resource_entry *entry;
> +
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		res =3D entry->res;
> +		if (res->flags & IORESOURCE_IO)
> +			pci_unmap_iospace(res);
> +		if (res->parent &&
> +		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +			release_resource(res);
> +	}
> +}
> +
>  static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>  {
>  	while (bus->parent)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9730c47..46725d9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -11,7 +11,7 @@ extern const unsigned char pcie_link_speed[];
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
> =20
>  /* Functions internal to the PCI core code */
> -
> +void release_host_bridge_resources(struct pci_host_bridge *bridge);
>  int pci_create_sysfs_dev_files(struct pci_dev *pdev);
>  void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
>  #if !defined(CONFIG_DMI) && !defined(CONFIG_ACPI)
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d1ef7ac..a42b396 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -161,6 +161,7 @@ void pci_remove_root_bus(struct pci_bus *bus)
>  	pci_remove_bus(bus);
>  	host_bridge->bus =3D NULL;
> =20
> +	release_host_bridge_resources(host_bridge);
>  	/* remove the host bridge */
>  	device_unregister(&host_bridge->dev);
>  }
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
