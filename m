From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date: Tue, 11 Sep 2018 13:32:14 -0600
Message-ID: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, jeremy.linton@arm.com
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org, Jeffrey Hugo <jhugo@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

The type of a cache might not be specified by architectural mechanisms (ie
system registers), but its type might be specified in the PPTT.  In this
case, following the PPTT specification, we should identify the cache as
the type specified by PPTT.

This fixes the following lscpu issue where only the cache type sysfs file
is missing which results in no output providing a poor user experience in
the above system configuration-
lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
file or directory

Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/acpi/pptt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index d1e26cb..3c6db09 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -401,6 +401,21 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 			break;
 		}
 	}
+	if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
+	    (found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
+		switch (found_cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) {
+		case ACPI_PPTT_CACHE_TYPE_DATA:
+			this_leaf->type = CACHE_TYPE_DATA;
+			break;
+		case ACPI_PPTT_CACHE_TYPE_INSTR:
+			this_leaf->type = CACHE_TYPE_INST;
+			break;
+		case ACPI_PPTT_CACHE_TYPE_UNIFIED:
+		case ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT:
+			this_leaf->type = CACHE_TYPE_UNIFIED;
+			break;
+		}
+	}
 	/*
 	 * If the above flags are valid, and the cache type is NOCACHE
 	 * update the cache type as well.
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
