From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Reading EeePC900 battery info causes stalls
Date: Thu, 25 Sep 2008 18:57:40 +0400
Message-ID: <48DBA6E4.80008@gmail.com>
References: <gbduo8$nj4$1@ger.gmane.org> <48DB5032.8020604@gmail.com> <48DB5B90.9060607@yahoo.com> <48DB5FEE.4000404@gmail.com> <48DB710A.2060206@gmail.com> <48DB7C5A.6070900@yahoo.com> <48DB7D91.4000206@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030309020305030208060304"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:48397 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825AbYIYO5m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 10:57:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so180988nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 07:57:39 -0700 (PDT)
In-Reply-To: <48DB7D91.4000206@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030309020305030208060304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alexey Starikovskiy wrote:
> Sitsofe Wheeler wrote:
>> Alexey Starikovskiy wrote:
>>> acpi_ps_parse_aml() is called not so often (~10000usec), so maybe it 
>>> is a "sweet spot"
>>
>> The latency is pretty bad with this patch (assuming you did not want 
>> it applied on top of your previous patch)
>>
>> Here's the tail end of a full trace:
>> http://sucs.org/~sits/test/eeepc-debug/20080925/1250/latency_trace_all_tail.gz 
>> (3.3Mbytes but close 100Mbytes when decompressed)
>>  latency: 2912285 us, #1000038/5344107, CPU#0 | (M:desktop VP:0, 
>> KP:0, SP:0 HP:0
>> )
>>
>> Here's a complete (but filtered) trace:
>> http://sucs.org/~sits/test/eeepc-debug/20080925/1250/latency_trace.gz
>>  latency: 315814 us, #227600/227600, CPU#0 | (M:desktop VP:0, KP:0, 
>> SP:0 HP:0)
>>
> Ok, let's stick with previous patch then.
> It will be somewhat difficult to push though, because the code we 
> touched belongs to ACPICA (multi-platform code),
> so should not contain explicit Linux-only operands.
> If you agree that the place is right, I'll make proper patch with all 
> needed redirections to
> make ACPICA happy.
Ok, here is the ACPICA-friendly patch, please check if it's still good.

Regards,
Alex.

--------------030309020305030208060304
Content-Type: text/x-diff;
 name="acpica_preemption_point.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpica_preemption_point.patch"

ACPICA: add preemption point after each opcode parse

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/parser/psloop.c    |    2 ++
 include/acpi/acmacros.h         |    5 +++++
 include/acpi/platform/aclinux.h |    6 ++++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index c06238e..4647039 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -719,6 +719,8 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 		*op = NULL;
 	}
 
+	ACPI_PREEMPTION_POINT();
+
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 57ab9e9..b402685 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -703,4 +703,9 @@ struct acpi_integer_overlay {
 
 #endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
 
+/* Preemption point */
+#ifndef ACPI_PREEMPTION_POINT
+#define ACPI_PREEMPTION_POINT() /* no preemption */
+#endif
+
 #endif				/* ACMACROS_H */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 9af4645..029c8c0 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -53,6 +53,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
+#include <linux/sched.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/div64.h>
@@ -137,4 +138,9 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 #define ACPI_ALLOCATE_ZEROED(a)	acpi_os_allocate_zeroed(a)
 #define ACPI_FREE(a)		kfree(a)
 
+/*
+ * We need to show where it is safe to preempt execution of ACPICA
+ */
+#define ACPI_PREEMPTION_POINT()	cond_resched()
+
 #endif				/* __ACLINUX_H__ */

--------------030309020305030208060304--
