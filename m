From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPICA: Windows compatibility fix: same buffer/string store
Date: Wed, 26 Aug 2009 09:01:34 +0800
Message-ID: <1251248494.17754.14.camel@minggr.sh.intel.com>
References: <B9D7F88A26B04740A56A35A34719F3AFE09E7D@AUSX3MPS330.aus.amer.dell.com>
	 <B9D7F88A26B04740A56A35A34719F3AF01052A9F@AUSX3MPS330.aus.amer.dell.com>
	 <E87738D94A6AD54789B5B8D1BAEB06CC5C74808741@azsmsx503.amr.corp.intel.com>
	 <B9D7F88A26B04740A56A35A34719F3AF010901C6@AUSX3MPS330.aus.amer.dell.com>
	 <1249956889.7853.2.camel@rzhang-dt>
	 <B9D7F88A26B04740A56A35A34719F3AF01090463@AUSX3MPS330.aus.amer.dell.com>
	 <1250045983.7853.68.camel@rzhang-dt>
	 <B9D7F88A26B04740A56A35A34719F3AF01090704@AUSX3MPS330.aus.amer.dell.com>
	 <037F493892196B458CD3E193E8EBAD4F01EAB64667@pdsmsx502.ccr.corp.intel.com>
	 <B9D7F88A26B04740A56A35A34719F3AF0110BCD1@AUSX3MPS330.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10147 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbZHZBGm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Aug 2009 21:06:42 -0400
In-Reply-To: <B9D7F88A26B04740A56A35A34719F3AF0110BCD1@AUSX3MPS330.aus.amer.dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Rezwanul_Kabir@Dell.com" <Rezwanul_Kabir@Dell.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi, Len

This is the important fix for the WMI based HotKey issue reported by Dell.
Could you merge it to 2.6.31-rc8?

Thanks,
Lin Ming
---

Subject: [PATCH] ACPICA: Windows compatibility fix: same buffer/string store

Fixes a compatibility issue when the same buffer or string is
stored to itself. This has been seen in the field. Previously,
ACPICA would zero out the buffer/string. Now, the operation is
treated as a noop. ACPICA BZ 803.

http://bugzilla.acpica.org/show_bug.cgi?id=803

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exstorob.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/exstorob.c b/drivers/acpi/acpica/exstorob.c
index 67340cc..257706e 100644
--- a/drivers/acpi/acpica/exstorob.c
+++ b/drivers/acpi/acpica/exstorob.c
@@ -70,6 +70,12 @@ acpi_ex_store_buffer_to_buffer(union acpi_operand_object *source_desc,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_store_buffer_to_buffer, source_desc);
 
+	/* If Source and Target are the same, just return */
+
+	if (source_desc == target_desc) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* We know that source_desc is a buffer by now */
 
 	buffer = ACPI_CAST_PTR(u8, source_desc->buffer.pointer);
@@ -161,6 +167,12 @@ acpi_ex_store_string_to_string(union acpi_operand_object *source_desc,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_store_string_to_string, source_desc);
 
+	/* If Source and Target are the same, just return */
+
+	if (source_desc == target_desc) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* We know that source_desc is a string by now */
 
 	buffer = ACPI_CAST_PTR(u8, source_desc->string.pointer);


