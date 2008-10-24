From: Miao Xie <miaox@cn.fujitsu.com>
Subject: [PATCH] ACPI: cpufreq, processor: fix compile error in drivers/acpi/processor_perflib.c
Date: Fri, 24 Oct 2008 17:22:04 +0800
Message-ID: <490193BC.70108@cn.fujitsu.com>
Reply-To: miaox@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:49572 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbYJXJ05 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Oct 2008 05:26:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, trenn@suse.de

When trying to build 2.6.28-rc1 on ia64, make aborts with:

  CC      drivers/acpi/processor_perflib.o
  drivers/acpi/processor_perflib.c:41:28: error: asm/cpufeature.h: No s=
uch file or directory
  drivers/acpi/processor_perflib.c: In function =E2=80=98acpi_processor=
_get_performance_info=E2=80=99:
  drivers/acpi/processor_perflib.c:364: error: implicit declaration of =
function =E2=80=98boot_cpu_has=E2=80=99
  drivers/acpi/processor_perflib.c:364: error: =E2=80=98X86_FEATURE_EST=
=E2=80=99 undeclared (first use in this function)
  drivers/acpi/processor_perflib.c:364: error: (Each undeclared identif=
ier is reported only once
  drivers/acpi/processor_perflib.c:364: error: for each function it app=
ears in.)
  make[2]: *** [drivers/acpi/processor_perflib.o] Error 1
  make[1]: *** [drivers/acpi] Error 2
  make: *** [drivers] Error 2

this patch fix it.

Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
Cc: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/processor_perflib.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_=
perflib.c
index dc98f7a..dbcf260 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -38,7 +38,10 @@
=20
 #include <asm/uaccess.h>
 #endif
+
+#ifdef CONFIG_X86
 #include <asm/cpufeature.h>
+#endif
=20
 #include <acpi/acpi_bus.h>
 #include <acpi/processor.h>
@@ -360,11 +363,13 @@ static int acpi_processor_get_performance_info(st=
ruct acpi_processor *pr)
 	 * the BIOS is older than the CPU and does not know its frequencies
 	 */
  update_bios:
+#ifdef CONFIG_X86
 	if (ACPI_SUCCESS(acpi_get_handle(pr->handle, "_PPC", &handle))){
 		if(boot_cpu_has(X86_FEATURE_EST))
 			printk(KERN_WARNING FW_BUG "BIOS needs update for CPU "
 			       "frequency support\n");
 	}
+#endif
 	return result;
 }
=20
--=20
1.5.4.rc3



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
