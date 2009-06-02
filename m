From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] io_start uses unsigned int instead of int
Date: Tue, 02 Jun 2009 15:11:40 +0800
Message-ID: <1243926700.9076.1.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16854 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687AbZFBHLC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Jun 2009 03:11:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Not sure which mail list I should send to.

io_start uses unsigned int instead of int
http://bugzilla.kernel.org/show_bug.cgi?id=13253

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 kernel/resource.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/resource.c
===================================================================
--- linux-2.6.orig/kernel/resource.c
+++ linux-2.6/kernel/resource.c
@@ -787,7 +787,7 @@ static int __init reserve_setup(char *st
 	static struct resource reserve[MAXRESERVE];
 
 	for (;;) {
-		int io_start, io_num;
+		unsigned int io_start, io_num;
 		int x = reserved;
 
 		if (get_option (&str, &io_start) != 2)


