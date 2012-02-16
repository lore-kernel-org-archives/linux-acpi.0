From: Petr Vandrovec <petr@vmware.com>
Subject: [PATCH 3.3.0-rc3] Fix use-after-free in acpi_map_lsapic
Date: Wed, 15 Feb 2012 16:06:43 -0800
Message-ID: <20120216000643.GA7508@petr-dev3.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akataria@vmware.com, dcovelli@vmware.com
List-Id: linux-acpi@vger.kernel.org

From: Petr Vandrovec <petr@vmware.com>

When processor is being hot-added to the system, acpi_map_lsapic invokes
ACPI _MAT method to find APIC ID and flags, verifies that returned structure
is indeed ACPI's local APIC structure, and that flags contain MADT_ENABLED
bit.  Then saves APIC ID, frees structure - and accesses structure when
computing arguments for acpi_register_lapic call.  Which sometime leads
to acpi_register_lapic call being made with second argument zero, failing
to bring processor online with error 'Unable to map lapic to logical cpu
number'.

As lapic->lapic_flags & ACPI_MADT_ENABLED was already confirmed to be non-zero
few lines above, we can just pass unconditional ACPI_MADT_ENABLED to the
acpi_register_lapic.

Thanks, Petr

Signed-off-by: Petr Vandrovec <petr@vmware.com>
Signed-off-by: Alok Kataria <akataria@vmware.com>


diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index ce664f3..a4a0901 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -650,7 +650,7 @@ static int __cpuinit _acpi_map_lsapic(acpi_handle handle, int *pcpu)
 		goto free_tmp_map;
 
 	cpumask_copy(tmp_map, cpu_present_mask);
-	acpi_register_lapic(physid, lapic->lapic_flags & ACPI_MADT_ENABLED);
+	acpi_register_lapic(physid, ACPI_MADT_ENABLED);
 
 	/*
 	 * If mp_register_lapic successfully generates a new logical cpu
