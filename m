From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] add "pnpacpi=off", print info during discovery
Date: Wed, 12 Jan 2005 09:02:44 +0800
Message-ID: <1105491763.29370.5.camel@sli10-desk.sh.intel.com>
References: <1105489541.31942.81.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1105489541.31942.81.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-01-12 at 08:25, Bjorn Helgaas wrote:
I just sent a similar patch to Len, but your patch is great.

> Make PNPACPI IDs uppercase, not lower (the specs, etc, are
> typically uppercase, but if you prefer it lower for some
> reason, feel free to ignore this hunk).  Print info about
> devices found via PNPACPI.  Add "pnpacpi=off" option to
> disable PNPACPI even when compiled in.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> --- pnp1/drivers/pnp/pnpacpi/core.c.1	2005-01-11 15:36:30.000000000 -0700
> +++ pnp1/drivers/pnp/pnpacpi/core.c	2005-01-11 15:41:02.000000000 -0700
> @@ -77,10 +77,10 @@
>  	str[0] = id[0];
>  	str[1] = id[1];
>  	str[2] = id[2];
> -	str[3] = tolower(id[3]);
> -	str[4] = tolower(id[4]);
> -	str[5] = tolower(id[5]);
> -	str[6] = tolower(id[6]);
> +	str[3] = id[3];
> +	str[4] = id[4];
> +	str[5] = id[5];
> +	str[6] = id[6];
>  	str[7] = '\0';
>  }
Some drivers use lower case pnp id.

>  
> @@ -142,7 +142,6 @@
>  		is_exclusive_device(device))
>  		return 0;
>  
> -	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
>  	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
>  	if (!dev) {
>  		pnp_err("Out of memory");
> @@ -220,6 +219,9 @@
>  	pnp_add_device(dev);
>  	num++;
>  
> +	pnp_info("%s ACPI device %s (%s)", dev->dev.bus_id, dev->name,
> +		acpi_device_hid(device));
> +
>  	return AE_OK;
>  err1:
>  	kfree(dev_id);
> @@ -240,8 +242,24 @@
>  	return AE_OK;
>  }
>  
> +static int __initdata pnpacpi_disabled;
> +
> +static int __init pnpacpi_setup(char *str)
> +{
> +	if (strncmp(str, "off", 3) == 0)
> +		pnpacpi_disabled = 1;
> +
> +	return 1;
> +}
> +__setup("pnpacpi=", pnpacpi_setup);
> +
>  int __init pnpacpi_init(void)
>  {
> +	if (pnpacpi_disabled) {
> +		pnp_info("PnP ACPI: Disabled");
> +		return 0;
> +	}
> +
>  	if (acpi_disabled) {
>  		pnp_info("PnP ACPI: ACPI disabled");
>  		return 0;
I somehow think PNPBIOS should be enabled if PNPACPI is disabled. Users
should get at least one PNP driver any way.

Thanks,
Shaohua



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
