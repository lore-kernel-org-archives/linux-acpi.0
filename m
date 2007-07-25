From: Len Brown <len.brown@intel.com>
Subject: [PATCH 06/16] ACPI: fix oops due to typo in new throttling code
Date: Wed, 25 Jul 2007 01:51:15 -0400
Message-ID: <1185342691248-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12607 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbXGYFvd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:33 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <3cc2649b879f0e83fd51b14c82bad5f8f208591e.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luming Yu <luming.yu@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Luming Yu <luming.yu@gmail.com>

Signed-off-by: Luming Yu <luming.yu@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 3f55d1f..dc5b859 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -658,18 +658,20 @@ static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 		   pr->throttling.state_count - 1);
 
 	seq_puts(seq, "states:\n");
-	if (acpi_processor_get_throttling == acpi_processor_get_throttling_fadt)
+	if (pr->throttling.acpi_processor_get_throttling ==
+			acpi_processor_get_throttling_fadt) {
 		for (i = 0; i < pr->throttling.state_count; i++)
 			seq_printf(seq, "   %cT%d:                  %02d%%\n",
 				   (i == pr->throttling.state ? '*' : ' '), i,
 				   (pr->throttling.states[i].performance ? pr->
 				    throttling.states[i].performance / 10 : 0));
-	else
+	} else {
 		for (i = 0; i < pr->throttling.state_count; i++)
 			seq_printf(seq, "   %cT%d:                  %02d%%\n",
 				   (i == pr->throttling.state ? '*' : ' '), i,
 				   (int)pr->throttling.states_tss[i].
 				   freqpercentage);
+	}
 
       end:
 	return 0;
-- 
1.5.3.rc2.22.g69a9b
