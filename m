From: Simon Derr <Simon.Derr-6ktuUTfB/bM@public.gmane.org>
Subject: Re: [PATCH] fix(Fix _STA checking in acpi_bus_add)
Date: Thu, 29 Apr 2004 10:18:16 +0200 (DFT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.A41.4.53.0404291005470.37100@isabelle.frec.bull.fr>
References: <Pine.LNX.4.58.0404281525160.30907@daphne.frec.bull.fr>
 <20040428142557.GB22558@parcelfarce.linux.theplanet.co.uk>
 <Pine.A41.4.53.0404281637220.37100@isabelle.frec.bull.fr>
 <200404280934.26381.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200404280934.26381.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Simon Derr <Simon.Derr-6ktuUTfB/bM@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 28 Apr 2004, Bjorn Helgaas wrote:

> Is your box based on Intel chipsets and/or firmware?  You might be
Indeed.

> suffering from the problem I described here:
>
>     https://sourceforge.net/mailarchive/message.php?msg_id=6923358
>
> Intel firmware seems to describe the PCI root bridge where chipset
> configuration space lives with _STA==0x8.  The spec says this means
> "functional, but not present".  The current Linux code ignores things
> that are "not present".

I tried your patch and it works perfectly. Thank you.
This chipset/firmware is probably very common in the ia64 world so I think
it might be a good idea to include your patch in the stock Linux kernel.

	Simon.

This is just your patch with updated line offsets, applies cleanly to
Linux 2.6.5:

--- linux-2.6.5-vanilla/drivers/acpi/bus.c	Sun Apr  4 05:37:24 2004
+++ linux-2.6.5/drivers/acpi/bus.c	Thu Apr 29 09:43:14 2004
@@ -112,6 +112,14 @@
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
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
