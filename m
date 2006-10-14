From: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/28] ACPI: ibm_acpi: delete obsolete documentation
Date: Sat, 14 Oct 2006 04:05:59 -0400
Message-ID: <11608131922738-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:43075 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752137AbWJNIDN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:13 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <2fe6dffabb06bfa0591c8c490b092b458fba1f06.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Thu, 31 Aug 2006 14:15:54 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, Len Brown <len.brown@intel.com>

From: Pavel Machek <pavel@suse.cz>

As this module is now part of the kernel tree, there is no need
for instructions on how to download it and build an external module.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/ibm-acpi.txt |   35 +----------------------------------
 1 files changed, 1 insertions(+), 34 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index 00b8cf3..e50595b 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -53,40 +53,7 @@ Installation
 
 If you are compiling this driver as included in the Linux kernel
 sources, simply enable the CONFIG_ACPI_IBM option (Power Management /
-ACPI / IBM ThinkPad Laptop Extras). The rest of this section describes
-how to install this driver when downloaded from the web site.
-
-First, you need to get a kernel with ACPI support up and running.
-Please refer to http://acpi.sourceforge.net/ for help with this
-step. How successful you will be depends a lot on you ThinkPad model,
-the kernel you are using and any additional patches applied. The
-kernel provided with your distribution may not be good enough. I
-needed to compile a 2.6.7 kernel with the 20040715 ACPI patch to get
-ACPI working reliably on my ThinkPad X40. Old ThinkPad models may not
-be supported at all.
-
-Assuming you have the basic ACPI support working (e.g. you can see the
-/proc/acpi directory), follow the following steps to install this
-driver:
-
-	- unpack the archive:
-
-		tar xzvf ibm-acpi-x.y.tar.gz; cd ibm-acpi-x.y
-
-	- compile the driver:
-
-		make
-
-	- install the module in your kernel modules directory:
-
-		make install
-
-	- load the module:
-
-		modprobe ibm_acpi
-
-After loading the module, check the "dmesg" output for any error messages.
-
+ACPI / IBM ThinkPad Laptop Extras).
 
 Features
 --------
-- 
1.4.3.rc2.g23bed-dirty
