From: oliver@neukum.org
Subject: [PATCH] xhci: make warnings greppable
Date: Fri, 10 Jan 2014 10:51:06 +0100
Message-ID: <1389347466-8058-1-git-send-email-oliver@neukum.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:51184 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaAJJvN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2014 04:51:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, trenn@suse.de
Cc: Oliver Neukum <oneukum@suse.de>

From: Oliver Neukum <oneukum@suse.de>

This changes debug messages and warnings in xhci-ring.c
to be on a single line so grep can find them. grep must
have precedence over the 80 column limit.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/usb/host/xhci-ring.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 09b2b55..34dce53 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1081,8 +1081,7 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 
 	ep_ring = xhci_stream_id_to_ring(dev, ep_index, stream_id);
 	if (!ep_ring) {
-		xhci_warn(xhci, "WARN Set TR deq ptr command for "
-				"freed stream ID %u\n",
+		xhci_warn(xhci, "WARN Set TR deq ptr command for freed stream ID %u\n",
 				stream_id);
 		/* XXX: Harmless??? */
 		dev->eps[ep_index].ep_state &= ~SET_DEQ_PENDING;
@@ -1098,12 +1097,10 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 
 		switch (cmd_comp_code) {
 		case COMP_TRB_ERR:
-			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd invalid because "
-					"of stream ID configuration\n");
+			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd invalid because of stream ID configuration\n");
 			break;
 		case COMP_CTX_STATE:
-			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd failed due "
-					"to incorrect slot or ep state.\n");
+			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.\n");
 			ep_state = le32_to_cpu(ep_ctx->ep_info);
 			ep_state &= EP_STATE_MASK;
 			slot_state = le32_to_cpu(slot_ctx->dev_state);
@@ -1113,13 +1110,12 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 					slot_state, ep_state);
 			break;
 		case COMP_EBADSLT:
-			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd failed because "
-					"slot %u was not enabled.\n", slot_id);
+			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd failed because slot "
+					"%u was not enabled.\n", slot_id);
 			break;
 		default:
-			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd with unknown "
-					"completion code of %u.\n",
-				  cmd_comp_code);
+			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd with unknown completion code of "
+					"%u.\n", cmd_comp_code);
 			break;
 		}
 		/* OK what do we do now?  The endpoint state is hosed, and we
@@ -1141,8 +1137,7 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
 			update_ring_for_set_deq_completion(xhci, dev,
 				ep_ring, ep_index);
 		} else {
-			xhci_warn(xhci, "Mismatch between completed Set TR Deq "
-					"Ptr command & xHCI internal state.\n");
+			xhci_warn(xhci, "Mismatch between completed Set TR Deq Ptr command & xHCI internal state.\n");
 			xhci_warn(xhci, "ep deq seg = %p, deq ptr = %p\n",
 					dev->eps[ep_index].queued_deq_seg,
 					dev->eps[ep_index].queued_deq_ptr);
-- 
1.8.4

