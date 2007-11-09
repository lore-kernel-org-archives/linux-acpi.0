From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] x86: acpi_pciprobe_dmi_table[] must be __devinitdata
Date: Fri, 9 Nov 2007 07:02:11 +0100
Message-ID: <20071109060211.GP26163@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751603AbXKIGDV@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch fixes the following section mismatches with CONFIG_HOTPLUG=n:

<--  snip  -->

...
WARNING: vmlinux.o(.data+0x23640): Section mismatch: reference to .init.text.20:can_skip_ioresource_align (between 'acpi_pciprobe_dmi_table' and 'pcibios_irq_mask')
WARNING: vmlinux.o(.data+0x2366c): Section mismatch: reference to .init.text.20:can_skip_ioresource_align (between 'acpi_pciprobe_dmi_table' and 'pcibios_irq_mask')
WARNING: vmlinux.o(.data+0x23698): Section mismatch: reference to .init.text.20:can_skip_ioresource_align (between 'acpi_pciprobe_dmi_table' and 'pcibios_irq_mask')
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
3225b3c19396e0e45f496dfe82e85ebc86951d91 
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 2d88f7c..a7536dc 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -13,7 +13,7 @@ static int __devinit can_skip_ioresource_align(const struct dmi_system_id *d)
 	return 0;
 }
 
-static struct dmi_system_id acpi_pciprobe_dmi_table[] = {
+static struct dmi_system_id acpi_pciprobe_dmi_table[] __devinitdata = {
 /*
  * Systems where PCI IO resource ISA alignment can be skipped
  * when the ISA enable bit in the bridge control is not set
