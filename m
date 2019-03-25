From: Matthew Garrett <matthewgarrett@google.com>
Subject: [PATCH 14/27] acpi: Ignore acpi_rsdp kernel param when the kernel has
 been locked down
Date: Mon, 25 Mar 2019 15:09:41 -0700
Message-ID: <20190325220954.29054-15-matthewgarrett@google.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jmorris@namei.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, Josh Boyer <jwboyer@redhat.com>, Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org, Matthew Garrett <matthewgarrett@google.com>
List-Id: linux-acpi@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..3e44cef7a0cd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -194,7 +194,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !kernel_is_locked_down("ACPI RSDP specification"))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.21.0.392.gf8f6787159e-goog
