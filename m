From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch] add Dock Station driver to MAINTAINERS
Date: Wed, 26 Jul 2006 10:59:25 -0700
Message-ID: <20060726105925.221718c4.kristen.c.accardi@intel.com>
References: <20060726105233.b31b5135.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:61716 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751099AbWGZR72 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jul 2006 13:59:28 -0400
In-Reply-To: <20060726105233.b31b5135.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Add the Dock driver to the MAINTAINERS file

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

--- 2.6-git.orig/MAINTAINERS
+++ 2.6-git/MAINTAINERS
@@ -882,6 +882,12 @@ M:	rdunlap@xenotime.net
 T:	git http://tali.admingilde.org/git/linux-docbook.git
 S:	Maintained
 
+DOCKING STATION DRIVER
+P:	Kristen Carlson Accardi
+M:	kristen.c.accardi@intel.com
+L:	linux-acpi@vger.kernel.org
+S:	Maintained
+
 DOUBLETALK DRIVER
 P:	James R. Van Zandt
 M:	jrv@vanzandt.mv.com
