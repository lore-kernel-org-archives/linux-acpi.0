From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI for 2.4
Date: 01 Apr 2004 05:40:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080816043.31353.181.camel@dhcppc4>
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
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040326-2.4.26.diff.gz

This will update the following files:

 arch/i386/kernel/acpi.c      |    4 +++
 arch/i386/kernel/io_apic.c   |    6 ++++-
 arch/x86_64/kernel/io_apic.c |    6 ++++-
 drivers/acpi/bus.c           |    5 ++++
 drivers/acpi/pci_irq.c       |   35 +++++++++++++++++--------------
 include/asm-i386/acpi.h      |    9 -------
 include/asm-i386/system.h    |    5 ----
 7 files changed, 40 insertions(+), 30 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/04/01 1.1063.46.95)
   [ACPI] Restore PIC-mode SCI default to Level Trigger (David Shaohua
Li)
   http://bugme.osdl.org/show_bug.cgi?id=2382

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/04/01 1.1063.46.94)
   [ACPI] PCI bridge interrupt fix (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2409

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/04/01 1.1063.46.93)
   [ACPI] delete extraneous IRQ->pin mappings below IRQ 16
   http://bugzilla.kernel.org/show_bug.cgi?id=2408

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/30 1.1063.46.92)
   [ACPI] allow building ACPI w/ CMPXCHG when CONFIG_M386=y
   http://bugzilla.kernel.org/show_bug.cgi?id=2391






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
