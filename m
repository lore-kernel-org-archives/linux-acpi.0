From: Len Brown <len.brown@intel.com>
Subject: [PATCH 14/28] ACPI: EC: export ec_transaction() for msi-laptop driver
Date: Sat, 14 Oct 2006 04:05:55 -0400
Message-ID: <11608131873455-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35212 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752131AbWJNIDH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:07 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <ab9e43c640b2b7d6e296fc39dd8cbcb96f9ae393.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Tue, 3 Oct 2006 22:49:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lennart Poettering <mzxreary@0pointer.de>, Len Brown <len.brown@intel.com>

From: Lennart Poettering <mzxreary@0pointer.de>

Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ae05e8c..e6d4b08 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -384,6 +384,8 @@ extern int ec_transaction(u8 command,
 				   wdata_len, rdata, rdata_len);
 }
 
+EXPORT_SYMBOL(ec_transaction);
+
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 {
 	int result;
-- 
1.4.3.rc2.g23bed-dirty
