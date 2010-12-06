From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 7/7] ACPI processor: remove unused function
Date: Mon, 06 Dec 2010 15:04:30 +0800
Message-ID: <1291619070.19296.582.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14508 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0LFHHk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 02:07:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

drivers/acpi/processor_thermal.c:159:12: warning: =E2=80=98acpi_thermal=
_cpufreq_increase=E2=80=99 defined but not used
drivers/acpi/processor_thermal.c:163:12: warning: =E2=80=98acpi_thermal=
_cpufreq_decrease=E2=80=99 defined but not used

Remove unused declaration of =E2=80=98acpi_thermal_cpufreq_increase=E2=80=
=99 and
=E2=80=98acpi_thermal_cpufreq_decrease=E2=80=99

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_thermal.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: linux-2.6/drivers/acpi/processor_thermal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/processor_thermal.c
+++ linux-2.6/drivers/acpi/processor_thermal.c
@@ -156,15 +156,6 @@ static int cpufreq_set_cur_state(unsigne
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


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
