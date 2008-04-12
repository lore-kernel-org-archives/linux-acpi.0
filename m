From: Len Brown <lenb@kernel.org>
Subject: [PATCH 48/73] ACPICA: Fix for SizeOf when used with Buffers and Packages
Date: Sat, 12 Apr 2008 00:25:31 -0400
Message-ID: <8f304d3e26c632e4082dc82397136b56e192b955.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:36418 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753267AbYDLE2J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:09 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the SizeOf operator when used with Package
and Buffer objects. These objects have deferred execution for some
arguments, and the execution is now completed before the SizeOf is
executed. This problem caused unexpected AE_PACKAGE_LIMIT errors
on some systems (Lin Ming, Bob Moore) BZ 9558

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exoparg1.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/executer/exoparg1.c b/drivers/acpi/executer/exoparg1.c
index ab5c037..313803b 100644
--- a/drivers/acpi/executer/exoparg1.c
+++ b/drivers/acpi/executer/exoparg1.c
@@ -740,26 +740,38 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 			value = acpi_gbl_integer_byte_width;
 			break;
 
-		case ACPI_TYPE_BUFFER:
-			value = temp_desc->buffer.length;
-			break;
-
 		case ACPI_TYPE_STRING:
 			value = temp_desc->string.length;
 			break;
 
+		case ACPI_TYPE_BUFFER:
+
+			/* Buffer arguments may not be evaluated at this point */
+
+			status = acpi_ds_get_buffer_arguments(temp_desc);
+			value = temp_desc->buffer.length;
+			break;
+
 		case ACPI_TYPE_PACKAGE:
+
+			/* Package arguments may not be evaluated at this point */
+
+			status = acpi_ds_get_package_arguments(temp_desc);
 			value = temp_desc->package.count;
 			break;
 
 		default:
 			ACPI_ERROR((AE_INFO,
-				    "Operand is not Buf/Int/Str/Pkg - found type %s",
+				    "Operand must be Buffer/Integer/String/Package - found type %s",
 				    acpi_ut_get_type_name(type)));
 			status = AE_AML_OPERAND_TYPE;
 			goto cleanup;
 		}
 
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+
 		/*
 		 * Now that we have the size of the object, create a result
 		 * object to hold the value
-- 
1.5.5.29.g7134

