From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 5/6] Altix: reinitialize acpi tables
Date: Wed, 7 Mar 2007 02:34:25 -0500
Message-ID: <200703070234.25710.lenb@kernel.org>
References: <200703061029.l26AThio019132@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47274 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161303AbXCGHgR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Mar 2007 02:36:17 -0500
In-Reply-To: <200703061029.l26AThio019132@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, jpk@sgi.com

Andrew,
This patch is munged -- please remove it from mm.

The correct patch is already present in git-acpi.patch,
which perhaps is why patch munged it on entry into mm.

thanks,
-Len


On Tuesday 06 March 2007 05:29, akpm@linux-foundation.org wrote:
> From: John Keller <jpk@sgi.com>
> 
> To provide compatibilty with SN kernels that do and do not have ACPI IO
> support, the SN PROM must build different versions of some ACPI tables
> based on which kernel is booting.  As such, the tables may have to change
> at kernel boot time.  By default, prior to kernel boot, the PROM builds an
> empty DSDT (header only) and no SSDTs.  If an ACPI capable kernel boots,
> the kernel will notify the PROM, at platform setup time, and the PROM will
> build full DSDT and SSDT tables.
> 
> With the latest changes to acpi_table_init(), the table lengths are saved,
> and when our PROM changes them, the changes are not seen, and the kernel
> will crash on boot.  Because of issues with kexec support, we are not able
> to create the tables prior to acpi_table_init().  As a result, we are
> making a second call to acpi_table_init() to process the rebuilt DSDT and
> SSDTs.
> 
> Signed-off-by: John Keller <jpk@sgi.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/ia64/sn/kernel/setup.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -puN arch/ia64/sn/kernel/setup.c~altix-reinitialize-acpi-tables arch/ia64/sn/kernel/setup.c
> --- a/arch/ia64/sn/kernel/setup.c~altix-reinitialize-acpi-tables
> +++ a/arch/ia64/sn/kernel/setup.c
> @@ -54,6 +54,8 @@
>  #include "xtalk/hubdev.h"
>  #include <asm/sn/klconfig.h>
>  
> +	/* Load the new DSDT and SSDT tables into the global table list. */
> + 	acpi_table_init();
>  
>  DEFINE_PER_CPU(struct pda_s, pda_percpu);
>  
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
