From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Allow ACPI_CUSTOM_DSDT for IA64
Date: 25 Oct 2004 17:55:12 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098741312.27397.166.camel@d845pe>
References: <3ACA40606221794F80A5670F0AF15F8403BD57CF@pdsmsx403>
	 <1098418443.2096.8.camel@d845pe>
	 <20041025134914.A8649@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041025134914.A8649-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Yi Zhu <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, brian-/bzczjCP1d2sTnJN9+BGXg@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Mon, 2004-10-25 at 16:49, Keshavamurthy Anil S wrote:
> On Fri, Oct 22, 2004 at 12:14:03AM -0400, Len Brown wrote:
> > DSDT overrides are for developers and experimentation,
> > not for production use.  Developers know how to build kernels,
> > and those that don't use initrd's can't use the initrd
> > method anyway.
> 
> Hi Len,
>         Currently DSDT override patch is available only on X86 and
> this is required for IA64 too.
> 
> The attached patch(for 2.6.10-rc1)make this option available on IA64.
> Will you please consider applying this path.
> 
> ---
> 
>  linux-2.6.10-rc1-askeshav/drivers/acpi/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/Kconfig~config_dsdt drivers/acpi/Kconfig
> --- linux-2.6.10-rc1/drivers/acpi/Kconfig~config_dsdt   2004-10-25
> 13:43:37.078238831 -0700
> +++ linux-2.6.10-rc1-askeshav/drivers/acpi/Kconfig      2004-10-25
> 13:45:31.171987433 -0700
> @@ -215,7 +215,7 @@ config ACPI_TOSHIBA
> 
>  config ACPI_CUSTOM_DSDT
>         bool "Include Custom DSDT"
> -       depends on X86 && ACPI_INTERPRETER && !STANDALONE
> +       depends on ACPI_INTERPRETER && !STANDALONE
>         default n
>         help
>           Thist option is to load a custom ACPI DSDT
> _
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
