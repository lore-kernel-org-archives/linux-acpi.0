From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
Date: Tue, 13 Dec 2005 20:58:08 -0800
Message-ID: <20051214045808.GA22308@kroah.com>
References: <4395D945.6080108@gmx.net> <20051206192136.GA22615@kroah.com> <4395F0AB.1080408@gmx.net> <20051208033841.GA25008@kroah.com> <439A23CB.50102@gmx.net> <439FA436.50107@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <439FA436.50107-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 14, 2005 at 05:48:54AM +0100, Carl-Daniel Hailfinger wrote:
> Linus, Greg,
> 
> please apply the following patch to your trees. It fixes
> http://bugzilla.kernel.org/show_bug.cgi?id=5067
> 
> The patch has been tested and verified, is shipped in the
> SUSE 10.0 kernel and does not cause any regressions.
> 
> Unfortunately, the ACPI maintainers have been ignoring
> this patch for the last few months despite repeated
> requests for review on acpi-devel. I even CCed all ACPI
> maintainers personally and didn't receive any response.

Give them a chance to respond.  I'll wait for them to accept this before
adding it to the -stable tree.

> +
> +	/* INIT on Samsung's P35 returns an integer, possible return
> +	 * values are tested below */
> +	if (model->type == ACPI_TYPE_INTEGER) {
> +		if (model->integer.value == -1 ||
> +			model->integer.value == 0x58 ||
> +			model->integer.value == 0x38) {
> +			hotk->model = P30;
> +			printk(KERN_NOTICE
> +				       "  Samsung P35 detected, 
> supported\n");

Patch is still linewrapped :(

And I still think that this comparison isn't right and want verification
from the ACPI maintainers about this.  You really have P35 machines that
both return an error for the model value, and return 58 and 38?


> +			goto out_known;
> +		} else {
> +			printk(KERN_WARNING
> +				"  unknown integer returned by INIT\n");
> +			goto out_unknown;
> +		}
> +	}

Why exit so quickly here?  What about the other models?

>  	if (model->type == ACPI_TYPE_STRING) {
>  		printk(KERN_NOTICE "  %s model detected, ",
>  		       model->string.pointer);
> @@ -1057,9 +1075,7 @@ static int __init asus_hotk_get_info(voi
>  		hotk->model = L5x;
> 
>  	if (hotk->model == END_MODEL) {
> -		printk("unsupported, trying default values, supply the "
> -		       "developers with your DSDT\n");
> -		hotk->model = M2E;
> +		goto out_unknown;
>  	} else {
>  		printk("supported\n");
>  	}
> @@ -1088,6 +1104,15 @@ static int __init asus_hotk_get_info(voi
>  	acpi_os_free(model);
> 
>  	return AE_OK;
> +
> +out_unknown:
> +	printk(KERN_WARNING "  unsupported, trying default values, "
> +			"supply the developers with your DSDT\n");

What's with the leading spaces here?

thanks,

greg k-h


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
