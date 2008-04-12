From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/73] ACPICA: Fixed a problem with FromBCD and ToBCD with some compilers
Date: Sat, 12 Apr 2008 00:25:20 -0400
Message-ID: <7904b1a7441132ee760e41f587449fb301ba6670.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:15947 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753479AbYDLE2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:11 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

On some compilers, the ShortDivide function worked incorrectly,
causing problems with the BCD functions with large input
values. (Truncation from 64-bit to 32-bit occurred.) Internal
BZ 435

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utmath.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/utilities/utmath.c b/drivers/acpi/utilities/utmath.c
index 0c56a0d..16dbf66 100644
--- a/drivers/acpi/utilities/utmath.c
+++ b/drivers/acpi/utilities/utmath.c
@@ -276,7 +276,7 @@ acpi_ut_short_divide(acpi_integer in_dividend,
 		*out_quotient = in_dividend / divisor;
 	}
 	if (out_remainder) {
-		*out_remainder = (u32) in_dividend % divisor;
+		*out_remainder = (u32) (in_dividend % divisor);
 	}
 
 	return_ACPI_STATUS(AE_OK);
-- 
1.5.5.29.g7134

