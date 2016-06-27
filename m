From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 3/3] acpi/pmic: Add support for PMIC regs operation
 region
Date: Mon, 27 Jun 2016 12:26:57 +0300
Message-ID: <20160627092657.GA20801@kuha.fi.intel.com>
References: <20160624005253.GF83592@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12334 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbcF0J1C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2016 05:27:02 -0400
Content-Disposition: inline
In-Reply-To: <20160624005253.GF83592@worksta>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

Whoa! Hold on!

On Thu, Jun 23, 2016 at 05:52:53PM -0700, Bin Gao wrote:
> Broxton platform firmware has defined new customized operation regions
> called regs for PMIC chip - regs op region is used to handle the
> PMIC gpio mainly intended for the TYPE-C VBUS and Orientation.
> 
> The intel_gpio_ctx  structure is created for the purpose of handling
> the PMIC gpio register read and write.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Chandra Sekhar Anagani <chandra.sekhar.anagani@intel.com>
> Signed-off-by: Bin Gao <bin.gao@intel.com>
> ---
> Changes in v4:
>  - various fixes to address Aaron's comments.
> Changes in v3: none
> Changes in v2: none
>  drivers/acpi/pmic/intel_pmic.c | 74 ++++++++++++++++++++++++++++++++++++++++--
>  drivers/acpi/pmic/intel_pmic.h |  5 +++
>  2 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index 410e96f..e11d1e0 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -21,12 +21,14 @@
>  
>  #define PMIC_POWER_OPREGION_ID		0x8d
>  #define PMIC_THERMAL_OPREGION_ID	0x8c
> +#define PMIC_REGS_OPREGION_ID		0x8f
>  
>  struct intel_pmic_opregion {
>  	struct mutex lock;
>  	struct acpi_lpat_conversion_table *lpat_table;
>  	struct regmap *regmap;
>  	struct intel_pmic_opregion_data *data;
> +	struct pmic_gpio_ctx	ctx;

What gpio?

>  };
>  
>  static int pmic_get_reg_bit(int address, struct pmic_table *table,
> @@ -204,6 +206,56 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
>  	return AE_OK;
>  }
>  
> +static acpi_status intel_pmic_gpio_handler(u32 function,
> +	acpi_physical_address address, u32 bits, u64 *value64,
> +		void *handler_context, void *region_context)

What the heck is this? Why is this suddenly a gpio handler?

This is handler for an operation region, not some gpio!



-- 
heikki
