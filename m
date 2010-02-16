From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/10] ACPI: processor: add kernel command line support for
 early _PDC eval
Date: Tue, 16 Feb 2010 04:46:01 -0500
Message-ID: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
References: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:57026 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab0BPJqO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 04:46:14 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX00H6DHT164G0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 03:46:14 -0600 (CST)
In-reply-to: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

Allow platforms not listed in DMI table
to opt-in and evaluate _PDC early.

Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/acpi/processor_pdc.c        |    7 +++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 736d456..826b6e1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -199,6 +199,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			acpi_display_output=video
 			See above.
 
+	acpi_early_pdc_eval	[HW,ACPI] Evaluate processor _PDC methods
+				early. Needed on some platforms to properly
+				initialize the EC.
+
 	acpi_irq_balance [HW,ACPI]
 			ACPI will balance active IRQs
 			default in APIC mode
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 7247819..3bbafe9 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -151,6 +151,13 @@ static int set_early_pdc_optin(const struct dmi_system_id *id)
 	return 0;
 }
 
+static int param_early_pdc_optin(char *s)
+{
+	early_pdc_optin = 1;
+	return 1;
+}
+__setup("acpi_early_pdc_eval", param_early_pdc_optin);
+
 static struct dmi_system_id __cpuinitdata early_pdc_optin_table[] = {
 	{
 	set_early_pdc_optin, "HP Envy", {
-- 
1.6.0.6

