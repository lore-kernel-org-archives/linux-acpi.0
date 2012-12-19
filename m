From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 06/19] ACPICA: Cleanup coding style to reduce differences between Linux and ACPICA.
Date: Wed, 19 Dec 2012 13:37:21 +0800
Message-ID: <5e6704d5159fc0dd61639117f658128b1ccf4a05.1355810294.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44713 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969Ab2LSFh2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 00:37:28 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This is a cosmetic patch only. Comparison of the resulting binary showed
only line number differences.

This patch does not affect the generation of the Linux binary.
This patch decreases 314 lines of 20121018 divergence.diff.

ACPICA core uses ()'s on return statements. This is a known and committed
differences from Linux standard coding style.

This patch cleans up the Linux side ACPICA code to use this codying style
in order to reduce the source code differences between Linux and ACPICA.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Binary comparision result:
  Changes can be found are caused by the line folding:
  -    be3a:	68 88 00 00 00       	push   $0x88
  +    be3a:	68 8a 00 00 00       	push   $0x8a
  hwgpe.c(138): acpi_hw_low_set_gpe
  ACPI_ERROR -> AE_INFO -> __LINE__
---
Divergences fixing result:
  Before applying: 2351 Lines, 82.4 Kbytes
  After applying: 2037 Lines, 72.3 Kbytes
---
 drivers/acpi/acpica/exconfig.c |    4 ++--
 drivers/acpi/acpica/hwgpe.c    |    6 ++++--
 drivers/acpi/acpica/hwvalid.c  |   18 +++++++++---------
 drivers/acpi/acpica/nspredef.c |    2 +-
 drivers/acpi/acpica/nswalk.c   |    4 ++--
 drivers/acpi/acpica/nsxfname.c |   14 +++++++-------
 drivers/acpi/acpica/rscalc.c   |    2 +-
 drivers/acpi/acpica/rsutils.c  |    2 +-
 drivers/acpi/acpica/tbutils.c  |    2 +-
 drivers/acpi/acpica/utcopy.c   |    4 ++--
 drivers/acpi/acpica/utlock.c   |   14 +++++++-------
 11 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index b4f42f5..d0cc2a4 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -304,7 +304,7 @@ acpi_ex_region_read(union acpi_operand_object *obj_desc, u32 length, u8 *buffer)
 		    acpi_ev_address_space_dispatch(obj_desc, NULL, ACPI_READ,
 						   region_offset, 8, &value);
 		if (ACPI_FAILURE(status)) {
-			return status;
+			return (status);
 		}
 
 		*buffer = (u8)value;
@@ -312,7 +312,7 @@ acpi_ex_region_read(union acpi_operand_object *obj_desc, u32 length, u8 *buffer)
 		region_offset++;
 	}
 
-	return AE_OK;
+	return (AE_OK);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 6456004..095666b 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -69,8 +69,10 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 u32 acpi_hw_get_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info)
 {
-	return (u32)1 << (gpe_event_info->gpe_number -
-		 gpe_event_info->register_info->base_gpe_number);
+
+	return ((u32)1 <<
+		(gpe_event_info->gpe_number -
+		 gpe_event_info->register_info->base_gpe_number));
 }
 
 /******************************************************************************
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index b6aae58..70686cd 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -135,7 +135,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	if ((bit_width != 8) && (bit_width != 16) && (bit_width != 32)) {
 		ACPI_ERROR((AE_INFO,
 			    "Bad BitWidth parameter: %8.8X", bit_width));
-		return AE_BAD_PARAMETER;
+		return (AE_BAD_PARAMETER);
 	}
 
 	port_info = acpi_protected_ports;
@@ -234,11 +234,11 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
 	status = acpi_hw_validate_io_request(address, width);
 	if (ACPI_SUCCESS(status)) {
 		status = acpi_os_read_port(address, value, width);
-		return status;
+		return (status);
 	}
 
 	if (status != AE_AML_ILLEGAL_ADDRESS) {
-		return status;
+		return (status);
 	}
 
 	/*
@@ -253,7 +253,7 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
 		if (acpi_hw_validate_io_request(address, 8) == AE_OK) {
 			status = acpi_os_read_port(address, &one_byte, 8);
 			if (ACPI_FAILURE(status)) {
-				return status;
+				return (status);
 			}
 
 			*value |= (one_byte << i);
@@ -262,7 +262,7 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
 		address++;
 	}
 
-	return AE_OK;
+	return (AE_OK);
 }
 
 /******************************************************************************
@@ -297,11 +297,11 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
 	status = acpi_hw_validate_io_request(address, width);
 	if (ACPI_SUCCESS(status)) {
 		status = acpi_os_write_port(address, value, width);
-		return status;
+		return (status);
 	}
 
 	if (status != AE_AML_ILLEGAL_ADDRESS) {
-		return status;
+		return (status);
 	}
 
 	/*
@@ -317,12 +317,12 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
 			status =
 			    acpi_os_write_port(address, (value >> i) & 0xFF, 8);
 			if (ACPI_FAILURE(status)) {
-				return status;
+				return (status);
 			}
 		}
 
 		address++;
 	}
 
-	return AE_OK;
+	return (AE_OK);
 }
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 352be3b..1f0e934 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -147,7 +147,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 
 	pathname = acpi_ns_get_external_pathname(node);
 	if (!pathname) {
-		return AE_OK;	/* Could not get pathname, ignore */
+		return (AE_OK);	/* Could not get pathname, ignore */
 	}
 
 	/*
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 0483877..4657e75 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -76,12 +76,12 @@ struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
 
 		/* It's really the parent's _scope_ that we want */
 
-		return parent_node->child;
+		return (parent_node->child);
 	}
 
 	/* Otherwise just return the next peer */
 
-	return child_node->peer;
+	return (child_node->peer);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 811c6f1..520bab4 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -539,14 +539,14 @@ acpi_status acpi_install_method(u8 *buffer)
 	/* Parameter validation */
 
 	if (!buffer) {
-		return AE_BAD_PARAMETER;
+		return (AE_BAD_PARAMETER);
 	}
 
 	/* Table must be a DSDT or SSDT */
 
 	if (!ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) &&
 	    !ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT)) {
-		return AE_BAD_HEADER;
+		return (AE_BAD_HEADER);
 	}
 
 	/* First AML opcode in the table must be a control method */
@@ -554,7 +554,7 @@ acpi_status acpi_install_method(u8 *buffer)
 	parser_state.aml = buffer + sizeof(struct acpi_table_header);
 	opcode = acpi_ps_peek_opcode(&parser_state);
 	if (opcode != AML_METHOD_OP) {
-		return AE_BAD_PARAMETER;
+		return (AE_BAD_PARAMETER);
 	}
 
 	/* Extract method information from the raw AML */
@@ -572,13 +572,13 @@ acpi_status acpi_install_method(u8 *buffer)
 	 */
 	aml_buffer = ACPI_ALLOCATE(aml_length);
 	if (!aml_buffer) {
-		return AE_NO_MEMORY;
+		return (AE_NO_MEMORY);
 	}
 
 	method_obj = acpi_ut_create_internal_object(ACPI_TYPE_METHOD);
 	if (!method_obj) {
 		ACPI_FREE(aml_buffer);
-		return AE_NO_MEMORY;
+		return (AE_NO_MEMORY);
 	}
 
 	/* Lock namespace for acpi_ns_lookup, we may be creating a new node */
@@ -644,12 +644,12 @@ acpi_status acpi_install_method(u8 *buffer)
 	/* Remove local reference to the method object */
 
 	acpi_ut_remove_reference(method_obj);
-	return status;
+	return (status);
 
 error_exit:
 
 	ACPI_FREE(aml_buffer);
 	ACPI_FREE(method_obj);
-	return status;
+	return (status);
 }
 ACPI_EXPORT_SYMBOL(acpi_install_method)
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 147feb6..4f39bd6 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -84,7 +84,7 @@ static u8 acpi_rs_count_set_bits(u16 bit_field)
 		bit_field &= (u16) (bit_field - 1);
 	}
 
-	return bits_set;
+	return (bits_set);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 441447f..5adae5a 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -108,7 +108,7 @@ u16 acpi_rs_encode_bitmask(u8 * list, u8 count)
 		mask |= (0x1 << list[i]);
 	}
 
-	return mask;
+	return (mask);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 285e24b..e3cc315 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -147,7 +147,7 @@ acpi_status acpi_tb_initialize_facs(void)
 					 ACPI_CAST_INDIRECT_PTR(struct
 								acpi_table_header,
 								&acpi_gbl_FACS));
-	return status;
+	return (status);
 }
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 294692a..99549ee 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -785,7 +785,7 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 
 		status = acpi_os_create_mutex(&dest_desc->mutex.os_mutex);
 		if (ACPI_FAILURE(status)) {
-			return status;
+			return (status);
 		}
 		break;
 
@@ -795,7 +795,7 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 						  &dest_desc->event.
 						  os_semaphore);
 		if (ACPI_FAILURE(status)) {
-			return status;
+			return (status);
 		}
 		break;
 
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
index b1eb7f1..8d1a749 100644
--- a/drivers/acpi/acpica/utlock.c
+++ b/drivers/acpi/acpica/utlock.c
@@ -66,11 +66,11 @@ acpi_status acpi_ut_create_rw_lock(struct acpi_rw_lock *lock)
 	lock->num_readers = 0;
 	status = acpi_os_create_mutex(&lock->reader_mutex);
 	if (ACPI_FAILURE(status)) {
-		return status;
+		return (status);
 	}
 
 	status = acpi_os_create_mutex(&lock->writer_mutex);
-	return status;
+	return (status);
 }
 
 void acpi_ut_delete_rw_lock(struct acpi_rw_lock *lock)
@@ -108,7 +108,7 @@ acpi_status acpi_ut_acquire_read_lock(struct acpi_rw_lock *lock)
 
 	status = acpi_os_acquire_mutex(lock->reader_mutex, ACPI_WAIT_FOREVER);
 	if (ACPI_FAILURE(status)) {
-		return status;
+		return (status);
 	}
 
 	/* Acquire the write lock only for the first reader */
@@ -121,7 +121,7 @@ acpi_status acpi_ut_acquire_read_lock(struct acpi_rw_lock *lock)
 	}
 
 	acpi_os_release_mutex(lock->reader_mutex);
-	return status;
+	return (status);
 }
 
 acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock *lock)
@@ -130,7 +130,7 @@ acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock *lock)
 
 	status = acpi_os_acquire_mutex(lock->reader_mutex, ACPI_WAIT_FOREVER);
 	if (ACPI_FAILURE(status)) {
-		return status;
+		return (status);
 	}
 
 	/* Release the write lock only for the very last reader */
@@ -141,7 +141,7 @@ acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock *lock)
 	}
 
 	acpi_os_release_mutex(lock->reader_mutex);
-	return status;
+	return (status);
 }
 
 /*******************************************************************************
@@ -165,7 +165,7 @@ acpi_status acpi_ut_acquire_write_lock(struct acpi_rw_lock *lock)
 	acpi_status status;
 
 	status = acpi_os_acquire_mutex(lock->writer_mutex, ACPI_WAIT_FOREVER);
-	return status;
+	return (status);
 }
 
 void acpi_ut_release_write_lock(struct acpi_rw_lock *lock)
-- 
1.7.10

