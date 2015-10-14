From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] ACPI: workaround x86 firmware with mis-matched FADT/MADT revisions
Date: Thu, 15 Oct 2015 01:36:06 +0200
Message-ID: <2839593.tq4jqzVY0F@vostro.rjw.lan>
References: <1444857985-28844-1-git-send-email-al.stone@linaro.org> <1444857985-28844-3-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46883 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753156AbbJNXHX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 19:07:23 -0400
In-Reply-To: <1444857985-28844-3-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Wednesday, October 14, 2015 03:26:23 PM Al Stone wrote:
> Looking across multiple versions of the ACPI specification, certain
> versions introduce new revision numbers for the FADT and/or MADT
> tables.  So, for example, an FADT indicating it is revision 4 should
> not be paired with an MADT revision of anything less than 2.
> 
> However, there are systems out there that do not update the revision
> fields in the FADT and MADT tables as they should.  So, for arm64, we
> can be stricter in complying with the specification, but we need to
> relax the checking for legacy systems.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/tables.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index e5cfd72..3b5ddfb 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -407,9 +407,17 @@ static int __init bad_madt_entry(struct acpi_table_header *table,
>  		ms++;
>  	}
>  	if (!ms->num_types) {
> -		pr_err("undefined version for either FADT %d.%d or MADT %d\n",
> -		       major, minor, madt->header.revision);
> -		return 1;
> +		if (IS_ENABLED(CONFIG_ARM64)) {
> +			/* Enforce this stricture on arm64... */
> +			pr_err("undefined version for either FADT %d.%d or MADT %d\n",
> +			       major, minor, madt->header.revision);
> +			return 1;
> +		} else {
> +			/* ... but relax it on legacy systems so they boot */
> +			pr_warn("undefined version for either FADT %d.%d or MADT %d\n",
> +			        major, minor, madt->header.revision);
> +			return 0;

Same comment as for the [1/4] applies here.

> +		}
>  	}
>  
>  	if (entry->type >= ms->num_types) {

Thanks,
Rafael

