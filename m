From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/15] ACPICA: Ensure all instances of AE_AML_INTERNAL have error messages
Date: Thu,  3 Aug 2017 14:27:28 +0800
Message-ID: <5eab2a037429903ba978a7ebfa7bcff0141514c6.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:65438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbdHCG1c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:27:32 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ea9152daaec30760fa4c25285998f58233ec0db5

This exception is only meaningful with an associated error message.

Link: https://github.com/acpica/acpica/commit/ea9152da
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsfield.c  | 2 ++
 drivers/acpi/acpica/exmisc.c   | 9 +++++++++
 drivers/acpi/acpica/exoparg2.c | 3 +++
 drivers/acpi/acpica/nsprepkg.c | 2 ++
 drivers/acpi/acpica/utmisc.c   | 2 ++
 5 files changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index c5dccc5..7bcf5f5e 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -184,6 +184,7 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 		/* Execute flag should always be set when this function is entered */
 
 		if (!(walk_state->parse_flags & ACPI_PARSE_EXECUTE)) {
+			ACPI_ERROR((AE_INFO, "Parse execute mode is not set"));
 			return_ACPI_STATUS(AE_AML_INTERNAL);
 		}
 
@@ -556,6 +557,7 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 			return_ACPI_STATUS(AE_OK);
 		}
 
+		ACPI_ERROR((AE_INFO, "Parse deferred mode is not set"));
 		return_ACPI_STATUS(AE_AML_INTERNAL);
 	}
 
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index f222a80..1e7649c 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -265,6 +265,8 @@ acpi_ex_do_logical_numeric_op(u16 opcode,
 
 	default:
 
+		ACPI_ERROR((AE_INFO,
+			    "Invalid numeric logical opcode: %X", opcode));
 		status = AE_AML_INTERNAL;
 		break;
 	}
@@ -345,6 +347,9 @@ acpi_ex_do_logical_op(u16 opcode,
 
 	default:
 
+		ACPI_ERROR((AE_INFO,
+			    "Invalid object type for logical operator: %X",
+			    operand0->common.type));
 		status = AE_AML_INTERNAL;
 		break;
 	}
@@ -388,6 +393,8 @@ acpi_ex_do_logical_op(u16 opcode,
 
 		default:
 
+			ACPI_ERROR((AE_INFO,
+				    "Invalid comparison opcode: %X", opcode));
 			status = AE_AML_INTERNAL;
 			break;
 		}
@@ -456,6 +463,8 @@ acpi_ex_do_logical_op(u16 opcode,
 
 		default:
 
+			ACPI_ERROR((AE_INFO,
+				    "Invalid comparison opcode: %X", opcode));
 			status = AE_AML_INTERNAL;
 			break;
 		}
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index eecb3bf..57980b7 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -414,6 +414,9 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 
 		default:
 
+			ACPI_ERROR((AE_INFO,
+				    "Invalid object type: %X",
+				    (operand[0])->common.type));
 			status = AE_AML_INTERNAL;
 			goto cleanup;
 		}
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 4954cb6..a8ea8fb 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -614,6 +614,8 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 
 		default:	/* Should not get here, type was validated by caller */
 
+			ACPI_ERROR((AE_INFO, "Invalid Package type: %X",
+				    package->ret_info.type));
 			return (AE_AML_INTERNAL);
 		}
 
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 4d9f3a2..45c78c2 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -341,6 +341,8 @@ acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
 
 	/* We should never get here */
 
+	ACPI_ERROR((AE_INFO, "State list did not terminate correctly"));
+
 	return_ACPI_STATUS(AE_AML_INTERNAL);
 }
 
-- 
2.7.4

