From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch] fix pciehp compile issue when CONFIG_ACPI is not
	enabled.
Date: Mon, 08 May 2006 13:22:52 -0700
Message-ID: <1147119772.3094.42.camel@whizzy>
References: <1147114470.3094.14.camel@whizzy>
	 <20060508192431.GB7235@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13123 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751298AbWEHUNU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 May 2006 16:13:20 -0400
In-Reply-To: <20060508192431.GB7235@mipter.zuzino.mipt.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: arjan@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, greg@kroah.com

Fix build error when CONFIG_ACPI not defined

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
Here's an alternate way to solve this problem - also easy, that may look
nicer. (thanks arjan).

 include/linux/pci-acpi.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6-git.orig/include/linux/pci-acpi.h
+++ 2.6-git/include/linux/pci-acpi.h
@@ -50,7 +50,7 @@
 extern acpi_status pci_osc_control_set(acpi_handle handle, u32 flags);
 extern acpi_status pci_osc_support_set(u32 flags);
 #else
-#if !defined(acpi_status)
+#if !defined(AE_ERROR)
 typedef u32 		acpi_status;
 #define AE_ERROR      	(acpi_status) (0x0001)
 #endif    
