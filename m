From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5]8250_pnp fix
Date: Thu, 21 Oct 2004 11:00:08 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098327571.6132.228.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VicswwPBdwvbN1Rvosxi"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu <castet.matthieu-GANU6spQydw@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-VicswwPBdwvbN1Rvosxi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This is a small fix found when debugging the 8250 driver in IA64.

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

--- 2.6/drivers/serial/8250_pnp.c.stg4	2004-09-28 11:27:42.371840736
+0800
+++ 2.6/drivers/serial/8250_pnp.c	2004-09-28 11:28:14.036027048 +0800
@@ -407,7 +407,7 @@ serial_pnp_probe(struct pnp_dev * dev, c
 	serial_req.irq = pnp_irq(dev,0);
 	serial_req.port = pnp_port_start(dev, 0);
 	if (HIGH_BITS_OFFSET)
-		serial_req.port = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
+		serial_req.port_high = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
 #ifdef SERIAL_DEBUG_PNP
 	printk("Setup PNP port: port %x, irq %d, type %d\n",
 	       serial_req.port, serial_req.irq, serial_req.io_type);


--=-VicswwPBdwvbN1Rvosxi
Content-Disposition: attachment; filename=8250.patch
Content-Type: text/x-patch; name=8250.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- 2.6/drivers/serial/8250_pnp.c.stg4	2004-09-28 11:27:42.371840736 +0800
+++ 2.6/drivers/serial/8250_pnp.c	2004-09-28 11:28:14.036027048 +0800
@@ -407,7 +407,7 @@ serial_pnp_probe(struct pnp_dev * dev, c
 	serial_req.irq = pnp_irq(dev,0);
 	serial_req.port = pnp_port_start(dev, 0);
 	if (HIGH_BITS_OFFSET)
-		serial_req.port = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
+		serial_req.port_high = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
 #ifdef SERIAL_DEBUG_PNP
 	printk("Setup PNP port: port %x, irq %d, type %d\n",
 	       serial_req.port, serial_req.irq, serial_req.io_type);

--=-VicswwPBdwvbN1Rvosxi--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
