From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 2/2] ACPI / OSL: add comment for the __ref annotation of acpi_os_unmap_iomem()
Date: Sun, 19 Jul 2015 18:50:39 +0200
Message-ID: <1437324639-18118-3-git-send-email-minipli@googlemail.com>
References: <1437324639-18118-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437324639-18118-1-git-send-email-minipli@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-acpi@vger.kernel.org

Add a comment clarifying the need for the __ref annotation of
acpi_os_unmap_iomem(). It's safe, however, as acpi_early_init() will set
acpi_gbl_permanent_mmap to 1, disabling the problematic branch.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/osl.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3b8963f21b36..7e85fb84e536 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -442,6 +442,9 @@ static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 	}
 }
 
+/* The __ref annotation is needed as during init we may call out to
+ * __acpi_unmap_table() which is an __init annotated function.
+ */
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
-- 
1.7.10.4
