From: Kimball Murray <kimball.murray@gmail.com>
Subject: [PATCH] ACPI SCI interrupt source override
Date: Thu, 30 Mar 2006 15:25:52 -0500
Message-ID: <20060330202152.27940.89027.sendpatchset@dhcp83-97.boston.redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:59782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750816AbWC3UZ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Mar 2006 15:25:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: Kimball Murray <kimball.murray@gmail.com>kimball.murray@gmail.com, linux-acpi@vger.kernel.org

Greetings.  The Linux group at Stratus Technologies has come across an
issue with SCI routing under ACPI.  We were bitten by this when we made an
x86_64 platform whose BIOS provides an Interrupt Source Override for the SCI
itself.  Apparently the override has no effect for the System Control
Interrupt, and this appears to be because of the way the SCI is setup
in the ACPI code.  It does not handle the case where busirq != gsi.

The code that sets up the SCI routing assumes that bus irq == global irq.
So there is simply no provision for telling it otherwise.  The attached patch
provides this mechanism.

This patch provided by David Bulkow, was tested on an i386 platform,
which does not use the SCI override, and also on an x86_64 platform which
does use an override.

This patch was generated against Len's tree, version 2.6.16-rc5-g9dc2a5c1.

Comments welcome.  - Kimball Murray


Signed-off by: David Bulkow	<david.bulkow@stratus.com>

---------------- snip -----------------------------------------

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index f1a2194..ed2600a 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -324,7 +324,7 @@ acpi_parse_ioapic(acpi_table_entry_heade
 /*
  * Parse Interrupt Source Override for the ACPI SCI
  */
-static void acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
+static void acpi_sci_ioapic_setup(u32 busirq, u32 gsi, u16 polarity, u16 trigger)
 {
 	if (trigger == 0)	/* compatible SCI trigger is level */
 		trigger = 3;
@@ -344,13 +344,13 @@ static void acpi_sci_ioapic_setup(u32 gs
 	 * If GSI is < 16, this will update its flags,
 	 * else it will create a new mp_irqs[] entry.
 	 */
-	mp_override_legacy_irq(gsi, polarity, trigger, gsi);
+	mp_override_legacy_irq(busirq, polarity, trigger, gsi);
 
 	/*
 	 * stash over-ride to indicate we've been here
 	 * and for later update of acpi_fadt
 	 */
-	acpi_sci_override_gsi = gsi;
+        acpi_sci_override_gsi = busirq;
 	return;
 }
 
@@ -368,7 +368,8 @@ acpi_parse_int_src_ovr(acpi_table_entry_
 	acpi_table_print_madt_entry(header);
 
 	if (intsrc->bus_irq == acpi_fadt.sci_int) {
-		acpi_sci_ioapic_setup(intsrc->global_irq,
+		acpi_sci_ioapic_setup(intsrc->bus_irq,
+				      intsrc->global_irq,
 				      intsrc->flags.polarity,
 				      intsrc->flags.trigger);
 		return 0;
@@ -786,7 +787,7 @@ static int __init acpi_parse_madt_ioapic
 	 * pretend we got one so we can set the SCI flags.
 	 */
 	if (!acpi_sci_override_gsi)
-		acpi_sci_ioapic_setup(acpi_fadt.sci_int, 0, 0);
+		acpi_sci_ioapic_setup(acpi_fadt.sci_int, acpi_fadt.sci_int, 0, 0);
 
 	/* Fill in identity legacy mapings where no override */
 	mp_config_acpi_legacy_irqs();
