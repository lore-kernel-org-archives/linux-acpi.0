From: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org>
Subject: Re: D600: S1 and S3 resume
Date: Wed, 3 Dec 2003 19:18:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031203181826.GA28870@tate.loria.fr>
References: <Pine.LNX.4.30.0311251150140.19330-100000@pcd403z.vsb.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0311251150140.19330-100000-Rd/Vp7eeBLeOZheNW5JDhQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Regarding your usb problem, you might try the silly patch attached.
First make sure in any case that you shut down the usb subsystem before
suspending ! The patch does nothing intelligent, but it helps. On _my_
dell d600, running 2.6.0-test11, this prevents the uhci controllers #2
and #3 from waking up, as they are bogus on wakeup (and put unnecessary
pressure on syslog). Having only one uhci controller active means that
only the bottom usb plug is functional on S3 resume.

Patch applies to 2.6.0-test9, test10, test11 afaik.

Now note that there seems to be power management patches floating around
in linux-usb-devel. You might want to try some of them. There has to be
a proper way of resuming these usb controllers.

If you have some sort of better success with usb, do tell me. I'm
currently trying to make something decent out of the proprietary
winmodem driver from linuxant (not sure I'll be succesful: it's such a
messy crap...). Currently, the winmodem causes a lot of instability with
S3.

Regards,

E.

On Tue, Nov 25, 2003 at 01:27:01PM +0100, Petr Olivka wrote:
> Hi !
> 
>   I have more question and informations about D600 with linux:
> 
>   I tested the patch for xfree radeon_driver.c, and now video wake up
> after resume from S3.  But system is terrible slow. CPU is half second
> working and half second is stopped. I have kernel 2.6-test10, bios A05.
> 
> 
>   I have problem with resume from S1 and S3, when
> uhci-hcd and sound card is loaded. When D600 resume from S1, display "back
> to C!", "set pci latency 00:1d.0, 00:1d.1 and 00:1d.2 to 64" and hang.
> When resume from S3 I have black LCD and do not see anything.
> (I have to say, that 00:1d.0-1-2-7 are usb devices on pci.)
> 
> 
>   What kernel is at this moment the best choice for D600? 2.4 or 2.6? What
> you are using and your experiences with suspend?
> 
> 
>   And back to patch for X. I debug the code and ax, bx, cx, dx items in
> Int10 struct are zero. The "->num-0xe6" is little mystery for me.
> 
>   I did try call Int 10h using "lrmi" - linux real mode interface, but
> it failed (SIGSEGV), when try outw to some port.
> 
> 
> And last information: when I suspend to S3 in "Dock", after resume is
> display ok, even I remove the notebook from dock before wakeup. But CPU is
> slow.
> 
> 
> I did ask dell about more technical informations about D600, but they
> did say me, that all technical delatils are marked internally
> "confidential" and nobody can share them. I hope Dell will change your
> restriction and improve support for linux.
> 
> poli

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb.patch_manu"

--- linux-2.6.x-custom/drivers/usb/host/uhci-hcd.c.orig	2003-12-01 19:27:55.473667736 +0100
+++ linux-2.6.x-custom/drivers/usb/host/uhci-hcd.c	2003-12-01 19:30:05.675873992 +0100
@@ -2128,7 +2128,7 @@
 	}
 }
 
-static void start_hc(struct uhci_hcd *uhci)
+static int start_hc(struct uhci_hcd *uhci)
 {
 	unsigned int io_addr = uhci->io_addr;
 	int timeout = 1000;
@@ -2143,7 +2143,7 @@
 	while (inw(io_addr + USBCMD) & USBCMD_HCRESET) {
 		if (!--timeout) {
 			printk(KERN_ERR "uhci: USBCMD_HCRESET timed out!\n");
-			break;
+			return -ETIMEDOUT;
 		}
 	}
 
@@ -2161,6 +2161,8 @@
 	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
 
         uhci->hcd.state = USB_STATE_RUNNING;
+
+	return 0;
 }
 
 /*
@@ -2414,7 +2416,11 @@
 		uhci->fl->frame[i] = cpu_to_le32(uhci->skelqh[7 - irq]->dma_handle);
 	}
 
-	start_hc(uhci);
+	if (start_hc(uhci) == -ETIMEDOUT) {
+		init_stall_timer(hcd);
+		retval = -ENODEV;
+		goto err_alloc_skelqh;
+	}
 
 	init_stall_timer(hcd);
 

--lrZ03NoBR/3+SXJZ--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
