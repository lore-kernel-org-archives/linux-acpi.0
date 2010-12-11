From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/15] ACPI thermal: remove two unused functions
Date: Sat, 11 Dec 2010 02:06:37 -0500
Message-ID: <b9047599695ae835252ba3d6a19eada98c19dc89.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33716 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0LKHwu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:52:50 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900699780NVJ2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:52:49 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

=46rom: Zhang Rui <rui.zhang@intel.com>

When CONFIG_CPU_FREQ=3Dn ...

drivers/acpi/processor_thermal.c:159:12: warning: =E2=80=98acpi_thermal=
_cpufreq_increase=E2=80=99 defined but not used
drivers/acpi/processor_thermal.c:163:12: warning: =E2=80=98acpi_thermal=
_cpufreq_decrease=E2=80=99 defined but not used

Remove unused declaration of =E2=80=98acpi_thermal_cpufreq_increase=E2=80=
=99 and
=E2=80=98acpi_thermal_cpufreq_decrease=E2=80=99

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_thermal.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_=
thermal.c
index fde49b9..79cb653 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -156,15 +156,6 @@ static int cpufreq_set_cur_state(unsigned int cpu,=
 int state)
 	return 0;
 }
=20
-static int acpi_thermal_cpufreq_increase(unsigned int cpu)
-{
-	return -ENODEV;
-}
-static int acpi_thermal_cpufreq_decrease(unsigned int cpu)
-{
-	return -ENODEV;
-}
-
 #endif
=20
 int acpi_processor_get_limit_info(struct acpi_processor *pr)
--=20
1.7.3.3.480.g2f76a

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
