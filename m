From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI 2.6
Date: 29 Oct 2003 02:59:05 -0500
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1067414344.15257.5.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0

	These two csets undo recent changes that caused crashes.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.0-test9/acpi-20031002-2.6.0-test9.diff.gz

This will update the following files:

 drivers/acpi/dispatcher/dsopcode.c |    8 +++-----
 drivers/acpi/ec.c                  |   16 ++--------------
 2 files changed, 5 insertions(+), 19 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/28 1.1373)
   [ACPI] REVERT ACPICA-20030918 CONFIG_ACPI_DEBUG printk that caused
crash
   http://bugzilla.kernel.org/show_bug.cgi?id=1341

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/28 1.1372)
   [ACPI] REVERT acpi_ec_gpe_query(ec) fix that crashed non-T40 boxes
   http://bugme.osdl.org/show_bug.cgi?id=1171
