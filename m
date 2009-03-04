From: akpm@linux-foundation.org
Subject: [patch 4/8] acpi: get_throttling_state() cannot be larger than state_count
Date: Wed, 04 Mar 2009 11:55:27 -0800
Message-ID: <200903041955.n24JtRIO027997@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39332 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756194AbZCDT4K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2009 14:56:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com, yakui.zhao@intel.com

From: Roel Kluin <roel.kluin@gmail.com>

With for(i = 0; i < n; i++) { ... } i reaches n.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_throttling.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/processor_throttling.c~acpi-get_throttling_state-cannot-be-larger-state_count drivers/acpi/processor_throttling.c
--- a/drivers/acpi/processor_throttling.c~acpi-get_throttling_state-cannot-be-larger-state_count
+++ a/drivers/acpi/processor_throttling.c
@@ -785,7 +785,7 @@ static int acpi_get_throttling_state(str
 		if (tx->control == value)
 			break;
 	}
-	if (i > pr->throttling.state_count)
+	if (i >= pr->throttling.state_count)
 		i = -1;
 	return i;
 }
_
