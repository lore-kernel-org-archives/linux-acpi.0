From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Fix a print format error in the ACPI PM clocksource driver
	and check range
Date: Fri, 11 Jul 2008 10:57:17 +0100
Message-ID: <20080711095717.21251.86648.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:43341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbYGKJ5j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jul 2008 05:57:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, akpm@linux-foundation.org
Cc: dhowells@redhat.com, johnstul@us.ibm.com, linux-acpi@vger.kernel.org

Fix a print format error in the ACPI PM clocksource driver:

drivers/clocksource/acpi_pm.c:231: warning: format '%04lx' expects type 'long unsigned int', but argument 2 has type 'u32'

This was introduced in patch 6b148507d3d042a3c11f4c3f6c0f649c6a89220d.

And check that the value being passed to parse_pmtmr() does not exceed the
limits of pmtmr_ioport.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/clocksource/acpi_pm.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)


diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 3baee02..71f2dc2 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -227,7 +227,12 @@ static int __init parse_pmtmr(char *arg)
 	if (strict_strtoul(arg, 16, &base))
 		return -EINVAL;
 
-	printk(KERN_INFO "PMTMR IOPort override: 0x%04lx -> 0x%04lx\n",
+#ifdef CONFIG_X86_64
+	if (base > UINT_MAX)
+		return -ERANGE;
+#endif
+
+	printk(KERN_INFO "PMTMR IOPort override: 0x%04x -> 0x%04lx\n",
 	       pmtmr_ioport, base);
 	pmtmr_ioport = base;
 

