From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / PMIC: Add opregion driver for Intel CHT
 WhiskeyCove PMIC
Date: Mon, 27 Feb 2017 15:41:42 +0200
Message-ID: <1488202902.20145.35.camel@linux.intel.com>
References: <20170227102023.10272-1-hdegoede@redhat.com>
         <1770161.xO7XBEenWm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751392AbdB0Nlq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Feb 2017 08:41:46 -0500
In-Reply-To: <1770161.xO7XBEenWm@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Darren Hart <darren.hart@intel.com>

On Mon, 2017-02-27 at 14:25 +0100, Rafael J. Wysocki wrote:
> +Andy Shevchenko & Darren Hart
> 
> On Monday, February 27, 2017 11:20:23 AM Hans de Goede wrote:
> > Add opregion driver for Intel CHT WhiskeyCove PMIC, based on various
> > non upstreamed CHT WhiskeyCove PMIC patches. This does not include
> > support for the Thermal opregion (DPTF) due to lacking
> > documentation.
> > 
> > Cc: Bin Gao <bin.gao@intel.com>
> > Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Andy, any comments?

I don't see definitions like CHT_WC_ here. Where are they defined?

Thus, question, how differs this to Broxton version of Whiskey Cove PMIC
opregion?

Some minor comments below.

>  
> > +config CHT_WC_PMIC_OPREGION
> > +	bool "ACPI operation region support for CHT WhiskeyCove
> > PMIC"
> > +	depends on INTEL_SOC_PMIC
> > +	help
> > +	  This config adds ACPI operation region support for CHT
> > WhiskeyCove PMIC.

Whiskey Cove

> > @@ -0,0 +1,236 @@
> > 

> > +/*
> > + * Regulator support is based on the non upstream patch:
> > + * "regulator: whiskey_cove: implements WhiskeyCove pmic VRF
> > support"
> > + */

Perhaps link to the patch?

> > +static struct pmic_table power_table[] = {
> > +	{
> > +		.address = 0x0,
> > +		.reg = CHT_WC_V1P8A_CTRL,
> > +		.bit = 0x01,
> > +	}, /* V18A */
> > 

> > +};

> > +static int intel_cht_wc_pmic_update_power(struct regmap *regmap,
> > int reg,
> > +		int bit, bool on)
> > +{
> > +	u8 val, mask = bit;
> > 

> > +
> > +	if (on)
> > +		val = 0x01;
> > +	else
> > +		val = 0x00;
> > +
> > +	return regmap_update_bits(regmap, reg, mask, val);

Perhaps just:

return regmap_update_bits(regmap, reg, mask, on ? 1 : 0);


> > +
> > +static struct platform_device_id cht_wc_opregion_id_table[] = {
> > +	{ .name = "cht_wcove_region" },
> > +	{},
> > +};
> > +
> > +static struct platform_driver intel_cht_wc_pmic_opregion_driver = {
> > +	.probe = intel_cht_wc_pmic_opregion_probe,
> > +	.driver = {
> > +		.name = "cht_whiskey_cove_pmic",
> > +	},
> > +	.id_table = cht_wc_opregion_id_table,
> > +};
> > +
> > +static int __init intel_cht_wc_pmic_opregion_driver_init(void)
> > +{
> > +	return
> > platform_driver_register(&intel_cht_wc_pmic_opregion_driver);
> > +}
> > +device_initcall(intel_cht_wc_pmic_opregion_driver_init);

Don't we have builtin_platform_driver() ?
Or it's not an equivalent?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
