From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.32.stable] ACPI: fix High cpu temperature with 2.6.32
Date: Thu, 18 Feb 2010 23:19:50 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002182316410.17638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:37683 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab0BSEUK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Feb 2010 23:20:10 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200IABMQ9HQV2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 22:20:50 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>

upstream 370d5cd88509b93b76eb2f5f97efbd71c25061cb
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
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 7c0441f..e88e8ae 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -110,6 +110,14 @@ static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
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
 
-- 
1.7.0.17.g7e5eb

