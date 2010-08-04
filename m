From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/2] x86: remove early_init_lapic_mapping
Date: Wed, 04 Aug 2010 15:00:42 -0700
Message-ID: <4C59E30A.4000004@kernel.org>
References: <201008031028.57263.tvrtko.ursulin@sophos.com>	<20100804093623.GE10499@redhat.com> <m1fwyuacjs.fsf@fess.ebiederm.org>	<201008041146.56406.tvrtko.ursulin@sophos.com> <m1eiee86jg.fsf_-_@fess.ebiederm.org> <4C59E2A1.4060203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:38270 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0HDWBP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2010 18:01:15 -0400
In-Reply-To: <4C59E2A1.4060203@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


It is almost the same as smp_register_lapic_addr()

Just need to make smp_read_mpc() call smp_register_lapic_addr when early==1.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/x86/include/asm/apic.h |    1 -
 arch/x86/kernel/apic/apic.c |   24 ++----------------------
 arch/x86/kernel/mpparse.c   |    8 ++------
 arch/x86/mm/k8topology_64.c |    1 -
 4 files changed, 4 insertions(+), 30 deletions(-)

Index: linux-2.6/arch/x86/mm/k8topology_64.c
===================================================================
--- linux-2.6.orig/arch/x86/mm/k8topology_64.c
+++ linux-2.6/arch/x86/mm/k8topology_64.c
@@ -64,7 +64,6 @@ static __init void early_get_boot_cpu_id
 	if (smp_found_config)
 		early_get_smp_config();
 #endif
-	early_init_lapic_mapping();
 }
 
 int __init k8_get_nodes(struct bootnode *physnodes)
Index: linux-2.6/arch/x86/kernel/apic/apic.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/apic/apic.c
+++ linux-2.6/arch/x86/kernel/apic/apic.c
@@ -1560,28 +1560,6 @@ no_apic:
 }
 #endif
 
-#ifdef CONFIG_X86_64
-void __init early_init_lapic_mapping(void)
-{
-	/*
-	 * If no local APIC can be found then go out
-	 * : it means there is no mpatable and MADT
-	 */
-	if (!smp_found_config)
-		return;
-
-	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
-	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
-		    APIC_BASE, mp_lapic_addr);
-
-	/*
-	 * Fetch the APIC ID of the BSP in case we have a
-	 * default configuration (or the MP table is broken).
-	 */
-	boot_cpu_physical_apicid = read_apic_id();
-}
-#endif
-
 /**
  * init_apic_mappings - initialize APIC mappings
  */
@@ -1637,6 +1615,8 @@ void __init smp_register_lapic_address(u
 	mp_lapic_addr = address;
 
 	set_fixmap_nocache(FIX_APIC_BASE, address);
+	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
+		    APIC_BASE, mp_lapic_addr);
 	if (boot_cpu_physical_apicid == -1U) {
 		boot_cpu_physical_apicid  = read_apic_id();
 		apic_version[boot_cpu_physical_apicid] =
Index: linux-2.6/arch/x86/kernel/mpparse.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/mpparse.c
+++ linux-2.6/arch/x86/kernel/mpparse.c
@@ -288,17 +288,13 @@ static int __init smp_read_mpc(struct mp
 #ifdef CONFIG_X86_32
 	generic_mps_oem_check(mpc, oem, str);
 #endif
-	/* save the local APIC address, it might be non-default */
+	/* Initialize the lapic mapping */
 	if (!acpi_lapic)
-		mp_lapic_addr = mpc->lapic;
+		smp_register_lapic_address(mpc->lapic);
 
 	if (early)
 		return 1;
 
-	/* Initialize the lapic mapping */
-	if (!acpi_lapic)
-		smp_register_lapic_address(mpc->lapic);
-
 	if (mpc->oemptr)
 		x86_init.mpparse.smp_read_mpc_oem(mpc);
 
Index: linux-2.6/arch/x86/include/asm/apic.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/apic.h
+++ linux-2.6/arch/x86/include/asm/apic.h
@@ -244,7 +244,6 @@ extern void enable_NMI_through_LVT0(void
  * On 32bit this is mach-xxx local
  */
 #ifdef CONFIG_X86_64
-extern void early_init_lapic_mapping(void);
 extern int apic_is_clustered_box(void);
 #else
 static inline int apic_is_clustered_box(void)
