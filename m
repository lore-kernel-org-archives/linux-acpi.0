From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/3] acpi: check _PSS invalidation when BIOS report _PSS
 with 0x80000000
Date: Tue, 26 May 2009 15:36:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905261535010.4215@localhost.localdomain>
References: <200905122054.n4CKsfa3001669@imap1.linux-foundation.org>
 <alpine.LFD.2.00.0905141335000.24833@localhost.localdomain>
 <20090514154412.fee72568.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55779 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbZEZT4b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 May 2009 15:56:31 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KK900BQWNSQU6W1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 26 May 2009 14:36:32 -0500 (CDT)
In-reply-to: <20090514154412.fee72568.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, youquan.song@intel.com, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

From: Len Brown <len.brown@intel.com>
Subject: [PATCH] ACPI: sanity check _PSS frequency to prevent cpufreq crash

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

I think this is a better patch for this issue.

thanks,
-Len

 drivers/acpi/processor_perflib.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index cafb410..160f9ed 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -309,9 +309,13 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 				  (u32) px->bus_master_latency,
 				  (u32) px->control, (u32) px->status));
 
-		if (!px->core_frequency) {
-			printk(KERN_ERR PREFIX
-				    "Invalid _PSS data: freq is zero\n");
+		/*
+ 		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
+		 */
+		if (!px->core_frequency ||
+			((u32)(px->core_frequency * 1000) != (px->core_frequency * 1000))) {
+			printk(KERN_ERR FW_BUG PREFIX
+				    "Invalid BIOS _PSS frequency: 0x%llx MHz\n", px->core_frequency);
 			result = -EFAULT;
 			kfree(pr->performance->states);
 			goto end;
-- 
1.6.3.1.169.g33fd


