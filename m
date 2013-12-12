From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] ACPI/EC: disable gpe before removing gpe handler
Date: Thu, 12 Dec 2013 18:08:52 +0800
Message-ID: <1386842932-8057-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Adjust the order of disabling gpe and removing gpe handler to
make sure no gpe after removing gpe handler.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ff40120..172a124 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -778,9 +778,9 @@ static int ec_install_handlers(struct acpi_ec *ec)
 			pr_err("Fail in evaluating the _REG object"
 				" of EC device. Broken bios is suspected.\n");
 		} else {
+			acpi_disable_gpe(NULL, ec->gpe);
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
-			acpi_disable_gpe(NULL, ec->gpe);
 			return -ENODEV;
 		}
 	}
-- 
1.8.2.1
