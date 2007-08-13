From: joe@perches.com
Subject: [PATCH] [24/2many] MAINTAINERS - ACPI EC DRIVER
Date: Sun, 12 Aug 2007 23:22:09 -0700
Message-ID: <46bff891.lrg/Kun4A1PmeyoK%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:3458 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965523AbXHMGW1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 02:22:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 6bb5785..ef63c9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -269,6 +269,7 @@ M:	astarikovskiy@suse.de
 L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 S:	Supported
+F:	drivers/acpi/ec.c
 
 ACPI FAN DRIVER
 P:	Konstantin A. Karasyov
