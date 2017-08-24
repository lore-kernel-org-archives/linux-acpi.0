From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Thu, 24 Aug 2017 09:53:48 +0200
Message-ID: <20170824075348.gqvobmk7mf5ppaip@pd.tnic>
References: <20170823225447.15608-1-toshi.kani@hpe.com>
 <20170823225447.15608-2-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823225447.15608-2-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 23, 2017 at 04:54:43PM -0600, Toshi Kani wrote:
> ACPI OEM ID / OEM Table ID / Revision can be used to identify
> a platform based on ACPI firmware info.  acpi_blacklisted(),
> intel_pstate_platform_pwr_mgmt_exists(), and some other funcs,
> have been using similar check to detect a list of platforms
> that require special handlings.
> 
> Move the platform check in acpi_blacklisted() to a new common
> utility function, acpi_match_platform_list(), so that other
> drivers do not have to implement their own version.
> 
> There is no change in functionality.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
>  drivers/acpi/blacklist.c |   83 ++++++++--------------------------------------
>  drivers/acpi/utils.c     |   36 ++++++++++++++++++++
>  include/linux/acpi.h     |   19 +++++++++++
>  3 files changed, 69 insertions(+), 69 deletions(-)

...

> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index b9d956c..0a9e597 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -816,3 +816,39 @@ static int __init acpi_backlight(char *str)
>  	return 1;
>  }
>  __setup("acpi_backlight=", acpi_backlight);
> +
> +/**
> + * acpi_match_platform_list - Check if the system matches with a given list
> + * @plat: pointer to acpi_platform_list table terminated by a NULL entry
> + *
> + * Return the matched index if the system is found in the platform list.
> + * Otherwise, return a negative error code.
> + */
> +int acpi_match_platform_list(const struct acpi_platform_list *plat)
> +{
> +	struct acpi_table_header hdr;
> +	int idx = 0;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	for (; plat->oem_id[0]; plat++, idx++) {
> +		if (ACPI_FAILURE(acpi_get_table_header(plat->table, 0, &hdr)))
> +			continue;
> +
> +		if (strncmp(plat->oem_id, hdr.oem_id, ACPI_OEM_ID_SIZE))
> +			continue;
> +
> +		if (strncmp(plat->oem_table_id, hdr.oem_table_id, ACPI_OEM_TABLE_ID_SIZE))
> +			continue;
> +
> +		if ((plat->pred == all_versions) ||
> +		    (plat->pred == less_than_or_equal && hdr.oem_revision <= plat->oem_revision) ||
> +		    (plat->pred == greater_than_or_equal && hdr.oem_revision >= plat->oem_revision) ||
> +		    (plat->pred == equal && hdr.oem_revision == plat->oem_revision))

If you align the second part of the test like this:

             if ((plat->pred == all_versions) ||
                 (plat->pred == less_than_or_equal	&& hdr.oem_revision <= plat->oem_revision) ||
                 (plat->pred == greater_than_or_equal	&& hdr.oem_revision >= plat->oem_revision) ||
                 (plat->pred == equal			&& hdr.oem_revision == plat->oem_revision))

it gets maximally readable. But I'd leave that up to Rafael when committing
- no need to send another version.

Other than that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
