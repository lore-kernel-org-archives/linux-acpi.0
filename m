From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: driver 8139too prevents swsusp.
Date: Mon, 10 Feb 2003 11:52:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030210105241.GA25625@poup.poupinou.org>
References: <20030208091526.GA20891@lps.ens.fr> <20030208190620.GB539@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030208190620.GB539-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 08, 2003 at 08:06:21PM +0100, Pavel Machek wrote:
> Hi!
> 
> > 
> > I have been trying S4 sleep on a 2.5.59 + acpi0123 patch kernel on my
> > computer (Shuttle motherboard, i845 chipset). The motherboard has an
> > integrated Realtek  ``RTL-8139/8139C/8139C+ (rev 10)'' ethernet card,
> > so I am using the 8139too driver compiled in the kernel.
> 
> Patch to fix this is floating around, already.

But only send to J. Garzik (my fault, sorry)..

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8139.iothread.2.5.patch"

--- linux-2.5.59/drivers/net/8139too.c	2003/02/04 17:03:24	1.1
+++ linux-2.5.59/drivers/net/8139too.c	2003/02/04 17:27:32
@@ -109,6 +109,7 @@
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/completion.h>
+#include <linux/suspend.h>
 #include <linux/crc32.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1601,6 +1602,8 @@
 		timeout = next_tick;
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_IOTHREAD);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
@@ -2570,6 +2573,8 @@
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
 	RTL_W32 (RxMissed, 0);
 
+	pci_set_power_state(pdev, state);
+
 	spin_unlock_irqrestore (&tp->lock, flags);
 	return 0;
 }
@@ -2581,6 +2586,7 @@
 
 	if (!netif_running (dev))
 		return 0;
+	pci_set_power_state(pdev, 0);
 	netif_device_attach (dev);
 	rtl8139_hw_start (dev);
 	return 0;

--FL5UXtIhxfXey3p5--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
