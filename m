From: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/25] ACPI: boot correctly with "nosmp" or "maxcpus=0"
Date: Fri, 24 Aug 2007 03:20:52 -0400
Message-ID: <11879400802531-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56620 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636AbXHXHVV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:21 -0400
In-Reply-To: <11879400794174-git-send-email-len.brown@intel.com>
Message-Id: <61ec7567db103d537329b0db9a887db570431ff4.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

In MPS mode, "nosmp" and "maxcpus=0" boot a UP kernel with IOAPIC disabled.
However, in ACPI mode, these parameters didn't completely disable
the IO APIC initialization code and boot failed.

init/main.c:
	Disable the IO_APIC if "nosmp" or "maxcpus=0"
	undefine disable_ioapic_setup() when it doesn't apply.

i386:
	delete ioapic_setup(), it was a duplicate of parse_noapic()
	delete undefinition of disable_ioapic_setup()

x86_64:
	rename disable_ioapic_setup() to parse_noapic() to match i386
	define disable_ioapic_setup() in header to match i386

http://bugzilla.kernel.org/show_bug.cgi?id=1641

Acked-by: Andi Kleen <ak@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |   15 ++++++---------
 arch/i386/kernel/io_apic.c          |    8 --------
 arch/x86_64/kernel/io_apic.c        |    8 +++-----
 include/asm-i386/io_apic.h          |    1 -
 include/asm-x86_64/io_apic.h        |    6 ++++++
 init/main.c                         |   12 ++++++++++--
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 975f029..17770b4 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -952,14 +952,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			Format: <1-256>
 
 	maxcpus=	[SMP] Maximum number of processors that	an SMP kernel
-			should make use of.
-			Using "nosmp" or "maxcpus=0" will disable SMP
-			entirely (the MPS table probe still happens, though).
-			A command-line option of "maxcpus=<NUM>", where <NUM>
-			is an integer greater than 0, limits the maximum number
-			of CPUs activated in SMP mode to <NUM>.
-			Using "maxcpus=1" on an SMP kernel is the trivial
-			case of an SMP kernel with only one CPU.
+			should make use of.  maxcpus=n : n >= 0 limits the
+			kernel to using 'n' processors.  n=0 is a special case,
+			it is equivalent to "nosmp", which also disables
+			the IO APIC.
 
 	max_addr=[KMG]	[KNL,BOOT,ia64] All physical memory greater than or
 			equal to this physical address is ignored.
@@ -1184,7 +1180,8 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	nosep		[BUGS=X86-32] Disables x86 SYSENTER/SYSEXIT support.
 
-	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel.
+	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
+			and disable the IO APIC.  legacy for "maxcpus=0".
 
 	nosoftlockup	[KNL] Disable the soft-lockup detector.
 
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 4b8a8da..e2f4a1c 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -754,14 +754,6 @@ static int pirq_entries [MAX_PIRQS];
 static int pirqs_enabled;
 int skip_ioapic_setup;
 
-static int __init ioapic_setup(char *str)
-{
-	skip_ioapic_setup = 1;
-	return 1;
-}
-
-__setup("noapic", ioapic_setup);
-
 static int __init ioapic_pirq_setup(char *str)
 {
 	int i, max;
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index f57f8b9..966fa10 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -397,14 +397,12 @@ static void clear_IO_APIC (void)
 int skip_ioapic_setup;
 int ioapic_force;
 
-/* dummy parsing: see setup.c */
-
-static int __init disable_ioapic_setup(char *str)
+static int __init parse_noapic(char *str)
 {
-	skip_ioapic_setup = 1;
+	disable_ioapic_setup();
 	return 0;
 }
-early_param("noapic", disable_ioapic_setup);
+early_param("noapic", parse_noapic);
 
 /* Actually the next is obsolete, but keep it for paranoid reasons -AK */
 static int __init disable_timer_pin_setup(char *arg)
diff --git a/include/asm-i386/io_apic.h b/include/asm-i386/io_apic.h
index 3407640..dbe734d 100644
--- a/include/asm-i386/io_apic.h
+++ b/include/asm-i386/io_apic.h
@@ -150,7 +150,6 @@ extern int (*ioapic_renumber_irq)(int ioapic, int irq);
 
 #else  /* !CONFIG_X86_IO_APIC */
 #define io_apic_assign_pci_irqs 0
-static inline void disable_ioapic_setup(void) { }
 #endif
 
 #endif
diff --git a/include/asm-x86_64/io_apic.h b/include/asm-x86_64/io_apic.h
index 969d225..d9f2e54 100644
--- a/include/asm-x86_64/io_apic.h
+++ b/include/asm-x86_64/io_apic.h
@@ -109,6 +109,12 @@ extern int mpc_default_type;
 /* 1 if "noapic" boot option passed */
 extern int skip_ioapic_setup;
 
+static inline void disable_ioapic_setup(void)
+{
+	skip_ioapic_setup = 1;
+}
+
+
 /*
  * If we use the IO-APIC for IRQ routing, disable automatic
  * assignment of PCI IRQ's.
diff --git a/init/main.c b/init/main.c
index d3bcb3b..cc0653e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -146,9 +146,14 @@ static unsigned int __initdata max_cpus = NR_CPUS;
  * greater than 0, limits the maximum number of CPUs activated in
  * SMP mode to <NUM>.
  */
+#ifndef CONFIG_X86_IO_APIC
+static inline void disable_ioapic_setup(void) {};
+#endif
+
 static int __init nosmp(char *str)
 {
 	max_cpus = 0;
+	disable_ioapic_setup();
 	return 0;
 }
 
@@ -157,10 +162,13 @@ early_param("nosmp", nosmp);
 static int __init maxcpus(char *str)
 {
 	get_option(&str, &max_cpus);
-	return 1;
+	if (max_cpus == 0)
+		disable_ioapic_setup();
+
+	return 0;
 }
 
-__setup("maxcpus=", maxcpus);
+early_param("maxcpus=", maxcpus);
 #else
 #define max_cpus NR_CPUS
 #endif
-- 
1.5.3.rc6.17.g1911
