From: Lin Ming <ming.m.lin@intel.com>
Subject: RE: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
Date: Tue, 11 May 2010 10:09:27 +0800
Message-ID: <1273543767.30322.2.camel@minggr.sh.intel.com>
References: <1272505354.9950.16.camel@minggr.sh.intel.com>
	 <201004290956.26922.bjorn.helgaas@hp.com>
	 <987664A83D2D224EAE907B061CE93D53B91F9656@orsmsx505.amr.corp.intel.com>
	 <1273111119.9950.41.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:55603 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203Ab0EKCKJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 May 2010 22:10:09 -0400
In-Reply-To: <1273111119.9950.41.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2010-05-06 at 09:58 +0800, Lin Ming wrote:
> On Fri, 2010-04-30 at 06:12 +0800, Luck, Tony wrote:
> > >There is not clue in the commit that added this to ia64 as to why
> > >dmi_scan_machine() was added as an initcall.  I just tried to move
> > >it into setup_arch() - immediately after the efi_init() call as in
> > >x86 - and my system hung without printing anything in boot.
> > >
> > >Agreed this would be a better fix.  I'll see if I can figure out
> > >what this call depends on, and so whether I can move is a bit later,
> > >but still early enough to be available for Ming's code to work.
> > 
> > At a random mid-point in setup_arch() I got a lot of errors from
> > slub about not being able to allocate memory.  At the very end of
> > setup_arch() (after paging_init()) it still failed - with a deref
> > NULL inside kmem_alloc().
> > 
> > So it seems to be non-trivial to just move dmi_scan_machine()
> > earlier on ia64 :-(
> 
> Sorry for late response, I'm just back from holiday.
> 
> Len, 
> Can you apply the patch since dmi_available check is needed for ia64?

Hi, all

What do you think of below new fix?

Subject: [PATCH] acpi: fix early DSDT dmi check warnings on ia64

Tony Luck saw a lot of warning messages on ia64:
WARNING: at drivers/firmware/dmi_scan.c:423 dmi_matches+0x70/0x160()
dmi check: not initialized yet.

This is caused by commit aa2110c(ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT).
DMI is not initialized yet in acpi_early_init on ia64.

The DSDT dmi check table is x86 specific, so make it empty on other archs.
And this fixes the warnings on ia64.

Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/bus.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c0113e6..6ff33a8 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -77,6 +77,7 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
 	return 0;
 }
 
+#ifdef CONFIG_X86
 static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 	/*
 	 * Insyde BIOS on some TOSHIBA machines corrupt the DSDT.
@@ -97,8 +98,14 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
 		},
-	}
+	},
+	{}
 };
+#else
+static struct dmi_system_id dsdt_dmi_table[] __initdata = {
+	{}
+};
+#endif
 
 /* --------------------------------------------------------------------------
                                 Device Management


