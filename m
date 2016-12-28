From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/18] ACPICA: Hardware: Remove bit_offset masking support
Date: Wed, 28 Dec 2016 15:28:14 +0800
Message-ID: <0af34dc41c65ffb7457c261bdbb64dbf014ed598.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit bc7c5291865e099ce01f345d0265f0eba6997e23

This linuxized ACPICA commit is a back port result of the following
Linux commit:
  Commit c3bc26d4b4e36f0dc458eea8b1f722d8a8d9addd
  Subject: ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset
           support in acpi_hw_read()

The commit was in ACPICA and Linux upstream, after reversion and
re-integration, it is designed not to do bit_offset masking (bit_offset is
only used to determine the boundary of the register) inside of the ACPICA
APIs, but let the callers to do that as:
1. Register can have different masking schemes (W1C, W0C);
2. Normally a mask value will be provided for region format GAS.
So actually the callers are the only ones having the knowledge of masking
the register values. Suggested by Bob Moore, Fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/bc7c5291
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwregs.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 3b7fb99..115c223 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -252,20 +252,6 @@ acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address *reg)
 							   &value32,
 							   access_width);
 			}
-
-			/*
-			 * Use offset style bit masks because:
-			 * bit_offset < access_width/bit_width < access_width, and
-			 * access_width is ensured to be less than 32-bits by
-			 * acpi_hw_validate_register().
-			 */
-			if (bit_offset) {
-				value32 &= ACPI_MASK_BITS_BELOW(bit_offset);
-				bit_offset = 0;
-			}
-			if (bit_width < access_width) {
-				value32 &= ACPI_MASK_BITS_ABOVE(bit_width);
-			}
 		}
 
 		/*
-- 
2.7.4
