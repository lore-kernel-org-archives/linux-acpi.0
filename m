From: michel.bouley-6ktuUTfB/bM@public.gmane.org
Subject: PCI Hot Add on 2.6.0 down
Date: Thu, 16 Oct 2003 15:45:15 +0200
Sender: linux-net-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <OF6120686D.6D490FF5-ONC1256DC1.0046252A@frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-net-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-net-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I am testing "PCI HotPlug" on Tiger (Intel chipset 870)
two categories of test with "ACPI PCI Hotplug driver" :
   hot replace (an adapter in the system is replaced by another)
   - kernel 2.4.20 or 2.6.0-test[4-5] with "ACPI PCI Hotplug driver", closing latch on slot PCI put on led in GREEN

   hot add (an adapter is added to the system)
   - kernel 2.4.20 , closing latch on slot PCI put on led in GREEN
   - kernel 2.6.0-test[4-5] , closing latch on one slot PCI put on led in AMBER

What differences can to explain this behavior ?

Any ideas are welcome...
Thanks.


-
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
