From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [RFC] Workaround for Intel _STA quirk
Date: Fri, 2 Jan 2004 16:51:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401021651.16295.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Intel firmware for the Big Sur and Tiger ia64 boxes (and probably
others) uses an _STA value of 0x8 for the pseudo PCI root bridges
where the chipset configuration space lives, i.e., CBN or CSFF.

As far as I can tell, this is nonsensical - it says the bridge is
functional, but not present.

We can't just ignore these bridges because there are useful devices
below them.  For example, the AGP bridge on Big Sur appears under CBN.

Any thoughts on this workaround?  I know it's ugly, so if there's a
Better Way, I'd be glad to be enlightened.  (This patch is against
2.6.1-rc1).

===== drivers/acpi/bus.c 1.35 vs edited =====
--- 1.35/drivers/acpi/bus.c	Mon Oct 20 12:10:28 2003
+++ edited/drivers/acpi/bus.c	Fri Jan  2 16:43:26 2004
@@ -110,6 +110,14 @@
 	else
 		STRUCT_TO_INT(device->status) = 0x0F;
 
+	if (device->status.functional && !device->status.present) {
+		printk(KERN_WARNING PREFIX "Device [%s] status [%08x]: "
+			"functional but not present; setting present\n",
+			device->pnp.bus_id,
+			(u32) STRUCT_TO_INT(device->status));
+		device->status.present = 1;
+	}
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n", 
 		device->pnp.bus_id, (u32) STRUCT_TO_INT(device->status)));
 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
