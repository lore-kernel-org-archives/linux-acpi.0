From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: bay: use IS_ERR for return of register_platform_device_simple
Date: Wed, 14 Feb 2007 10:55:00 -0200
Message-ID: <20070214125459.GB4447@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48224 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932241AbXBNMzG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Feb 2007 07:55:06 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org

register_platform_device_simple returns ERR_PTR(foo), so test it with
IS_ERR(foo).

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

---

I wonder how many of these are in the kernel?  An annotation for this would be
a good idea.  It doesn't help that people, as usual, do not see fit to document
how the heck they return errors, so you have to track down the source of every
function you are not intimately familiar with before using it.
---
 drivers/acpi/bay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index dcf5f42..fb3f31b 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -281,7 +281,7 @@ static int bay_add(acpi_handle handle, int id)
 
 	/* initialize platform device stuff */
 	pdev = platform_device_register_simple(ACPI_BAY_CLASS, id, NULL, 0);
-	if (pdev == NULL) {
+	if (IS_ERR(pdev)) {
 		printk(KERN_ERR PREFIX "Error registering bay device\n");
 		goto bay_add_err;
 	}
-- 
1.4.4.4

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
