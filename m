From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] ACPI: workaround x86 firmware using reserved MADT subtable IDs
Date: Thu, 15 Oct 2015 01:34:55 +0200
Message-ID: <21909494.Kej2eCg5II@vostro.rjw.lan>
References: <1444857985-28844-1-git-send-email-al.stone@linaro.org> <1444857985-28844-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54290 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753898AbbJNXGN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 19:06:13 -0400
In-Reply-To: <1444857985-28844-2-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Wednesday, October 14, 2015 03:26:22 PM Al Stone wrote:
> According to the ACPI specification, version 6.0, table 5-46,  MADT
> subtable IDs in the range of 0x10-0x7f are reserved for possible
> future use by the specification.  The function bad_madt_entry() tries
> to enforce the spec, but it turns out there are x86 machines that use
> 0x7f even though they should not.
> 
> So, continue to enforce this rule for arm64, since we're starting out
> fresh, but relax it for systems already out there so we don't keep them
> from booting.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/tables.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index a2ed38a..e5cfd72 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -413,9 +413,17 @@ static int __init bad_madt_entry(struct acpi_table_header *table,
>  	}
>  
>  	if (entry->type >= ms->num_types) {
> -		pr_err("undefined MADT subtable type for FADT %d.%d: %d (length %d)\n",
> -		       major, minor, entry->type, entry->length);
> -		return 1;
> +		if (IS_ENABLED(CONFIG_ARM64)) {
> +			/* Enforce this stricture on arm64... */
> +			pr_err("undefined MADT subtable type for FADT %d.%d: %d (length %d)\n",
> +			       major, minor, entry->type, entry->length);
> +			return 1;
> +		} else {
> +			/* ... but relax it on legacy systems so they boot */
> +			pr_warn("undefined MADT subtable type for FADT %d.%d: %d (length %d)\n",
> +			         major, minor, entry->type, entry->length);
> +			return 0;

I don't see much point in varying the log level of the message depending on
the architecture.  It can stay pr_err() for all of them as far as I'm concerned
and then you only need to change the return line to something like:

			return IS_ENABLED(CONFIG_ARM64);

That said, this is getting messy and we may be much better off by having
bad_madt_entry() defined per arch.  Then, for x86 and ia64 it may just do
what was done before and you may use a more sophisticated one for ARM64.

Have you considered doing that?


> +		}
>  	}
>  
>  	/* verify that the table is allowed for this version of the spec */

Thanks,
Rafael

