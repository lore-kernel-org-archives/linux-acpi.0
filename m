From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] ACPI EC driver on ia64
Date: Tue, 06 Dec 2005 13:49:32 +0900
Message-ID: <4395185C.9010802@jp.fujitsu.com>
References: <43941A47.40304@jp.fujitsu.com> <200512050911.01808.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <200512050911.01808.bjorn.helgaas@hp.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: acpi-devel@lists.sourceforge.net, len.brown@intel.com, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>> config ACPI_EC
>> 	bool
>>-	depends on X86
>>+	depends on IA64 || X86
> 
> 
> Why not just remove the "depends on" altogether?  I don't see anything
> in ec.c that's architecture-dependent.
> 

Only the reason was I didn't have x86_64 machine for testing
ACPI EC driver. But I think "depends on" should be removed,
as you said.

I'm attaching the updated patch.

Thanks,
Kenji Kaneshige


This patch removes "depends on X86" from config ACPI_EC. With this
patch, ACPI EC driver will be built also on x86_64 and ia64.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/acpi/Kconfig |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6.15-rc5/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.15-rc5.orig/drivers/acpi/Kconfig
+++ linux-2.6.15-rc5/drivers/acpi/Kconfig
@@ -269,7 +269,6 @@ config ACPI_DEBUG
 
 config ACPI_EC
 	bool
-	depends on X86
 	default y
 	help
 	  This driver is required on some systems for the proper operation of
