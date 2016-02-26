From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] device property: don't bother the drivers with struct
 property_set
Date: Fri, 26 Feb 2016 16:35:26 +0200
Message-ID: <1456497326.13244.151.camel@linux.intel.com>
References: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43538 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbcBZOeo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Feb 2016 09:34:44 -0500
In-Reply-To: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 2016-02-26 at 13:20 +0200, Heikki Krogerus wrote:
> Since device_add_property_set() now always takes a copy of
> the property_set, and also since the fwnode type is always
> hard coded to be FWNODE_PDATA, there is no need for the
> drivers to deliver the entire struct property_set. The
> function can just create the instance of it on its own and
> bind the properties from the drivers to it on the spot.
>=20
> This renames device_add_property_set() to
> device_add_properties(). The function now takes struct
> property_entry as its parameter instead of struct
> property_set.

Rationale IIUC is the eliminating of an extra structure definition in
users.

=46WIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


>=20
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> =C2=A0arch/arm/mach-tegra/board-paz00.c |=C2=A0=C2=A06 +-----
> =C2=A0drivers/base/platform.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 19 ++++++++++---------
> =C2=A0drivers/base/property.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 35 ++++++++++++++++++++++-------
> ------
> =C2=A0drivers/mfd/intel-lpss-acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A06 +-----
> =C2=A0drivers/mfd/intel-lpss-pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
| 14 +++-----------
> =C2=A0drivers/mfd/intel-lpss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0drivers/mfd/intel-lpss.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0drivers/mfd/mfd-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A04 ++--
> =C2=A0include/linux/mfd/core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0include/linux/platform_device.h=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A04=
 ++--
> =C2=A0include/linux/property.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 15 +++------------
> =C2=A011 files changed, 47 insertions(+), 62 deletions(-)
>=20
> Hi Rafael,
>=20
> This depends on Johannes' wireless next tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
>=20
>=20
> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-
> tegra/board-paz00.c
> index 52db8bf..7478f6f 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -29,10 +29,6 @@ static struct property_entry __initdata
> wifi_rfkill_prop[] =3D {
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> -static struct property_set __initdata wifi_rfkill_pset =3D {
> -	.properties =3D wifi_rfkill_prop,
> -};
> -
> =C2=A0static struct platform_device wifi_rfkill_device =3D {
> =C2=A0	.name	=3D "rfkill_gpio",
> =C2=A0	.id	=3D -1,
> @@ -49,7 +45,7 @@ static struct gpiod_lookup_table wifi_gpio_lookup =3D
> {
> =C2=A0
> =C2=A0void __init tegra_paz00_wifikill_init(void)
> =C2=A0{
> -	platform_device_add_properties(&wifi_rfkill_device,
> &wifi_rfkill_pset);
> +	platform_device_add_properties(&wifi_rfkill_device,
> wifi_rfkill_prop);
> =C2=A0	gpiod_add_lookup_table(&wifi_gpio_lookup);
> =C2=A0	platform_device_register(&wifi_rfkill_device);
> =C2=A0}
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index f437afa..6482d47 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -322,16 +322,16 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
> =C2=A0/**
> =C2=A0 * platform_device_add_properties - add built-in properties to =
a
> platform device
> =C2=A0 * @pdev: platform device to add properties to
> - * @pset: properties to add
> + * @properties: null terminated array of properties to add
> =C2=A0 *
> - * The function will take deep copy of the properties in @pset and
> attach
> - * the copy to the platform device. The memory associated with
> properties
> - * will be freed when the platform device is released.
> + * The function will take deep copy of @properties and attach the
> copy to the
> + * platform device. The memory associated with properties will be
> freed when the
> + * platform device is released.
> =C2=A0 */
> =C2=A0int platform_device_add_properties(struct platform_device *pdev=
,
> -				=C2=A0=C2=A0=C2=A0const struct property_set *pset)
> +				=C2=A0=C2=A0=C2=A0struct property_entry
> *properties)
> =C2=A0{
> -	return device_add_property_set(&pdev->dev, pset);
> +	return device_add_properties(&pdev->dev, properties);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(platform_device_add_properties);
> =C2=A0
> @@ -447,7 +447,7 @@ void platform_device_del(struct platform_device
> *pdev)
> =C2=A0				release_resource(r);
> =C2=A0		}
> =C2=A0
> -		device_remove_property_set(&pdev->dev);
> +		device_remove_properties(&pdev->dev);
> =C2=A0	}
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(platform_device_del);
> @@ -526,8 +526,9 @@ struct platform_device
> *platform_device_register_full(
> =C2=A0	if (ret)
> =C2=A0		goto err;
> =C2=A0
> -	if (pdevinfo->pset) {
> -		ret =3D platform_device_add_properties(pdev, pdevinfo-
> >pset);
> +	if (pdevinfo->properties) {
> +		ret =3D platform_device_add_properties(pdev,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pdevinfo-
> >properties);
> =C2=A0		if (ret)
> =C2=A0			goto err;
> =C2=A0	}
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 167f0a9..8442033 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -19,6 +19,11 @@
> =C2=A0#include <linux/etherdevice.h>
> =C2=A0#include <linux/phy.h>
> =C2=A0
> +struct property_set {
> +	struct fwnode_handle fwnode;
> +	struct property_entry *properties;
> +};
> +
> =C2=A0static inline bool is_pset_node(struct fwnode_handle *fwnode)
> =C2=A0{
> =C2=A0	return fwnode && fwnode->type =3D=3D FWNODE_PDATA;
> @@ -797,14 +802,14 @@ static struct property_set *pset_copy_set(const
> struct property_set *pset)
> =C2=A0}
> =C2=A0
> =C2=A0/**
> - * device_remove_property_set - Remove properties from a device
> object.
> + * device_remove_properties - Remove properties from a device
> object.
> =C2=A0 * @dev: Device whose properties to remove.
> =C2=A0 *
> =C2=A0 * The function removes properties previously associated to the
> device
> - * secondary firmware node with device_add_property_set(). Memory
> allocated
> + * secondary firmware node with device_add_properties(). Memory
> allocated
> =C2=A0 * to the properties will also be released.
> =C2=A0 */
> -void device_remove_property_set(struct device *dev)
> +void device_remove_properties(struct device *dev)
> =C2=A0{
> =C2=A0	struct fwnode_handle *fwnode;
> =C2=A0
> @@ -822,24 +827,28 @@ void device_remove_property_set(struct device
> *dev)
> =C2=A0		pset_free_set(to_pset_node(fwnode));
> =C2=A0	set_secondary_fwnode(dev, NULL);
> =C2=A0}
> -EXPORT_SYMBOL_GPL(device_remove_property_set);
> +EXPORT_SYMBOL_GPL(device_remove_properties);
> =C2=A0
> =C2=A0/**
> - * device_add_property_set - Add a collection of properties to a
> device object.
> + * device_add_properties - Add a collection of properties to a
> device object.
> =C2=A0 * @dev: Device to add properties to.
> - * @pset: Collection of properties to add.
> + * @properties: Collection of properties to add.
> =C2=A0 *
> - * Associate a collection of device properties represented by @pset
> with @dev
> - * as its secondary firmware node. The function takes a copy of
> @pset.
> + * Associate a collection of device properties represented by
> @properties with
> + * @dev as its secondary firmware node. The function takes a copy of
> + * @properties.
> =C2=A0 */
> -int device_add_property_set(struct device *dev, const struct
> property_set *pset)
> +int device_add_properties(struct device *dev,
> +			=C2=A0=C2=A0struct property_entry *properties)
> =C2=A0{
> -	struct property_set *p;
> +	struct property_set *p, pset;
> =C2=A0
> -	if (!pset)
> +	if (!properties)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	p =3D pset_copy_set(pset);
> +	pset.properties =3D properties;
> +
> +	p =3D pset_copy_set(&pset);
> =C2=A0	if (IS_ERR(p))
> =C2=A0		return PTR_ERR(p);
> =C2=A0
> @@ -847,7 +856,7 @@ int device_add_property_set(struct device *dev,
> const struct property_set *pset)
> =C2=A0	set_secondary_fwnode(dev, &p->fwnode);
> =C2=A0	return 0;
> =C2=A0}
> -EXPORT_SYMBOL_GPL(device_add_property_set);
> +EXPORT_SYMBOL_GPL(device_add_properties);
> =C2=A0
> =C2=A0/**
> =C2=A0 * device_get_next_child_node - Return the next child node hand=
le
> for a device
> diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-
> acpi.c
> index 06f00d6..8e94ad2 100644
> --- a/drivers/mfd/intel-lpss-acpi.c
> +++ b/drivers/mfd/intel-lpss-acpi.c
> @@ -31,13 +31,9 @@ static struct property_entry spt_i2c_properties[]
> =3D {
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> -static struct property_set spt_i2c_pset =3D {
> -	.properties =3D spt_i2c_properties,
> -};
> -
> =C2=A0static const struct intel_lpss_platform_info spt_i2c_info =3D {
> =C2=A0	.clk_rate =3D 120000000,
> -	.pset =3D &spt_i2c_pset,
> +	.properties =3D spt_i2c_properties,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct intel_lpss_platform_info bxt_info =3D {
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-
> pci.c
> index afc7af9..5855cce 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -71,13 +71,9 @@ static struct property_entry spt_i2c_properties[]
> =3D {
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> -static struct property_set spt_i2c_pset =3D {
> -	.properties =3D spt_i2c_properties,
> -};
> -
> =C2=A0static const struct intel_lpss_platform_info spt_i2c_info =3D {
> =C2=A0	.clk_rate =3D 120000000,
> -	.pset =3D &spt_i2c_pset,
> +	.properties =3D spt_i2c_properties,
> =C2=A0};
> =C2=A0
> =C2=A0static struct property_entry uart_properties[] =3D {
> @@ -87,14 +83,10 @@ static struct property_entry uart_properties[] =3D
> {
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> -static struct property_set uart_pset =3D {
> -	.properties =3D uart_properties,
> -};
> -
> =C2=A0static const struct intel_lpss_platform_info spt_uart_info =3D =
{
> =C2=A0	.clk_rate =3D 120000000,
> =C2=A0	.clk_con_id =3D "baudclk",
> -	.pset =3D &uart_pset,
> +	.properties =3D uart_properties,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct intel_lpss_platform_info bxt_info =3D {
> @@ -104,7 +96,7 @@ static const struct intel_lpss_platform_info
> bxt_info =3D {
> =C2=A0static const struct intel_lpss_platform_info bxt_uart_info =3D =
{
> =C2=A0	.clk_rate =3D 100000000,
> =C2=A0	.clk_con_id =3D "baudclk",
> -	.pset =3D &uart_pset,
> +	.properties =3D uart_properties,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct intel_lpss_platform_info bxt_i2c_info =3D {
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 1bbbe87..6352aab 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -407,7 +407,7 @@ int intel_lpss_probe(struct device *dev,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	lpss->cell->pset =3D info->pset;
> +	lpss->cell->properties =3D info->properties;
> =C2=A0
> =C2=A0	intel_lpss_init_dev(lpss);
> =C2=A0
> diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
> index 0dcea9e..d064973 100644
> --- a/drivers/mfd/intel-lpss.h
> +++ b/drivers/mfd/intel-lpss.h
> @@ -23,7 +23,7 @@ struct intel_lpss_platform_info {
> =C2=A0	int irq;
> =C2=A0	unsigned long clk_rate;
> =C2=A0	const char *clk_con_id;
> -	struct property_set *pset;
> +	struct property_entry *properties;
> =C2=A0};
> =C2=A0
> =C2=A0int intel_lpss_probe(struct device *dev,
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 88bd1b1..fc1c1fc 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -193,8 +193,8 @@ static int mfd_add_device(struct device *parent,
> int id,
> =C2=A0			goto fail_alias;
> =C2=A0	}
> =C2=A0
> -	if (cell->pset) {
> -		ret =3D platform_device_add_properties(pdev, cell-
> >pset);
> +	if (cell->properties) {
> +		ret =3D platform_device_add_properties(pdev, cell-
> >properties);
> =C2=A0		if (ret)
> =C2=A0			goto fail_alias;
> =C2=A0	}
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index 1a5a87f..ba9d79f 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -73,7 +73,7 @@ struct mfd_cell {
> =C2=A0	size_t			pdata_size;
> =C2=A0
> =C2=A0	/* device properties passed to the sub devices drivers */
> -	const struct property_set *pset;
> +	struct property_entry *properties;
> =C2=A0
> =C2=A0	/*
> =C2=A0	=C2=A0* Device Tree compatible string
> diff --git a/include/linux/platform_device.h
> b/include/linux/platform_device.h
> index 03b7555..66dca60 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -73,7 +73,7 @@ struct platform_device_info {
> =C2=A0		size_t size_data;
> =C2=A0		u64 dma_mask;
> =C2=A0
> -		const struct property_set *pset;
> +		struct property_entry *properties;
> =C2=A0};
> =C2=A0extern struct platform_device *platform_device_register_full(
> =C2=A0		const struct platform_device_info *pdevinfo);
> @@ -172,7 +172,7 @@ extern int platform_device_add_resources(struct
> platform_device *pdev,
> =C2=A0extern int platform_device_add_data(struct platform_device *pde=
v,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0const void *data, size_t size);
> =C2=A0extern int platform_device_add_properties(struct platform_devic=
e
> *pdev,
> -					=C2=A0=C2=A0const struct property_set
> *pset);
> +					=C2=A0=C2=A0struct property_entry
> *properties);
> =C2=A0extern int platform_device_add(struct platform_device *pdev);
> =C2=A0extern void platform_device_del(struct platform_device *pdev);
> =C2=A0extern void platform_device_put(struct platform_device *pdev);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index b51fcd3..ecab11e 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -238,18 +238,9 @@ struct property_entry {
> =C2=A0	.name =3D _name_,				\
> =C2=A0}
> =C2=A0
> -/**
> - * struct property_set - Collection of "built-in" device properties.
> - * @fwnode: Handle to be pointed to by the fwnode field of struct
> device.
> - * @properties: Array of properties terminated with a null entry.
> - */
> -struct property_set {
> -	struct fwnode_handle fwnode;
> -	struct property_entry *properties;
> -};
> -
> -int device_add_property_set(struct device *dev, const struct
> property_set *pset);
> -void device_remove_property_set(struct device *dev);
> +int device_add_properties(struct device *dev,
> +			=C2=A0=C2=A0struct property_entry *properties);
> +void device_remove_properties(struct device *dev);
> =C2=A0
> =C2=A0bool device_dma_supported(struct device *dev);
> =C2=A0

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
