From: Pavel Vondricka <Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Subject: processor.o still slows down and hangs (Gericom Supersonic M6T)
Date: Sun, 23 Mar 2003 18:21:45 -0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303231821.45851.Pavel.Vondricka@ff.cuni.cz>
Reply-To: Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!
I still have same problems with the latest ACPI patch (2.4.21-pre5 + 
acpi-20030321). If I include (compile) processor.o code into the kernel, the 
computer slows down and after some time it hangs completely (I didn't use 
neither the modem, nor the PCMCIA). Later I moved the code to a module 
(CONFIG_ACPI_PROCESSOR=m, which also implies CONFIG_ACPI_THERMAL=m) and now 
everything runs without problems and very quickly. Well, I didn't try loading 
(insmod) these modules at all yet, because I suppose it would do the same as 
before, when compiled into the kernel.

BTW: The previus problems with 2.4.20 hanging (I also had remove the 
processor.o code from the kernel first of all) dissappeared when I moved from 
ALSA to the kernel drivers (via86CXXX), and from HostAP WiFi driver to 
linux-wlan-ng. (I only still realized some strange problems with the PCMCIA 
wifi card. Probably not problem of ACPI.)

Regards,
Pavel

-- 
###########################################################################
# mailto:Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org / ICQ:143159880 
# http://web.ff.cuni.cz/~vondric
#
# Muzete mi psat cesky s libovolnym kodovanim (UTF-8, ISO-8859-2,
# windows-1250, atd. ...)
###########################################################################


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
