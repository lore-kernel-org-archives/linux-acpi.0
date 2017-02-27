From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / PMIC: Add opregion driver for Intel CHT
 WhiskeyCove PMIC
Date: Mon, 27 Feb 2017 15:20:33 +0100
Message-ID: <51ee3a33-b789-731d-4df6-1ffa011d1940@redhat.com>
References: <20170227102023.10272-1-hdegoede@redhat.com>
 <1770161.xO7XBEenWm@aspire.rjw.lan>
 <1488202902.20145.35.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbdB0OUh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Feb 2017 09:20:37 -0500
In-Reply-To: <1488202902.20145.35.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Darren Hart <darren.hart@intel.com>, Hans de Goede <hdegoede@redhat.com>

Hi,

On 27-02-17 14:41, Andy Shevchenko wrote:
> On Mon, 2017-02-27 at 14:25 +0100, Rafael J. Wysocki wrote:
>> +Andy Shevchenko & Darren Hart
>>
>> On Monday, February 27, 2017 11:20:23 AM Hans de Goede wrote:
>>> Add opregion driver for Intel CHT WhiskeyCove PMIC, based on various
>>> non upstreamed CHT WhiskeyCove PMIC patches. This does not include
>>> support for the Thermal opregion (DPTF) due to lacking
>>> documentation.
>>>
>>> Cc: Bin Gao <bin.gao@intel.com>
>>> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Andy, any comments?
>
> I don't see definitions like CHT_WC_ here. Where are they defined?

They are defined in include/linux/mfd/intel_chtwc.h which gets added
by this patch: https://lkml.org/lkml/2017/2/27/90

> Thus, question, how differs this to Broxton version of Whiskey Cove PMIC
> opregion?

They seem to be different devices in all but name, there are some
similarities but not enough to allow doing a merged driver. E.g.
the CHT WhiskeyCove use i2c and the BXT one uses some mmio based
mailbox interface and almost all the register addresses are
different.

>
> Some minor comments below.
>
>>
>>> +config CHT_WC_PMIC_OPREGION
>>> +	bool "ACPI operation region support for CHT WhiskeyCove
>>> PMIC"
>>> +	depends on INTEL_SOC_PMIC
>>> +	help
>>> +	  This config adds ACPI operation region support for CHT
>>> WhiskeyCove PMIC.
>
> Whiskey Cove

I used the spelling from the BXT Kconfig bit, but I agree
the spelling with the " " in there is better, will fix.

>
>>> @@ -0,0 +1,236 @@
>>>
>
>>> +/*
>>> + * Regulator support is based on the non upstream patch:
>>> + * "regulator: whiskey_cove: implements WhiskeyCove pmic VRF
>>> support"
>>> + */
>
> Perhaps link to the patch?

Those kinda links tend to go 404, but I can add a link to the
comment if you want, I used this as a base:

https://github.com/intel-aero/meta-intel-aero/blob/master/recipes-kernel/linux/linux-yocto/0019-regulator-whiskey_cove-implements-WhiskeyCove-pmic-V.patch

>
>>> +static struct pmic_table power_table[] = {
>>> +	{
>>> +		.address = 0x0,
>>> +		.reg = CHT_WC_V1P8A_CTRL,
>>> +		.bit = 0x01,
>>> +	}, /* V18A */
>>>
>
>>> +};
>
>>> +static int intel_cht_wc_pmic_update_power(struct regmap *regmap,
>>> int reg,
>>> +		int bit, bool on)
>>> +{
>>> +	u8 val, mask = bit;
>>>
>
>>> +
>>> +	if (on)
>>> +		val = 0x01;
>>> +	else
>>> +		val = 0x00;
>>> +
>>> +	return regmap_update_bits(regmap, reg, mask, val);
>
> Perhaps just:
>
> return regmap_update_bits(regmap, reg, mask, on ? 1 : 0);

Sure, will fix.

>>> +
>>> +static struct platform_device_id cht_wc_opregion_id_table[] = {
>>> +	{ .name = "cht_wcove_region" },
>>> +	{},
>>> +};
>>> +
>>> +static struct platform_driver intel_cht_wc_pmic_opregion_driver = {
>>> +	.probe = intel_cht_wc_pmic_opregion_probe,
>>> +	.driver = {
>>> +		.name = "cht_whiskey_cove_pmic",
>>> +	},
>>> +	.id_table = cht_wc_opregion_id_table,
>>> +};
>>> +
>>> +static int __init intel_cht_wc_pmic_opregion_driver_init(void)
>>> +{
>>> +	return
>>> platform_driver_register(&intel_cht_wc_pmic_opregion_driver);
>>> +}
>>> +device_initcall(intel_cht_wc_pmic_opregion_driver_init);
>
> Don't we have builtin_platform_driver() ?
> Or it's not an equivalent?

Actually I believe this should become a tristate having all the
i2c based PMIC stiff as builtin only makes no sense since the
i2c-controller driver in practice can (and often is) a module
and that seems to work fine. It seems these opregion stuff is
not needed till the first suspend / freeze (famous last words ?)

So I will change this to be a tristate for the next version.

Regards,

Hans
