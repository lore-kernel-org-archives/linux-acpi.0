From: Kevin Hao <kexin.hao@windriver.com>
Subject: [PATCH 1/2] fix acpi ec read write bug
Date: Thu, 11 Sep 2008 11:17:44 +0800
Message-ID: <d41e1c0a5be061176c65db7ef42263f75ae84dcb.1221102420.git.kexin.hao@windriver.com>
References: <1221103065-9123-1-git-send-email-kexin.hao@windriver.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37587 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbYIKDR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 23:17:58 -0400
In-Reply-To: <1221103065-9123-1-git-send-email-kexin.hao@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com, astarikovskiy@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Fill in command unit of transaction_data structure, otherwise
gpe_transaction will skip read or write instruction.

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
---
 drivers/acpi/ec.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index bd3555c..0c65e82 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -240,6 +240,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 	}
 	atomic_set(&ec->irq_count, 0);
 	/* fill in transaction structure */
+	ec->t.command = command;
 	ec->t.wdata = wdata;
 	ec->t.wlen = wdata_len;
 	ec->t.rdata = rdata;
-- 
1.5.6.2.220.g44701

