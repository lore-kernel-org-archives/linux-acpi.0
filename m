From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 06/12] ACPI: report errors in fan.c
Date: 02 Mar 2005 13:56:12 -0500
Message-ID: <1109789772.2103.576.camel@d845pe>
References: <200502230953.j1N9rIwN020705@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502230953.j1N9rIwN020705-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Wed, 2005-02-23 at 04:53, akpm-3NddpPZAyC0@public.gmane.org wrote:
> From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> 
> Currently, fan.c ignores errors from acpi_bus_get_power.  On compaq
> evo
> notebook that leads to very confusing empty output.
> 
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/drivers/acpi/fan.c |   19 ++++++++-----------
>  1 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff -puN drivers/acpi/fan.c~acpi-report-errors-in-fanc
> drivers/acpi/fan.c
> --- 25/drivers/acpi/fan.c~acpi-report-errors-in-fanc    2005-02-23
> 01:48:03.000000000 -0800
> +++ 25-akpm/drivers/acpi/fan.c  2005-02-23 01:48:03.000000000 -0800
> @@ -78,21 +78,18 @@ struct proc_dir_entry               *acpi_fan_dir;
>  static int
>  acpi_fan_read_state (struct seq_file *seq, void *offset)
>  {
> -       struct acpi_fan         *fan = (struct acpi_fan *)
> seq->private;
> +       struct acpi_fan         *fan = seq->private;
>         int                     state = 0;
> 
>         ACPI_FUNCTION_TRACE("acpi_fan_read_state");
> 
> -       if (!fan)
> -               goto end;
> -
> -       if (acpi_bus_get_power(fan->handle, &state))
> -               goto end;
> -
> -       seq_printf(seq, "status:                  %s\n",
> -               !state?"on":"off");
> -
> -end:
> +       if (fan) {
> +               if (acpi_bus_get_power(fan->handle, &state))
> +                       seq_printf(seq, "status:                 
> ERROR\n");
> +               else
> +                       seq_printf(seq, "status:                 
> %s\n",
> +                                    !state?"on":"off");
> +       }
>         return_VALUE(0);
>  }
> 
> _
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
