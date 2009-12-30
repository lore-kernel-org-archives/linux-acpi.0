From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/14] ACPI: fix ACPI=n allmodconfig build
Date: Wed, 30 Dec 2009 02:36:32 -0500
Message-ID: <27d0567ab635bc2af11be48f91c8d5a7a2dca2e4.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:34194 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZL3Hgr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:36:47 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVG00C25FT7HKT3@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:36:46 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <len.brown@intel.com>

From: Ingo Molnar <mingo@elte.hu>

Today's -tip failed to build because commit
9e368fa011d4e0aa050db348d69514900520e40b ("ipmi: add PNP discovery (ACPI
namespace via PNPACPI)") from today's upstream kernel causes the following
build failure on x86, for CONFIG_ACPI=n && CONFIG_IPMI_SI=y:

 drivers/char/ipmi/ipmi_si_intf.c:3208: error: 'ipmi_pnp_driver' undeclared (first use in this function)
 drivers/char/ipmi/ipmi_si_intf.c:3208: error: (Each undeclared identifier is reported only once
 drivers/char/ipmi/ipmi_si_intf.c:3208: error: for each function it appears in.)
 drivers/char/ipmi/ipmi_si_intf.c:3334: error: 'ipmi_pnp_driver' undeclared (first use in this function)

The reason is that the ipmi_pnp_driver depends on ACPI facilities and is only
made available under ACPI - while the registration and unregistration is made
dependent on CONFIG_PNP:

 #ifdef CONFIG_PNP
 	pnp_register_driver(&ipmi_pnp_driver);
 #endif

The solution is to only register this driver under ACPI. (Also, the CONFIG_PNP
dependency is not needed because pnp_register_driver() is stubbed out in the
!CONFIG_PNP case.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 679cd08..176f175 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -3204,7 +3204,7 @@ static __devinit int init_ipmi_si(void)
 #ifdef CONFIG_ACPI
 	spmi_find_bmc();
 #endif
-#ifdef CONFIG_PNP
+#ifdef CONFIG_ACPI
 	pnp_register_driver(&ipmi_pnp_driver);
 #endif
 
@@ -3330,7 +3330,7 @@ static __exit void cleanup_ipmi_si(void)
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&ipmi_pci_driver);
 #endif
-#ifdef CONFIG_PNP
+#ifdef CONFIG_ACPI
 	pnp_unregister_driver(&ipmi_pnp_driver);
 #endif
 
-- 
1.6.0.6

