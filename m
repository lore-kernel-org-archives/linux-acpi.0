From: Emmanuel Thome <Emmanuel.Thome+acpi-/zGXu1G9BXs@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Sat, 22 Nov 2003 17:31:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031122163147.GA26528@tate.loria.fr>
References: <20031119180119.GB22307@tate.loria.fr> <yzo1xs3ijgr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yzo1xs3ijgr.fsf-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ole.rohne-vJEk5272eHo@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Great big thanks ! Works for me as well (the int10 part for xfree ;
haven't tried fb code yet. According to benh, restoring pci state as you
do is likely not to help much).

I suggest you update your patch for the xf86 driver as in the attached
patch, still. The reason is that I've experienced failed int10 POSTs
when they turn out to be useless. There are many registers to choose
from if one wants to decide whether the card is at D3cold or not.
CONFIG_MEMSIZE being zero is just a reasonable guess IMHO.

Many thanks,

E.

P.S for acpi-devel folks: compiled a radeon_drv.o for XFree86-4.3.0 ;
it's available at http://www.loria.fr/~thome/radeon_drv.o.gz


On Thu, Nov 20, 2003 at 08:32:04AM +0100, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> I've done similar exercises on my Fujitsu P2120 (it's an M6), and I
> concluded that the card needed to go through the BIOS POST sequence,
> but for some reason s3_bios cannot be used. I tried backporting the
> powerbook code, with no result except a hanging computer. I suspect
> even ATI docs wouldn't help as they "provide" the BIOS for this
> purpose.
> 
> I eventuall hacked it using the vm86 emulator that comes with XFree86,
> plugging in a call to BIOS POST when switching virtual console; kind
> of ugly but it worked. I think I also needed some PCI hackery in the
> radeonfb resume code, not sure if that made it back into the 2.6.0
> kernel. I haven't been able to play with it at all lately as my
> machine reboots on S3 resume with recent kernels.
> 
> Regards, Ole

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=radeon_patch_xfree86

--- /usr/X11R6/lib/Server/drivers/ati/radeon_driver.c	2003-10-25 00:10:20.000000000 +0200
+++ drivers/ati/radeon_driver.c	2003-11-22 17:20:14.000000000 +0100
@@ -345,6 +345,7 @@
     "xf86InitInt10",
     "xf86FreeInt10",
     "xf86int10Addr",
+    "xf86ExecX86int10",
     NULL
 };
 
@@ -6409,9 +6410,22 @@
 {
     ScrnInfoPtr    pScrn = xf86Screens[scrnIndex];
     RADEONInfoPtr  info  = RADEONPTR(pScrn);
+    unsigned char * RADEONMMIO = info->MMIO;
 
     RADEONTRACE(("RADEONEnterVT\n"));
 
+    if (INREG(RADEON_CONFIG_MEMSIZE) == 0) { /* Softboot V_BIOS */
+      xf86Int10InfoPtr pInt;
+	xf86DrvMsg(pScrn->scrnIndex, X_WARNING,
+	       "zero MEMSIZE, probably at D3cold. Re-POSTing via int10.\n");
+      pInt = xf86InitInt10 (info->pEnt->index);
+      if (pInt) {
+        pInt->num = 0xe6;
+        xf86ExecX86int10 (pInt);
+        xf86FreeInt10 (pInt);
+      }
+    }
+
     if (info->FBDev) {
 	unsigned char *RADEONMMIO = info->MMIO;
 	if (!fbdevHWEnterVT(scrnIndex,flags)) return FALSE;

--SLDf9lqlvOQaIe6s--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
