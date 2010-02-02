From: akpm@linux-foundation.org
Subject: [patch for 2.6.33? 1/1] drivers/acpi/processor_idle.c: add two laptops to the C-state DMI table
Date: Tue, 02 Feb 2010 14:10:53 -0800
Message-ID: <201002022210.o12MArf8017355@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41699 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756972Ab0BBWMA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 17:12:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, arjan@linux.intel.com, achiang@hp.com, akwatts@ymail.com, bjorn.helgaas@hp.com, jimis@gmx.net, ming.m.lin@intel.com, rjw@sisk.pl, stable@kernel.org, venkatesh.pallipadi@intel.com, yinghai@kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

Since the rewrite of the CPU idle governor in 2.6.32, two laptops have
surfaced where the BIOS advertises a C2 power state, but for some reason
this state is not functioning (as verified in both cases by powertop
before the patch in .32).

The old governor had the accidental behavior that if a non-working state
was chosen too many times, it would end up falling back to C1.  The new
governor works differently and this accidental behavior is no longer
there; the result is a high temperature on these two machines.

This patch adds these 2 machines to the DMI table for C state anomalies;
by just not using C2 both these machines are better off (the TSC can be
used instead of the pm timer, giving a performance boost for example).

Addresses http://bugzilla.kernel.org/show_bug.cgi?id=14742

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Reported-by: <akwatts@ymail.com>
Cc: Dimitrios Apostolou <jimis@gmx.net>
Cc: Alex Chiang <achiang@hp.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Lin Ming <ming.m.lin@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_idle.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/acpi/processor_idle.c~drivers-acpi-processor_idlec-add-two-laptops-to-the-c-state-dmi-table drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~drivers-acpi-processor_idlec-add-two-laptops-to-the-c-state-dmi-table
+++ a/drivers/acpi/processor_idle.c
@@ -110,6 +110,14 @@ static struct dmi_system_id __cpuinitdat
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
 	 (void *)2},
+	{ set_max_cstate, "Pavilion zv5000", {
+	  DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"Pavilion zv5000 (DS502A#ABA)")},
+	 (void *)1},
+	{ set_max_cstate, "Asus L8400B", {
+	  DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"L8400B series Notebook PC")},
+	 (void *)1},
 	{},
 };
 
_
