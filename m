From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC PATCH] ACPICA: Improve GPE detect
Date: Wed, 15 Dec 2010 15:59:36 +0800
Message-ID: <1292399976.10384.187.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8764 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab0LOHyk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Dec 2010 02:54:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi, Rafael

Currently, the ACPICA GPE interrupt handler reads all the GPE registers to
detect which GPEs, if any, have fired. This is done on each and every SCI,
since there is no way to know up front if any GPEs have been raised.

However, since ACPICA internally keeps a GPE enable mask for every GPE
register, it may be possible to ignore any GPE registers whose internal
GPE enable mask is zero. This would eliminate reading the status and enable
registers for that particular GPE register pair.

http://www.acpica.org/bugzilla/show_bug.cgi?id=884

I have tested suspend/resume and it works OK.
What do you think about below simple patch?

Thanks.
---
 drivers/acpi/acpica/evgpe.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 7c339d3..49fab43 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -373,6 +373,14 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 
 			gpe_register_info = &gpe_block->register_info[i];
 
+			if (!gpe_register_info->enable_for_run &&
+				!gpe_register_info->enable_for_wake) {
+
+				/* Disabled for both "runtime" and "wakeup", move on */
+
+				continue;
+			}
+
 			/* Read the Status Register */
 
 			status =


