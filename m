From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.12-rc2-mm2
Date: Fri, 8 Apr 2005 15:21:26 -0700
Message-ID: <20050408152126.3b1c03ac.akpm@osdl.org>
References: <20050408030835.4941cd98.akpm@osdl.org>
	<425691BD.9080507@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <425691BD.9080507-wDE+IXx/zk/R7s880joybQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Dittmer <j.dittmer-wDE+IXx/zk/R7s880joybQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Jan Dittmer <j.dittmer-wDE+IXx/zk/R7s880joybQ@public.gmane.org> wrote:
>
> Andrew Morton wrote:
> > - The bk-acpi patch here causes my ia64 test box to hang during boot
> 
> >  bk-ia64.patch
> 
> ia64 defconfig does not even build anymore:
> 
> 
>   CC [M]  drivers/char/agp/hp-agp.o
> In file included from /usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:18:
> include2/asm/acpi-ext.h:15: error: parse error before "hp_acpi_csr_space"
> include2/asm/acpi-ext.h:15: error: parse error before "u64"
> include2/asm/acpi-ext.h:15: warning: type defaults to `int' in declaration of `hp_acpi_csr_space'

I suppose this is needed.

--- 25/include/asm-ia64/acpi-ext.h~acpi-ext-build-fix	Fri Apr  8 15:19:43 2005
+++ 25-akpm/include/asm-ia64/acpi-ext.h	Fri Apr  8 15:20:12 2005
@@ -11,6 +11,7 @@
 #define _ASM_IA64_ACPI_EXT_H
 
 #include <linux/types.h>
+#include <acpi/actypes.h>
 
 extern acpi_status hp_acpi_csr_space (acpi_handle, u64 *base, u64 *length);
 
_



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
