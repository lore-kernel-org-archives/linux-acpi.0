From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] ACPI, psargs: Fix small mem leaks on error paths
Date: Sun, 5 Feb 2012 02:12:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202050210060.30244@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from swampdragon.chaosbits.net ([90.184.90.115]:11327 "EHLO
	swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2BEBLw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Feb 2012 20:11:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>

As far as I can see, there are two small mem leaks in error paths of
'acpi_ps_get_next_field()' where we neglect to free the memory
previously allocated to 'field'.

I believe this patch should fix the leaks.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/acpi/acpica/psargs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

 Note: Compile tested only.

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 5ac36ab..a683d66 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -618,6 +618,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 				arg = acpi_ps_alloc_op(AML_INT_BYTELIST_OP);
 				if (!arg) {
+					acpi_ps_free_op(field);
 					return_PTR(NULL);
 				}
 
@@ -662,6 +663,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 		} else {
 			arg = acpi_ps_alloc_op(AML_INT_NAMEPATH_OP);
 			if (!arg) {
+				acpi_ps_free_op(field);
 				return_PTR(NULL);
 			}
 
-- 
1.7.9


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

