From: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Subject: 2.6 won't poweroff
Date: Tue, 25 May 2004 00:45:14 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040525044514.GC2217@smeagol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I have two big irritants for the 2.6.5/2.6.6 (patched for ACPI) kernels 
with ACPI. 

	1. My computer no longer powers off. acpi_power_off is called, but the
	computer doesn't actually turn itself off. In fact when I use
	"poweroff" directly I get a message flashing across my screen saying:
		syntax error on 658 of stdin

	2. Random freezes. It's not just the touch pad or the keyboard, but
	rather the entire monitor seems to freeze from time to time and for no
	apparent reason. Gaim and xmms are usually (always?) open when it
	happens, but I can't believe that either of them would cause my system
	to freeze.

I have an AcerTM 634 that did not have either of these two problems with
2.4.22. As requested on acpi.sf.net I have also made available:

www.xtrinsic.com/geek/config/2.6.6/dmidecode.txt 
www.xtrinsic.com/geek/config/2.6.6/interrupts.txt 
www.xtrinsic.com/geek/config/2.6.6/lscpi.txt 
www.xtrinsic.com/geek/config/2.6.6/dmesg.txt

(and 2.6.5 by changing the kernel number) I installed the PMTools Debian
package, but it doesn't seem to include acpidmp. Is there a Debian package
for it?

Any suggestions would be much appreciated.

thanks,
emma

-- 
Emma Jane Hogbin
[[ 416 417 2868 ][ www.xtrinsic.com ]]


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
