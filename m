From: Alex Shi <alex.shi@intel.com>
Subject: Re: [LKP] Commit ac3ebafa81a makes NHM EX/EP machines hung out since
 3.9-rc1
Date: Tue, 26 Mar 2013 23:21:52 +0800
Message-ID: <5151BD10.3000108@intel.com>
References: <20130313022759.GA120840@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25680 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964869Ab3CZPV4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 11:21:56 -0400
In-Reply-To: <20130313022759.GA120840@bee>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Changlong Xie <changlongx.xie@intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, lkp@linux.intel.com

On 03/13/2013 10:27 AM, Changlong Xie wrote:
> Hi Len,
> 
> 	FYI, since 3.9-rc1 our three NHM EP/EX LKP(linux kernel performance) test servers 
> 	except SNB/IVB/WSM hung up unexpectly. 
> 

the following draft patch can fix the panic, so it proved we still need the percpu cstate.

but look at the struct acpi_processor_cx {
        u8 valid;
        u8 type;
        u32 address;
        u8 entry_method;
        u8 index;
        u32 latency;
        u8 bm_sts_skip;
        char desc[ACPI_CX_DESC_LEN];
};

I have printed all members except the last one. all of them are same on all cpu.
It's interesting. 


-----------

>From 5a4fc23fdf5202f8555a25a03afc4d06ac168032 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@intel.com>
Date: Tue, 26 Mar 2013 22:57:47 +0800
Subject: [PATCH] acpi: abc

---
 drivers/acpi/processor_idle.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index fc95308..61373ab 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -66,7 +66,7 @@ module_param(latency_factor, uint, 0644);
 
 static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
 
-static struct acpi_processor_cx *acpi_cstate[CPUIDLE_STATE_MAX];
+static DEFINE_PER_CPU (struct acpi_processor_cx *[CPUIDLE_STATE_MAX], acpi_cstate);
 
 static int disabled_by_idle_boot_param(void)
 {
@@ -722,9 +722,10 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
-	struct acpi_processor_cx *cx = acpi_cstate[index];
+	struct acpi_processor_cx *cx;
 
 	pr = __this_cpu_read(processors);
+ 	cx = per_cpu(acpi_cstate[index], pr->id);
 
 	if (unlikely(!pr))
 		return -EINVAL;
@@ -745,7 +746,8 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
  */
 static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 {
-	struct acpi_processor_cx *cx = acpi_cstate[index];
+	struct acpi_processor_cx *cx;
+ 	cx = per_cpu(acpi_cstate[index], dev->cpu);
 
 	ACPI_FLUSH_CPU_CACHE();
 
@@ -775,9 +777,10 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
-	struct acpi_processor_cx *cx = acpi_cstate[index];
+	struct acpi_processor_cx *cx;
 
 	pr = __this_cpu_read(processors);
+ 	cx = per_cpu(acpi_cstate[index], pr->id);
 
 	if (unlikely(!pr))
 		return -EINVAL;
@@ -833,9 +836,10 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
-	struct acpi_processor_cx *cx = acpi_cstate[index];
+	struct acpi_processor_cx *cx;
 
 	pr = __this_cpu_read(processors);
+ 	cx = per_cpu(acpi_cstate[index], pr->id);
 
 	if (unlikely(!pr))
 		return -EINVAL;
@@ -960,7 +964,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
 			continue;
 #endif
-		acpi_cstate[count] = cx;
+		per_cpu(acpi_cstate[count], dev->cpu) = cx;
 
 		count++;
 		if (count == CPUIDLE_STATE_MAX)
-- 
1.7.5.4

