From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] ACPI, x86: Extended error log driver depends on CONFIG_X86_LOCAL_APIC
Date: Fri, 08 Nov 2013 14:03:33 -0800
Message-ID: <6be3afdcad7968f7fb7c0b681e547b3e872e44dd.1383947368.git.tony.luck@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62819 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758278Ab3KHWEC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Nov 2013 17:04:02 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Chen Gong <gong.chen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Randconfig build by Fengguang's robot army reported:

   drivers/built-in.o: In function `extlog_print':
>> acpi_extlog.c:(.text+0xcc719): undefined reference to `boot_cpu_physical_apicid'

The config had CONFIG_SMP=n so we picked up this defintion from <asm/cpu.h>:
#define cpu_physical_id(cpu)                 boot_cpu_physical_apicid

But boot_cpu_physical_apicid is defined in arch/x86/kernel/apic/apic.c
which is only built if CONFIG_X86_LOCAL_APIC=y

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Ingo: This belongs on top of x86/mce branch

 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 08eadb4a57cb..e11faae81ed9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -374,7 +374,7 @@ source "drivers/acpi/apei/Kconfig"
 
 config ACPI_EXTLOG
 	tristate "Extended Error Log support"
-	depends on X86_MCE
+	depends on X86_MCE && X86_LOCAL_APIC
 	select EFI
 	select UEFI_CPER
 	default n
-- 
1.8.4.1

