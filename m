From: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 4/4] pinctrl: Parse GpioInt/GpioIo resources
Date: Mon, 4 Apr 2016 14:05:33 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F22D82F@irsmsx105.ger.corp.intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <1459424685-26965-5-git-send-email-irina.tirdea@intel.com>
 <20160404134740.GB1727@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160404134740.GB1727-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Ciocan, Cristina" <cristina.ciocan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: 04 April, 2016 16:48
> To: Tirdea, Irina
> Cc: Rafael J. Wysocki; Len Brown; Linus Walleij; linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Rob Herring; Heikki Krogerus;
> Andy Shevchenko; Purdila, Octavian; Ciocan, Cristina; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [RFC PATCH 4/4] pinctrl: Parse GpioInt/GpioIo resources
> 
> On Thu, Mar 31, 2016 at 02:44:45PM +0300, Irina Tirdea wrote:
> > +static int acpi_parse_gpio_res(struct pinctrl *p,
> > +			       struct pinctrl_map **map,
> > +			       unsigned *num_maps,
> > +			       struct pinctrl_dev ***pctldevs)
> > +{
> > +	struct acpi_gpio_lookup lookup;
> > +	struct list_head res_list;
> > +	struct acpi_device *adev;
> > +	unsigned int index;
> > +	int ret;
> > +
> > +	adev = ACPI_COMPANION(p->dev);
> > +
> > +	*map = NULL;
> > +	*num_maps = 0;
> > +	memset(&lookup, 0, sizeof(lookup));
> > +
> > +	/* Parse all GpioInt/GpioIo resources in _CRS and extract pin conf */
> > +	for (index = 0; ; index++) {
> > +		lookup.index = index;
> > +		lookup.n = 0;
> > +		lookup.found = false;
> > +
> > +		INIT_LIST_HEAD(&res_list);
> > +		ret = acpi_dev_get_resources(adev, &res_list, acpi_gpio_to_map,
> > +					     &lookup);
> > +		if (ret < 0)
> > +			goto exit_free;
> > +		acpi_dev_free_resource_list(&res_list);
> > +		if (!lookup.found)
> > +			break;
> > +	}
> > +
> > +	*map = lookup.map;
> > +	*num_maps = lookup.num_maps;
> > +	*pctldevs = lookup.pctldevs;
> 
> This function has quite many stars in arguments and in the function
> body. In particular pctldevs has three stars!
> 
> I wonder if this could be written in such way that avoids that. Like
> create a structure holding the map information and pass that to the
> function instead.
> 


Yes, that would make the code more clear. I will rewrite it using a structure.

> Other parts of the patch look good to me.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
