From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ACPI: SPCR: Mark expected switch fall-through in
 acpi_parse_spcr
Date: Fri, 9 Feb 2018 12:08:21 -0600
Message-ID: <20180209180821.GA20326@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-acpi@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1465078
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
This code was compiled with GCC 7.3.0

 drivers/acpi/spcr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 89e97d2..9d52743 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -115,6 +115,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 			table->serial_port.access_width))) {
 		default:
 			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
+			/* fall through */
 		case 8:
 			iotype = "mmio";
 			break;
-- 
2.7.4
