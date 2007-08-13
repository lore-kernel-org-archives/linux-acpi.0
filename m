From: joe@perches.com
Subject: [PATCH] [22/2many] MAINTAINERS - ACPI
Date: Sun, 12 Aug 2007 23:22:05 -0700
Message-ID: <46bff88d.zVo0DUSTuvIvka+P%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:3460 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965526AbXHMGWa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 02:22:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, len.brown@intel.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 1162fb7..93a100b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -251,6 +251,9 @@ L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
 S:	Supported
+F:	drivers/acpi/
+F:	drivers/ata/libata-acp*
+F:	drivers/pnp/pnpacpi/
 
 ACPI BATTERY DRIVERS
 P:	Alexey Starikovskiy
