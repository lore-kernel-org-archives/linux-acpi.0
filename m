From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 1/3] xhci: Add clear PORT_POWER feature process in the xhci_hub_control()
Date: Fri, 25 May 2012 13:48:00 +0800
Message-ID: <1337924882-17332-2-git-send-email-tianyu.lan@intel.com>
References: <1337924882-17332-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337924882-17332-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch is to add process of clearing PORT_POWER feature request
for xhci hub.

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/host/xhci-hub.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 2732ef6..feb515e 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -827,6 +827,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			xhci_disable_port(hcd, xhci, wIndex,
 					port_array[wIndex], temp);
 			break;
+		case USB_PORT_FEAT_POWER:
+			temp = xhci_readl(xhci, port_array[wIndex])
+				& ~PORT_POWER;
+			xhci_writel(xhci, temp,	port_array[wIndex]);
+			break;
 		default:
 			goto error;
 		}
-- 
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
