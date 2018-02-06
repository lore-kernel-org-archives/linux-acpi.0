From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ACPI / CPPC: Use 64-bit arithmetic instead of 32-bit
Date: Tue, 6 Feb 2018 17:36:17 -0600
Message-ID: <20180206233617.GA30829@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway24.websitewelcome.com ([192.185.50.66]:23713 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753862AbeBFXgT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2018 18:36:19 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id BBB271B7B8
        for <linux-acpi@vger.kernel.org>; Tue,  6 Feb 2018 17:36:18 -0600 (CST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Add suffix ULL to constant 500 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression NUM_RETRIES * cppc_ss->latency at line 578, which at
preprocessing time translates to 500 * cppc_ss->latency is currently
being evaluated using 32-bit arithmetic.

Addresses-Coverity-ID: 1382602
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Notice that another option is to cast NUM_RETRIES to u64 at line 578,
but as there is only one instace in which this macro is being used I
think adding the ULL is just enough.

 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 06ea474..0afbb26 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -119,7 +119,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
  * to PCC commands. Keeping it high enough to cover emulators where
  * the processors run painfully slow.
  */
-#define NUM_RETRIES 500
+#define NUM_RETRIES 500ULL
 
 struct cppc_attr {
 	struct attribute attr;
-- 
2.7.4

