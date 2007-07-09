From: akpm@linux-foundation.org
Subject: [patch 2/7] make cpuidle_replace_governor() static
Date: Mon, 09 Jul 2007 11:33:13 -0700
Message-ID: <200707091833.l69IXDpL000338@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48308 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754504AbXGISde (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 14:33:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bunk@stusta.de, venkatesh.pallipadi@intel.com

From: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/cpuidle/governor.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/cpuidle/governor.c~cpuidle-add-rating-to-the-governors-and-pick-the-one-with-highest-rating-by-default-fix drivers/cpuidle/governor.c
--- a/drivers/cpuidle/governor.c~cpuidle-add-rating-to-the-governors-and-pick-the-one-with-highest-rating-by-default-fix
+++ a/drivers/cpuidle/governor.c
@@ -147,7 +147,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register_gover
  * @exclude_rating: the rating that will be skipped while looking for
  * new governor.
  */
-struct cpuidle_governor *cpuidle_replace_governor(int exclude_rating)
+static struct cpuidle_governor *cpuidle_replace_governor(int exclude_rating)
 {
 	struct cpuidle_governor *gov;
 	struct cpuidle_governor *ret_gov = NULL;
_
