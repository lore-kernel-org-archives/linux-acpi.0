From: Len Brown <len.brown@intel.com>
Subject: [PATCH 7/65] ACPICA: fix for object premature deletion
Date: Fri, 24 Nov 2006 02:18:17 -0500
Message-ID: <1164352762703-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50244 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757611AbWKXHPX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:23 -0500
In-Reply-To: <1164352761941-git-send-email-len.brown@intel.com>
Message-Id: <c243528a18ae423700c1e6d41e027b18907189eb.1164352288.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Fix for object premature deletion after CopyObject
on Operation Region (BZ 350)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utcopy.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index 5e1a80d..5c38276 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -719,6 +719,15 @@ acpi_ut_copy_simple_object(union acpi_op
 		acpi_ut_add_reference(source_desc->reference.object);
 		break;
 
+	case ACPI_TYPE_REGION:
+		/*
+		 * We copied the Region Handler, so we now must add a reference
+		 */
+		if (dest_desc->region.handler) {
+			acpi_ut_add_reference(dest_desc->region.handler);
+		}
+		break;
+
 	default:
 		/* Nothing to do for other simple objects */
 		break;
-- 
1.4.4.1
