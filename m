From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] include/asm-i386/acpi.h should #include <asm/processor.h>
Date: Wed, 28 Jun 2006 18:54:18 +0200
Message-ID: <20060628165418.GJ13915@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751412AbWF1QyV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm1:
>...
> +cpu_relax-use-in-acpi-lock.patch
>...
>  ACPI stuff
>...

This patch fixes the following issue:

<--  snip  -->

=2E..
  CC      arch/i386/mach-visws/mpparse.o
In file included from include/asm/fixmap.h:26,
                 from include/asm/smp.h:15,
                 from arch/i386/mach-visws/mpparse.c:6:
include/asm/acpi.h: In function =E2=80=98__acpi_acquire_global_lock=E2=80=
=99:
include/asm/acpi.h:70: warning: implicit declaration of function =E2=80=
=98cpu_relax=E2=80=99
=2E..

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm2/include/asm-i386/acpi.h.old	2006-06-26 23:00:40.00=
0000000 +0200
+++ linux-2.6.17-mm2/include/asm-i386/acpi.h	2006-06-26 23:01:04.000000=
000 +0200
@@ -31,6 +31,7 @@
 #include <acpi/pdc_intel.h>
=20
 #include <asm/system.h>		/* defines cmpxchg */
+#include <asm/processor.h>
=20
 #define COMPILER_DEPENDENT_INT64   long long
 #define COMPILER_DEPENDENT_UINT64  unsigned long long
