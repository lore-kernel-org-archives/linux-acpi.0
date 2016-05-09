From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] drivers/acpi: make evged.c explicitly non-modular
Date: Mon, 9 May 2016 14:40:27 -0400
Message-ID: <1462819227-28297-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Sinan Kaya <okaya@codeaurora.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The Makefile/Kconfig currently controlling compilation of this code is:

Makefile:acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o

drivers/acpi/Kconfig:config ACPI_REDUCED_HARDWARE_ONLY
drivers/acpi/Kconfig:   bool "Hardware-reduced ACPI support only" if EXPERT

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modularity so that when reading the
code there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

The file wasn't explicitly including the module.h file but it did
already have init.h so, unlike similar changes, this one has no
header changes at all.

We also delete the MODULE_LICENSE tag since all that information
is already contained at the top of the file in the comments.

Cc: Sinan Kaya <okaya@codeaurora.org>
c: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/evged.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index 9c0a868d7b57..46f060356a22 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -151,6 +151,4 @@ static struct platform_driver ged_driver = {
 		.acpi_match_table = ACPI_PTR(ged_acpi_ids),
 	},
 };
-
-module_platform_driver(ged_driver);
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(ged_driver);
-- 
2.8.0
