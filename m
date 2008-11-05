From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 10/11] ia64: remove automatic PM selection
Date: Wed, 05 Nov 2008 16:18:23 -0700
Message-ID: <20081105231823.26131.17345.stgit@bob.kio>
References: <20081105231710.26131.3110.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:47684 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbYKEXSY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 18:18:24 -0500
In-Reply-To: <20081105231710.26131.3110.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Allow ia64 to build without CONFIG_PM.

The "select PM" was added here: 8140a90ec180192b202af086e7a582e5937c5580
to work around the fact that ia64 selected ACPI, which depended on PM.
But kconfig select ignores dependencies, so allnoconfig could set
CONFIG_PM=n and break the build.

We don't need that any longer because ACPI no longer depends on PM.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/ia64/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 08559ee..333359c 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -15,7 +15,6 @@ config IA64
 	bool
 	select PCI if (!IA64_HP_SIM)
 	select ACPI if (!IA64_HP_SIM)
-	select PM if (!IA64_HP_SIM)
 	select ARCH_SUPPORTS_MSI
 	select HAVE_IDE
 	select HAVE_OPROFILE

