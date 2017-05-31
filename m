From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] ACPI / bus: Switch to use new generic UUID API
Date: Wed, 31 May 2017 22:41:50 +0300
Message-ID: <20170531194152.65927-4-andriy.shevchenko@linux.intel.com>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:50341 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdEaTl6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 15:41:58 -0400
In-Reply-To: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki " <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 784bda663d16..042cd16265b3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -225,13 +225,13 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 	struct acpi_object_list input;
 	union acpi_object in_params[4];
 	union acpi_object *out_obj;
-	u8 uuid[16];
+	guid_t guid;
 	u32 errors;
 	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
 
 	if (!context)
 		return AE_ERROR;
-	if (ACPI_FAILURE(acpi_str_to_uuid(context->uuid_str, uuid)))
+	if (guid_parse(context->uuid_str, &guid))
 		return AE_ERROR;
 	context->ret.length = ACPI_ALLOCATE_BUFFER;
 	context->ret.pointer = NULL;
@@ -241,7 +241,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 	input.pointer = in_params;
 	in_params[0].type 		= ACPI_TYPE_BUFFER;
 	in_params[0].buffer.length 	= 16;
-	in_params[0].buffer.pointer	= uuid;
+	in_params[0].buffer.pointer	= (u8 *)&guid;
 	in_params[1].type 		= ACPI_TYPE_INTEGER;
 	in_params[1].integer.value 	= context->rev;
 	in_params[2].type 		= ACPI_TYPE_INTEGER;
-- 
2.11.0

