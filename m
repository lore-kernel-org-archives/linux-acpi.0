From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5] trace, RAS: Add basic RAS trace event
Date: Wed, 9 Apr 2014 21:46:54 +0200
Message-ID: <20140409194654.GR6529@pd.tnic>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57185 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933782AbaDITrC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2014 15:47:02 -0400
Content-Disposition: inline
In-Reply-To: <1395985981-20476-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com

On Fri, Mar 28, 2014 at 01:52:57AM -0400, Chen, Gong wrote:
> To avoid the confuision of usage for RAS related trace event, add
> an unified RAS trace event stub.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/Kconfig          |  2 ++
>  drivers/Makefile         |  1 +
>  drivers/edac/edac_mc.c   |  3 ---
>  drivers/ras/Kconfig      |  4 ++++
>  drivers/ras/Makefile     |  1 +
>  drivers/ras/ras-traces.c | 12 ++++++++++++
>  6 files changed, 20 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/ras/Kconfig
>  create mode 100644 drivers/ras/Makefile
>  create mode 100644 drivers/ras/ras-traces.c
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index b3138fb..d70f7ba 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -170,4 +170,6 @@ source "drivers/phy/Kconfig"
>  
>  source "drivers/powercap/Kconfig"
>  
> +source "drivers/ras/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 8e3b8b0..10aaab0 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -155,3 +155,4 @@ obj-$(CONFIG_IPACK_BUS)		+= ipack/
>  obj-$(CONFIG_NTB)		+= ntb/
>  obj-$(CONFIG_FMC)		+= fmc/
>  obj-$(CONFIG_POWERCAP)		+= powercap/
> +obj-$(CONFIG_RAS_TRACE)		+= ras/
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 33edd67..28c1695 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -33,9 +33,6 @@
>  #include <asm/edac.h>
>  #include "edac_core.h"
>  #include "edac_module.h"
> -
> -#define CREATE_TRACE_POINTS
> -#define TRACE_INCLUDE_PATH ../../include/ras
>  #include <ras/ras_event.h>
>  
>  /* lock to memory controller's control array */
> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> new file mode 100644
> index 0000000..6e4aec5
> --- /dev/null
> +++ b/drivers/ras/Kconfig
> @@ -0,0 +1,4 @@
> +# RAS_TRACE always gets selected by whoever wants it.
> +config RAS_TRACE
> +	def_bool y
> +	depends on EDAC_MM_EDAC

This should actually be

menuconfig RAS
	bool "Reliability, Availability, Serviceability features"
	help
	  <A nice text about what this is going to contain, i.e. RAS stuff

	  ...

if RAS
config RAS_TRACE
	def_bool y
	depends on ...

See drivers/edac/Kconfig for an example.

RAS_TRACE should actually depend on all the code that uses it, or, it
should be selected by them. EDAC_MM_EDAC is not accurate enough and will
enable RAS_TRACE even for drivers which don't use the tracepoint(s).

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
