From: Len Brown <lenb@kernel.org>
Subject: [PATCH 63/73] ACPICA: Fix for possible error when packages/buffers are passed to methods externally
Date: Sat, 12 Apr 2008 00:25:46 -0400
Message-ID: <835a25a5f1cf38f41e50239d0e19e77ccbb94782.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:11821 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753588AbYDLE2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:13 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem where buffer and package objects passed as
arguments to a control method via the external AcpiEvaluateObject
interface could cause an AE_AML_INTERNAL exception depending on the
order and type of operators executed by the target control method.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utcopy.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index 4c4021d..4e9a62b 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -511,6 +511,10 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 			    external_object->buffer.length);
 
 		internal_object->buffer.length = external_object->buffer.length;
+
+		/* Mark buffer data valid */
+
+		internal_object->buffer.flags |= AOPOBJ_DATA_VALID;
 		break;
 
 	case ACPI_TYPE_INTEGER:
@@ -586,6 +590,10 @@ acpi_ut_copy_epackage_to_ipackage(union acpi_object *external_object,
 		}
 	}
 
+	/* Mark package data valid */
+
+	package_object->package.flags |= AOPOBJ_DATA_VALID;
+
 	*internal_object = package_object;
 	return_ACPI_STATUS(status);
 }
-- 
1.5.5.29.g7134

