From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [BUGFIX] ACPI, APEI, Fix building of APEI EINJ and GHES
Date: Mon, 10 May 2010 10:50:48 -0600
Message-ID: <201005101050.49328.bjorn.helgaas@hp.com>
References: <1273483482.3344.65.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:25068 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab0EJQwG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2010 12:52:06 -0400
In-Reply-To: <1273483482.3344.65.camel@yhuang-dev.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday, May 10, 2010 03:24:42 am Huang Ying wrote:
> Randy reported building warnings and errors for APEI EINJ and GHES as follow:
> 
> drivers/acpi/apei/einj.c:127:error: implicit declaration of function 'ndelay'
> 
> ghes.c:(.text+0x119e71): undefined reference to `apei_mce_report_mem_error'
> CONFIG_X86_MCE is not enabled
> 
> This patch fixes these two bugs.
> 
> Reported-by: Randy Dunlap <randy.dunlap@oracle.com>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> ---
>  drivers/acpi/apei/einj.c |    1 +
>  drivers/acpi/apei/ghes.c |    2 ++
>  2 files changed, 3 insertions(+)

The drivers/acpi/apei directory isn't in Linus' tree yet, so this should
be fixed by reposting the original submission with this change included.
Otherwise, there will be a series of commits that is not bisectable
because of this build failure.

> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -29,6 +29,7 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/debugfs.h>
> +#include <linux/delay.h>
>  #include <linux/seq_file.h>
>  #include <linux/nmi.h>
>  #include <acpi/acpi.h>
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -242,6 +242,7 @@ static void ghes_do_proc(struct ghes *gh
>  
>  	ser = ghes_severity(ghes->estatus->error_severity);
>  	apei_estatus_for_each_section(ghes->estatus, gdata) {
> +#ifdef CONFIG_X86_MCE
>  		if (!uuid_le_cmp(*(uuid_le *)gdata->section_type,
>  				 CPER_SEC_PLATFORM_MEM)) {
>  			apei_mce_report_mem_error(
> @@ -249,6 +250,7 @@ static void ghes_do_proc(struct ghes *gh
>  				(struct cper_sec_mem_err *)(gdata+1));
>  			processed = 1;
>  		}
> +#endif
>  	}
>  
>  	if (!processed && printk_ratelimit())
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
