From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI 2.4
Date: 29 Oct 2003 03:09:14 -0500
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1067414953.15257.17.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

	This request includes the earlier x86_64 ACPI build fix,
	plus fixes two crash regressions due to recent deltas,
	plus picks up Andrew Morton's tweak to printk from 2.6.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.23-pre8/acpi-20031002-2.4.23-pre8.diff.gz

This will update the following files:
 arch/x86_64/kernel/acpi.c          |   29 ++++++++++++++++++++++++-
 drivers/acpi/dispatcher/dsopcode.c |    8 ++----
 drivers/acpi/ec.c                  |   16 +------------
 lib/vsprintf.c                     |    3 +-
 4 files changed, 35 insertions(+), 21 deletions(-)

through these ChangeSets:

<akpm-3NddpPZAyC0@public.gmane.org> (03/10/28 1.1063.44.35)
   [PATCH] make printk more robust with "null" pointers
   
   Expand printk's traditional handling of null pointers so that
anything in the
   first page is considered a null pointer.
   
   This gives us better behaviour when someone (acpi..) accidentally
prints a
   string which is embedded in a struct, the pointer to which is null.

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/28 1.1063.44.34)
   [ACPI] REVERT ACPICA-20030918 CONFIG_ACPI_DEBUG printk that caused
crash
   http://bugzilla.kernel.org/show_bug.cgi?id=1341

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/28 1.1063.44.33)
   [ACPI] REVERT acpi_ec_gpe_query(ec) T40 fix that crashed other boxes
   http://bugme.osdl.org/show_bug.cgi?id=1171

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/10/28 1.1063.44.32)
   [ACPI] fix x86_64 build (Jeff Garzik)
