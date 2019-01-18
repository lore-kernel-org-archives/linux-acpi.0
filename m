From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec usage
Date: Fri, 18 Jan 2019 19:13:09 +0800
Message-ID: <20190118111310.29589-3-kasong@redhat.com>
References: <20190118111310.29589-1-kasong@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118111310.29589-1-kasong@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, dyoung@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, robert.moore@intel.com, erik.schmauss@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org, Kairui Song <kasong@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Currently we have acpi_os_get_root_pointer as the universal function
to get RSDP address. But the function itself and some functions it
depends on are in .init section and make it not easy to retrieve the
RSDP value once kernel is initialized.

And for kexec, it need to retrive RSDP again if EFI is disabled, because
the second kernel will not be able get the RSDP value in such case, so
it expects either the user specify the RSDP value using kernel cmdline,
or kexec could retrive and pass the RSDP value using boot_params.

This patch stores the RSDP address when initialized is done, and
introduce an acpi_os_get_root_pointer_late for later kexec usage.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 drivers/acpi/osl.c   | 10 ++++++++++
 include/linux/acpi.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..6340d34d0df1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -187,6 +187,16 @@ static int __init setup_acpi_rsdp(char *arg)
 	return kstrtoul(arg, 16, &acpi_rsdp);
 }
 early_param("acpi_rsdp", setup_acpi_rsdp);
+
+acpi_physical_address acpi_os_get_root_pointer_late(void) {
+	return acpi_rsdp;
+}
+
+static int __init acpi_store_root_pointer(void) {
+	acpi_rsdp = acpi_os_get_root_pointer();
+	return 0;
+}
+late_initcall(acpi_store_root_pointer);
 #endif
 
 acpi_physical_address __init acpi_os_get_root_pointer(void)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..226f2572eb8e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -892,6 +892,9 @@ static inline void arch_reserve_mem_area(acpi_physical_address addr,
 {
 }
 #endif /* CONFIG_X86 */
+#ifdef CONFIG_KEXEC
+acpi_physical_address acpi_os_get_root_pointer_late(void);
+#endif
 #else
 #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
 #endif
-- 
2.20.1
