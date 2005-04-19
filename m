From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: bk-acpi causes freezes on ia64/tiger
Date: 19 Apr 2005 01:41:10 -0400
Message-ID: <1113889270.14025.24.camel@d845pe>
References: <20050408011437.7fe1159d.akpm@osdl.org>
	 <1113190685.2420.36.camel@d845pe><1113252341.2419.44.camel@d845pe>
	 <20050411182951.52f76e93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050411182951.52f76e93.akpm-3NddpPZAyC0@public.gmane.org>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andrew,
as of the latest acpi to-akpm tree,
you should no longer need to revert the patch below
for the benefit of ia64.

thanks,
-Len

On Mon, 2005-04-11 at 21:29, Andrew Morton wrote:
> Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > On Sun, 2005-04-10 at 23:38, Len Brown wrote:
> >  > On Fri, 2005-04-08 at 04:14, Andrew Morton wrote:
> >  > > Current bk-acpi tree causes my Intel tiger box to freeze
> partway
> >  > > through boot.
> >
> >  Looks like the freeze may be due to the "C1 patch":
> >
> > 
> http://linux-acpi.bkbits.net:8080/to-akpm/cset@424cccb33M89YNHJOda1O6L0B6ucjw
> >
> >  If you revert that one does your tiger live?
> 
> That server appears to be dead.  I took a punt and reverted the below
> patch.  That fixed things up.
> 
> There's a bit of noice in the bootup though:
> 
> usbcore: registered new driver usbled                
> usbcore: registered new driver legousbtower
> drivers/usb/misc/legousbtower.c: LEGO USB Tower Driver v0.96
> mice: PS/2 mouse device common for all mice                
> i2c /dev entries driver                   
> i2c-parport: using default base 0x378
> i2c-sis96x version 1.0.0            
> ACPI: No ACPI bus support for 1-0018
> ACPI: No ACPI bus support for 1-0019
> ACPI: No ACPI bus support for 1-001a
> ACPI: No ACPI bus support for 1-0029
> ACPI: No ACPI bus support for 1-002a
> ACPI: No ACPI bus support for 1-002b
> ACPI: No ACPI bus support for 1-004c
> ACPI: No ACPI bus support for 1-004d
> ACPI: No ACPI bus support for 1-004e
> ACPI: No ACPI bus support for 1-0050
> ACPI: No ACPI bus support for 1-0051
> ACPI: No ACPI bus support for 1-0052
> ACPI: No ACPI bus support for 1-0053
> ACPI: No ACPI bus support for 1-0054
> ACPI: No ACPI bus support for 1-0055
> ACPI: No ACPI bus support for 1-0056
> ACPI: No ACPI bus support for 1-0057
> ACPI: No ACPI bus support for 1-0048
> ACPI: No ACPI bus support for 1-0049
> ACPI: No ACPI bus support for 1-004a
> ACPI: No ACPI bus support for 1-004b
> ACPI: No ACPI bus support for 1-004f
> i2c_adapter i2c-1: Unsupported chip (man_id=0x0000, chip_id=0x00).
> EFI Variables Facility v0.08 2004-May-17                         
> NET: Registered protocol family 2      
> 
> 
> 
> 
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2005/03/31 23:23:15-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
> #   [ACPI] update /proc/acpi/processor/*/power even if only C1 support
> #  
> #   Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> #   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> #
> # drivers/acpi/processor_idle.c
> #   2005/03/25 21:41:52-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +26 -7
> #   C1 stats
> #
> diff -Nru a/drivers/acpi/processor_idle.c
> b/drivers/acpi/processor_idle.c
> --- a/drivers/acpi/processor_idle.c     2005-04-11 18:19:06 -07:00
> +++ b/drivers/acpi/processor_idle.c     2005-04-11 18:19:06 -07:00
> @@ -519,6 +519,29 @@
>  }
> 
> 
> +static int acpi_processor_get_power_info_default_c1 (struct
> acpi_processor *pr)
> +{
> +       int i;
> +
> +      
> ACPI_FUNCTION_TRACE("acpi_processor_get_power_info_default_c1");
> +
> +       for (i = 0; i < ACPI_PROCESSOR_MAX_POWER; i++)
> +               memset(pr->power.states, 0, sizeof(struct
> acpi_processor_cx));
> +
> +       /* if info is obtained from pblk/fadt, type equals state */
> +       pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
> +       pr->power.states[ACPI_STATE_C2].type = ACPI_STATE_C2;
> +       pr->power.states[ACPI_STATE_C3].type = ACPI_STATE_C3;
> +
> +       /* the C0 state only exists as a filler in our array,
> +        * and all processors need to support C1 */
> +       pr->power.states[ACPI_STATE_C0].valid = 1;
> +       pr->power.states[ACPI_STATE_C1].valid = 1;
> +
> +       return_VALUE(0);
> +}
> +
> +
>  static int acpi_processor_get_power_info_cst (struct acpi_processor
> *pr)
>  {
>         acpi_status             status = 0;
> @@ -787,10 +810,7 @@
>         if ((result) || (acpi_processor_power_verify(pr) < 2)) {
>                 result = acpi_processor_get_power_info_fadt(pr);
>                 if (result)
> -                       return_VALUE(result);
> -
> -               if (acpi_processor_power_verify(pr) < 2)
> -                       return_VALUE(-ENODEV);
> +                       result =
> acpi_processor_get_power_info_default_c1(pr);
>         }
> 
>         /*
> @@ -810,11 +830,10 @@
>          * CPU as being "idle manageable"
>          */
>         for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
> -               if (pr->power.states[i].valid)
> +               if (pr->power.states[i].valid) {
>                         pr->power.count = i;
> -               if ((pr->power.states[i].valid) &&
> -                   (pr->power.states[i].type >= ACPI_STATE_C2))
>                         pr->flags.power = 1;
> +               }
>         }
> 
>         return_VALUE(0);
> 
> 
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
