From: Len Brown <len.brown@intel.com>
Subject: [BKPATCH] ACPI for 2.4
Date: 09 Nov 2004 03:17:27 -0500
Message-ID: <1099986430.5517.55.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261438AbUKIIRw@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/24-latest-release

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/24-latest-release/acpi-20040326-24-latest-release.diff.gz

This will update the following files:

 drivers/acpi/dispatcher/dsopcode.c |    3 ---
 drivers/acpi/hardware/hwsleep.c    |   20 ++++++++++----------
 2 files changed, 10 insertions(+), 13 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/11/04 1.1458.1.6)
   [ACPI] fix poweroff regression
   backport from 2.6 and ACPICA 20040427
   http://bugzilla.kernel.org/show_bug.cgi?id=2109
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/04 1.1458.1.5)
   [ACPI] fix ASUS boot crash
   http://bugzilla.kernel.org/show_bug.cgi?id=2755
   
   backported from ACPICA 20040527 in linux-2.6.9
   
   Signed-off-by: Len Brown <len.brown@intel.com>
