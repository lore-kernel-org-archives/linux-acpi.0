From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 21:57:02 +0100
Message-ID: <200412162157.02741.stefandoesinger@gmx.at>
References: <41BFC3AD.5030001@gmx.net> <200412161832.09711.stefandoesinger@gmx.at> <41C1D3CB.5010805@gmx.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eafwBNOD7tmEiO9"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41C1D3CB.5010805-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_eafwBNOD7tmEiO9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> > Just a note about 2.6.10-rc2/3 kernels: I also had some Problems with
> > them. snd-Intel8x0 needs an update concerning PCI config save/restore and
> > ehci-hcd causes problems after resume. uhci-hcd suspend/resume works for
> > me, except that I must not plug or unplug usb devices while the system is
> > supended.
>
> Could you go into more detail? Changing the hardware config while suspended
> is obviously not recommended, but what are the exact problems occuring
> besides that?
I get a kernel panic at resume if I plugged in a device while suspended 
(Capslock led blinking, screen stays black)
The system locks during resume up if I unplug a device while in S3(capslock 
led not blinking, screen stays black too.)

> > No, I think it's the kernels problem. The various framebuffer drivers 
should 
> > know how to wake up the card.
> > There were some discussions on the linux-fbdev-devel list about writing a 
> > lightwhight(20-30k) 8086 emulator for the kernel to avoid real mode hacks.
> > As far as I know, this should be based on the 8086 emulator XFree/X.org 
uses.

> Yes, but for that to work we should have a procedure in place which allows
> us to get the card working again without having to crash a secondary vesa
> xserver. If boot-radeon could be extended to do the things the crashing
> vesa xserver does, we would be much better off. That could be folded
> a) into the kernel framebuffer drivers
> b) into the radeon xserver.
In the ideal case the frame buffer driver would run the VGA Rom post 
routine($0xc000:$3) in an X86 emulator(or in vm86 mode if it works), set up 
the frame buffer and at the end of the resume function the device is in the 
same state where it was before suspend and user mode programs like the 
X-Server won't recognise that the system was suspended.
That's at least my opinion.

Boot-radeon and the others are supposed to do that(in User mode), but the 
80x86 environment they set up seems to be incorrect in some way so they crash 
before they finish their task on some systems. If it works, the display comes 
back without any Vesa X11 server.

Attached is a patch against Xorg-6.8.0 which makes the radeon X11 driver call 
the reset routine if it notices that the system was in S3. This patch is 
quite uncomfortable because it's necessary to recompile X11. It is from 
Gentoo where it is compiled by default.

Stefan

--Boundary-00=_eafwBNOD7tmEiO9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="9375_all_6.7.0-radeon-resume-from-S3-suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="9375_all_6.7.0-radeon-resume-from-S3-suspend.patch"

This enables resume from suspend level S3 by asking the Radeon chip if it
thinks it has no memory.  If so, the card is re-POSTed via the int10
interface.  Reportedly enables the driver to work for this type of
suspend/resume cycle on Dell D600 laptops (Dell D800s as well, if the video
BIOS is patched to 4.28.20.31.C1 or later). See Gentoo bug #48095 or Debian bug
#234575. This patch by Emmanuel Thome and Ole Rohne, and this info borrowed from
Debian.

--- xc/programs/Xserver/hw/xfree86/drivers/ati/radeon_driver.c	2003-10-25 00:10:20.000000000 +0200
+++ xc/programs/Xserver/hw/xfree86/drivers/ati/radeon_driver.c.new	2003-11-22 17:20:14.000000000 +0100
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


--Boundary-00=_eafwBNOD7tmEiO9--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
