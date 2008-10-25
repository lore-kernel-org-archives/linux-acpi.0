From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/9] ACPI: cpufreq,
 processor: fix compile error in drivers/acpi/processor_perflib.c
Date: Sat, 25 Oct 2008 04:13:34 -0400
Message-ID: <16be87ea170ae6cfaa9f47f79d14f7577d8cb420.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:41693 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbYJYINo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:13:44 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9A00EIJC6VTSK6@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:13:43 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
In-reply-to: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Miao Xie <miaox@cn.fujitsu.com>, Len Brown <len.brown@intel.com>

=46rom: Miao Xie <miaox@cn.fujitsu.com>

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
Acked-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
