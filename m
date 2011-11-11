From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] ACPICA: acpi_read: update return value atomically
Date: Fri, 11 Nov 2011 16:05:08 -0700
Message-ID: <20111111230508.20897.69840.stgit@bhelgaas.mtv.corp.google.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f74.google.com ([209.85.161.74]:47248 "EHLO
	mail-fx0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1KLAGY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2011 19:06:24 -0500
Received: by faas12 with SMTP id s12so110204faa.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Nov 2011 16:06:22 -0800 (PST)
In-Reply-To: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Huang Ying <ying.huang@intel.com>, Myron Stowe <myron.stowe@redhat.com>, Thomas Renninger <trenn@suse.de>

Accumulate the entire 64-bit value before updating the return_value.
Previously, it was possible to update the low 32 bits, then return
failure if reading the upper 32 bits failed, leaving a half-updated
return_value.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/acpica/hwxface.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index c2793a8..12b5c57 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -123,6 +123,7 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 	u32 value;
 	u32 width;
 	u64 address;
+	u64 complete_value;
 	acpi_status status;
 
 	ACPI_FUNCTION_NAME(acpi_read);
@@ -146,6 +147,7 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 	/* Initialize entire 64-bit return value to zero */
 
 	*return_value = 0;
+	complete_value = 0;
 	value = 0;
 
 	/*
@@ -158,7 +160,7 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
-		*return_value = value;
+		complete_value = value;
 
 		if (reg->bit_width == 64) {
 
@@ -169,7 +171,7 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
-			*return_value |= ((u64)value << 32);
+			complete_value |= ((u64)value << 32);
 		}
 	} else {		/* ACPI_ADR_SPACE_SYSTEM_IO, validated earlier */
 
@@ -178,7 +180,7 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
-		*return_value = value;
+		complete_value = value;
 
 		if (reg->bit_width == 64) {
 
@@ -189,10 +191,11 @@ acpi_status acpi_read(u64 *return_value, struct acpi_generic_address *reg)
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
-			*return_value |= ((u64)value << 32);
+			complete_value |= ((u64)value << 32);
 		}
 	}
 
+	*return_value = complete_value;
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
 			  "Read:  %8.8X%8.8X width %2d from %8.8X%8.8X (%s)\n",
 			  ACPI_FORMAT_UINT64(*return_value), reg->bit_width,

