From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: cpufreq, processor: fix compile error in drivers/acpi/processor_perflib.c
Date: Fri, 24 Oct 2008 12:31:43 +0200
Message-ID: <200810241231.44283.trenn@suse.de>
References: <490193BC.70108@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51279 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbYJXKbv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Oct 2008 06:31:51 -0400
In-Reply-To: <490193BC.70108@cn.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: miaox@cn.fujitsu.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Friday 24 October 2008 11:22:04 Miao Xie wrote:
> When trying to build 2.6.28-rc1 on ia64, make aborts with:
>
>   CC      drivers/acpi/processor_perflib.o
>   drivers/acpi/processor_perflib.c:41:28: error: asm/cpufeature.h: No=
 such
> file or directory drivers/acpi/processor_perflib.c: In function
> =E2=80=98acpi_processor_get_performance_info=E2=80=99:
> drivers/acpi/processor_perflib.c:364: error: implicit declaration of
> function =E2=80=98boot_cpu_has=E2=80=99 drivers/acpi/processor_perfli=
b.c:364: error:
> =E2=80=98X86_FEATURE_EST=E2=80=99 undeclared (first use in this funct=
ion)
> drivers/acpi/processor_perflib.c:364: error: (Each undeclared identif=
ier is
> reported only once drivers/acpi/processor_perflib.c:364: error: for e=
ach
> function it appears in.) make[2]: *** [drivers/acpi/processor_perflib=
=2Eo]
> Error 1
>   make[1]: *** [drivers/acpi] Error 2
>   make: *** [drivers] Error 2
>
> this patch fix it.

Thanks.

     Thomas
>
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
> Cc: Thomas Renninger <trenn@suse.de>
>
> ---
>  drivers/acpi/processor_perflib.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/processor_perflib.c
> b/drivers/acpi/processor_perflib.c index dc98f7a..dbcf260 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -38,7 +38,10 @@
>
>  #include <asm/uaccess.h>
>  #endif
> +
> +#ifdef CONFIG_X86
>  #include <asm/cpufeature.h>
> +#endif
>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/processor.h>
> @@ -360,11 +363,13 @@ static int acpi_processor_get_performance_info(=
struct
> acpi_processor *pr) * the BIOS is older than the CPU and does not kno=
w its
> frequencies */
>   update_bios:
> +#ifdef CONFIG_X86
>  	if (ACPI_SUCCESS(acpi_get_handle(pr->handle, "_PPC", &handle))){
>  		if(boot_cpu_has(X86_FEATURE_EST))
>  			printk(KERN_WARNING FW_BUG "BIOS needs update for CPU "
>  			       "frequency support\n");
>  	}
> +#endif
>  	return result;
>  }


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
