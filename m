From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2/2] acpi video pointer size fix
Date: 30 Mar 2005 22:51:36 -0500
Message-ID: <1112241095.2175.70.camel@d845pe>
References: <200503090857.j298v8ln021826@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200503090857.j298v8ln021826-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2005-03-09 at 03:56, akpm-3NddpPZAyC0@public.gmane.org wrote:
> From: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>
> 
> Fix two instances where we take &p instead of *p when calculating
> storage
> size.
> 
> Also, kfree(NULL) is legal, so remove some unneeded checks.
> 
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/drivers/acpi/video.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff -puN drivers/acpi/video.c~acpi-video-pointer-size-fix
> drivers/acpi/video.c
> --- 25/drivers/acpi/video.c~acpi-video-pointer-size-fix 2005-03-09
> 00:55:00.000000000 -0800
> +++ 25-akpm/drivers/acpi/video.c        2005-03-09 00:55:00.000000000
> -0800
> @@ -564,12 +564,13 @@ acpi_video_device_find_cap (struct acpi_
>                 int count = 0;
>                 union acpi_object *o;
>                
> -               br = kmalloc(sizeof &br, GFP_KERNEL);
> +               br = kmalloc(sizeof(*br), GFP_KERNEL);
>                 if (!br) {
>                         printk(KERN_ERR "can't allocate memory\n");
>                 } else {
> -                       memset(br, 0, sizeof &br);
> -                       br->levels = kmalloc(obj->package.count *
> sizeof &br->levels, GFP_KERNEL);
> +                       memset(br, 0, sizeof(*br));
> +                       br->levels = kmalloc(obj->package.count *
> +                                       sizeof *(br->levels),
> GFP_KERNEL);
>                         if (!br->levels)
>                                 goto out;
> 
> @@ -584,8 +585,7 @@ acpi_video_device_find_cap (struct acpi_
>                         }
>  out:
>                         if (count < 2) {
> -                               if (br->levels)
> -                                       kfree(br->levels);
> +                               kfree(br->levels);
>                                 kfree(br);
>                         } else {
>                                 br->count = count;
> @@ -595,8 +595,7 @@ out:
>                 }
>         }
> 
> -       if (obj)
> -               kfree(obj);
> +       kfree(obj);
> 
>         return_VOID;
>  }
> _
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
