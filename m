From: joe@perches.com
Subject: [PATCH] [160/2many] MAINTAINERS - DOCKING STATION DRIVER
Date: Sun, 12 Aug 2007 23:26:29 -0700
Message-ID: <46bff995.TAA7qqrnMrIxNSfv%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:4206 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966373AbXHMG0n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 02:26:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fafb83..b8ff492 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1565,6 +1565,7 @@ P:	Kristen Carlson Accardi
 M:	kristen.c.accardi@intel.com
 L:	linux-acpi@vger.kernel.org
 S:	Supported
+F:	drivers/acpi/dock.c
 
 DOUBLETALK DRIVER
 P:	James R. Van Zandt
