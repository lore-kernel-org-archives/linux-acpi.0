From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 11/15] x86 ioapic: Move nr_ioapic_registers calculation to mp_register_ioapic.
Date: Tue, 30 Mar 2010 01:07:12 -0700
Message-ID: <1269936436-7039-11-git-send-email-ebiederm@xmission.com>
References: <m1oci6qlmr.fsf_-_@fess.ebiederm.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m1oci6qlmr.fsf_-_@fess.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, len.brown@intel.com, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org, Iranna D Ankad <iranna.ankad@in.ibm.com>, Gary Hade <garyhade@us.ibm.com>, Natalie Protasevich <protasnb@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-acpi@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

Now that all ioapic registration happens in mp_register_ioapic we can
move the calculation of nr_ioapic_registers there from enable_IO_APIC.
The number of ioapic registers is already calucated in mp_register_ioapic
so all that really needs to be done is to save the caluclated value
in nr_ioapic_registers.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86/kernel/apic/io_apic.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 71988c5..c505fe0 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1944,20 +1944,8 @@ static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
 
 void __init enable_IO_APIC(void)
 {
-	union IO_APIC_reg_01 reg_01;
 	int i8259_apic, i8259_pin;
 	int apic;
-	unsigned long flags;
-
-	/*
-	 * The number of IO-APIC IRQ registers (== #pins):
-	 */
-	for (apic = 0; apic < nr_ioapics; apic++) {
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		reg_01.raw = io_apic_read(apic, 1);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-		nr_ioapic_registers[apic] = reg_01.bits.entries+1;
-	}
 
 	if (!legacy_pic->nr_legacy_irqs)
 		return;
@@ -4284,6 +4272,7 @@ static int bad_ioapic(unsigned long address)
 void __init mp_register_ioapic(int id, u32 address, u32 gsi_base)
 {
 	int idx = 0;
+	int entries;
 
 	if (bad_ioapic(address))
 		return;
@@ -4302,9 +4291,14 @@ void __init mp_register_ioapic(int id, u32 address, u32 gsi_base)
 	 * Build basic GSI lookup table to facilitate gsi->io_apic lookups
 	 * and to prevent reprogramming of IOAPIC pins (PCI GSIs).
 	 */
+	entries = io_apic_get_redir_entries(idx);
 	mp_gsi_routing[idx].gsi_base = gsi_base;
-	mp_gsi_routing[idx].gsi_end = gsi_base +
-	    io_apic_get_redir_entries(idx) - 1;
+	mp_gsi_routing[idx].gsi_end = gsi_base + entries - 1;
+
+	/*
+	 * The number of IO-APIC IRQ registers (== #pins):
+	 */
+	nr_ioapic_registers[idx] = entries;
 
 	if (mp_gsi_routing[idx].gsi_end > gsi_end)
 		gsi_end = mp_gsi_routing[idx].gsi_end;
-- 
1.6.5.2.143.g8cc62
