From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] acpi: cm_sbs: use NULL instead of 0 for ptr
Date: Tue, 26 Sep 2006 03:20:03 -0400
Message-ID: <200609260320.03436.len.brown@intel.com>
References: <20060925214720.2f9778f9.rdunlap@xenotime.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56033 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750742AbWIZHR6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 03:17:58 -0400
In-Reply-To: <20060925214720.2f9778f9.rdunlap@xenotime.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: akpm <akpm@osdl.org>, linux-acpi@vger.kernel.org, viro <viro@zeniv.linux.org.uk>

Applied.

thanks,
-Len

On Tuesday 26 September 2006 00:47, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Use NULL instead of 0 for pointer value, eliminate sparse warnings.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/acpi/cm_sbs.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2618-g4.orig/drivers/acpi/cm_sbs.c
> +++ linux-2618-g4/drivers/acpi/cm_sbs.c
> @@ -67,7 +67,7 @@ void acpi_unlock_ac_dir(struct proc_dir_
>  		lock_ac_dir_cnt--;
>  	if (lock_ac_dir_cnt == 0 && acpi_ac_dir_param && acpi_ac_dir) {
>  		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
> -		acpi_ac_dir = 0;
> +		acpi_ac_dir = NULL;
>  	}
>  	mutex_unlock(&cm_sbs_mutex);
>  }
> @@ -99,7 +99,7 @@ void acpi_unlock_battery_dir(struct proc
>  	if (lock_battery_dir_cnt == 0 && acpi_battery_dir_param
>  	    && acpi_battery_dir) {
>  		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
> -		acpi_battery_dir = 0;
> +		acpi_battery_dir = NULL;
>  	}
>  	mutex_unlock(&cm_sbs_mutex);
>  	return;
> 
> 
> ---
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
