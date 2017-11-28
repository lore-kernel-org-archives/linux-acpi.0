From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/3] x86/acpi: take rsdp address for boot params if available
Date: Tue, 28 Nov 2017 10:43:59 +0100
Message-ID: <20171128094400.25955-3-jgross@suse.com>
References: <20171128094400.25955-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128094400.25955-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>
List-Id: linux-acpi@vger.kernel.org

In case the rsdp address in struct boot_params is specified don't try
to find the table by searching, but take the address directly as set
by the boot loader.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/acpi/osl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3bb46cb24a99..3b25e2ad7d75 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -45,6 +45,10 @@
 #include <linux/uaccess.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
+#ifdef CONFIG_X86
+#include <asm/setup.h>
+#endif
+
 #include "internal.h"
 
 #define _COMPONENT		ACPI_OS_SERVICES
@@ -195,6 +199,10 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	if (acpi_rsdp)
 		return acpi_rsdp;
 #endif
+#ifdef CONFIG_X86
+	if (boot_params.hdr.acpi_rsdp_addr)
+		return boot_params.hdr.acpi_rsdp_addr;
+#endif
 
 	if (efi_enabled(EFI_CONFIG_TABLES)) {
 		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
-- 
2.12.3
