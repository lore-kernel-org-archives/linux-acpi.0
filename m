From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/4] ACPI: workaround FADT always being revision 2
Date: Thu, 15 Oct 2015 01:38:18 +0200
Message-ID: <35258221.7q9NA1W9dF@vostro.rjw.lan>
References: <1444857985-28844-1-git-send-email-al.stone@linaro.org> <1444857985-28844-4-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45323 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753882AbbJNXJf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 19:09:35 -0400
In-Reply-To: <1444857985-28844-4-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Wednesday, October 14, 2015 03:26:24 PM Al Stone wrote:
> In some environments, the FADT revision number is always 2, independent
> of any other factors indicating that it may be a newer revision.  So,
> we cannot rely on the FADT and MADT revisions being in proper sync.  For
> those environments, relax the checking so we only enforce the size check,
> even if we do issue warnings on other problems.
> 
> If we do not relax the rules, these systems will not boot as they have in
> the past.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/tables.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 3b5ddfb..790d4b0 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -416,7 +416,6 @@ static int __init bad_madt_entry(struct acpi_table_header *table,
>  			/* ... but relax it on legacy systems so they boot */
>  			pr_warn("undefined version for either FADT %d.%d or MADT %d\n",
>  			        major, minor, madt->header.revision);
> -			return 0;
>  		}
>  	}
>  
> @@ -430,16 +429,41 @@ static int __init bad_madt_entry(struct acpi_table_header *table,
>  			/* ... but relax it on legacy systems so they boot */
>  			pr_warn("undefined MADT subtable type for FADT %d.%d: %d (length %d)\n",
>  			         major, minor, entry->type, entry->length);
> -			return 0;
>  		}
>  	}
>  
>  	/* verify that the table is allowed for this version of the spec */
>  	len = ms->lengths[entry->type];
>  	if (!len) {
> -		pr_err("MADT subtable %d not defined for FADT %d.%d\n",
> -			 entry->type, major, minor);
> -		return 1;
> +		if (IS_ENABLED(CONFIG_ARM64)) {
> +			pr_err("MADT subtable %d not defined for FADT %d.%d\n",
> +			       entry->type, major, minor);
> +			return 1;
> +		} else {
> +			pr_warn("MADT subtable %d not defined for FADT %d.%d\n",
> +			        entry->type, major, minor);
> +		}

Same comment again.

> +	}
> +
> +	/*
> +	 * When we get this far, we may have issued warnings on either
> +	 * a mismatch in FADT/MADT revisions, or have noted that the subtable
> +	 * ID is not defined for the MADT revision we're using.  On some
> +	 * architectures, this is an error, but for legacy systems, we need
> +	 * to push on with other checks of the subtable.
> +	 *
> +	 * In fact, there are environments where the *only* value the FADT
> +	 * revision will ever have is 2, regardless of anything else.  So,
> +	 * for those systems to boot, we have to pretend the MADT is the
> +	 * latest version to allow all known subtables since we have no way
> +	 * to determine what revision it should be.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ARM64) && major == 2) {

Gosh.  No sorry, this isn't going in.  Please rethink the approach.

> +		ms = spec_info;
> +		while (ms->num_types != 0)
> +			ms++;
> +		ms--;
> +		len = ms->lengths[entry->type];
>  	}
>  
>  	/* verify that the length is what we expect */
> 

Thanks,
Rafael

