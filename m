From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3] ACPICA / Hardware: Fix old register check in acpi_hw_get_access_bit_width()
Date: Wed,  1 Jun 2016 11:03:20 +0800
Message-ID: <076e22f0e5fdd4e4322b65e169a53945cb0a3962.1464750066.git.lv.zheng@intel.com>
References: <fc78867f000b99f4c692876a77b3ea061e44a368>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3728 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbcFADDl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 May 2016 23:03:41 -0400
In-Reply-To: <fc78867f000b99f4c692876a77b3ea061e44a368>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The address check in acpi_hw_get_access_bit_width() should be byte width
based, not bit width based. This patch fixes this mistake.

For those who want to review acpi_hw_access_bit_width(), here is the
concerns and the design details of the function:

It is supposed that the GAS Address field should be aligned to the byte
width indicated by the GAS AccessSize field. Similarly, for the old non
GAS register, it is supposed that its Address should be aligned to its
Length.
For the "AccessSize = 0 (meaning ANY)" case, we try to return the maximum
instruction width (64 for MMIO or 32 for PIO) or the user expected access
bit width (64 for acpi_read()/acpi_write() or 32 for acpi_hw_read()/
acpi_hw_write()) and it is supposed that the GAS Address field should
always be aligned to the maximum expected access bit width (otherwise it
can't be accessed using ANY access bit width).

The problem is in acpi_tb_init_generic_address(), where the non GAS
register's Length is converted into the GAS BitWidth field, its Address is
converted into the GAS Address field, and the GAS AccessSize field is left
0 but most of the registers actually cannot be accessed using "ANY"
accesses.

As a conclusion, when AccessSize = 0 (ANY), the Address should either be
aligned to the BitWidth (wrong conversion) or aligned to 32 for PIO or 64
for MMIO (real GAS). Since currently, max_bit_width is 32, then:
1. BitWidth for the wrong conversion is 8,16,32; and
2. The Address of the real GAS should always be aligned to 8,16,32.
The address alignment check to exclude false matched real GAS is not
necessary. Thus this patch fixes the issue by removing the address
alignment check.
OTOH, we in fact could use a simpler check of
"reg->bit_width < max_bit_width" to exclude the "BitWidth=64 PIO" case that
may be issued from acpi_read()/acpi_write() in the future.

Fixes: b314a172ee96 ("ACPICA: Hardware: Add optimized access bit width support")
Reported-and-tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Mike Marshall <hubcap@omnibond.com>
Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwregs.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 0f18dbc..daceb80 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -83,27 +83,22 @@ acpi_hw_write_multiple(u32 value,
 static u8
 acpi_hw_get_access_bit_width(struct acpi_generic_address *reg, u8 max_bit_width)
 {
-	u64 address;
-
 	if (!reg->access_width) {
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+			max_bit_width = 32;
+		}
+
 		/*
 		 * Detect old register descriptors where only the bit_width field
-		 * makes senses. The target address is copied to handle possible
-		 * alignment issues.
+		 * makes senses.
 		 */
-		ACPI_MOVE_64_TO_64(&address, &reg->address);
-		if (!reg->bit_offset && reg->bit_width &&
+		if (reg->bit_width < max_bit_width &&
+		    !reg->bit_offset && reg->bit_width &&
 		    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
-		    ACPI_IS_ALIGNED(reg->bit_width, 8) &&
-		    ACPI_IS_ALIGNED(address, reg->bit_width)) {
+		    ACPI_IS_ALIGNED(reg->bit_width, 8)) {
 			return (reg->bit_width);
-		} else {
-			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-				return (32);
-			} else {
-				return (max_bit_width);
-			}
 		}
+		return (max_bit_width);
 	} else {
 		return (1 << (reg->access_width + 2));
 	}
-- 
1.7.10

