From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI for 2.4
Date: 07 Feb 2004 04:10:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076145024.8687.32.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.25

	the AML param fix is in 2.6 -- the others changes
	are Asus and Toshiba model specific.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.25/acpi-20040116-2.4.25.diff.gz

This will update the following files:

 drivers/acpi/asus_acpi.c           |  753 +++++++++++++++----------
 drivers/acpi/dispatcher/dsmthdat.c |   10 
 drivers/acpi/pci_irq.c             |   12 
 drivers/acpi/toshiba_acpi.c        |   81 +-
 4 files changed, 533 insertions(+), 323 deletions(-)

through these ChangeSets:

<sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> (04/02/06 1.1063.46.71)
   [PATCH] acpi4asus update from Karol 'sziwan' Kozimor
   
   The attached patch updates the acpi4asus driver to 0.27 through the
   following changes:
   - add support for M1300A, S5200N, L8400L,
   - remove WLED support for certain models, since it is not controlled
by
     AML,
   - add LCD backlight switching for L2E / L3H,
   - C99 initializers,
   - generic LED handlers,
   - the output of ASYM method to provide battery state information
(might be
     more accurate under certain conditions) in /proc/acpi/asus/info,
   - fix several oddities, various clean-ups and other minor changes.
   
   The patch itself is quite big, which is mostly due to the C99
initializers
   and the fact that diff doesn't like moving code around.
   
   This has been compile-tested in various configurations, the
substantive
   changes were discussed on the acpi4asus mailing list.
   
   The code should apply to current bk (both for 2.4 and 2.6). The patch
is
   also available here:
   http://hell.org.pl/~sziwan/asus/acpi4asus-0.26-0.27.diff
   
   Thanks to all the contributors (notably Pontus Fuchs) to this
release.

<john-wanGne27zNesTnJN9+BGXg@public.gmane.org> (04/02/05 1.1063.46.70)
   [PATCH] toshiba_acpi 0.17 from John Belmonte
   
   Fix remote chance of invalid buffer access in write_video.
   Support alternate HCI method path (recent "Phoenix BIOS" Toshiba's).
   Signal more proc-write errors.
   On proc-reads, report errors via printk instead of proc output.
   Add log level and driver name prefix to all printk's.
   Add missing __init and __exit function attributes.
   Be explicit about vars for which code relies on zero-init of BSS.

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/05 1.1063.46.69)
   [ACPI] fix IA64 build warning
   from Martin Hicks

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/01/30 1.1293)
   [ACPI] proposed fix for AML parameter passing from Bob Moore
     http://bugzilla.kernel.org/show_bug.cgi?id=1766






-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
