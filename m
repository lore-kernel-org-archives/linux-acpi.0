From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI 2.4
Date: 21 Oct 2003 23:21:18 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1066792878.2593.13.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.23-pre7/acpi-20031002-2.4.23-pre7.diff.gz

This will update the following files:

 Documentation/Configure.help      |   44 --------------------------
 arch/i386/kernel/acpi.c           |   28 ++++++++++++++++
 arch/i386/kernel/dmi_scan.c       |   16 ++++++---
 arch/i386/kernel/pci-pc.c         |   10 ++++-
 drivers/acpi/battery.c            |    6 +--
 drivers/acpi/bus.c                |    4 +-
 drivers/acpi/button.c             |    4 +-
 drivers/acpi/ec.c                 |   16 ++++++++-
 drivers/acpi/events/evgpe.c       |    4 +-
 drivers/acpi/power.c              |    7 ++--
 drivers/acpi/utilities/utdelete.c |   42 +++++++++++++++++++++++-
 11 files changed, 114 insertions(+), 67 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/20 1.1063.43.31)
   [ACPI] Broken fan detection prevents booting (Shaohua David Li)
     http://bugme.osdl.org/show_bug.cgi?id=1185

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/20 1.1063.43.30)
   [ACPI] fix use_acpi_pci !CONFIG_PCI build error per 2.6
   http://bugzilla.kernel.org/show_bug.cgi?id=1392

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/20 1.1063.43.29)
   [ACPI] fix !CONFIG_PCI build
     use X86 ACPI specific version of eisa_set_level_irq()
     http://bugzilla.kernel.org/show_bug.cgi?id=1390

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1063.43.28)
   [ACPI] correct parameter to acpi_ev_gpe_dispatch() take II (Bob
Moore)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1063.43.27)
   [ACPI] correct parameter to acpi_ev_gpe_dispatch() (Shaohua David Li)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1063.43.26)
   [ACPI] acpi_ec_gpe_query(ec) fix for T40 crash (Shaohua David Li)
   http://bugme.osdl.org/show_bug.cgi?id=1171

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1063.43.25)
   [ACPI] fix object reference count bug for battery status (Shaohua
David Li)
   http://bugme.osdl.org/show_bug.cgi?id=1038

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/17 1.1063.43.24)
   [ACPI] speed up reads from /proc/acpi/ (Shaohua David Li)
   http://bugme.osdl.org/show_bug.cgi?id=726

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/16 1.1063.43.23)
   [ACPI] delete descriptions for stale ACPI build options
