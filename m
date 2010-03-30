From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 01/15] x86 acpi/irq: Introduce apci_isa_irq_to_gsi
Date: Tue, 30 Mar 2010 01:07:02 -0700
Message-ID: <1269936436-7039-1-git-send-email-ebiederm@xmission.com>
References: <m1oci6qlmr.fsf_-_@fess.ebiederm.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m1oci6qlmr.fsf_-_@fess.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, len.brown@intel.com, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org, Iranna D Ankad <iranna.ankad@in.ibm.com>, Gary Hade <garyhade@us.ibm.com>, Natalie Protasevich <protasnb@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-acpi@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

There are a number of cases where the current code makes the assumption
that isa irqs identity map to the first 16 acpi global system intereupts.
In most instances that assumption is correct as that is the required
behaviour in dual i8259 mode and the default behavior in ioapic mode.

However there are some systems out there that take advantage of acpis
interrupt remapping  for the isa irqs to have a completely different
mapping of isa_irq to gsi.

Introduce acpi_isa_irq_to_gsi to perform this mapping explicitly in the
code that needs it.  Initially this will be just the current assumed
identity mapping to ensure it's introduction does not cause regressions.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/kernel/acpi.c     |    8 ++++++++
 arch/x86/kernel/acpi/boot.c |    8 ++++++++
 include/linux/acpi.h        |    1 +
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index f1c9f70..16921bd 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -784,6 +784,14 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 	return 0;
 }
 
+int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
+{
+	if (isa_irq >= 16)
+		return -1;
+	*gsi = isa_irq;
+	return 0;
+}
+
 /*
  *  ACPI based hotplug CPU support
  */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 0061ea2..f96060d 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -457,6 +457,14 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 	return 0;
 }
 
+int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
+{
+	if (isa_irq >= 16)
+		return -1;
+	*gsi = isa_irq;
+	return 0;
+}
+
 /*
  * success: return IRQ number (>=0)
  * failure: return < 0
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b926afe..7a937da 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -116,6 +116,7 @@ extern unsigned long acpi_realmode_flags;
 
 int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
+int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(int bus_irq, int *trigger, int *polarity);
-- 
1.6.5.2.143.g8cc62
