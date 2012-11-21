From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/15] ACPICA: Enhance the ACPI_GETx and ACPI_SETx macros.
Date: Wed, 21 Nov 2012 18:08:32 +0800
Message-ID: <8173a1db72935a38cdfe1d27587166766d86f027.1353491653.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8963 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220Ab2KUKIo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:08:44 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>

Improve the implementation of the macros.  Change the SETx macros
to the style of (destination, source).  Also add ACPI_CASTx
companion macros.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acmacros.h |   20 ++++++-----
 drivers/acpi/acpica/exregion.c |    8 ++---
 drivers/acpi/acpica/rsmisc.c   |   71 +++++++++++++++++++++-------------------
 3 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 1fa91f1..3ba11d2 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -49,14 +49,18 @@
  * get into potential aligment issues -- see the STORE macros below.
  * Use with care.
  */
-#define ACPI_GET8(ptr)                  *ACPI_CAST_PTR (u8, ptr)
-#define ACPI_GET16(ptr)                 *ACPI_CAST_PTR (u16, ptr)
-#define ACPI_GET32(ptr)                 *ACPI_CAST_PTR (u32, ptr)
-#define ACPI_GET64(ptr)                 *ACPI_CAST_PTR (u64, ptr)
-#define ACPI_SET8(ptr)                  *ACPI_CAST_PTR (u8, ptr)
-#define ACPI_SET16(ptr)                 *ACPI_CAST_PTR (u16, ptr)
-#define ACPI_SET32(ptr)                 *ACPI_CAST_PTR (u32, ptr)
-#define ACPI_SET64(ptr)                 *ACPI_CAST_PTR (u64, ptr)
+#define ACPI_CAST8(ptr)                 ACPI_CAST_PTR (u8, (ptr))
+#define ACPI_CAST16(ptr)                ACPI_CAST_PTR (u16, (ptr))
+#define ACPI_CAST32(ptr)                ACPI_CAST_PTR (u32, (ptr))
+#define ACPI_CAST64(ptr)                ACPI_CAST_PTR (u64, (ptr))
+#define ACPI_GET8(ptr)                  (*ACPI_CAST8 (ptr))
+#define ACPI_GET16(ptr)                 (*ACPI_CAST16 (ptr))
+#define ACPI_GET32(ptr)                 (*ACPI_CAST32 (ptr))
+#define ACPI_GET64(ptr)                 (*ACPI_CAST64 (ptr))
+#define ACPI_SET8(ptr, val)             (*ACPI_CAST8 (ptr) = (u8) (val))
+#define ACPI_SET16(ptr, val)            (*ACPI_CAST16 (ptr) = (u16) (val))
+#define ACPI_SET32(ptr, val)            (*ACPI_CAST32 (ptr) = (u32) (val))
+#define ACPI_SET64(ptr, val)            (*ACPI_CAST64 (ptr) = (u64) (val))
 
 /*
  * printf() format helpers
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 06a4924..28d3cd9 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -239,19 +239,19 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		switch (bit_width) {
 		case 8:
-			ACPI_SET8(logical_addr_ptr) = (u8)*value;
+			ACPI_SET8(logical_addr_ptr, *value);
 			break;
 
 		case 16:
-			ACPI_SET16(logical_addr_ptr) = (u16)*value;
+			ACPI_SET16(logical_addr_ptr, *value);
 			break;
 
 		case 32:
-			ACPI_SET32(logical_addr_ptr) = (u32)*value;
+			ACPI_SET32(logical_addr_ptr, *value);
 			break;
 
 		case 64:
-			ACPI_SET64(logical_addr_ptr) = (u64)*value;
+			ACPI_SET64(logical_addr_ptr, *value);
 			break;
 
 		default:
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 3d0e15c..7b094eb 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -136,30 +136,30 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			/*
 			 * Mask and shift the flag bit
 			 */
-			ACPI_SET8(destination) = (u8)
-			    ((ACPI_GET8(source) >> info->value) & 0x01);
+			ACPI_SET8(destination,
+				  ((ACPI_GET8(source) >> info->value) & 0x01));
 			break;
 
 		case ACPI_RSC_2BITFLAG:
 			/*
 			 * Mask and shift the flag bits
 			 */
-			ACPI_SET8(destination) = (u8)
-			    ((ACPI_GET8(source) >> info->value) & 0x03);
+			ACPI_SET8(destination,
+				  ((ACPI_GET8(source) >> info->value) & 0x03));
 			break;
 
 		case ACPI_RSC_3BITFLAG:
 			/*
 			 * Mask and shift the flag bits
 			 */
-			ACPI_SET8(destination) = (u8)
-			    ((ACPI_GET8(source) >> info->value) & 0x07);
+			ACPI_SET8(destination,
+				  ((ACPI_GET8(source) >> info->value) & 0x07));
 			break;
 
 		case ACPI_RSC_COUNT:
 
 			item_count = ACPI_GET8(source);
-			ACPI_SET8(destination) = (u8)item_count;
+			ACPI_SET8(destination, item_count);
 
 			resource->length = resource->length +
 			    (info->value * (item_count - 1));
@@ -168,7 +168,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 		case ACPI_RSC_COUNT16:
 
 			item_count = aml_resource_length;
-			ACPI_SET16(destination) = item_count;
+			ACPI_SET16(destination, item_count);
 
 			resource->length = resource->length +
 			    (info->value * (item_count - 1));
@@ -181,13 +181,13 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 
 			resource->length = resource->length + item_count;
 			item_count = item_count / 2;
-			ACPI_SET16(destination) = item_count;
+			ACPI_SET16(destination, item_count);
 			break;
 
 		case ACPI_RSC_COUNT_GPIO_VEN:
 
 			item_count = ACPI_GET8(source);
-			ACPI_SET8(destination) = (u8)item_count;
+			ACPI_SET8(destination, item_count);
 
 			resource->length = resource->length +
 			    (info->value * item_count);
@@ -216,7 +216,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			}
 
 			resource->length = resource->length + item_count;
-			ACPI_SET16(destination) = item_count;
+			ACPI_SET16(destination, item_count);
 			break;
 
 		case ACPI_RSC_COUNT_SERIAL_VEN:
@@ -224,7 +224,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			item_count = ACPI_GET16(source) - info->value;
 
 			resource->length = resource->length + item_count;
-			ACPI_SET16(destination) = item_count;
+			ACPI_SET16(destination, item_count);
 			break;
 
 		case ACPI_RSC_COUNT_SERIAL_RES:
@@ -234,7 +234,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			    - ACPI_GET16(source) - info->value;
 
 			resource->length = resource->length + item_count;
-			ACPI_SET16(destination) = item_count;
+			ACPI_SET16(destination, item_count);
 			break;
 
 		case ACPI_RSC_LENGTH:
@@ -385,7 +385,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			}
 
 			target = ACPI_ADD_PTR(char, resource, info->value);
-			ACPI_SET8(target) = (u8)item_count;
+			ACPI_SET8(target, item_count);
 			break;
 
 		case ACPI_RSC_BITMASK16:
@@ -401,7 +401,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			}
 
 			target = ACPI_ADD_PTR(char, resource, info->value);
-			ACPI_SET8(target) = (u8)item_count;
+			ACPI_SET8(target, item_count);
 			break;
 
 		case ACPI_RSC_EXIT_NE:
@@ -514,37 +514,40 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			/*
 			 * Clear the flag byte
 			 */
-			ACPI_SET8(destination) = 0;
+			ACPI_SET8(destination, 0);
 			break;
 
 		case ACPI_RSC_1BITFLAG:
 			/*
 			 * Mask and shift the flag bit
 			 */
-			ACPI_SET8(destination) |= (u8)
-			    ((ACPI_GET8(source) & 0x01) << info->value);
+			ACPI_SET_BIT(*ACPI_CAST8(destination), (u8)
+				     ((ACPI_GET8(source) & 0x01) << info->
+				      value));
 			break;
 
 		case ACPI_RSC_2BITFLAG:
 			/*
 			 * Mask and shift the flag bits
 			 */
-			ACPI_SET8(destination) |= (u8)
-			    ((ACPI_GET8(source) & 0x03) << info->value);
+			ACPI_SET_BIT(*ACPI_CAST8(destination), (u8)
+				     ((ACPI_GET8(source) & 0x03) << info->
+				      value));
 			break;
 
 		case ACPI_RSC_3BITFLAG:
 			/*
 			 * Mask and shift the flag bits
 			 */
-			ACPI_SET8(destination) |= (u8)
-			    ((ACPI_GET8(source) & 0x07) << info->value);
+			ACPI_SET_BIT(*ACPI_CAST8(destination), (u8)
+				     ((ACPI_GET8(source) & 0x07) << info->
+				      value));
 			break;
 
 		case ACPI_RSC_COUNT:
 
 			item_count = ACPI_GET8(source);
-			ACPI_SET8(destination) = (u8)item_count;
+			ACPI_SET8(destination, item_count);
 
 			aml_length =
 			    (u16) (aml_length +
@@ -561,18 +564,18 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 		case ACPI_RSC_COUNT_GPIO_PIN:
 
 			item_count = ACPI_GET16(source);
-			ACPI_SET16(destination) = (u16)aml_length;
+			ACPI_SET16(destination, aml_length);
 
 			aml_length = (u16)(aml_length + item_count * 2);
 			target = ACPI_ADD_PTR(void, aml, info->value);
-			ACPI_SET16(target) = (u16)aml_length;
+			ACPI_SET16(target, aml_length);
 			acpi_rs_set_resource_length(aml_length, aml);
 			break;
 
 		case ACPI_RSC_COUNT_GPIO_VEN:
 
 			item_count = ACPI_GET16(source);
-			ACPI_SET16(destination) = (u16)item_count;
+			ACPI_SET16(destination, item_count);
 
 			aml_length =
 			    (u16)(aml_length + (info->value * item_count));
@@ -584,7 +587,7 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			/* Set resource source string length */
 
 			item_count = ACPI_GET16(source);
-			ACPI_SET16(destination) = (u16)aml_length;
+			ACPI_SET16(destination, aml_length);
 
 			/* Compute offset for the Vendor Data */
 
@@ -594,7 +597,7 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			/* Set vendor offset only if there is vendor data */
 
 			if (resource->data.gpio.vendor_length) {
-				ACPI_SET16(target) = (u16)aml_length;
+				ACPI_SET16(target, aml_length);
 			}
 
 			acpi_rs_set_resource_length(aml_length, aml);
@@ -603,7 +606,7 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 		case ACPI_RSC_COUNT_SERIAL_VEN:
 
 			item_count = ACPI_GET16(source);
-			ACPI_SET16(destination) = item_count + info->value;
+			ACPI_SET16(destination, item_count + info->value);
 			aml_length = (u16)(aml_length + item_count);
 			acpi_rs_set_resource_length(aml_length, aml);
 			break;
@@ -707,10 +710,12 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			/*
 			 * 8-bit encoded bitmask (DMA macro)
 			 */
-			ACPI_SET8(destination) = (u8)
-			    acpi_rs_encode_bitmask(source,
-						   *ACPI_ADD_PTR(u8, resource,
-								 info->value));
+			ACPI_SET8(destination,
+				  acpi_rs_encode_bitmask(source,
+							 *ACPI_ADD_PTR(u8,
+								       resource,
+								       info->
+								       value)));
 			break;
 
 		case ACPI_RSC_BITMASK16:
-- 
1.7.10

