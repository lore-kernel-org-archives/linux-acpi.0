From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 06/12] asus_acpi: don't printk on writing garbage to proc files
Date: Sat, 14 Oct 2006 04:07:45 -0400
Message-ID: <200610140407.45983.len.brown@intel.com>
References: <200610102120.k9ALKa9G024281@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58055 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161000AbWJNIFO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:05:14 -0400
In-Reply-To: <200610102120.k9ALKa9G024281@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, adobriyan@gmail.com

Applied.

thanks,
-Len

On Tuesday 10 October 2006 17:20, akpm@osdl.org wrote:
> From: Alexey Dobriyan <adobriyan@gmail.com>
> 
> * This reporting is useless (you get errno anyway).
> * This reporting is already inconsistent in driver.
> * Looks like created files in proc are rw-rw-rw- by default.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/asus_acpi.c |   10 +---------
>  1 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff -puN drivers/acpi/asus_acpi.c~asus_acpi-dont-printk-on-writing-garbage-to-proc-files drivers/acpi/asus_acpi.c
> --- a/drivers/acpi/asus_acpi.c~asus_acpi-dont-printk-on-writing-garbage-to-proc-files
> +++ a/drivers/acpi/asus_acpi.c
> @@ -629,9 +629,7 @@ proc_write_ledd(struct file *file, const
>  			       "Asus ACPI: LED display write failed\n");
>  		else
>  			hotk->ledd_status = (u32) value;
> -	} else if (rv < 0)
> -		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
> -
> +	}
>  	return rv;
>  }
>  
> @@ -849,10 +847,7 @@ proc_write_brn(struct file *file, const 
>  		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
>  		/* 0 <= value <= 15 */
>  		set_brightness(value);
> -	} else if (rv < 0) {
> -		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
>  	}
> -
>  	return rv;
>  }
>  
> @@ -897,9 +892,6 @@ proc_write_disp(struct file *file, const
>  	rv = parse_arg(buffer, count, &value);
>  	if (rv > 0)
>  		set_display(value);
> -	else if (rv < 0)
> -		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
> -
>  	return rv;
>  }
>  
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
