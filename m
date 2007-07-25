From: "Noah Watkins" <noah.lkml@gmail.com>
Subject: Re: 2.6.23-rc1 -- build failure
Date: Wed, 25 Jul 2007 12:08:22 -0500
Message-ID: <be2dacd50707251008q2f69a3c0y3f8fa29c9462d393@mail.gmail.com>
References: <20070725161116.GF23458@ittc.ku.edu>
	 <200707251255.12359.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:20339 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758482AbXGYRIZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jul 2007 13:08:25 -0400
Received: by nz-out-0506.google.com with SMTP id s18so227779nze
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jul 2007 10:08:24 -0700 (PDT)
In-Reply-To: <200707251255.12359.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Noah Watkins <nwatkins@ittc.ku.edu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Thanks this fixed it. My LKML search didn't find this patch.
-noah

On 7/25/07, Len Brown <lenb@kernel.org> wrote:
> On Wednesday 25 July 2007 12:11, Noah Watkins wrote:
> > Latest git tree gives following build errors (config attached):
> >
> > make -C /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6 O=/yggnfs/nwatkins/kernels/git-linux-2.6/build
> >   Using /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6 as source for kernel
> >   GEN     /yggnfs/nwatkins/kernels/git-linux-2.6/build/Makefile
> >   CHK     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   CALL    /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/scripts/checksyscalls.sh
> >   CHK     include/linux/compile.h
> >   CC      arch/i386/kernel/acpi/cstate.o
> > In file included from /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/arch/i386/kernel/acpi/cstate.c:16:
> > /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/processor.h:90: error: expected specifier-qualifier-list before 'acpi_integer'
> > /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/processor.h:108: error: expected specifier-qualifier-list before 'acpi_integer'
> > /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/processor.h:131: error: expected specifier-qualifier-list before 'acpi_integer'
> > /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/processor.h:149: error: expected specifier-qualifier-list before 'acpi_integer'
> > /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/processor.h:205: error: expected specifier-qualifier-list before 'acpi_handle'
> > /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/processor.h:319: warning: 'struct acpi_device' declared inside parameter list
> > /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/processor.h:319: warning: its scope is only this definition or declaration, which is probably not what you want
> > /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/processor.h:322: warning: 'struct acpi_device' declared inside parameter list
> > make[4]: *** [arch/i386/kernel/acpi/cstate.o] Error 1
> > make[3]: *** [arch/i386/kernel/acpi] Error 2
> > make[2]: *** [arch/i386/kernel] Error 2
> > make[1]: *** [_all] Error 2
> > make: *** [all] Error 2
>
> try this:
>
> From akpm@linux-foundation.org Mon Jul 23 20:50:44 2007
>
>
> -----------------------------------------------------
> Subject: X86_POWERNOW_K8_ACPI must depend on ACPI
> From: Adrian Bunk <bunk@stusta.de>
>
> This patch fixes the following compile error introduced by
> commit e8666b2718fdb5bf0ea7c3126f7e292bbbf2946b and reported
> by Alexey Dobriyan:
>
> <--  snip  -->
>
>    CC      arch/i386/kernel/acpi/cstate.o
> In file included from arch/i386/kernel/acpi/cstate.c:17:
> include/acpi/processor.h:88: error: expected specifier-qualifier-list before 'acpi_integer'
>
> <--  snip  -->
>
> If you select something you must ensure that the dependencies of what
> you are selecting are fulfilled.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Cc: Alexey Dobriyan <adobriyan@sw.ru>
> Cc: Joshua Hoblitt <jhoblitt@ifa.hawaii.edu>
> Cc: Dave Jones <davej@redhat.com>
> Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  arch/i386/kernel/cpu/cpufreq/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN arch/i386/kernel/cpu/cpufreq/Kconfig~x86_powernow_k8_acpi-must-depend-on-acpi arch/i386/kernel/cpu/cpufreq/Kconfig
> --- a/arch/i386/kernel/cpu/cpufreq/Kconfig~x86_powernow_k8_acpi-must-depend-on-acpi
> +++ a/arch/i386/kernel/cpu/cpufreq/Kconfig
> @@ -92,7 +92,7 @@ config X86_POWERNOW_K8
>  config X86_POWERNOW_K8_ACPI
>         bool "ACPI Support"
>         select ACPI_PROCESSOR
> -       depends on X86_POWERNOW_K8
> +       depends on ACPI && X86_POWERNOW_K8
>         default y
>         help
>           This provides access to the K8s Processor Performance States via ACPI.
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
