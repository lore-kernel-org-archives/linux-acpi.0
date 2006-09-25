From: akpm@osdl.org
Subject: [patch 03/10] ACPI: SCI interrupt source override
Date: Mon, 25 Sep 2006 16:28:08 -0700
Message-ID: <200609252328.k8PNS8MB002173@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:6829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751670AbWIYX23 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Sep 2006 19:28:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, kimball.murray@gmail.com, ak@muc.de, david.bulkow@stratus.com, luming.yu@intel.com

From: Kimball Murray <kimball.murray@gmail.com>

The Linux group at Stratus Technologies has come across an issue with SCI
routing under ACPI.  We were bitten by this when we made an x86_64 platform
whose BIOS provides an Interrupt Source Override for the SCI itself. 
Apparently the override has no effect for the System Control Interrupt, and
this appears to be because of the way the SCI is setup in the ACPI code. 
It does not handle the case where busirq != gsi.

The code that sets up the SCI routing assumes that bus irq == global irq. 
So there is simply no provision for telling it otherwise.  The attached
patch provides this mechanism.

This patch provided by David Bulkow, was tested on an i386 platform, which
does not use the SCI override, and also on an x86_64 platform which does
use an override.

Signed-off-by: David Bulkow <david.bulkow@stratus.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/acpi/boot.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~acpi-sci-interrupt-source-override arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c~acpi-sci-interrupt-source-override
+++ a/arch/i386/kernel/acpi/boot.c
@@ -325,7 +325,7 @@ acpi_parse_ioapic(acpi_table_entry_heade
 /*
  * Parse Interrupt Source Override for the ACPI SCI
  */
-static void acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
+static void acpi_sci_ioapic_setup(u32 bus_irq, u32 gsi, u16 polarity, u16 trigger)
 {
 	if (trigger == 0)	/* compatible SCI trigger is level */
 		trigger = 3;
@@ -345,13 +345,13 @@ static void acpi_sci_ioapic_setup(u32 gs
 	 * If GSI is < 16, this will update its flags,
 	 * else it will create a new mp_irqs[] entry.
 	 */
-	mp_override_legacy_irq(gsi, polarity, trigger, gsi);
+	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
 
 	/*
 	 * stash over-ride to indicate we've been here
 	 * and for later update of acpi_fadt
 	 */
-	acpi_sci_override_gsi = gsi;
+	acpi_sci_override_gsi = bus_irq;
 	return;
 }
 
@@ -369,7 +369,7 @@ acpi_parse_int_src_ovr(acpi_table_entry_
 	acpi_table_print_madt_entry(header);
 
 	if (intsrc->bus_irq == acpi_fadt.sci_int) {
-		acpi_sci_ioapic_setup(intsrc->global_irq,
+		acpi_sci_ioapic_setup(intsrc->bus_irq, intsrc->global_irq,
 				      intsrc->flags.polarity,
 				      intsrc->flags.trigger);
 		return 0;
@@ -793,7 +793,7 @@ static int __init acpi_parse_madt_ioapic
 	 * pretend we got one so we can set the SCI flags.
 	 */
 	if (!acpi_sci_override_gsi)
-		acpi_sci_ioapic_setup(acpi_fadt.sci_int, 0, 0);
+		acpi_sci_ioapic_setup(acpi_fadt.sci_int, acpi_fadt.sci_int, 0, 0);
 
 	/* Fill in identity legacy mapings where no override */
 	mp_config_acpi_legacy_irqs();
_
