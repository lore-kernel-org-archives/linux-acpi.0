From: joe@perches.com
Subject: [PATCH] [27/2many] MAINTAINERS - ACPI THERMAL DRIVER
Date: Sun, 12 Aug 2007 23:22:14 -0700
Message-ID: <46bff896.eu+8Yn1qDA3mPeqH%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:3478 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965523AbXHMGWe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 02:22:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konstantin.a.karasyov@intel.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index aca4528..b159b00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -292,6 +292,7 @@ M:	konstantin.a.karasyov@intel.com
 L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 S:	Supported
+F:	drivers/acpi/*thermal*
 
 ACPI VIDEO DRIVER
 P:	Luming Yu
