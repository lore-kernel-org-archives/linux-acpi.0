From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 8/8] usb: enable usb port device's async suspend.
Date: Mon, 21 Jan 2013 22:18:07 +0800
Message-ID: <1358777887-2656-9-git-send-email-tianyu.lan@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358777887-2656-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/core/port.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 0334d91..50b646e 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -215,7 +215,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		pm_runtime_enable(&port_dev->dev);
 
 	usb_acpi_register_power_resources(&port_dev->dev);
