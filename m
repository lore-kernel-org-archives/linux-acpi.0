From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPICA: Handle large field appertures.
Date: Wed, 19 May 2010 00:31:29 +0400
Message-ID: <20100518203129.30268.71941.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:60053 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758120Ab0ERUbb (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 18 May 2010 16:31:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 source/components/executer/exfldio.c |   49 ++++++++++++++++++++++++----------
 source/components/executer/exprep.c  |   12 +++++++-
 source/include/acobject.h            |    3 +-
 3 files changed, 46 insertions(+), 18 deletions(-)


diff --git a/source/components/executer/exfldio.c b/source/components/executer/exfldio.c
index 0cff9f9..5b08445 100644
--- a/source/components/executer/exfldio.c
+++ b/source/components/executer/exfldio.c
@@ -802,8 +802,7 @@ AcpiExExtractFromField (
 
     /* Validate target buffer and clear it */
 
-    if (BufferLength <
-            ACPI_ROUND_BITS_UP_TO_BYTES (ObjDesc->CommonField.BitLength))
+    if (BufferLength < ACPI_ROUND_BITS_UP_TO_BYTES (ObjDesc->CommonField.BitLength))
     {
         ACPI_ERROR ((AE_INFO,
             "Field size %u (bits) is too large for buffer (%u)",
@@ -813,15 +812,31 @@ AcpiExExtractFromField (
     }
     ACPI_MEMSET (Buffer, 0, BufferLength);
 
+    /* Simple case handling */
+
+    if (ObjDesc->CommonField.StartFieldBitOffset == 0 &&
+	ObjDesc->CommonField.BitLength ==
+	    8 * ObjDesc->CommonField.AccessByteWidth)
+    {
+	Status = AcpiExFieldDatumIo (ObjDesc, 0, Buffer, ACPI_READ);
+	return_ACPI_STATUS(Status);
+    }
+
+    /* Algo is limited to sizeof(UINT64), so cut the AccessByteWidth */
+    if (ObjDesc->CommonField.AccessByteWidth > sizeof(UINT64))
+    {
+	ObjDesc->CommonField.AccessByteWidth = sizeof(UINT64);
+    }
+
     /* Compute the number of datums (access width data items) */
 
     DatumCount = ACPI_ROUND_UP_TO (
                         ObjDesc->CommonField.BitLength,
-                        ObjDesc->CommonField.AccessBitWidth);
+                        ObjDesc->CommonField.AccessByteWidth * 8);
     FieldDatumCount = ACPI_ROUND_UP_TO (
                         ObjDesc->CommonField.BitLength +
                         ObjDesc->CommonField.StartFieldBitOffset,
-                        ObjDesc->CommonField.AccessBitWidth);
+                        ObjDesc->CommonField.AccessByteWidth * 8);
 
     /* Priming read from the field */
 
@@ -854,11 +869,11 @@ AcpiExExtractFromField (
          * This avoids the differences in behavior between different compilers
          * concerning shift values larger than the target data width.
          */
-        if ((ObjDesc->CommonField.AccessBitWidth -
+        if ((ObjDesc->CommonField.AccessByteWidth * 8 -
             ObjDesc->CommonField.StartFieldBitOffset) < ACPI_INTEGER_BIT_SIZE)
         {
             MergedDatum |= RawDatum <<
-                (ObjDesc->CommonField.AccessBitWidth -
+                (ObjDesc->CommonField.AccessByteWidth * 8 -
                     ObjDesc->CommonField.StartFieldBitOffset);
         }
 
@@ -880,7 +895,7 @@ AcpiExExtractFromField (
     /* Mask off any extra bits in the last datum */
 
     BufferTailBits = ObjDesc->CommonField.BitLength %
-                        ObjDesc->CommonField.AccessBitWidth;
+                        (ObjDesc->CommonField.AccessByteWidth * 8);
     if (BufferTailBits)
     {
         MergedDatum &= ACPI_MASK_BITS_ABOVE (BufferTailBits);
@@ -965,18 +980,24 @@ AcpiExInsertIntoField (
         BufferLength = RequiredLength;
     }
 
+    /* Algo is limited to sizeof(UINT64), so cut the AccessByteWidth */
+    if (ObjDesc->CommonField.AccessByteWidth > sizeof(UINT64))
+    {
+	ObjDesc->CommonField.AccessByteWidth = sizeof(UINT64);
+    }
+
     /*
      * Create the bitmasks used for bit insertion.
      * Note: This if/else is used to bypass compiler differences with the
      * shift operator
      */
-    if (ObjDesc->CommonField.AccessBitWidth == ACPI_INTEGER_BIT_SIZE)
+    if (ObjDesc->CommonField.AccessByteWidth * 8 == ACPI_INTEGER_BIT_SIZE)
     {
         WidthMask = ACPI_UINT64_MAX;
     }
     else
     {
-        WidthMask = ACPI_MASK_BITS_ABOVE (ObjDesc->CommonField.AccessBitWidth);
+        WidthMask = ACPI_MASK_BITS_ABOVE (ObjDesc->CommonField.AccessByteWidth * 8);
     }
 
     Mask = WidthMask &
@@ -985,11 +1006,11 @@ AcpiExInsertIntoField (
     /* Compute the number of datums (access width data items) */
 
     DatumCount = ACPI_ROUND_UP_TO (ObjDesc->CommonField.BitLength,
-                    ObjDesc->CommonField.AccessBitWidth);
+                    ObjDesc->CommonField.AccessByteWidth * 8);
 
     FieldDatumCount = ACPI_ROUND_UP_TO (ObjDesc->CommonField.BitLength +
                         ObjDesc->CommonField.StartFieldBitOffset,
-                        ObjDesc->CommonField.AccessBitWidth);
+                        ObjDesc->CommonField.AccessByteWidth * 8);
 
     /* Get initial Datum from the input buffer */
 
@@ -1024,11 +1045,11 @@ AcpiExInsertIntoField (
          * This avoids the differences in behavior between different compilers
          * concerning shift values larger than the target data width.
          */
-        if ((ObjDesc->CommonField.AccessBitWidth -
+        if ((ObjDesc->CommonField.AccessByteWidth * 8 -
             ObjDesc->CommonField.StartFieldBitOffset) < ACPI_INTEGER_BIT_SIZE)
         {
             MergedDatum = RawDatum >>
-                (ObjDesc->CommonField.AccessBitWidth -
+                (ObjDesc->CommonField.AccessByteWidth * 8 -
                     ObjDesc->CommonField.StartFieldBitOffset);
         }
         else
@@ -1056,7 +1077,7 @@ AcpiExInsertIntoField (
 
     BufferTailBits = (ObjDesc->CommonField.BitLength +
             ObjDesc->CommonField.StartFieldBitOffset) %
-                ObjDesc->CommonField.AccessBitWidth;
+                (ObjDesc->CommonField.AccessByteWidth * 8);
     if (BufferTailBits)
     {
         Mask &= ACPI_MASK_BITS_ABOVE (BufferTailBits);
diff --git a/source/components/executer/exprep.c b/source/components/executer/exprep.c
index 6cc3719..b133c06 100644
--- a/source/components/executer/exprep.c
+++ b/source/components/executer/exprep.c
@@ -455,8 +455,6 @@ AcpiExPrepCommonFieldObject (
     ObjDesc->CommonField.AccessByteWidth = (UINT8)
             ACPI_DIV_8 (AccessBitWidth);            /* 1,  2,  4,  8 */
 
-    ObjDesc->CommonField.AccessBitWidth = (UINT8) AccessBitWidth;
-
     /*
      * BaseByteOffset is the address of the start of the field within the
      * region.  It is the byte address of the first *datum* (field-width data
@@ -567,6 +565,16 @@ AcpiExPrepFieldValue (
 
         ObjDesc->Field.RegionObj = AcpiNsGetAttachedObject (Info->RegionNode);
 
+	/* allow full data read from EC address space */
+	if (ObjDesc->Field.RegionObj->Region.SpaceId == ACPI_ADR_SPACE_EC) {
+	    if (ObjDesc->CommonField.BitLength > 8) {
+		ObjDesc->CommonField.AccessByteWidth =
+		    ACPI_ROUND_BITS_UP_TO_BYTES(ObjDesc->CommonField.BitLength);
+	    }
+	}
+
+
+	
         /* An additional reference for the container */
 
         AcpiUtAddReference (ObjDesc->Field.RegionObj);
diff --git a/source/include/acobject.h b/source/include/acobject.h
index 502132a..21c3706 100644
--- a/source/include/acobject.h
+++ b/source/include/acobject.h
@@ -381,12 +381,11 @@ typedef struct acpi_object_thermal_zone
     UINT8                           FieldFlags;         /* Access, update, and lock bits */\
     UINT8                           Attribute;          /* From AccessAs keyword */\
     UINT8                           AccessByteWidth;    /* Read/Write size in bytes */\
+    UINT8                           StartFieldBitOffset;/* Bit offset within first field datum (0-63) */\
     ACPI_NAMESPACE_NODE             *Node;              /* Link back to parent node */\
     UINT32                          BitLength;          /* Length of field in bits */\
     UINT32                          BaseByteOffset;     /* Byte offset within containing object */\
     UINT32                          Value;              /* Value to store into the Bank or Index register */\
-    UINT8                           StartFieldBitOffset;/* Bit offset within first field datum (0-63) */\
-    UINT8                           AccessBitWidth;     /* Read/Write size in bits (8-64) */
 
 
 typedef struct acpi_object_field_common                 /* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */

