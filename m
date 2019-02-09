From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Date: Fri,  8 Feb 2019 18:47:16 -0600
Message-ID: <20190209004718.3292087-2-jeremy.linton@arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190209004718.3292087-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, robert.moore@intel.com, erik.schmauss@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-acpi@vger.kernel.org

[Placeholder patch for upstream ACPICA commit]

Add just ACPI 6.3 changes associated with the arm64 SPE.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/acpi/actbl2.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c50ef7e6b942..4b58eb6cf64e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -623,7 +623,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
+/* 11: Generic Interrupt (ACPI 5.0 + 6.0 + 6.3 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -641,7 +641,8 @@ struct acpi_madt_generic_interrupt {
 	u64 gicr_base_address;
 	u64 arm_mpidr;
 	u8 efficiency_class;
-	u8 reserved2[3];
+	u8 reserved2;
+	u16 spe_overflow_interrupt;
 };
 
 /* Masks for Flags field above */
-- 
2.17.2
