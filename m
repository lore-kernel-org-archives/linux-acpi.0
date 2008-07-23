From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: drivers/acpi/processor_idle.c: Removed duplicated include
Date: Wed, 23 Jul 2008 22:45:08 +0800
Message-ID: <20080723222044.9437.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:42025 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbYGWOpI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jul 2008 10:45:08 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1200607tic.23
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jul 2008 07:45:07 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com, lenb@kernel.org, venkatesh.pallipadi@intel.com
Cc: linux-acpi@vger.kernel.org

Removed duplicated include file <linux/cpuidle.h> in 
drivers/acpi/processor_idle.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d592dbb..77e901d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -41,7 +41,6 @@
 #include <linux/pm_qos_params.h>
 #include <linux/clockchips.h>
 #include <linux/cpuidle.h>
-#include <linux/cpuidle.h>

 /*
  * Include the apic definitions for x86 to have the APIC timer related defines

