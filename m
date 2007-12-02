From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPICA: fix acpi-cpufreq boot crash due to _PSD return-by-reference
Date: Sun,  2 Dec 2007 14:48:45 -0500
Message-ID: <1196624925-17220-3-git-send-email-lenb@kernel.org>
References: <1196624925-17220-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:60075 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751494AbXLBT4E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Dec 2007 14:56:04 -0500
In-Reply-To: <1196624925-17220-1-git-send-email-lenb@kernel.org>
Message-Id: <152c300d007c70c4a1847dad39ecdaba22e7d457.1196624815.git.len.brown@intel.com>
In-Reply-To: <357dc4c3f13cb5c1e3b40a09cbe6ff1b0df2c7c3.1196624815.git.len.brown@intel.com>
References: <357dc4c3f13cb5c1e3b40a09cbe6ff1b0df2c7c3.1196624815.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Changed resolution of named references in packages

Fixed a problem with the Package operator where all named
references were created as object references and left otherwise
unresolved. According to the ACPI specification, a Package can
only contain Data Objects or references to control methods. The
implication is that named references to Data Objects (Integer,
Buffer, String, Package, BufferField, Field) should be resolved
immediately upon package creation. This is the approach taken
with this change. References to all other named objects (Methods,
Devices, Scopes, etc.) are all now properly created as reference objects.

http://bugzilla.kernel.org/show_bug.cgi?id=5328
http://bugzilla.kernel.org/show_bug.cgi?id=9429

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |   91 +++++++++++++++++++++++++++++++++--
 1 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index a474ca2..954ac8c 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -137,6 +137,71 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(status);
 			}
 		}
+
+		/* Special object resolution for elements of a package */
+
+		if ((op->common.parent->common.aml_opcode == AML_PACKAGE_OP) ||
+		    (op->common.parent->common.aml_opcode ==
+		     AML_VAR_PACKAGE_OP)) {
+			/*
+			 * Attempt to resolve the node to a value before we insert it into
+			 * the package. If this is a reference to a common data type,
+			 * resolve it immediately. According to the ACPI spec, package
+			 * elements can only be "data objects" or method references.
+			 * Attempt to resolve to an Integer, Buffer, String or Package.
+			 * If cannot, return the named reference (for things like Devices,
+			 * Methods, etc.) Buffer Fields and Fields will resolve to simple
+			 * objects (int/buf/str/pkg).
+			 *
+			 * NOTE: References to things like Devices, Methods, Mutexes, etc.
+			 * will remain as named references. This behavior is not described
+			 * in the ACPI spec, but it appears to be an oversight.
+			 */
+			obj_desc = (union acpi_operand_object *)op->common.node;
+
+			status =
+			    acpi_ex_resolve_node_to_value(ACPI_CAST_INDIRECT_PTR
+							  (struct
+							   acpi_namespace_node,
+							   &obj_desc),
+							  walk_state);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
+
+			switch (op->common.node->type) {
+				/*
+				 * For these types, we need the actual node, not the subobject.
+				 * However, the subobject got an extra reference count above.
+				 */
+			case ACPI_TYPE_MUTEX:
+			case ACPI_TYPE_METHOD:
+			case ACPI_TYPE_POWER:
+			case ACPI_TYPE_PROCESSOR:
+			case ACPI_TYPE_EVENT:
+			case ACPI_TYPE_REGION:
+			case ACPI_TYPE_DEVICE:
+			case ACPI_TYPE_THERMAL:
+
+				obj_desc =
+				    (union acpi_operand_object *)op->common.
+				    node;
+				break;
+
+			default:
+				break;
+			}
+
+			/*
+			 * If above resolved to an operand object, we are done. Otherwise,
+			 * we have a NS node, we must create the package entry as a named
+			 * reference.
+			 */
+			if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) !=
+			    ACPI_DESC_TYPE_NAMED) {
+				goto exit;
+			}
+		}
 	}
 
 	/* Create and init a new internal ACPI object */
@@ -156,6 +221,7 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(status);
 	}
 
+      exit:
 	*obj_desc_ptr = obj_desc;
 	return_ACPI_STATUS(AE_OK);
 }
@@ -356,12 +422,25 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 	arg = arg->common.next;
 	for (i = 0; arg && (i < element_count); i++) {
 		if (arg->common.aml_opcode == AML_INT_RETURN_VALUE_OP) {
-
-			/* This package element is already built, just get it */
-
-			obj_desc->package.elements[i] =
-			    ACPI_CAST_PTR(union acpi_operand_object,
-					  arg->common.node);
+			if (arg->common.node->type == ACPI_TYPE_METHOD) {
+				/*
+				 * A method reference "looks" to the parser to be a method
+				 * invocation, so we special case it here
+				 */
+				arg->common.aml_opcode = AML_INT_NAMEPATH_OP;
+				status =
+				    acpi_ds_build_internal_object(walk_state,
+								  arg,
+								  &obj_desc->
+								  package.
+								  elements[i]);
+			} else {
+				/* This package element is already built, just get it */
+
+				obj_desc->package.elements[i] =
+				    ACPI_CAST_PTR(union acpi_operand_object,
+						  arg->common.node);
+			}
 		} else {
 			status = acpi_ds_build_internal_object(walk_state, arg,
 							       &obj_desc->
-- 
1.5.3.7.949.g2221a6
