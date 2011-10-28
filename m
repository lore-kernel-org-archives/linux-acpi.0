From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Fri, 28 Oct 2011 03:49:25 +0200
Message-ID: <201110280349.26410.trenn@suse.de>
References: <20110929215907.21126.24480.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35342 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284Ab1J1BtK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Oct 2011 21:49:10 -0400
In-Reply-To: <20110929215907.21126.24480.stgit@amt.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com, bhelgaas@google.com

On Thursday 29 September 2011 23:59:08 Myron Stowe wrote:
..
> Myron Stowe (2):
>       ACPI: Convert acpi_pre_map_gar()/acpi_atomic_read() and remove ./drivers/acpi/atomicio.[ch]
>       ACPI: Export interfaces for ioremapping/iounmapping ACPI registers

Would be great to know whether these are going to be accepted.
If yes, this check should get removed as well:

drivers/acpi/acpica/hwregs.c:
acpi_status
acpi_hw_validate_register(struct acpi_generic_address *reg,
                          u8 max_bit_width, u64 *address)
{
...
        if (reg->bit_offset != 0) {
                ACPI_WARNING((AE_INFO,
                              "Unsupported register bit offset: 0x%X",
                              reg->bit_offset));
        }

because APEI GAR declarations do use bit_offset != 0.

There is another problem. Would be great to get some opinions/feedback
on it already:
APEI GAR entries seem to have invalid bit_width entries on some platforms.
After looking at several tables, I expect that with APEI tables access width
(in bytes) should get used instead, Windows seem to ignore bit width fields,
at least for APEI tables.

I have patches but I need to know whether your patches are accepted.

There also is a problem with modifying GAR bit_width field to be able to
pass it to the generic acpica functions (what your patches are doing).
The problem is that the structures are located in reserved BIOS areas and
they should be const and not get modified.

I have 2 solutions for this:
  1) Make apei_check_gar() pass 2 struct acpi_generic_address:
     int apei_check_gar(struct acpi_generic_address *reg,
                    const struct acpi_generic_address *orig, u64 *paddr)
     orig -> is the one located in reserved mem area, mapped to virtual addr space
     reg  -> will be a copy of it, possibly with bit_width adjusted which then
            can be passed to acpi_memory_read/write and friends.
  2) Allocate memory and copy whole APEI tables

1. Should have the advantage of less memory waste
2. Should have the advantage of a bit nicer code (kalloc and memcpy per table) and
   if more things like this happen, tables could get adjusted easily.
   It also has the advantage that GAR structures do not need to get double
   checked and eventually adjusted at runtime again.

Below is the first patch which goes for 1. More patches may be needed, but I
as said, I need to know whether your patches get accepted.
What do you think?

Thanks,

    Thomas

----
ACPI APEI: Adjust GAR checking code to what exists out there

Comparing different Generic Adress Register definitions of
different vendors it came out that bit width (at least in APEI
tables) is sometimes wrong or used different compared to older
ACPI BIOS definitions (e.g. older FACP tables).
It looks like Windows ignores the bit width field in
latest implementations. Either in APEI table parts only
(I'd say more likely) or in other ACPI parts as well.

Worst case is that an address value to be read from a GAR structure
can have a 8 bit width definition resulting in:
ERST: Can not request iomem region <0x              3f-0x              3f>
while the access width is correct:
[1B0h 0432  1]                       Action : 0D (Get Error Address Range)
[1B4h 0436 12]              Register Region : <Generic Address Structure>
[1B4h 0436  1]                     Space ID : 00 (SystemMemory)
[1B5h 0437  1]                    Bit Width : 08
[1B6h 0438  1]                   Bit Offset : 00
[1B7h 0439  1]         Encoded Access Width : 04 (QWord Access:64)
[1B8h 0440  8]                      Address : 000000007F8A8032


-> Ignore bit width field in APEI GAR checking code.
Correct bit width value if needed (derived from access width)
in the GAR structure, so that generic acpi read/write functions
can still be used.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/apei/apei-base.c     |   63 +++++++++++++++++++++++++++++-------
 drivers/acpi/apei/apei-internal.h |    2 +
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 6154036..d05f084 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -520,25 +520,53 @@ void apei_resources_release(struct apei_resources *resources)
 }
 EXPORT_SYMBOL_GPL(apei_resources_release);
 
-static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr)
+int apei_check_gar(struct acpi_generic_address *reg,
+		   const struct acpi_generic_address *orig, u64 *paddr)
 {
-	u32 width, space_id;
+	int bit_width, space_id, acc_width, acc_width_bits;
 
-	width = reg->bit_width;
+	memcpy(reg, orig, sizeof(struct acpi_generic_address));
+	bit_width = reg->bit_width;
 	space_id = reg->space_id;
+	acc_width = reg->access_width;
+
 	/* Handle possible alignment issues */
 	memcpy(paddr, &reg->address, sizeof(*paddr));
 	if (!*paddr) {
 		pr_warning(FW_BUG APEI_PFX
 			   "Invalid physical address in GAR [0x%llx/%u/%u]\n",
-			   *paddr, width, space_id);
+			   *paddr, bit_width, space_id);
 		return -EINVAL;
 	}
 
-	if ((width != 8) && (width != 16) && (width != 32) && (width != 64)) {
+	switch (acc_width) {
+	case 1:
+		acc_width_bits = 8;
+		break;
+	case 2:
+		acc_width_bits = 16;
+		break;
+	case 3:
+		acc_width_bits = 32;
+		break;
+	case 4:
+		acc_width_bits = 64;
+		break;
+	case 0:
+		/* Never seen this, acc_width should always be correct */
+		if ((bit_width == 8) || (bit_width == 16) ||
+		    (bit_width == 32) || (bit_width == 64)) {
+			pr_warning(FW_BUG APEI_PFX
+				   "Incorrect acc width, using bit width"
+				   "[%d]\n", bit_width);
+			acc_width = bit_width / 8;
+			acc_width_bits = bit_width;
+			break;
+		}
+	default:
 		pr_warning(FW_BUG APEI_PFX
-			   "Invalid bit width in GAR [0x%llx/%u/%u]\n",
-			   *paddr, width, space_id);
+			   "Invalid access width in GAR [0x%llx/%u/%u]\n",
+			   *paddr, bit_width, space_id);
 		return -EINVAL;
 	}
 
@@ -546,19 +574,28 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr)
 	    space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
 		pr_warning(FW_BUG APEI_PFX
 			   "Invalid address space type in GAR [0x%llx/%u/%u]\n",
-			   *paddr, width, space_id);
+			   *paddr, bit_width, space_id);
 		return -EINVAL;
 	}
 
+	/* bit width is not much worth in APEI GAR structures */
+	if (acc_width_bits != bit_width) {
+		pr_debug(FW_INFO APEI_PFX
+			 "Correcting bit width value 0x%x -> 0x%x\n",
+			 reg->bit_width, acc_width_bits);
+		reg->bit_width = acc_width_bits;
+	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(apei_check_gar);
 
 static int collect_res_callback(struct apei_exec_context *ctx,
 				struct acpi_whea_header *entry,
 				void *data)
 {
 	struct apei_resources *resources = data;
-	struct acpi_generic_address *reg = &entry->register_region;
+	struct acpi_generic_address reg;
+	const struct acpi_generic_address *orig = &entry->register_region;
 	u8 ins = entry->instruction;
 	u64 paddr;
 	int rc;
@@ -566,17 +603,17 @@ static int collect_res_callback(struct apei_exec_context *ctx,
 	if (!(ctx->ins_table[ins].flags & APEI_EXEC_INS_ACCESS_REGISTER))
 		return 0;
 
-	rc = apei_check_gar(reg, &paddr);
+	rc = apei_check_gar(&reg, orig, &paddr);
 	if (rc)
 		return rc;
 
-	switch (reg->space_id) {
+	switch (reg.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
 		return apei_res_add(&resources->iomem, paddr,
-				    reg->bit_width / 8);
+				    reg.bit_width / 8);
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		return apei_res_add(&resources->ioport, paddr,
-				    reg->bit_width / 8);
+				    reg.bit_width / 8);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index f57050e..63d43d8 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -82,6 +82,8 @@ int apei_exec_noop(struct apei_exec_context *ctx,
 		   struct acpi_whea_header *entry);
 int apei_exec_pre_map_gars(struct apei_exec_context *ctx);
 int apei_exec_post_unmap_gars(struct apei_exec_context *ctx);
+int apei_check_gar(struct acpi_generic_address *reg,
+		   const struct acpi_generic_address *orig, u64 *paddr);
 
 struct apei_resources {
 	struct list_head iomem;
