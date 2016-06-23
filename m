From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v3 2/3] acpi/pmic: Add opregion driver for Intel BXT
 WhiskeyCove PMIC
Date: Thu, 23 Jun 2016 16:43:31 +0800
Message-ID: <20160623084331.GA17596@aaronlu.sh.intel.com>
References: <20160623080330.GD239751@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26336 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbcFWInf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 04:43:35 -0400
Content-Disposition: inline
In-Reply-To: <20160623080330.GD239751@worksta>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

On Thu, Jun 23, 2016 at 01:03:30AM -0700, Bin Gao wrote:
> This patch adds operation region driver for Intel BXT WhiskeyCove
> PMIC. The register mapping is done as per the BXT WC data sheet.
> 
> Signed-off-by: Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Chandra Sekhar Anagani <chandra.sekhar.anagani@intel.com>
> Signed-off-by: Bin Gao <bin.gao@intel.com>
> ---
> Changes in v3:
>  - Added regs_read() and regs_write() methods to the
>    intel_pmic_opregion_data{} structure.
> Changs in v2:
>  - Replaced module_init() with device_initcall().
>  drivers/acpi/Kconfig                 |   6 +
>  drivers/acpi/Makefile                |   1 +
>  drivers/acpi/pmic/intel_pmic.h       |   2 +
>  drivers/acpi/pmic/intel_pmic_bxtwc.c | 449 +++++++++++++++++++++++++++++++++++
>  4 files changed, 458 insertions(+)
>  create mode 100644 drivers/acpi/pmic/intel_pmic_bxtwc.c
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> new file mode 100644
> index 0000000..51d5bcc
> --- /dev/null
> +++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c

> +static int
> +intel_bxtwc_pmic_regs_read(struct regmap *regmap, u16 address,
> +					unsigned int *value)
> +{
> +	unsigned int data;
> +
> +	if (regmap_read(regmap, address, &data))
> +		return -EIO;
> +
> +	*value = data;
> +	return 0;
> +}

It looks like you can:
static int
intel_bxtwc_pmic_regs_read(struct regmap *regmap, u16 address,
					unsigned int *value)
{
	return regmap_read(regmap, address, value);
}

But then why adding a new function for no actual use? Or you really need
to return -EIO for all possible regmap_read's error return values? I
don't see such a need.

BTW, the callback functions defined in intel_pmic_opregion_data is there
due to different PMICs have different ways to do the same thing like
turn on/off a power rail, get raw temperature reading, etc. It's not
supposed to host helper functions like the two here.

> +
> +static int
> +intel_bxtwc_pmic_regs_write(struct regmap *regmap, u16 address,
> +					unsigned int value)
> +{
> +	if (regmap_write(regmap, address, value))
> +		return -EIO;
> +
> +	return 0;
> +}

Ditto.

> +static struct intel_pmic_opregion_data intel_bxtwc_pmic_opregion_data = {
> +	.get_power      = intel_bxtwc_pmic_get_power,
> +	.update_power   = intel_bxtwc_pmic_update_power,
> +	.get_raw_temp   = intel_bxtwc_pmic_get_raw_temp,
> +	.update_aux     = intel_bxtwc_pmic_update_aux,
> +	.regs_read	= intel_bxtwc_pmic_regs_read,
> +	.regs_write	= intel_bxtwc_pmic_regs_write,

As said above, please drop the two callbacks.

> +	.get_policy     = intel_bxtwc_pmic_get_policy,
> +	.update_policy  = intel_bxtwc_pmic_update_policy,
> +	.power_table      = power_table,
> +	.power_table_count = ARRAY_SIZE(power_table),
> +	.thermal_table     = thermal_table,
> +	.thermal_table_count = ARRAY_SIZE(thermal_table),
> +};
