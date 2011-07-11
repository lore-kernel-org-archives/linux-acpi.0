From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH v2] acpi: introduce "acpi_rsdp=" parameter for kdump
Date: Mon, 11 Jul 2011 11:14:41 -0400
Message-ID: <E8CC3FDD41FF9Findou.takao@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: amwang@redhat.com, ebiederm@xmission.com, vgoyal@redhat.com, rdunlap@xenotime.net, lenb@kernel.org, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, mjg@redhat.com
List-Id: linux-acpi@vger.kernel.org

Revised version of the patch which was posted by Cong WANG

v1:
https://lkml.org/lkml/2011/3/10/206

There is a problem with putting the first kernel in EFI virtual mode,
it is that when the second kernel comes up it tries to initialize the
EFI again and once we have put EFI in virtual mode we can not really
do that.

Actually, EFI is not necessary for kdump, we can boot the second kernel
with "noefi" parameter, but the boot will mostly fail because 2nd kernel
cannot find RSDP.

In this situation, we introduced "acpi_rsdp=" kernel parameter, so that
kexec-tools can pass the "noefi acpi_rsdp=X" to the second kernel to make
kdump works.

Changes in v2:
* Change parameter name from "acpi_addr" to "acpi_rsdp"
* Add CONFIG_KEXEC

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
[amwang@redhat.com: Add documentation.]
---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/osl.c                  |   15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index fd248a3..b88b8f1 100644
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
