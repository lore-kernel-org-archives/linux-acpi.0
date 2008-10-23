From: Len Brown <lenb@kernel.org>
Subject: [PATCH 003/122] CPUFREQ: powernow-k8: Try to detect old BIOS,
 not supporting CPU freq on a recent AMD CPUs.
Date: Thu, 23 Oct 2008 02:37:37 -0400
Message-ID: <2fd47094f92fa2bdbf99be33294a7b6b97785a70.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58020 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbYJWGjn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:43 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KE7II6S772@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:43 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Make use of FW_BUG interface to give vendors and users the ability to
automatically check for powernow-k8 related BIOS bugs by:
dmesg |grep "Firmware Bug"

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/powernow-k8.c |   42 ++++++++++++++++------------
 1 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/powernow-k8.c b/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
index 84bb395..4e0c6ab 100644
--- a/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
+++ b/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
@@ -45,7 +45,6 @@
 #endif
 
 #define PFX "powernow-k8: "
-#define BFX PFX "BIOS error: "
 #define VERSION "version 2.20.00"
 #include "powernow-k8.h"
 
@@ -536,35 +535,40 @@ static int check_pst_table(struct powernow_k8_data *data, struct pst_s *pst, u8
 
 	for (j = 0; j < data->numps; j++) {
 		if (pst[j].vid > LEAST_VID) {
-			printk(KERN_ERR PFX "vid %d invalid : 0x%x\n", j, pst[j].vid);
+			printk(KERN_ERR FW_BUG PFX "vid %d invalid : 0x%x\n",
+			       j, pst[j].vid);
 			return -EINVAL;
 		}
 		if (pst[j].vid < data->rvo) {	/* vid + rvo >= 0 */
-			printk(KERN_ERR BFX "0 vid exceeded with pstate %d\n", j);
+			printk(KERN_ERR FW_BUG PFX "0 vid exceeded with pstate"
+			       " %d\n", j);
 			return -ENODEV;
 		}
 		if (pst[j].vid < maxvid + data->rvo) {	/* vid + rvo >= maxvid */
-			printk(KERN_ERR BFX "maxvid exceeded with pstate %d\n", j);
+			printk(KERN_ERR FW_BUG PFX "maxvid exceeded with pstate"
+			       " %d\n", j);
 			return -ENODEV;
 		}
 		if (pst[j].fid > MAX_FID) {
-			printk(KERN_ERR BFX "maxfid exceeded with pstate %d\n", j);
+			printk(KERN_ERR FW_BUG PFX "maxfid exceeded with pstate"
+			       " %d\n", j);
 			return -ENODEV;
 		}
 		if (j && (pst[j].fid < HI_FID_TABLE_BOTTOM)) {
 			/* Only first fid is allowed to be in "low" range */
-			printk(KERN_ERR BFX "two low fids - %d : 0x%x\n", j, pst[j].fid);
+			printk(KERN_ERR FW_BUG PFX "two low fids - %d : "
+			       "0x%x\n", j, pst[j].fid);
 			return -EINVAL;
 		}
 		if (pst[j].fid < lastfid)
 			lastfid = pst[j].fid;
 	}
 	if (lastfid & 1) {
-		printk(KERN_ERR BFX "lastfid invalid\n");
+		printk(KERN_ERR FW_BUG PFX "lastfid invalid\n");
 		return -EINVAL;
 	}
 	if (lastfid > LO_FID_TABLE_TOP)
-		printk(KERN_INFO BFX  "first fid not from lo freq table\n");
+		printk(KERN_INFO FW_BUG PFX  "first fid not from lo freq table\n");
 
 	return 0;
 }
@@ -672,13 +676,13 @@ static int find_psb_table(struct powernow_k8_data *data)
 
 		dprintk("table vers: 0x%x\n", psb->tableversion);
 		if (psb->tableversion != PSB_VERSION_1_4) {
-			printk(KERN_ERR BFX "PSB table is not v1.4\n");
+			printk(KERN_ERR FW_BUG PFX "PSB table is not v1.4\n");
 			return -ENODEV;
 		}
 
 		dprintk("flags: 0x%x\n", psb->flags1);
 		if (psb->flags1) {
-			printk(KERN_ERR BFX "unknown flags\n");
+			printk(KERN_ERR FW_BUG PFX "unknown flags\n");
 			return -ENODEV;
 		}
 
@@ -705,7 +709,7 @@ static int find_psb_table(struct powernow_k8_data *data)
 			}
 		}
 		if (cpst != 1) {
-			printk(KERN_ERR BFX "numpst must be 1\n");
+			printk(KERN_ERR FW_BUG PFX "numpst must be 1\n");
 			return -ENODEV;
 		}
 
@@ -1130,17 +1134,19 @@ static int __cpuinit powernowk8_cpu_init(struct cpufreq_policy *pol)
 			       "ACPI Processor module before starting this "
 			       "driver.\n");
 #else
-			printk(KERN_ERR PFX "Your BIOS does not provide ACPI "
-			       "_PSS objects in a way that Linux understands. "
-			       "Please report this to the Linux ACPI maintainers"
-			       " and complain to your BIOS vendor.\n");
+			printk(KERN_ERR FW_BUG PFX "Your BIOS does not provide"
+			       " ACPI _PSS objects in a way that Linux "
+			       "understands. Please report this to the Linux "
+			       "ACPI maintainers and complain to your BIOS "
+			       "vendor.\n");
 #endif
 			kfree(data);
 			return -ENODEV;
 		}
 		if (pol->cpu != 0) {
-			printk(KERN_ERR PFX "No ACPI _PSS objects for CPU other than "
-			       "CPU0. Complain to your BIOS vendor.\n");
+			printk(KERN_ERR FW_BUG PFX "No ACPI _PSS objects for "
+			       "CPU other than CPU0. Complain to your BIOS "
+			       "vendor.\n");
 			kfree(data);
 			return -ENODEV;
 		}
@@ -1193,7 +1199,7 @@ static int __cpuinit powernowk8_cpu_init(struct cpufreq_policy *pol)
 
 	/* min/max the cpu is capable of */
 	if (cpufreq_frequency_table_cpuinfo(pol, data->powernow_table)) {
-		printk(KERN_ERR PFX "invalid powernow_table\n");
+		printk(KERN_ERR FW_BUG PFX "invalid powernow_table\n");
 		powernow_k8_cpu_exit_acpi(data);
 		kfree(data->powernow_table);
 		kfree(data);
-- 
1.5.5.1

