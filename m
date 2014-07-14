From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/3] xhci: Log ep-index and comp-code on TRB DMA ptr not part of current TD
Date: Mon, 14 Jul 2014 14:35:49 +0200
Message-ID: <1405341351-32679-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439AbaGNMf7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2014 08:35:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

These errors should never happen, so lets add some extra info when they happen
to make figuring out what is going on easier.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/host/xhci-ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 749fc68..5542dfe 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2504,7 +2504,9 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 				/* HC is busted, give up! */
 				xhci_err(xhci,
 					"ERROR Transfer event TRB DMA ptr not "
-					"part of current TD\n");
+					"part of current TD ep_index %d "
+					"comp_code %u\n", ep_index,
+					trb_comp_code);
 				return -ESHUTDOWN;
 			}
 
-- 
2.0.0

