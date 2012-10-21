From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] ACPICA: Don't leak next_walk_state in
 acpi_ds_call_control_method()
Date: Sun, 21 Oct 2012 22:35:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210212233180.26319@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 1010ds2-suoe.0.fullrate.dk ([90.184.90.115]:27851 "EHLO
	swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab2JUUfs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Oct 2012 16:35:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>

If acpi_ds_create_walk_state() succeeds, but the call to
ACPI_ALLOCATE_ZEROED() fails, then we'll return from the function
without properly freeing 'next_walk_state'.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/acpi/acpica/dsmethod.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index aa9a5d4..ade59a3 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -378,7 +378,8 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	 */
 	info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
 	if (!info) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto cleanup;
 	}
 
 	info->parameters = &this_walk_state->operands[0];
-- 
1.7.1


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

