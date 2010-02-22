From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v2 09/12] ACPI: processor: refactor internal map_x2apic_id()
Date: Mon, 22 Feb 2010 12:11:50 -0700
Message-ID: <20100222191149.19752.78161.stgit@bob.kio>
References: <20100222190145.19752.20978.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100222190145.19752.20978.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: linux-acpi@vger.kernel.org

Untangle the nested if conditions to make this function look
more similar to the other map_*apic_id() functions.

Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/processor_core.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9eeda9e..18fa633 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -66,22 +66,16 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
 {
 	struct acpi_madt_local_x2apic *apic =
 		(struct acpi_madt_local_x2apic *)entry;
-	u32 tmp = apic->local_apic_id;
 
-	/* Only check enabled APICs*/
 	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
 		return 0;
 
-	/* Device statement declaration type */
-	if (device_declaration) {
-		if (apic->uid == acpi_id)
-			goto found;
+	if (device_declaration && (apic->uid == acpi_id)) {
+		*apic_id = apic->local_apic_id;
+		return 1;
 	}
 
 	return 0;
-found:
-	*apic_id = tmp;
-	return 1;
 }
 
 static int map_lsapic_id(struct acpi_subtable_header *entry,
