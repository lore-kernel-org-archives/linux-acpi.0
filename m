From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: [PATCH]2/3 intel_menlow:Adding to MAINTAINERS
Date: Wed, 5 Nov 2008 16:15:31 +0530
Message-ID: <7D0189F5BE1DF549A570B212D1D5612182AF04@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48469 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315AbYKEKsG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 05:48:06 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

Adding a maintainer for intel's menlow thermal driver

Signed-off-by: Sujith Thomas <sujith.thomas@intel.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.27/MAINTAINERS
===================================================================
--- linux-2.6.27.orig/MAINTAINERS
+++ linux-2.6.27/MAINTAINERS
@@ -2185,6 +2185,13 @@ M:	adaplas@gmail.com
 L:	linux-fbdev-devel@lists.sourceforge.net (moderated for
non-subscribers)
 S:	Maintained
 
+INTEL MENLOW THERMAL DRIVER
+P:	Sujith Thomas
+M:	sujith.thomas@intel.com
+L:	linux-acpi@vger.kernel.org
+W:	http://www.lesswatts.org/projects/acpi/
+S:	Supported
+
 INTEL IA32 MICROCODE UPDATE SUPPORT
 P:	Tigran Aivazian
 M:	tigran@aivazian.fsnet.co.uk
