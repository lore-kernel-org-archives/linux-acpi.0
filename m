From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI 2.6
Date: 21 Oct 2003 23:17:48 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1066792668.2594.8.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.0-test8/acpi-20031002-2.6.0-test8.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/boot.c      |   28 +++++++++++++++++
 drivers/acpi/battery.c            |    6 +--
 drivers/acpi/bus.c                |    4 +-
 drivers/acpi/ec.c                 |   16 ++++++++-
 drivers/acpi/events/evgpe.c       |    4 +-
 drivers/acpi/power.c              |    7 +++-
 drivers/acpi/utilities/utdelete.c |   42 ++++++++++++++++++++++++--
 7 files changed, 93 insertions(+), 14 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/20 1.1350)
   [ACPI] Broken fan detection prevents booting (Shaohua David Li)
     http://bugme.osdl.org/show_bug.cgi?id=1185

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/20 1.1349)
   [ACPI] fix !CONFIG_PCI build
     use X86 ACPI specific version of eisa_set_level_irq()
     http://bugzilla.kernel.org/show_bug.cgi?id=1390

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1344.1.4)
   [ACPI] fix acpi_ev_gpe_dispatch() parameter (Bob Moore)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1344.1.3)
   [ACPI] acpi_ec_gpe_query(ec) fix for T40 crash (Shaohua David Li)
   http://bugme.osdl.org/show_bug.cgi?id=1171

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1344.1.2)
   [ACPI] fix object reference count bug for battery status (Shaohua
David Li)
   http://bugme.osdl.org/show_bug.cgi?id=1038

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1344.1.1)
   [ACPI] speed up reads from /proc/acpi/ (Shaohua David Li)
   http://bugme.osdl.org/show_bug.cgi?id=726
