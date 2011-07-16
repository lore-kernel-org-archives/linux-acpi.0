From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] ACPI: APEI build fix
Date: Sat, 16 Jul 2011 16:45:03 -0700
Message-ID: <20110716164503.0ee2dc3d.rdunlap@xenotime.net>
References: <20110717000815.c83755be9598d34ac8431908@canb.auug.org.au>
	<20110716120304.83d79985.rdunlap@xenotime.net>
	<alpine.LFD.2.02.1107161815220.4339@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1107161815220.4339@x980>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 16 Jul 2011 18:16:20 -0400 (EDT) Len Brown wrote:

> From: Len Brown <len.brown@intel.com>
> 
> as GHES is optional...
> 
> When # CONFIG_ACPI_APEI_GHES is not set:
> 
> (.init.text+0x4c22): undefined reference to `ghes_disable'
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Reported-by: Randy Dunlap <rdunlap@xenotime.net>
Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.

> ---
>  drivers/acpi/bus.c  |    2 --
>  include/acpi/apei.h |    4 ++++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 43ce3b0..437ddbf 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -544,10 +544,8 @@ static void acpi_bus_osc_support(void)
>  	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PPC_OST_SUPPORT;
>  #endif
>  
> -#ifdef CONFIG_ACPI_APEI_GHES
>  	if (!ghes_disable)
>  		capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_APEI_SUPPORT;
> -#endif
>  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>  		return;
>  	if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index d40bc55..51a527d 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -18,7 +18,11 @@
>  
>  extern int hest_disable;
>  extern int erst_disable;
> +#ifdef CONFIG_ACPI_APEI_GHES
>  extern int ghes_disable;
> +#else
> +#define ghes_disable 1
> +#endif
>  
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> -- 


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
