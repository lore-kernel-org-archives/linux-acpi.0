From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 4/4] pinctrl: Parse GpioInt/GpioIo resources
Date: Mon, 4 Apr 2016 16:47:40 +0300
Message-ID: <20160404134740.GB1727@lahna.fi.intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <1459424685-26965-5-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459424685-26965-5-git-send-email-irina.tirdea@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 31, 2016 at 02:44:45PM +0300, Irina Tirdea wrote:
> +static int acpi_parse_gpio_res(struct pinctrl *p,
> +			       struct pinctrl_map **map,
> +			       unsigned *num_maps,
> +			       struct pinctrl_dev ***pctldevs)
> +{
> +	struct acpi_gpio_lookup lookup;
> +	struct list_head res_list;
> +	struct acpi_device *adev;
> +	unsigned int index;
> +	int ret;
> +
> +	adev = ACPI_COMPANION(p->dev);
> +
> +	*map = NULL;
> +	*num_maps = 0;
> +	memset(&lookup, 0, sizeof(lookup));
> +
> +	/* Parse all GpioInt/GpioIo resources in _CRS and extract pin conf */
> +	for (index = 0; ; index++) {
> +		lookup.index = index;
> +		lookup.n = 0;
> +		lookup.found = false;
> +
> +		INIT_LIST_HEAD(&res_list);
> +		ret = acpi_dev_get_resources(adev, &res_list, acpi_gpio_to_map,
> +					     &lookup);
> +		if (ret < 0)
> +			goto exit_free;
> +		acpi_dev_free_resource_list(&res_list);
> +		if (!lookup.found)
> +			break;
> +	}
> +
> +	*map = lookup.map;
> +	*num_maps = lookup.num_maps;
> +	*pctldevs = lookup.pctldevs;

This function has quite many stars in arguments and in the function
body. In particular pctldevs has three stars!

I wonder if this could be written in such way that avoids that. Like
create a structure holding the map information and pass that to the
function instead.

Other parts of the patch look good to me.
