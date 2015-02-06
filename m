From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / table: remove duplicate NULL check for the handler of acpi_table_parse()
Date: Fri, 06 Feb 2015 01:59:56 +0100
Message-ID: <14843787.5RuRk4hTkJ@vostro.rjw.lan>
References: <1423128794-4680-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60178 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751401AbbBFAg7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 19:36:59 -0500
In-Reply-To: <1423128794-4680-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Thursday, February 05, 2015 05:33:14 PM Hanjun Guo wrote:
> In acpi_table_parse(), pointer of the table to pass to handler() is
> checked before handler() called, so remove all the duplicate NULL
> check in the handler function.
> 
> CC: Tony Luck <tony.luck@intel.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Queued up for 3.20, thanks!

> ---
>  arch/ia64/kernel/acpi.c     |  6 ------
>  arch/x86/kernel/acpi/boot.c | 16 ++--------------
>  drivers/acpi/numa.c         | 12 ++----------
>  3 files changed, 4 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index e795cb8..2c44989 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -380,9 +380,6 @@ static void __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>  
>  static int __init acpi_parse_madt(struct acpi_table_header *table)
>  {
> -	if (!table)
> -		return -EINVAL;
> -
>  	acpi_madt = (struct acpi_table_madt *)table;
>  
>  	acpi_madt_rev = acpi_madt->header.revision;
> @@ -645,9 +642,6 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
>  	struct acpi_table_header *fadt_header;
>  	struct acpi_table_fadt *fadt;
>  
> -	if (!table)
> -		return -EINVAL;
> -
>  	fadt_header = (struct acpi_table_header *)table;
>  	if (fadt_header->revision != 3)
>  		return -ENODEV;	/* Only deal with ACPI 2.0 FADT */
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index b9e30da..14d3652 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -843,13 +843,7 @@ int acpi_ioapic_registered(acpi_handle handle, u32 gsi_base)
>  
>  static int __init acpi_parse_sbf(struct acpi_table_header *table)
>  {
> -	struct acpi_table_boot *sb;
> -
> -	sb = (struct acpi_table_boot *)table;
> -	if (!sb) {
> -		printk(KERN_WARNING PREFIX "Unable to map SBF\n");
> -		return -ENODEV;
> -	}
> +	struct acpi_table_boot *sb = (struct acpi_table_boot *)table;
>  
>  	sbf_port = sb->cmos_index;	/* Save CMOS port */
>  
> @@ -863,13 +857,7 @@ static struct resource *hpet_res __initdata;
>  
>  static int __init acpi_parse_hpet(struct acpi_table_header *table)
>  {
> -	struct acpi_table_hpet *hpet_tbl;
> -
> -	hpet_tbl = (struct acpi_table_hpet *)table;
> -	if (!hpet_tbl) {
> -		printk(KERN_WARNING PREFIX "Unable to map HPET\n");
> -		return -ENODEV;
> -	}
> +	struct acpi_table_hpet *hpet_tbl = (struct acpi_table_hpet *)table;
>  
>  	if (hpet_tbl->address.space_id != ACPI_SPACE_MEM) {
>  		printk(KERN_WARNING PREFIX "HPET timers must be located in "
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 24b5476..1333cbdc 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -177,12 +177,7 @@ static int __init slit_valid(struct acpi_table_slit *slit)
>  
>  static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
> -	struct acpi_table_slit *slit;
> -
> -	if (!table)
> -		return -EINVAL;
> -
> -	slit = (struct acpi_table_slit *)table;
> +	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
>  
>  	if (!slit_valid(slit)) {
>  		printk(KERN_INFO "ACPI: SLIT table looks invalid. Not used.\n");
> @@ -260,11 +255,8 @@ acpi_parse_memory_affinity(struct acpi_subtable_header * header,
>  
>  static int __init acpi_parse_srat(struct acpi_table_header *table)
>  {
> -	struct acpi_table_srat *srat;
> -	if (!table)
> -		return -EINVAL;
> +	struct acpi_table_srat *srat = (struct acpi_table_srat *)table;
>  
> -	srat = (struct acpi_table_srat *)table;
>  	acpi_srat_revision = srat->header.revision;
>  
>  	/* Real work done in acpi_table_parse_srat below. */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
