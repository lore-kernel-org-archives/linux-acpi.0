From: Adam Belay <abelay@novell.com>
Subject: [PATCH 4/6] CPUIDLE: max_cstate fix
Date: Tue, 21 Aug 2007 18:25:58 -0400
Message-ID: <1187735158.7199.52.camel@callisto.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from peabody.ximian.com ([130.57.169.10]:43644 "EHLO
	peabody.ximian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbXHUWcp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Aug 2007 18:32:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brown@vger.kernel.org, Len <len.brown@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Shaohua Li <shaohua.li@intel.com>

Currently max_cstate is limited to 0, resulting in no idle processor
power management on ACPI platforms.  This patch restores the value to
the array size.

Please Apply,
Adam

Change Summary:
 processor_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---

diff -urN a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c	2007-08-14 15:53:48.000000000 -0400
+++ b/drivers/acpi/processor_idle.c	2007-08-14 16:00:48.000000000 -0400
@@ -67,7 +67,7 @@
 #define C2_OVERHEAD			1	/* 1us */
 #define C3_OVERHEAD			1	/* 1us */
 
-static unsigned int max_cstate __read_mostly;
+static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0000);
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);


