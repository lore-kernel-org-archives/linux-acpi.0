From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] allow sonypi to use ec_get ec_set in a patched linux-2.4 with latest acpi.
Date: Wed, 22 Jan 2003 16:47:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030122154726.GE18109@poup.poupinou.org>
References: <E18aorV-0004ws-00@sc8-sf-list2.sourceforge.net> <000601c2c130$4a7d1ea0$64f1dc0c@insightbb.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+g7M9IMkV8truYOl"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000601c2c130$4a7d1ea0$64f1dc0c-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James Shatto <shadow.seven-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi James,

On Tue, Jan 21, 2003 at 04:34:26AM -0500, James Shatto wrote:
> Pardon my newness to ACPI.  That being said, I have an ACPI problem.
> However inconsistent it may be.  The problem being sometimes it works, and
> when it does it keeps the computer cooler than APM, maybe even cooler than
> WinME.  But when it doesn't my laptop gets really hot and shuts itself down.
> 
> Is there anyway to fix this?
> Should I always use APM instead of ACPI?
> Should I use APM and ACPI?
> (The problem here is that SonyPI conflicts with APM)
> 
> Laptop ='s Sony Vaio - PCG-FX215 - PIII 800MHz Duron
> VIA Tech VT82C686 Power Management Controller
> 
> Power management details under windows:
> (Control Panel->System->Device Manager)
> ACPI AC Power Source
> ACPI Battery
> ACPI Embedded Controller
> ACPI Lid
> ACPI Sleep Button
> ACPI System Button
> Advanced Configuration and Power Interface BIOS
> 
> When this doesn't work, it only takes about 5 to 30 minutes for the computer
> to get hot enough for it to shut itself down.  I am running Debian
> Linux(Sarge).  With Kernel 2.4.20pre3.  I've had the same results with
> earlier 2.4 kernels, even with the ac patches.  The only real extras are
> SonyPI and the Alsa drivers for sound.  Is there a patch to fix this?  If
> so, where would I go to find it?
> 


Could you please try this patch?  You have to get acpi-20021212 or
newer apci patch for it to work.

Stelian, could we have this patch in marcello tree, please ?

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_2.4.21pre3acpi20021212_sonypi_h_allow_acpi.diff"

--- linux-2.4/drivers/char/sonypi.h	2003/01/21 10:19:05	1.1
+++ linux-2.4/drivers/char/sonypi.h	2003/01/22 13:18:44
@@ -358,6 +358,14 @@
 
 extern int verbose;
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#if (ACPI_CA_VERSION > 0x20021121)
+#define USE_ACPI
+#endif
+#endif
+
+#ifndef USE_ACPI
 static inline int ec_write(u8 addr, u8 value) {
 	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
 	outb_p(0x81, SONYPI_CST_IOPORT);
@@ -378,6 +386,7 @@
 	*value = inb_p(SONYPI_DATA_IOPORT);
 	return 0;
 }
+#endif /* USE_ACPI */
 
 #endif /* __KERNEL__ */
 

--+g7M9IMkV8truYOl--


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
