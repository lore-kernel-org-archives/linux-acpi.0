From: Len Brown <len.brown@intel.com>
Subject: [BKPATCH] LAPIC fix for 2.6
Date: 10 Oct 2004 13:35:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1097429707.30734.21.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268379AbUJJRfi@vger.kernel.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/26-latest-release

	I recommend that we include this patch in 2.6.9.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/26-latest-release/acpi-20040816-26-latest-release.diff.gz

This will update the following files:

 arch/i386/kernel/apic.c |    6 ++++++
 1 files changed, 6 insertions(+)

through these ChangeSets:

<len.brown@intel.com> (04/10/10 1.2158)
   [ACPI] If BIOS disabled the LAPIC, believe it by default.
   "lapic" is available to force enabling the LAPIC
   in the event you know more than your BIOS vendor.
   http://bugzilla.kernel.org/show_bug.cgi?id=3238
