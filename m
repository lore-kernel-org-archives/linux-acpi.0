From: akpm@linux-foundation.org
Subject: [patch 10/10] acpi: fix drivers/acpi/glue.c build error
Date: Fri, 02 May 2008 13:31:43 -0700
Message-ID: <200805022031.m42KVhPN013078@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40978 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765206AbYEBUcP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 May 2008 16:32:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, mingo@elte.hu, bjorn.helgaas@hp.com

From: Ingo Molnar <mingo@elte.hu>

x86.git testing found the following build bug:

  drivers/built-in.o: In function `acpi_rtc_init':
  glue.c:(.init.text+0x16c3): undefined reference to `pnp_bus_type'

this tries to use PNP bus infrastructure even in the !PNP case.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/glue.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN drivers/acpi/glue.c~acpi-fix-drivers-acpi-gluec-build-error drivers/acpi/glue.c
--- a/drivers/acpi/glue.c~acpi-fix-drivers-acpi-gluec-build-error
+++ a/drivers/acpi/glue.c
@@ -299,6 +299,7 @@ static void rtc_wake_off(struct device *
 
 static struct cmos_rtc_board_info rtc_info;
 
+#ifdef CONFIG_PNP
 
 /* PNP devices are registered in a subsys_initcall();
  * ACPI specifies the PNP IDs to use.
@@ -360,4 +361,6 @@ static int __init acpi_rtc_init(void)
 /* do this between RTC subsys_initcall() and rtc_cmos driver_initcall() */
 fs_initcall(acpi_rtc_init);
 
+#endif /* CONFIG_PNP */
+
 #endif
_
