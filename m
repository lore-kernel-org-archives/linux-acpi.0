From: joe@perches.com
Subject: [PATCH] [28/2many] MAINTAINERS - ACPI VIDEO DRIVER
Date: Sun, 12 Aug 2007 23:22:16 -0700
Message-ID: <46bff898.QBRdcCdpCAEm8W02%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:3472 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965570AbXHMGWb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 02:22:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org, luming.yu@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index b159b00..4faf1ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -300,6 +300,7 @@ M:	luming.yu@intel.com
 L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 S:	Supported
+F:	drivers/acpi/video.c
 
 ADM1025 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
