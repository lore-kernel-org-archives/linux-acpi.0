From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPICA: Handle large field apertures.
Date: Tue, 25 May 2010 14:59:10 +0400
Message-ID: <20100525105910.2629.76253.stgit@thinkpad>
References: <4911F71203A09E4D9981D27F9D830858709F2D04@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:57240 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab0EYK7M (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 25 May 2010 06:59:12 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858709F2D04@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Allow field reads of more than 64 bits if the field is properly aligned.
EC driver will be able to read in bursts of up to 32 bytes with this patch.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 source/components/executer/exfldio.c |   67 ++++++++++++++++++++++------------
 source/components/executer/exprep.c  |   12 +++++-
 source/include/acobject.h            |    3 +-
 3 files changed, 54 insertions(+), 28 deletions(-)


diff --git a/source/components/executer/exfldio.c b/source/components/executer/exfldio.c
index 3276bc4..2e70763 100644
--- a/source/components/executer/exfldio.c
+++ b/source/components/executer/exfldio.c
@@ -233,9 +233,8 @@ AcpiExSetupRegion (
      * (Region length is specified in bytes)
      */
     if (RgnDesc->Region.Length <
-            (ObjDesc->CommonField.BaseByteOffset +
-            FieldDatumByteOffset +
-            ObjDesc->CommonField.AccessByteWidth))
+            (ObjDesc->CommonField.BaseByteOffset + FieldDatumByteOffset +
+             ObjDesc->CommonField.AccessByteWidth))
     {
         if (AcpiGbl_EnableInterpreterSlack)
         {
@@ -795,6 +794,7 @@ AcpiExExtractFromField (
     UINT32                  DatumCount;
     UINT32                  FieldDatumCount;
     UINT32                  i;
+    UINT32                  AccessBitWidth;
 
 
     ACPI_FUNCTION_TRACE (ExExtractFromField);
@@ -802,8 +802,7 @@ AcpiExExtractFromField (
 
     /* Validate target buffer and clear it */
 
-    if (BufferLength <
-            ACPI_ROUND_BITS_UP_TO_BYTES (ObjDesc->CommonField.BitLength))
+    if (BufferLength < ACPI_ROUND_BITS_UP_TO_BYTES (ObjDesc->CommonField.BitLength))
     {
         ACPI_ERROR ((AE_INFO,
             "Field size %u (bits) is too large for buffer (%u)",
@@ -813,15 +812,30 @@ AcpiExExtractFromField (
     }
     ACPI_MEMSET (Buffer, 0, BufferLength);
 
+    /* Simple case handling */
+    AccessBitWidth = ACPI_MUL_8(ObjDesc->CommonField.AccessByteWidth);
+    if (ObjDesc->CommonField.StartFieldBitOffset == 0 &&
+        ObjDesc->CommonField.BitLength == AccessBitWidth)
+    {
+        Status = AcpiExFieldDatumIo (ObjDesc, 0, Buffer, ACPI_READ);
+        return_ACPI_STATUS(Status);
+    }
+
+    /* Algo is limited to sizeof(UINT64), so cut the AccessByteWidth */
+    if (ObjDesc->CommonField.AccessByteWidth > sizeof(UINT64))
+    {
+        ObjDesc->CommonField.AccessByteWidth = sizeof(UINT64);
+        AccessBitWidth = ACPI_MUL_8(ObjDesc->CommonField.AccessByteWidth);
+    }
+
     /* Compute the number of datums (access width data items) */
 
     DatumCount = ACPI_ROUND_UP_TO (
-                        ObjDesc->CommonField.BitLength,
-                        ObjDesc->CommonField.AccessBitWidth);
+                        ObjDesc->CommonField.BitLength, AccessBitWidth);
     FieldDatumCount = ACPI_ROUND_UP_TO (
                         ObjDesc->CommonField.BitLength +
                         ObjDesc->CommonField.StartFieldBitOffset,
-                        ObjDesc->CommonField.AccessBitWidth);
+                        AccessBitWidth);
 
     /* Priming read from the field */
 
@@ -854,12 +868,11 @@ AcpiExExtractFromField (
          * This avoids the differences in behavior between different compilers
          * concerning shift values larger than the target data width.
          */
-        if ((ObjDesc->CommonField.AccessBitWidth -
-            ObjDesc->CommonField.StartFieldBitOffset) < ACPI_INTEGER_BIT_SIZE)
+        if (AccessBitWidth - ObjDesc->CommonField.StartFieldBitOffset <
+                ACPI_INTEGER_BIT_SIZE)
         {
             MergedDatum |= RawDatum <<
-                (ObjDesc->CommonField.AccessBitWidth -
-                    ObjDesc->CommonField.StartFieldBitOffset);
+                (AccessBitWidth - ObjDesc->CommonField.StartFieldBitOffset);
         }
 
         if (i == DatumCount)
@@ -879,8 +892,7 @@ AcpiExExtractFromField (
 
     /* Mask off any extra bits in the last datum */
 
-    BufferTailBits = ObjDesc->CommonField.BitLength %
-                        ObjDesc->CommonField.AccessBitWidth;
+    BufferTailBits = ObjDesc->CommonField.BitLength % AccessBitWidth;
     if (BufferTailBits)
     {
         MergedDatum &= ACPI_MASK_BITS_ABOVE (BufferTailBits);
@@ -928,6 +940,7 @@ AcpiExInsertIntoField (
     UINT32                  FieldDatumCount;
     UINT32                  i;
     UINT32                  RequiredLength;
+    UINT32                  AccessBitWidth;
     void                    *NewBuffer;
 
 
@@ -965,18 +978,26 @@ AcpiExInsertIntoField (
         BufferLength = RequiredLength;
     }
 
+    /* Algo is limited to sizeof(UINT64), so cut the AccessByteWidth */
+    if (ObjDesc->CommonField.AccessByteWidth > sizeof(UINT64))
+    {
+        ObjDesc->CommonField.AccessByteWidth = sizeof(UINT64);
+    }
+
+    AccessBitWidth = ACPI_MUL_8(ObjDesc->CommonField.AccessByteWidth);
+
     /*
      * Create the bitmasks used for bit insertion.
      * Note: This if/else is used to bypass compiler differences with the
      * shift operator
      */
-    if (ObjDesc->CommonField.AccessBitWidth == ACPI_INTEGER_BIT_SIZE)
+    if (AccessBitWidth == ACPI_INTEGER_BIT_SIZE)
     {
         WidthMask = ACPI_UINT64_MAX;
     }
     else
     {
-        WidthMask = ACPI_MASK_BITS_ABOVE (ObjDesc->CommonField.AccessBitWidth);
+        WidthMask = ACPI_MASK_BITS_ABOVE (AccessBitWidth);
     }
 
     Mask = WidthMask &
@@ -985,11 +1006,11 @@ AcpiExInsertIntoField (
     /* Compute the number of datums (access width data items) */
 
     DatumCount = ACPI_ROUND_UP_TO (ObjDesc->CommonField.BitLength,
-                    ObjDesc->CommonField.AccessBitWidth);
+                    AccessBitWidth);
 
     FieldDatumCount = ACPI_ROUND_UP_TO (ObjDesc->CommonField.BitLength +
                         ObjDesc->CommonField.StartFieldBitOffset,
-                        ObjDesc->CommonField.AccessBitWidth);
+                        AccessBitWidth);
 
     /* Get initial Datum from the input buffer */
 
@@ -1024,12 +1045,11 @@ AcpiExInsertIntoField (
          * This avoids the differences in behavior between different compilers
          * concerning shift values larger than the target data width.
          */
-        if ((ObjDesc->CommonField.AccessBitWidth -
-            ObjDesc->CommonField.StartFieldBitOffset) < ACPI_INTEGER_BIT_SIZE)
+        if (AccessBitWidth - ObjDesc->CommonField.StartFieldBitOffset <
+                ACPI_INTEGER_BIT_SIZE)
         {
             MergedDatum = RawDatum >>
-                (ObjDesc->CommonField.AccessBitWidth -
-                    ObjDesc->CommonField.StartFieldBitOffset);
+                (AccessBitWidth - ObjDesc->CommonField.StartFieldBitOffset);
         }
         else
         {
@@ -1055,8 +1075,7 @@ AcpiExInsertIntoField (
     /* Mask off any extra bits in the last datum */
 
     BufferTailBits = (ObjDesc->CommonField.BitLength +
-            ObjDesc->CommonField.StartFieldBitOffset) %
-                ObjDesc->CommonField.AccessBitWidth;
+            ObjDesc->CommonField.StartFieldBitOffset) % AccessBitWidth;
     if (BufferTailBits)
     {
         Mask &= ACPI_MASK_BITS_ABOVE (BufferTailBits);
diff --git a/source/components/executer/exprep.c b/source/components/executer/exprep.c
index 0709676..95fa502 100644
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
index cb6e199..e9c3d0a 100644
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

