From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 08/12] ACPI: processor: refactor internal map_lapic_id()
Date: Mon, 25 Jan 2010 14:41:19 -0700
Message-ID: <20100125214119.28510.84191.stgit@bob.kio>
References: <20100125213221.28510.74078.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:8953 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0AYVlU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2010 16:41:20 -0500
In-Reply-To: <20100125213221.28510.74078.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Untangle the if() statement a little for readability.

Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/processor_core.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 1fc06c6..bebd411 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -50,12 +50,15 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
 {
 	struct acpi_madt_local_apic *lapic =
 		(struct acpi_madt_local_apic *)entry;
-	if ((lapic->lapic_flags & ACPI_MADT_ENABLED) &&
-	    lapic->processor_id == acpi_id) {
-		*apic_id = lapic->id;
-		return 1;
-	}
-	return 0;
+
+	if (!(lapic->lapic_flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	if (lapic->processor_id != acpi_id)
+		return 0;
+
+	*apic_id = lapic->id;
+	return 1;
 }
 
 static int map_x2apic_id(struct acpi_subtable_header *entry,

