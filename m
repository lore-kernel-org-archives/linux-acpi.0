From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 01/10] ACPI: fix leak in debug code
Date: Mon, 24 Aug 2009 10:38:35 -0600
Message-ID: <20090824163835.28131.63789.stgit@bob.kio>
References: <20090824163659.28131.96400.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:46670 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbZHXQia (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 12:38:30 -0400
In-Reply-To: <20090824163659.28131.96400.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Free the buffer after getting the namespace pathname.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 87d3df4..cbeb4c0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1299,6 +1299,7 @@ end:
 			 (char *) buffer.pointer,
 			 device->parent ? dev_name(&device->parent->dev) :
 					  "(null)"));
+		kfree(buffer.pointer);
 		*child = device;
 	} else {
 		kfree(device->pnp.cid_list);

