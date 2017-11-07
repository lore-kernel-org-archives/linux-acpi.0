From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI / PMIC: Make some pointers, structure field and
 function argument as const
Date: Tue, 7 Nov 2017 11:29:54 +0200
Message-ID: <20171107092954.GO18997@lahna.fi.intel.com>
References: <1509721428-6147-1-git-send-email-bhumirks@gmail.com>
 <1509721428-6147-2-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22303 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933382AbdKGJ36 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Nov 2017 04:29:58 -0500
Content-Disposition: inline
In-Reply-To: <1509721428-6147-2-git-send-email-bhumirks@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 03, 2017 at 04:03:47PM +0100, Bhumika Goyal wrote:
> Make some pointers of type intel_pmic_opregion_data as const as they
> do not modify the fields of the structure they point too.
> After this change, make the data field of intel_pmic_opregion
> structure const as this data field is used for initializing the above pointers
> that are now const.
> Finally, make the struct intel_pmic_opregion_data * argument of the
> function intel_pmic_install_opregion_handler as const as it is only
> getting stored in the data field of the intel_pmic_opregion
> structure which is now made const.

One minor nit:

> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/acpi/pmic/intel_pmic.c | 10 +++++-----
>  drivers/acpi/pmic/intel_pmic.h |  4 +++-
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index ca18e0d..553fa4f 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -32,7 +32,7 @@ struct intel_pmic_opregion {
>  	struct mutex lock;
>  	struct acpi_lpat_conversion_table *lpat_table;
>  	struct regmap *regmap;
> -	struct intel_pmic_opregion_data *data;
> +	const struct intel_pmic_opregion_data *data;
>  	struct intel_pmic_regs_handler_ctx ctx;
>  };
>  
> @@ -58,7 +58,7 @@ static acpi_status intel_pmic_power_handler(u32 function,
>  {
>  	struct intel_pmic_opregion *opregion = region_context;
>  	struct regmap *regmap = opregion->regmap;
> -	struct intel_pmic_opregion_data *d = opregion->data;
> +	const struct intel_pmic_opregion_data *d = opregion->data;
>  	int reg, bit, result;
>  
>  	if (bits != 32 || !value64)
> @@ -140,7 +140,7 @@ static int pmic_thermal_aux(struct intel_pmic_opregion *opregion, int reg,
>  static int pmic_thermal_pen(struct intel_pmic_opregion *opregion, int reg,
>  			    int bit, u32 function, u64 *value)
>  {
> -	struct intel_pmic_opregion_data *d = opregion->data;
> +	const struct intel_pmic_opregion_data *d = opregion->data;
>  	struct regmap *regmap = opregion->regmap;
>  
>  	if (!d->get_policy || !d->update_policy)
> @@ -176,7 +176,7 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
>  		void *handler_context, void *region_context)
>  {
>  	struct intel_pmic_opregion *opregion = region_context;
> -	struct intel_pmic_opregion_data *d = opregion->data;
> +	const struct intel_pmic_opregion_data *d = opregion->data;
>  	int reg, bit, result;
>  
>  	if (bits != 32 || !value64)
> @@ -255,7 +255,7 @@ static acpi_status intel_pmic_regs_handler(u32 function,
>  
>  int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
>  					struct regmap *regmap,
> -					struct intel_pmic_opregion_data *d)
> +					const struct intel_pmic_opregion_data *d)
>  {
>  	acpi_status status;
>  	struct intel_pmic_opregion *opregion;
> diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
> index e8bfa7b..754b7bd 100644
> --- a/drivers/acpi/pmic/intel_pmic.h
> +++ b/drivers/acpi/pmic/intel_pmic.h
> @@ -20,6 +20,8 @@ struct intel_pmic_opregion_data {
>  	int thermal_table_count;
>  };
>  
> -int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle, struct regmap *regmap, struct intel_pmic_opregion_data *d);
> +int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
> +					struct regmap *regmap,
> +					const struct intel_pmic_opregion_data *d);

I would rather write it like:

int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
					struct regmap *regmap, const struct intel_pmic_opregion_data *d);

The rest looks good to me.
