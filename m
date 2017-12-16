From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: Fix ACPI GPE mask kernel parameter
Date: Sat, 16 Dec 2017 02:56:20 +0100
Message-ID: <22958031.ChIbo70fkb@aspire.rjw.lan>
References: <20171130200559.19240-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59209 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755977AbdLPB5G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 20:57:06 -0500
In-Reply-To: <20171130200559.19240-1-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On Thursday, November 30, 2017 9:05:59 PM CET Prarit Bhargava wrote:
> The acpi_mask_gpe= kernel parameter documentation states that the range
> of mask is 128 GPEs (0x00 to 0x7F).  The acpi_masked_gpes mask is a u64 so
> only 64 GPEs (0x00 to 0x3F) can really be masked.
> 
> Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
> GPEs can be masked.
> 
> Fixes: 9c4aa1eecb48 ("ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding")
> Signed-off-by: Prarit Bharava <prarit@redhat.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  1 -
>  drivers/acpi/sysfs.c                            | 26 ++++++++-----------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6571fbfdb2a1..89ba74761180 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -114,7 +114,6 @@
>  			This facility can be used to prevent such uncontrolled
>  			GPE floodings.
>  			Format: <int>
> -			Support masking of GPEs numbered from 0x00 to 0x7f.
>  
>  	acpi_no_auto_serialize	[HW,ACPI]
>  			Disable auto-serialization of AML methods
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 06a150bb35bf..4fc59c3bc673 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -816,14 +816,8 @@ static ssize_t counter_set(struct kobject *kobj,
>   * interface:
>   *   echo unmask > /sys/firmware/acpi/interrupts/gpe00
>   */
> -
> -/*
> - * Currently, the GPE flooding prevention only supports to mask the GPEs
> - * numbered from 00 to 7f.
> - */
> -#define ACPI_MASKABLE_GPE_MAX	0x80
> -
> -static u64 __initdata acpi_masked_gpes;
> +#define ACPI_MASKABLE_GPE_MAX	0xFF
> +static DECLARE_BITMAP(acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) __initdata;
>  
>  static int __init acpi_gpe_set_masked_gpes(char *val)
>  {
> @@ -831,7 +825,7 @@ static int __init acpi_gpe_set_masked_gpes(char *val)
>  
>  	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)
>  		return -EINVAL;
> -	acpi_masked_gpes |= ((u64)1<<gpe);
> +	set_bit(gpe, acpi_masked_gpes_map);
>  
>  	return 1;
>  }
> @@ -843,15 +837,11 @@ void __init acpi_gpe_apply_masked_gpes(void)
>  	acpi_status status;
>  	u8 gpe;
>  
> -	for (gpe = 0;
> -	     gpe < min_t(u8, ACPI_MASKABLE_GPE_MAX, acpi_current_gpe_count);
> -	     gpe++) {
> -		if (acpi_masked_gpes & ((u64)1<<gpe)) {
> -			status = acpi_get_gpe_device(gpe, &handle);
> -			if (ACPI_SUCCESS(status)) {
> -				pr_info("Masking GPE 0x%x.\n", gpe);
> -				(void)acpi_mask_gpe(handle, gpe, TRUE);
> -			}
> +	for_each_set_bit(gpe, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) {
> +		status = acpi_get_gpe_device(gpe, &handle);
> +		if (ACPI_SUCCESS(status)) {
> +			pr_info("Masking GPE 0x%x.\n", gpe);
> +			(void)acpi_mask_gpe(handle, gpe, TRUE);
>  		}
>  	}
>  }
> 

Applied, thanks!


