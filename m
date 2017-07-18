From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] ACPI / blacklist: add acpi_match_oemlist() interface
Date: Tue, 18 Jul 2017 07:34:55 +0200
Message-ID: <20170718053455.GA8736@nazgul.tnic>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-2-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717215912.26070-2-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tglx@linutronix.de, srinivas.pandruvada@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 17, 2017 at 03:59:10PM -0600, Toshi Kani wrote:
> ACPI OEM ID / OEM Table ID / Revision can be used to identify
> platform type based on ACPI firmware.  acpi_blacklisted(),
> intel_pstate_platform_pwr_mgmt_exists() and some other funcs
> have been using this type of check to detect a list of platforms
> that require special handlings.
> 
> Move the platform type check in acpi_blacklisted() to a common
> utility function, acpi_match_oemlist(), so that other drivers
> do not have to implement their own.
> 
> There is no change in functionality.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/acpi/blacklist.c |   84 ++++++++--------------------------------------
>  drivers/acpi/utils.c     |   40 ++++++++++++++++++++++
>  include/linux/acpi.h     |   19 ++++++++++
>  3 files changed, 74 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index bb542ac..288fe4d 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -30,30 +30,13 @@
>  
>  #include "internal.h"
>  
> -enum acpi_blacklist_predicates {
> -	all_versions,
> -	less_than_or_equal,
> -	equal,
> -	greater_than_or_equal,
> -};
> -
> -struct acpi_blacklist_item {
> -	char oem_id[7];
> -	char oem_table_id[9];
> -	u32 oem_revision;
> -	char *table;
> -	enum acpi_blacklist_predicates oem_revision_predicate;
> -	char *reason;
> -	u32 is_critical_error;
> -};
> -
>  static struct dmi_system_id acpi_rev_dmi_table[] __initdata;
>  
>  /*
>   * POLICY: If *anything* doesn't work, put it on the blacklist.
>   *	   If they are critical errors, mark it critical, and abort driver load.
>   */
> -static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
> +static struct acpi_oemlist acpi_blacklist[] __initdata = {

Why the arbitrary rename?

If anything, you should shorten that

	enum acpi_blacklist_predicates oem_revision_predicate;

unreadable insanity.

>  	/* Compaq Presario 1700 */
>  	{"PTLTD ", "  DSDT  ", 0x06040000, ACPI_SIG_DSDT, less_than_or_equal,
>  	 "Multiple problems", 1},
> @@ -67,65 +50,28 @@ static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
>  	{"IBM   ", "TP600E  ", 0x00000105, ACPI_SIG_DSDT, less_than_or_equal,
>  	 "Incorrect _ADR", 1},
>  
> -	{""}
> +	{ }
>  };
>  
>  int __init acpi_blacklisted(void)
>  {
> -	int i = 0;
> +	int i;
>  	int blacklisted = 0;
> -	struct acpi_table_header table_header;
> -
> -	while (acpi_blacklist[i].oem_id[0] != '\0') {
> -		if (acpi_get_table_header(acpi_blacklist[i].table, 0, &table_header)) {
> -			i++;
> -			continue;
> -		}
> -
> -		if (strncmp(acpi_blacklist[i].oem_id, table_header.oem_id, 6)) {
> -			i++;
> -			continue;
> -		}
> -
> -		if (strncmp
> -		    (acpi_blacklist[i].oem_table_id, table_header.oem_table_id,
> -		     8)) {
> -			i++;
> -			continue;
> -		}
> -
> -		if ((acpi_blacklist[i].oem_revision_predicate == all_versions)
> -		    || (acpi_blacklist[i].oem_revision_predicate ==
> -			less_than_or_equal
> -			&& table_header.oem_revision <=
> -			acpi_blacklist[i].oem_revision)
> -		    || (acpi_blacklist[i].oem_revision_predicate ==
> -			greater_than_or_equal
> -			&& table_header.oem_revision >=
> -			acpi_blacklist[i].oem_revision)
> -		    || (acpi_blacklist[i].oem_revision_predicate == equal
> -			&& table_header.oem_revision ==
> -			acpi_blacklist[i].oem_revision)) {
>  
> -			printk(KERN_ERR PREFIX
> -			       "Vendor \"%6.6s\" System \"%8.8s\" "
> -			       "Revision 0x%x has a known ACPI BIOS problem.\n",
> -			       acpi_blacklist[i].oem_id,
> -			       acpi_blacklist[i].oem_table_id,
> -			       acpi_blacklist[i].oem_revision);
> +	i = acpi_match_oemlist(acpi_blacklist);
> +	if (i >= 0) {
> +		pr_err(PREFIX "Vendor \"%6.6s\" System \"%8.8s\" "
> +		       "Revision 0x%x has a known ACPI BIOS problem.\n",

Put that string on a single line for grepping. checkpatch catches that
error, didn't you see it?

> +		       acpi_blacklist[i].oem_id,
> +		       acpi_blacklist[i].oem_table_id,
> +		       acpi_blacklist[i].oem_revision);
>  
> -			printk(KERN_ERR PREFIX
> -			       "Reason: %s. This is a %s error\n",
> -			       acpi_blacklist[i].reason,
> -			       (acpi_blacklist[i].
> -				is_critical_error ? "non-recoverable" :
> -				"recoverable"));
> +		pr_err(PREFIX "Reason: %s. This is a %s error\n",
> +		       acpi_blacklist[i].reason,
> +		       (acpi_blacklist[i].data ?
> +			"non-recoverable" : "recoverable"));
>  
> -			blacklisted = acpi_blacklist[i].is_critical_error;
> -			break;
> -		} else {
> -			i++;
> -		}
> +		blacklisted = acpi_blacklist[i].data;
>  	}
>  
>  	(void)early_acpi_osi_init();

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
