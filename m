From: joe@perches.com
Subject: [PATCH] [25/2many] MAINTAINERS - ACPI FAN DRIVER
Date: Sun, 12 Aug 2007 23:22:10 -0700
Message-ID: <46bff892.QY86DfzmPpGJRVW1%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:3456 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965511AbXHMGW0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 02:22:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konstantin.a.karasyov@intel.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index ef63c9d..e99d959 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -277,6 +277,7 @@ M:	konstantin.a.karasyov@intel.com
 L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 S:	Supported
+F:	drivers/acpi/fan.c
 
 ACPI PCI HOTPLUG DRIVER
 P:	Kristen Carlson Accardi
