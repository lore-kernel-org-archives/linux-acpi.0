From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 3/4] pinctrl: Add ACPI support
Date: Fri, 01 Apr 2016 17:14:34 +0300
Message-ID: <1459520074.5907.205.camel@linux.intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	 <1459424685-26965-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58429 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbcDAONl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Apr 2016 10:13:41 -0400
In-Reply-To: <1459424685-26965-4-git-send-email-irina.tirdea@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-03-31 at 14:44 +0300, Irina Tirdea wrote:
> Add ACPI support for pin controller properties. These are
> based on ACPI _DSD properties and follow the device tree
> model based on states and node configurations. The states
> are defined as _DSD properties and configuration nodes
> are defined using the _DSD Hierarchical Properties Extension.
>=20
> A configuration node supports the generic device tree properties.
>=20
> The implementation is based on device tree code from devicetree.c.
>=20

Patch is good to me, though few minor comments below.

> +/**
> + * struct pinctrl_acpi_map - mapping table chunk parsed from ACPI
> + * @node: list node for struct pinctrl's @fw_maps field
> + * @pctldev: the pin controller that allocated this struct, and will
> free it

> + * @maps: the mapping table entries

We have @map and @num_maps.

> + */
> +struct pinctrl_acpi_map {
> +	struct list_head node;
> +	struct pinctrl_dev *pctldev;
> +	struct pinctrl_map *map;
> +	unsigned num_maps;
> +};
> +
>=20

> +static int acpi_remember_or_free_map(struct pinctrl *p, const char
> *statename,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pinctrl_dev *pctldev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pinctrl_map *map,
> unsigned num_maps)
> +{
> +	struct pinctrl_acpi_map *acpi_map;
> +	struct list_head *acpi_maps;


> +	unsigned int i;

Just unsigned i to be in align with unsigned num_maps.

> +
> +	/* Initialize common mapping table entry fields */
> +	for (i =3D 0; i < num_maps; i++) {
> +		map[i].dev_name =3D dev_name(p->dev);
> +		map[i].name =3D statename;
> +		if (pctldev)
> +			map[i].ctrl_dev_name =3D dev_name(pctldev-
> >dev);
> +	}


> +int pinctrl_acpi_to_map(struct pinctrl *p)
> +{
> +	const union acpi_object *prop, *statenames, *configs;
> +	unsigned int state, nstates, nconfigs, config;
> +	char *statename, *propname, *configname;
> +	struct fwnode_handle *fw_prop;
> +	struct acpi_device *adev;
> +	int ret;
> +
> +	/* We may store pointers to property names within the node
> */
> +	adev =3D acpi_bus_get_acpi_device(ACPI_HANDLE(p->dev));
> +	if (!adev)
> +		return -ENODEV;
> +

> +	/* Only allow named states (device must have prop 'pinctrl-
> names') */

Does it fit one line?

> +err_free_map:

Perhaps err_free_maps?

> +	pinctrl_acpi_free_maps(p);
> +	return ret;

--=C2=A0
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
