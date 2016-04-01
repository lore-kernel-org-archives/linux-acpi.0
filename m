From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] pinctrl: pinconf-generic: Add ACPI support
Date: Fri, 01 Apr 2016 17:05:29 +0300
Message-ID: <1459519529.5907.198.camel@linux.intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	 <1459424685-26965-3-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459424685-26965-3-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2016-03-31 at 14:44 +0300, Irina Tirdea wrote:
> Add ACPI support for the generic device tree properties.
> Convert the pinconf generic code to handle both ACPI and
> device tree by using the fwnode_property API. Also include
> renaming device tree references in names of functions and
> structures from 'dt' to 'fwnode'.

This is looks good to me, though few style / minor comments below.

> --- a/drivers/pinctrl/pinconf-generic.c
> +++ b/drivers/pinctrl/pinconf-generic.c
>=20

> @@ -175,22 +176,22 @@ static const struct pinconf_generic_params
> dt_params[] =3D {
> =C2=A0};
> =C2=A0
> =C2=A0/**
> - * parse_dt_cfg() - Parse DT pinconf parameters
> - * @np:	DT node
> + * parse_fwnode_cfg() - Parse FW pinconf parameters
> + * @fw:	FW node

Here and below it should be @fwnode.

> -int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> -		struct device_node *np, struct pinctrl_map **map,
> +static int pinconf_generic_fwnode_subnode_to_map(struct pinctrl_dev
> *pctldev,
> +		struct fwnode_handle *fwnode, struct pinctrl_map
> **map,
> =C2=A0		unsigned *reserved_maps, unsigned *num_maps,
> =C2=A0		enum pinctrl_map_type type)
> =C2=A0{
> -	int ret;
> +	int ret, i;

Since you change this line anyway, perhaps move it to be last in the
definition block?

> =C2=A0	const char *function;
> =C2=A0	struct device *dev =3D pctldev->dev;
> =C2=A0	unsigned long *configs =3D NULL;
> =C2=A0	unsigned num_configs =3D 0;
> =C2=A0	unsigned reserve, strings_count;
> -	struct property *prop;
> -	const char *group;
> +	const char **groups;
> =C2=A0	const char *subnode_target_type =3D "pins";

=2E..to here.

> +#ifdef CONFIG_OF
> +inline int pinconf_generic_parse_dt_config(struct device_node *np,
> +					=C2=A0=C2=A0=C2=A0struct pinctrl_dev
> *pctldev,
> +					=C2=A0=C2=A0=C2=A0unsigned long **configs,
> +					=C2=A0=C2=A0=C2=A0unsigned int *nconfigs)
> +{
> +	return pinconf_generic_parse_fwnode_config(&np->fwnode,
> pctldev,
> +						=C2=A0=C2=A0=C2=A0configs,
> nconfigs);
> +}

I didn't see any user of this.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
