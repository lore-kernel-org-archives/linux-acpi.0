From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 13:27:38 +0200
Message-ID: <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
 <20170818194644.14538-2-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:53994 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdHUL1r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Aug 2017 07:27:47 -0400
Content-Disposition: inline
In-Reply-To: <20170818194644.14538-2-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>, rjw@rjwysocki.net
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 18, 2017 at 01:46:40PM -0600, Toshi Kani wrote:
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
>  drivers/acpi/utils.c     |   40 ++++++++++++++++++++++
>  include/linux/acpi.h     |   19 +++++++++++
>  3 files changed, 73 insertions(+), 69 deletions(-)

...

> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index b9d956c..998aaf5 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -816,3 +816,43 @@ static int __init acpi_backlight(char *str)
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

Btw, Rafael, should we do something like this:

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 010b1c43df92..881b0d5b2838 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -226,6 +226,9 @@ acpi_get_table_header(char *signature,
 	u32 j;
 	struct acpi_table_header *header;
 
+	if (acpi_disabled)
+		return (AE_ERROR);
+
 	/* Parameter validation */
 
 	if (!signature || !out_table_header) {
---

in order to avoid that sprinkling of if (acpi_disabled) everywhere?

> +
> +	for (; plat->oem_id[0]; plat++, idx++) {
> +		if (ACPI_FAILURE(acpi_get_table_header(plat->table, 0, &hdr)))
> +			continue;
> +
> +		if (strncmp(plat->oem_id, hdr.oem_id, ACPI_OEM_ID_SIZE))
> +			continue;
> +
> +		if (strncmp(plat->oem_table_id, hdr.oem_table_id,
> +			    ACPI_OEM_TABLE_ID_SIZE))

Let that stick out.

> +			continue;
> +
> +		if ((plat->pred == all_versions) ||
> +		    (plat->pred == less_than_or_equal
> +			&& hdr.oem_revision <= plat->oem_revision) ||
> +		    (plat->pred == greater_than_or_equal
> +			&& hdr.oem_revision >= plat->oem_revision) ||
> +		    (plat->pred == equal
> +			&& hdr.oem_revision == plat->oem_revision))
> +			return idx;

Make that more readable:

                if ((plat->pred == all_versions) ||
                    (plat->pred == less_than_or_equal    && hdr.oem_revision <= plat->oem_revision) ||
                    (plat->pred == greater_than_or_equal && hdr.oem_revision >= plat->oem_revision) ||
                    (plat->pred == equal                 && hdr.oem_revision == plat->oem_revision))
                        return idx;


> +	}
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL(acpi_match_platform_list);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 27b4b66..a9b6dc2 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -556,6 +556,25 @@ extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
>  #define ACPI_OST_SC_DRIVER_LOAD_FAILURE		0x81
>  #define ACPI_OST_SC_INSERT_NOT_SUPPORTED	0x82
>  
> +enum acpi_predicate {
> +	all_versions,
> +	less_than_or_equal,
> +	equal,
> +	greater_than_or_equal,
> +};
> +
> +/* Table must be terminted by a NULL entry */
> +struct acpi_platform_list {
> +	char	oem_id[ACPI_OEM_ID_SIZE];

					+ 1

> +	char	oem_table_id[ACPI_OEM_TABLE_ID_SIZE];

						   + 1
> +	u32	oem_revision;
> +	char	*table;
> +	enum acpi_predicate pred;
> +	char	*reason;
> +	u32	data;

Ok, turning that into data from is_critical_error is a step in the right
direction. Let's make it even better:

	u32	flags;

and do

#define ACPI_PLAT_IS_CRITICAL_ERROR	BIT(0)

so that future elements add new bits instead of wasting a whole u32 as a
boolean.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
