From: Kevin Hao <kexin.hao@windriver.com>
Subject: [PATCH 2/2] fix acpi ec set GPE storm flag bug
Date: Thu, 11 Sep 2008 11:17:45 +0800
Message-ID: <b1360ffe431c427477d030eb5c182e87f1fcd85a.1221102420.git.kexin.hao@windriver.com>
References: <1221103065-9123-1-git-send-email-kexin.hao@windriver.com>
 <d41e1c0a5be061176c65db7ef42263f75ae84dcb.1221102420.git.kexin.hao@windriver.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37661 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753490AbYIKDSM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2008 23:18:12 -0400
In-Reply-To: <d41e1c0a5be061176c65db7ef42263f75ae84dcb.1221102420.git.kexin.hao@windriver.com>
In-Reply-To: <d41e1c0a5be061176c65db7ef42263f75ae84dcb.1221102420.git.kexin.hao@windriver.com>
References: <d41e1c0a5be061176c65db7ef42263f75ae84dcb.1221102420.git.kexin.hao@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com, astarikovskiy@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The intent of the code was clear, however the missing braces
meant that EC_FLAGS_GPE_STORM was incorrectly being set
all the time

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
---
 drivers/acpi/ec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 0c65e82..d8f273d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -268,9 +268,10 @@ end:
 		/* it is safe to enable GPE outside of transaction */
 		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
-		   atomic_read(&ec->irq_count) > ACPI_EC_STORM_THRESHOLD)
+		   atomic_read(&ec->irq_count) > ACPI_EC_STORM_THRESHOLD) {
 		pr_debug(PREFIX "GPE storm detected\n");
 		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
+	}
 	return 0;
 }
 
-- 
1.5.6.2.220.g44701

