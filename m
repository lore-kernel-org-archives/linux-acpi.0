From: hotran <hotran@apm.com>
Subject: [PATCH] ACPICA: ACPI 6.1: Add PCC HW-Reduced Communication Subspace Type 2
Date: Fri,  8 Apr 2016 14:00:05 -0700
Message-ID: <1460149205-10502-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33946 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbcDHVAe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Apr 2016 17:00:34 -0400
Received: by mail-pf0-f178.google.com with SMTP id c20so82472258pfc.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 Apr 2016 14:00:34 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: lho@apm.com, hotran@apm.com, dhdang@apm.com

ACPI 6.1 PCC has a HW-Reduced Communication Subspace Type 2 intended for
using on HW-Reduce ACPI Platform, which requires read-modify-write sequence
to acknowledge doorbell interrupt. This patch adds the Communication
Subspace Type 2.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 include/acpi/actbl3.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index ddf5e66..5937075 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -476,7 +476,8 @@ struct acpi_table_pcct {
 enum acpi_pcct_type {
 	ACPI_PCCT_TYPE_GENERIC_SUBSPACE = 0,
 	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE = 1,
-	ACPI_PCCT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
+	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2 = 2,
+	ACPI_PCCT_TYPE_RESERVED = 3	/* 3 and greater are reserved */
 };
 
 /*
@@ -498,7 +499,7 @@ struct acpi_pcct_subspace {
 	u16 min_turnaround_time;
 };
 
-/* 1: HW-reduced Communications Subspace (ACPI 5.1) */
+/* 1 or 2: HW-reduced Communications Subspace (ACPI 6.1) */
 
 struct acpi_pcct_hw_reduced {
 	struct acpi_subtable_header header;
@@ -513,6 +514,9 @@ struct acpi_pcct_hw_reduced {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
+	struct acpi_generic_address doorbell_ack_register;
+	u64 ack_preserve_mask;
+	u64 ack_write_mask;
 };
 
 /* Values for doorbell flags above */
-- 
1.9.1


-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
