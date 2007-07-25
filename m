From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.23-rc1 -- build failure
Date: Wed, 25 Jul 2007 12:55:12 -0400
Message-ID: <200707251255.12359.lenb@kernel.org>
References: <20070725161116.GF23458@ittc.ku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59436 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbXGYQzR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jul 2007 12:55:17 -0400
In-Reply-To: <20070725161116.GF23458@ittc.ku.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Noah Watkins <nwatkins@ittc.ku.edu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday 25 July 2007 12:11, Noah Watkins wrote:
> Latest git tree gives following build errors (config attached):
>=20
> make -C /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6 O=3D/yggnfs/=
nwatkins/kernels/git-linux-2.6/build
>   Using /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6 as source fo=
r kernel
>   GEN     /yggnfs/nwatkins/kernels/git-linux-2.6/build/Makefile
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/scripts/ch=
ecksyscalls.sh
>   CHK     include/linux/compile.h
>   CC      arch/i386/kernel/acpi/cstate.o
> In file included from /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.=
6/arch/i386/kernel/acpi/cstate.c:16:
> /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/process=
or.h:90: error: expected specifier-qualifier-list before =E2=80=98acpi_=
integer=E2=80=99
> /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/process=
or.h:108: error: expected specifier-qualifier-list before =E2=80=98acpi=
_integer=E2=80=99
> /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/process=
or.h:131: error: expected specifier-qualifier-list before =E2=80=98acpi=
_integer=E2=80=99
> /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/process=
or.h:149: error: expected specifier-qualifier-list before =E2=80=98acpi=
_integer=E2=80=99
> /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/process=
or.h:205: error: expected specifier-qualifier-list before =E2=80=98acpi=
_handle=E2=80=99
> /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/process=
or.h:319: warning: =E2=80=98struct acpi_device=E2=80=99 declared inside=
 parameter list
> /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/process=
or.h:319: warning: its scope is only this definition or declaration, wh=
ich is probably not what you want
> /yggnfs/nwatkins/kernels/git-linux-2.6/linux-2.6/include/acpi/process=
or.h:322: warning: =E2=80=98struct acpi_device=E2=80=99 declared inside=
 parameter list
> make[4]: *** [arch/i386/kernel/acpi/cstate.o] Error 1
> make[3]: *** [arch/i386/kernel/acpi] Error 2
> make[2]: *** [arch/i386/kernel] Error 2
> make[1]: *** [_all] Error 2
> make: *** [all] Error 2

try this:

=46rom akpm@linux-foundation.org Mon Jul 23 20:50:44 2007


-----------------------------------------------------
Subject: X86_POWERNOW_K8_ACPI must depend on ACPI
=46rom: Adrian Bunk <bunk@stusta.de>

This patch fixes the following compile error introduced by
commit e8666b2718fdb5bf0ea7c3126f7e292bbbf2946b and reported
by Alexey Dobriyan:

<--  snip  -->

   CC      arch/i386/kernel/acpi/cstate.o
In file included from arch/i386/kernel/acpi/cstate.c:17:
include/acpi/processor.h:88: error: expected specifier-qualifier-list b=
efore 'acpi_integer'

<--  snip  -->

If you select something you must ensure that the dependencies of what
you are selecting are fulfilled.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Alexey Dobriyan <adobriyan@sw.ru>
Cc: Joshua Hoblitt <jhoblitt@ifa.hawaii.edu>
Cc: Dave Jones <davej@redhat.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/i386/kernel/cpu/cpufreq/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/cpu/cpufreq/Kconfig~x86_powernow_k8_acpi-mus=
t-depend-on-acpi arch/i386/kernel/cpu/cpufreq/Kconfig
--- a/arch/i386/kernel/cpu/cpufreq/Kconfig~x86_powernow_k8_acpi-must-de=
pend-on-acpi
+++ a/arch/i386/kernel/cpu/cpufreq/Kconfig
@@ -92,7 +92,7 @@ config X86_POWERNOW_K8
 config X86_POWERNOW_K8_ACPI
 	bool "ACPI Support"
 	select ACPI_PROCESSOR
-	depends on X86_POWERNOW_K8
+	depends on ACPI && X86_POWERNOW_K8
 	default y
 	help
 	  This provides access to the K8s Processor Performance States via AC=
PI.
_
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
