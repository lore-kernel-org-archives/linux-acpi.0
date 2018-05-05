From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] =?UTF-8?q?acpi:=20add=20missing=20prototype=20for=20?= =?UTF-8?q?=E2=80=98arch=5Fpost=5Facpi=5Fsubsys=5Finit=E2=80=99?=
Date: Sat,  5 May 2018 22:36:03 +0200
Message-ID: <20180505203603.4071-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Mathieu Malaterre <malat@debian.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

In commit e7ff3a47630d ("x86/amd: Check for the C1E bug post ACPI subsystem
init") a new function ‘arch_post_acpi_subsys_init’ was introduced. This
weak function can potentially be overridden on a per arch basis, introduce
the prototype for clarity.

Silence the following gcc warning (W=1):

  init/main.c:484:20: warning: no previous prototype for ‘arch_post_acpi_subsys_init’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/acpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 15bfb15c2fa5..cb4d7b6b085c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -578,6 +578,7 @@ int acpi_match_platform_list(const struct acpi_platform_list *plat);
 
 extern void acpi_early_init(void);
 extern void acpi_subsystem_init(void);
+extern void arch_post_acpi_subsys_init(void);
 
 extern int acpi_nvs_register(__u64 start, __u64 size);
 
-- 
2.11.0
