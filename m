From: Lin Ming <ming.m.lin@intel.com>
Subject: RE: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
Date: Wed, 12 May 2010 09:26:48 +0800
Message-ID: <1273627608.30322.78.camel@minggr.sh.intel.com>
References: <1272505354.9950.16.camel@minggr.sh.intel.com>
	 <201004290956.26922.bjorn.helgaas@hp.com>
	 <987664A83D2D224EAE907B061CE93D53B91F9656@orsmsx505.amr.corp.intel.com>
	 <1273111119.9950.41.camel@minggr.sh.intel.com>
	 <1273543767.30322.2.camel@minggr.sh.intel.com>
	 <987664A83D2D224EAE907B061CE93D53C5D446C0@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57082 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab0ELB1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 May 2010 21:27:33 -0400
In-Reply-To: <987664A83D2D224EAE907B061CE93D53C5D446C0@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2010-05-12 at 07:01 +0800, Luck, Tony wrote:
> +#ifdef CONFIG_X86
>  static struct dmi_system_id dsdt_dmi_table[] __initdata = {
> 
> This #ifdef needs to be a few lines earlier to avoid getting a
> warning:
> 
> drivers/acpi/bus.c:73: 'set_copy_dsdt' defined but not used

Fixed it now. Thanks.

Here is new one,

Subject: [PATCH] acpi: fix early DSDT dmi check warnings on ia64

Tony Luck saw a lot of warning messages on ia64:
WARNING: at drivers/firmware/dmi_scan.c:423 dmi_matches+0x70/0x160()
dmi check: not initialized yet.

This is caused by commit aa2110c(ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT).
DMI is not initialized yet in acpi_early_init on ia64.

The DSDT dmi check table is x86 specific, so make it empty on other archs.
And this fixes the warnings on ia64.

Reported-and-tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/bus.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c0113e6..9042a85 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -69,6 +69,7 @@ static struct dmi_system_id __cpuinitdata power_nocheck_dmi_table[] = {
 };
 
 
+#ifdef CONFIG_X86
 static int set_copy_dsdt(const struct dmi_system_id *id)
 {
 	printk(KERN_NOTICE "%s detected - "
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


> 
> But otherwise this patch does work and fixes the problem.
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> 
> Insyde are now writing BIOS for ia64 systems (I have two in
> my lab). I hope they don't copy this bug from their laptop
> BIOS to my systems.  If they do, we'd have to revisit this :-)
> 
> -Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

