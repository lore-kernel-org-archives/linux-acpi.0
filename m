From: akpm@linux-foundation.org
Subject: [patch 4/5] acpi: remove NID_INVAL
Date: Thu, 28 Jul 2011 13:48:43 -0700
Message-ID: <201107282048.p6SKmhxp007588@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60650 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754757Ab1G1Usq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jul 2011 16:48:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, rientjes@google.com

From: David Rientjes <rientjes@google.com>

b552a8c56db8 ("ACPI: remove NID_INVAL") removed the left over uses of
NID_INVAL, but didn't actually remove the definition.  Remove it.

Signed-off-by: David Rientjes <rientjes@google.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/acpi.h |    1 -
 1 file changed, 1 deletion(-)

diff -puN include/linux/acpi.h~acpi-remove-nid_inval include/linux/acpi.h
--- a/include/linux/acpi.h~acpi-remove-nid_inval
+++ a/include/linux/acpi.h
@@ -238,7 +238,6 @@ extern int acpi_paddr_to_node(u64 start_
 extern int pnpacpi_disabled;
 
 #define PXM_INVAL	(-1)
-#define NID_INVAL	(-1)
 
 int acpi_check_resource_conflict(const struct resource *res);
 
_
