From: Len Brown <len.brown@intel.com>
Subject: [BKPATCH] ACPI for 2.4
Date: 18 Jun 2004 03:32:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1087540935.4488.214.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S265029AbUFRHdR@vger.kernel.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.27

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.27/acpi-20040326-2.4.27.diff.gz

This will update the following files:

 arch/i386/kernel/acpi.c      |    5 +++
 arch/i386/kernel/mpparse.c   |   18 ++++++++++-
 arch/x86_64/kernel/mpparse.c |    1 
 drivers/acpi/asus_acpi.c     |    4 +-
 drivers/acpi/pci_link.c      |   22 +------------
 drivers/acpi/pci_root.c      |   49 ++++++++++++++++++++++++++++++-
 drivers/acpi/thermal.c       |    7 ++++
 7 files changed, 82 insertions(+), 24 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/06/18 1.1359.6.28)
   [ACPI] handle SCI override to nth IOAPIC
   http://bugzilla.kernel.org/show_bug.cgi?id=2835

<len.brown@intel.com> (04/06/18 1.1359.6.27)
   [ACPI] fix 2.4.27-pre3 IRQ override regression
   due to dynamically allocated mp_irqs[].
   http://bugzilla.kernel.org/show_bug.cgi?id=2834

<len.brown@intel.com> (04/06/18 1.1359.6.26)
   [ACPI] avoid spurious interrupts on VIA
   http://bugzilla.kernel.org/show_bug.cgi?id=2243

<len.brown@intel.com> (04/06/18 1.1359.6.25)
   [ACPI] fix passive cooling mode indicator (Luming Yu)
   http://bugzilla.kernel.org/show_bug.cgi?id=1770

<len.brown@intel.com> (04/06/17 1.1359.6.24)
   [ACPI] PCI bus numbering workaround for ServerWorks
   from David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=1662

<sziwan@hell.org.pl> (04/06/03 1.1359.6.23)
   [PATCH] acpi4asus trivial sync with 2.6 (Karol 'sziwan' Kozimor)
