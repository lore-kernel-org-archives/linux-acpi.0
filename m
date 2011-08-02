From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/27] ACPI: introduce "acpi_rsdp=" parameter for kdump
Date: Tue, 02 Aug 2011 16:53:20 -0400
Message-ID: <4996c02306a25def1d352ec8e8f48895bbc7dea9.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab1HBVwF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:05 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:03 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, Len Brown <len.brown@intel.com>

From: Takao Indoh <indou.takao@jp.fujitsu.com>

There is a problem with putting the first kernel in EFI virtual mode,
it is that when the second kernel comes up it tries to initialize the
EFI again and once we have put EFI in virtual mode we can not really
do that.

Actually, EFI is not necessary for kdump, we can boot the second kernel
with "noefi" parameter, but the boot will mostly fail because 2nd kernel
cannot find RSDP.

In this situation, we introduced "acpi_rsdp=" kernel parameter, so that
kexec-tools can pass the "noefi acpi_rsdp=X" to the second kernel to
make kdump works. The physical address of the RSDP can be got from
sysfs(/sys/firmware/efi/systab).

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
Reviewed-by: WANG Cong <amwang@redhat.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/osl.c                  |   15 +++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index aa47be7..37713bc 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -163,6 +163,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 			See also Documentation/power/pm.txt, pci=noacpi
 
+	acpi_rsdp=	[ACPI,EFI,KEXEC]
+			Pass the RSDP address to the kernel, mostly used
+			on machines running EFI runtime service to boot the
+			second kernel for kdump.
+
 	acpi_apic_instance=	[ACPI, IOAPIC]
 			Format: <int>
 			2: use 2nd APIC table, if available
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 52ca964..27cd140 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -237,8 +237,23 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 #endif
 }
 
+#ifdef CONFIG_KEXEC
+static unsigned long acpi_rsdp;
+static int __init setup_acpi_rsdp(char *arg)
+{
+	acpi_rsdp = simple_strtoul(arg, NULL, 16);
+	return 0;
+}
+early_param("acpi_rsdp", setup_acpi_rsdp);
+#endif
+
 acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
+#ifdef CONFIG_KEXEC
+	if (acpi_rsdp)
+		return acpi_rsdp;
+#endif
+
 	if (efi_enabled) {
 		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
 			return efi.acpi20;
-- 
1.7.6.396.ge0613

