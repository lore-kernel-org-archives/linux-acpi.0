From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] acpi : remove power from acpi_processor_cx structure
Date: Tue, 24 Jul 2012 23:12:29 +0200
Message-ID: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:62596 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab2GXVMd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jul 2012 17:12:33 -0400
Received: by weyx8 with SMTP id x8so15263wey.19
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jul 2012 14:12:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xensource.com, linux-pm@vger.kernel.org, konrad.wilk@oracle.com, patches@linaro.org, linaro-dev@lists.linaro.org

Remove the power field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/acpi/processor_idle.c    |    2 --
 drivers/xen/xen-acpi-processor.c |    1 -
 include/acpi/processor.h         |    1 -
 3 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e589c19..90582fb 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -483,8 +483,6 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
-		cx.power = obj->integer.value;
-
 		current_count++;
 		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
 
diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index 7ff2569..7ef9c1d 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -98,7 +98,6 @@ static int push_cxx_to_hypervisor(struct acpi_processor *_pr)
 
 		dst_cx->type = cx->type;
 		dst_cx->latency = cx->latency;
-		dst_cx->power = cx->power;
 
 		dst_cx->dpcnt = 0;
 		set_xen_guest_handle(dst_cx->dp, NULL);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 64ec644..db427fa 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -59,7 +59,6 @@ struct acpi_processor_cx {
 	u8 entry_method;
 	u8 index;
 	u32 latency;
-	u32 power;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
 };
-- 
1.7.5.4

