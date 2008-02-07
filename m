From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] asus-laptop new write_acpi_int
Date: Thu, 7 Feb 2008 00:43:05 -0500
Message-ID: <200802070043.05184.lenb@kernel.org>
References: <200801161656.42640.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200801161656.42640.corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Wednesday 16 January 2008 10:56, Corentin CHARY wrote:
> From: Corentin CHARY <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
> 
> Just a little modification of write_acpi_int
> 
> Signed-off-by: Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
> ---
>  asus-laptop.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> --- a/drivers/misc/asus-laptop.c	2008-01-15 23:08:01.000000000 +0100
> +++ b/drivers/misc/asus-laptop.c	2008-01-15 23:04:56.000000000 +0100
> @@ -255,7 +255,7 @@
>   * method is searched within the scope of the handle, can be NULL. The output
>   * of the method is written is output, which can also be NULL
>   *
> - * returns 1 if write is successful, 0 else.
> + * returns 0 if write is successful, -1 else.
>   */
>  static int write_acpi_int(acpi_handle handle, const char *method, int val,
>  			  struct acpi_buffer *output)
> @@ -264,13 +264,19 @@
>  	union acpi_object in_obj;	//the only param we use
>  	acpi_status status;
>  
> +	if (!handle)
> +		return 0;
> +
>  	params.count = 1;
>  	params.pointer = &in_obj;
>  	in_obj.type = ACPI_TYPE_INTEGER;
>  	in_obj.integer.value = val;
>  
>  	status = acpi_evaluate_object(handle, (char *)method, &params, output);
> -	return (status == AE_OK);
> +	if (status == AE_OK)
> +		return 0;
> +	else
> +		return -1;
>  }
>  
>  static int read_wireless_status(int mask)
> @@ -336,7 +342,7 @@
>  		break;
>  	}
>  
> -	if (handle && !write_acpi_int(handle, NULL, out, NULL))
> +	if (write_acpi_int(handle, NULL, out, NULL))
>  		printk(ASUS_WARNING " write failed %x\n", mask);
>  }
>  
> @@ -416,7 +422,7 @@
>  	value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
>  	/* 0 <= value <= 15 */
>  
> -	if (!write_acpi_int(brightness_set_handle, NULL, value, NULL)) {
> +	if (write_acpi_int(brightness_set_handle, NULL, value, NULL)) {
>  		printk(ASUS_WARNING "Error changing brightness\n");
>  		ret = -EIO;
>  	}
> @@ -546,7 +552,7 @@
>  
>  	rv = parse_arg(buf, count, &value);
>  	if (rv > 0) {
> -		if (!write_acpi_int(ledd_set_handle, NULL, value, NULL))
> +		if (write_acpi_int(ledd_set_handle, NULL, value, NULL))
>  			printk(ASUS_WARNING "LED display write failed\n");
>  		else
>  			hotk->ledd_status = (u32) value;
> @@ -591,7 +597,7 @@
>  static void set_display(int value)
>  {
>  	/* no sanity check needed for now */
> -	if (!write_acpi_int(display_set_handle, NULL, value, NULL))
> +	if (write_acpi_int(display_set_handle, NULL, value, NULL))
>  		printk(ASUS_WARNING "Error setting display\n");
>  	return;
>  }
> @@ -648,7 +654,7 @@
>   */
>  static void set_light_sens_switch(int value)
>  {
> -	if (!write_acpi_int(ls_switch_handle, NULL, value, NULL))
> +	if (write_acpi_int(ls_switch_handle, NULL, value, NULL))
>  		printk(ASUS_WARNING "Error setting light sensor switch\n");
>  	hotk->light_switch = value;
>  }
> @@ -673,7 +679,7 @@
>  
>  static void set_light_sens_level(int value)
>  {
> -	if (!write_acpi_int(ls_level_handle, NULL, value, NULL))
> +	if (write_acpi_int(ls_level_handle, NULL, value, NULL))
>  		printk(ASUS_WARNING "Error setting light sensor level\n");
>  	hotk->light_level = value;
>  }
> @@ -861,7 +867,7 @@
>  		printk(ASUS_WARNING "Couldn't get the DSDT table header\n");
>  
>  	/* We have to write 0 on init this far for all ASUS models */
> -	if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
> +	if (write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
>  		printk(ASUS_ERR "Hotkey initialization failed\n");
>  		return -ENODEV;
>  	}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
