From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 053/112] the generic thermal sysfs driver
Date: Thu, 7 Feb 2008 17:32:52 -0500
Message-ID: <200802071732.52412.lenb@kernel.org>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org> <200802071705.02695.lenb@kernel.org> <47AB81B9.1000702@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41097 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759816AbYBGWdR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 17:33:17 -0500
In-Reply-To: <47AB81B9.1000702@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>


> Lindent has several other known issues as far as Linux kernel
> is concerned.  I.e., it's not a fine tool to use and not review
> what it did.

agreed.
this is a common one -- Lindent wants a ';' between every statement:


@@ -32,7 +32,7 @@
 #include <linux/spinlock.h>

 MODULE_AUTHOR("Zhang Rui")
-MODULE_DESCRIPTION("Generic thermal management sysfs support");
+    MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");

 #define PREFIX "Thermal: "
