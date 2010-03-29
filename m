From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 08/14] x86 ioapic: Teach mp_register_ioapic to compute a global gsi_end
Date: Mon, 29 Mar 2010 16:20:19 -0700
Message-ID: <1269904825-27462-8-git-send-email-ebiederm@xmission.com>
References: <m1r5n2wwah.fsf_-_@fess.ebiederm.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:44043 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab0C2XUw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2010 19:20:52 -0400
In-Reply-To: <m1r5n2wwah.fsf_-_@fess.ebiederm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, len.brown@intel.com, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org, Iranna D Ankad <iranna.ankad@in.ibm.com>, Gary Hade <garyhade@us.ibm.com>, Natalie Protasevich <protasnb@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>

From: Eric W. Biederman <ebiederm@xmission.com>

Add the global variable gsi_end and teach mp_register_ioapic
to keep it uptodate as we add more ioapics into the system.

ioapics can only be added early in boot so the code that
runs later can treat gsi_end as a constant.

Remove the have hacks in sfi.c to second guess mp_register_ioapic
by keeping t's own running total of how many gsi's have been seen,
and instead use the gsi_end.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86/include/asm/io_apic.h |    1 +
 arch/x86/kernel/apic/io_apic.c |    6 ++++++
 arch/x86/kernel/sfi.c          |    4 +---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index feeaf0d..37b0f2b 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -184,6 +184,7 @@ struct mp_ioapic_gsi{
 	u32 gsi_end;
 };
 extern struct mp_ioapic_gsi  mp_gsi_routing[];
+extern u32 gsi_end;
 int mp_find_ioapic(u32 gsi);
 int mp_find_ioapic_pin(int ioapic, u32 gsi);
 void __init mp_register_ioapic(int id, u32 address, u32 gsi_base);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 32cea57..a979a00 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -88,6 +88,9 @@ int nr_ioapics;
 /* IO APIC gsi routing info */
 struct mp_ioapic_gsi  mp_gsi_routing[MAX_IO_APICS];
 
+/* One past the last gsi number used */
+u32 gsi_end;
+
 /* MP IRQ source entries */
 struct mpc_intsrc mp_irqs[MAX_IRQ_SOURCES];
 
@@ -4299,6 +4302,9 @@ void __init mp_register_ioapic(int id, u32 address, u32 gsi_base)
 	mp_gsi_routing[idx].gsi_end = gsi_base +
 	    io_apic_get_redir_entries(idx);
 
+	if (mp_gsi_routing[idx].gsi_end > gsi_end)
+		gsi_end = mp_gsi_routing[idx].gsi_end;
+
 	printk(KERN_INFO "IOAPIC[%d]: apic_id %d, version %d, address 0x%x, "
 	       "GSI %d-%d\n", idx, mp_ioapics[idx].apicid,
 	       mp_ioapics[idx].apicver, mp_ioapics[idx].apicaddr,
diff --git a/arch/x86/kernel/sfi.c b/arch/x86/kernel/sfi.c
index 34e0993..7ef6df2 100644
--- a/arch/x86/kernel/sfi.c
+++ b/arch/x86/kernel/sfi.c
@@ -81,7 +81,6 @@ static int __init sfi_parse_cpus(struct sfi_table_header *table)
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
-static u32 gsi_base;
 
 static int __init sfi_parse_ioapic(struct sfi_table_header *table)
 {
@@ -94,8 +93,7 @@ static int __init sfi_parse_ioapic(struct sfi_table_header *table)
 	pentry = (struct sfi_apic_table_entry *)sb->pentry;
 
 	for (i = 0; i < num; i++) {
-		mp_register_ioapic(i, pentry->phys_addr, gsi_base);
-		gsi_base += io_apic_get_redir_entries(i);
+		mp_register_ioapic(i, pentry->phys_addr, gsi_end);
 		pentry++;
 	}
 
-- 
1.6.5.2.143.g8cc62

