From: Gary Hade <garyhade@us.ibm.com>
Subject: [PATCH] ACPI, APEI: Fix incorrect APEI register bit width check
 and usage
Date: Wed, 21 Mar 2012 15:28:50 -0700
Message-ID: <20120321222850.GA7889@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:59469 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab2CUW24 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Mar 2012 18:28:56 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <garyhade@us.ibm.com>;
	Wed, 21 Mar 2012 16:28:55 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 58829C9005A
	for <linux-acpi@vger.kernel.org>; Wed, 21 Mar 2012 18:28:53 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2LMSrJ2312554
	for <linux-acpi@vger.kernel.org>; Wed, 21 Mar 2012 18:28:53 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2LMSrbO025509
	for <linux-acpi@vger.kernel.org>; Wed, 21 Mar 2012 19:28:53 -0300
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, garyhade@us.ibm.com


The current code incorrectly assumes that 
(1) the APEI register bit width is always 8, 16, 32, or 64 and
(2) the APEI register bit width is always equal to the APEI
    register access width.

ERST serialization instructions entries such as: 

[030h 0048   1]                       Action : 00 [Begin Write Operation]
[031h 0049   1]                  Instruction : 03 [Write Register Value]
[032h 0050   1]        Flags (decoded below) : 01
                      Preserve Register Bits : 1
[033h 0051   1]                     Reserved : 00

[034h 0052  12]              Register Region : [Generic Address Structure]
[034h 0052   1]                     Space ID : 00 [SystemMemory]
[035h 0053   1]                    Bit Width : 03
[036h 0054   1]                   Bit Offset : 00
[037h 0055   1]         Encoded Access Width : 03 [DWord Access:32]
[038h 0056   8]                      Address : 000000007F2D7038

[040h 0064   8]                        Value : 0000000000000001
[048h 0072   8]                         Mask : 0000000000000007

break this assumption by yielding:
  [Firmware Bug]: APEI: Invalid bit width in GAR [0x7f2d7038/3/0]

I have found no ACPI specification requirements corresponding
with the above assumptions.  There is even a good example in
the Serialization Instruction Entries section (ACPI 4.0 section
17.4,1.2, ACPI 4.0a section 2.5.1.2, ACPI 5.0 section 18.5.1.2)
that mentions a serialization instruction with a bit range of
[6:2] which is 5 bits wide, _not_ 8, 16, 32, or 64 bits wide.

Compile and boot tested with 3.3.0-rc7 on a IBM HX5.

Signed-off-by: Gary Hade <garyhade@us.ibm.com>

---
 drivers/acpi/apei/apei-base.c |   61 +++++++++++++++++++++++++++--------------
 1 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index e5d53b7..1d3656f 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -558,33 +558,48 @@ void apei_resources_release(struct apei_resources *resources)
 }
 EXPORT_SYMBOL_GPL(apei_resources_release);
 
-static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr)
+static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
+				u32 *access_bit_width)
 {
-	u32 width, space_id;
+	u32 bit_width, bit_offset, access_size_code, space_id;
 
-	width = reg->bit_width;
+	bit_width = reg->bit_width;
+	bit_offset = reg->bit_offset;
+	access_size_code = reg->access_width;
 	space_id = reg->space_id;
 	/* Handle possible alignment issues */
 	memcpy(paddr, &reg->address, sizeof(*paddr));
 	if (!*paddr) {
 		pr_warning(FW_BUG APEI_PFX
-			   "Invalid physical address in GAR [0x%llx/%u/%u]\n",
-			   *paddr, width, space_id);
+			   "Invalid physical address in GAR [0x%llx/%u/%u/%u/%u]\n",
+			   *paddr, bit_width, bit_offset, access_size_code,
+			   space_id);
 		return -EINVAL;
 	}
 
-	if ((width != 8) && (width != 16) && (width != 32) && (width != 64)) {
+	if (access_size_code < 1 || access_size_code > 4) {
 		pr_warning(FW_BUG APEI_PFX
-			   "Invalid bit width in GAR [0x%llx/%u/%u]\n",
-			   *paddr, width, space_id);
+			   "Invalid access size code in GAR [0x%llx/%u/%u/%u/%u]\n",
+			   *paddr, bit_width, bit_offset, access_size_code,
+			   space_id);
+		return -EINVAL;
+	}
+	*access_bit_width = 1UL << (access_size_code + 2);
+
+	if ((bit_width + bit_offset) > *access_bit_width) {
+		pr_warning(FW_BUG APEI_PFX
+			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
+			   *paddr, bit_width, bit_offset, access_size_code,
+			   space_id);
 		return -EINVAL;
 	}
 
 	if (space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY &&
 	    space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
 		pr_warning(FW_BUG APEI_PFX
-			   "Invalid address space type in GAR [0x%llx/%u/%u]\n",
-			   *paddr, width, space_id);
+			   "Invalid address space type in GAR [0x%llx/%u/%u/%u/%u]\n",
+			   *paddr, bit_width, bit_offset, access_size_code,
+			   space_id);
 		return -EINVAL;
 	}
 
@@ -595,23 +610,25 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr)
 int apei_read(u64 *val, struct acpi_generic_address *reg)
 {
 	int rc;
+	u32 access_bit_width;
 	u64 address;
 	acpi_status status;
 
-	rc = apei_check_gar(reg, &address);
+	rc = apei_check_gar(reg, &address, &access_bit_width);
 	if (rc)
 		return rc;
 
 	*val = 0;
 	switch(reg->space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-		status = acpi_os_read_memory64((acpi_physical_address)
-					     address, val, reg->bit_width);
+		status = acpi_os_read_memory64((acpi_physical_address) address,
+					       val, access_bit_width);
 		if (ACPI_FAILURE(status))
 			return -EIO;
 		break;
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		status = acpi_os_read_port(address, (u32 *)val, reg->bit_width);
+		status = acpi_os_read_port(address, (u32 *)val,
+					   access_bit_width);
 		if (ACPI_FAILURE(status))
 			return -EIO;
 		break;
@@ -627,22 +644,23 @@ EXPORT_SYMBOL_GPL(apei_read);
 int apei_write(u64 val, struct acpi_generic_address *reg)
 {
 	int rc;
+	u32 access_bit_width;
 	u64 address;
 	acpi_status status;
 
-	rc = apei_check_gar(reg, &address);
+	rc = apei_check_gar(reg, &address, &access_bit_width);
 	if (rc)
 		return rc;
 
 	switch (reg->space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-		status = acpi_os_write_memory64((acpi_physical_address)
-					      address, val, reg->bit_width);
+		status = acpi_os_write_memory64((acpi_physical_address) address,
+						val, access_bit_width);
 		if (ACPI_FAILURE(status))
 			return -EIO;
 		break;
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		status = acpi_os_write_port(address, val, reg->bit_width);
+		status = acpi_os_write_port(address, val, access_bit_width);
 		if (ACPI_FAILURE(status))
 			return -EIO;
 		break;
@@ -661,23 +679,24 @@ static int collect_res_callback(struct apei_exec_context *ctx,
 	struct apei_resources *resources = data;
 	struct acpi_generic_address *reg = &entry->register_region;
 	u8 ins = entry->instruction;
+	u32 access_bit_width;
 	u64 paddr;
 	int rc;
 
 	if (!(ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER))
 		return 0;
 
-	rc = apei_check_gar(reg, &paddr);
+	rc = apei_check_gar(reg, &paddr, &access_bit_width);
 	if (rc)
 		return rc;
 
 	switch (reg->space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 		return apei_res_add(&resources->iomem, paddr,
-				    reg->bit_width / 8);
+				    access_bit_width / 8);
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		return apei_res_add(&resources->ioport, paddr,
-				    reg->bit_width / 8);
+				    access_bit_width / 8);
 	default:
 		return -EINVAL;
 	}

