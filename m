From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] ACPI / APEI: Suppress message if HEST not present
Date: Tue, 29 Aug 2017 14:38:15 +0200
Message-ID: <20170829123815.2z6hoclakznophom@pd.tnic>
References: <20170816112753.12085-1-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751243AbdH2Mib (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Aug 2017 08:38:31 -0400
Content-Disposition: inline
In-Reply-To: <20170816112753.12085-1-punit.agrawal@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-acpi@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, James Morse <james.morse@arm.com>

On Wed, Aug 16, 2017 at 12:27:53PM +0100, Punit Agrawal wrote:
> According to the ACPI specification, firmware is not required to provide
> the Hardware Error Source Table (HEST). When HEST is not present, the
> following superfluous message is printed to the kernel boot log -
> 
> [    3.460067] GHES: HEST is not enabled!
> 
> Extend hest_disable variable to track whether the firmware provides this
> table and if it is not present skip any log output. The existing
> behaviour is preserved in all other cases.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c |  4 ++--
>  drivers/acpi/apei/hest.c | 13 +++++++------
>  include/acpi/apei.h      |  8 +++++++-
>  3 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d452b238..f8685bcbeff2 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1262,10 +1262,10 @@ static int __init ghes_init(void)
>  {
>  	int rc;
>  
> -	if (acpi_disabled)
> +	if (acpi_disabled || hest_disable == HEST_NOT_FOUND)
>  		return -ENODEV;
>  
> -	if (hest_disable) {
> +	if (hest_disable == HEST_DISABLED) {
>  		pr_info(GHES_PFX "HEST is not enabled!\n");
>  		return -EINVAL;
>  	}

Yap, looks good.

Just a minor nitpick: I'd additionally group the hest_disable checking
in one switch-case, so that the code flow is obvious at a quick glance:

        if (acpi_disabled)
                return -ENODEV;

        switch (hest_disable) {
        case HEST_NOT_FOUND:
                return -ENODEV;
        case HEST_DISABLED:
                pr_info(GHES_PFX "HEST is not enabled!\n");
                return -EINVAL;
        default:
                break;
        }

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
