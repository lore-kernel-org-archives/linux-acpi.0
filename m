From: Len Brown <lenb@kernel.org>
Subject: [PATCH 59/65] ACPI: sanity check _PSS frequency to prevent cpufreq
 crash
Date: Fri, 29 May 2009 21:42:37 -0400
Message-ID: <34d531e640cb805973cf656b15c716b961565cea.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757372AbZE3BnF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:05 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00CSMORR4TY3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:04 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

When BIOS SETUP is changed to disable EIST, some BIOS
hand the OS an un-initialized _PSS:

        Name (_PSS, Package (0x06)
        {
            Package (0x06)
            {
                0x80000000,	// frequency [MHz]
                0x80000000,	// power [mW]
                0x80000000,	// latency [us]
                0x80000000,	// BM latency [us]
                0x80000000,	// control
                0x80000000	// status
            },
	    ...

These are outrageous values for frequency,
power and latency, raising the question where to draw
the line between legal and illegal.  We tend to survive
garbage in the power and latency fields, but we can BUG_ON
when garbage is in the frequency field.

Cpufreq multiplies the frequency by 1000 and stores it in a u32 KHz.
So disregard a _PSS with a frequency so large
that it can't be represented by cpufreq.

https://bugzilla.redhat.com/show_bug.cgi?id=500311

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_perflib.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index cafb410..60e543d 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -309,9 +309,15 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 				  (u32) px->bus_master_latency,
 				  (u32) px->control, (u32) px->status));
 
-		if (!px->core_frequency) {
-			printk(KERN_ERR PREFIX
-				    "Invalid _PSS data: freq is zero\n");
+		/*
+ 		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
+		 */
+		if (!px->core_frequency ||
+		    ((u32)(px->core_frequency * 1000) !=
+		     (px->core_frequency * 1000))) {
+			printk(KERN_ERR FW_BUG PREFIX
+			       "Invalid BIOS _PSS frequency: 0x%llx MHz\n",
+			       px->core_frequency);
 			result = -EFAULT;
 			kfree(pr->performance->states);
 			goto end;
-- 
1.6.0.6

