From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2/4] acpi: Toshiba failure handling
Date: 30 Mar 2005 22:17:30 -0500
Message-ID: <1112239050.2175.63.camel@d845pe>
References: <200503302116.j2ULGc4Y027730@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200503302116.j2ULGc4Y027730-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, panagiotis.issaris-hfxpx0nnwYVX2QMWbMbClIble9XqW/aP@public.gmane.org, takis-8nu/KwtRnEU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2005-03-30 at 16:16, akpm-3NddpPZAyC0@public.gmane.org wrote:
> From: "Panagiotis Issaris" <panagiotis.issaris-hfxpx0nnwYVX2QMWbMbClIble9XqW/aP@public.gmane.org>
> 
> Adds the missing failure handling for a kmalloc in the Toshiba ACPI
> driver.
> 
> Signed-off-by: Panagiotis Issaris <takis-8nu/KwtRnEU@public.gmane.org>
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/drivers/acpi/toshiba_acpi.c |    3 +++
>  1 files changed, 3 insertions(+)
> 
> diff -puN drivers/acpi/toshiba_acpi.c~acpi-toshiba-failure-handling
> drivers/acpi/toshiba_acpi.c
> ---
> 25/drivers/acpi/toshiba_acpi.c~acpi-toshiba-failure-handling       
> Wed Mar 30 13:16:02 2005
> +++ 25-akpm/drivers/acpi/toshiba_acpi.c Wed Mar 30 13:16:02 2005
> @@ -263,6 +263,9 @@ dispatch_write(struct file* file, const
>          * destination so that sscanf can be used on it safely.
>          */
>         tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
> +       if(!tmp_buffer)
> +               return -ENOMEM;
> +
>         if (copy_from_user(tmp_buffer, buffer, count)) {
>                 result = -EFAULT;
>         }
> _
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
