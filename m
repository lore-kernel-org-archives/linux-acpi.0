From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/7] ACPI / blacklist: add acpi_match_oemlist()
 interface
Date: Fri, 4 Aug 2017 05:42:06 +0200
Message-ID: <20170804034206.GB12082@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-2-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:39444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751887AbdHDDmx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 23:42:53 -0400
Content-Disposition: inline
In-Reply-To: <20170803215753.30553-2-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 03, 2017 at 03:57:47PM -0600, Toshi Kani wrote:
> ACPI OEM ID / OEM Table ID / Revision can be used to identify
> a platform based on ACPI firmware info.  acpi_blacklisted(),
> intel_pstate_platform_pwr_mgmt_exists(), and some other funcs,
> have been using similar check to detect a list of platforms
> that require special handlings.
> 
> Move the platform check in acpi_blacklisted() to a new common
> utility function, acpi_match_oemlist(), so that other drivers
> do not have to implement their own version.
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
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index bb542ac..bf44573 100644
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

All that wasted energy to try to explain to you that "oemlist" is wrong
and that whole rename is pointless, went for nothing.

So NAK.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
