From: Len Brown <len.brown@intel.com>
Subject: [BKPATCH] ACPI for 2.4
Date: 31 Jan 2005 03:32:21 -0500
Message-ID: <1107160339.18002.44.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261840AbVAaIcc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/to-marcelo

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.29/acpi-20040326-2.4.29.diff.gz

This will update the following files:

 arch/i386/kernel/pci-irq.c   |    4 ++--
 arch/x86_64/kernel/pci-irq.c |    4 ++--
 drivers/acpi/pci_irq.c       |    4 ++++
 drivers/pci/quirks.c         |   30 +++++-------------------------
 4 files changed, 13 insertions(+), 29 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (05/01/26 1.1499.5.2)
   [ACPI] via interrupt quirk fix from 2.6
   http://bugzilla.kernel.org/show_bug.cgi?id=3319
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com.
