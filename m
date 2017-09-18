From: "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Subject: [PATCH for 4.9 27/39] x86/acpi: Restore the order of CPU IDs
Date: Mon, 18 Sep 2017 00:40:33 +0000
Message-ID: <20170918004024.7247-10-alexander.levin@verizon.com>
References: <20170918004024.7247-1-alexander.levin@verizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170918004024.7247-1-alexander.levin@verizon.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "guzheng1@huawei.com" <guzheng1@huawei.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "lenb@kernel.org" <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
List-Id: linux-acpi@vger.kernel.org

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

[ Upstream commit 2b85b3d22920db7473e5fed5719e7955c0ec323e ]

The following commits:

  f7c28833c2 ("x86/acpi: Enable acpi to register all possible cpus at
boot time") and 8f54969dc8 ("x86/acpi: Introduce persistent storage
for cpuid <-> apicid mapping")

... registered all the possible CPUs at boot time via ACPI tables to
make the mapping of cpuid <-> apicid fixed. Both enabled and disabled
CPUs could have a logical CPU ID after boot time.

But, ACPI tables are unreliable. the number amd order of Local APIC
entries which depends on the firmware is often inconsistent with the
physical devices. Even if they are consistent, The disabled CPUs which
take up some logical CPU IDs will also make the order discontinuous.

Revert the part of disabled CPUs registration, keep the allocation
logic of logical CPU IDs and also keep some code location changes.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
Cc: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org
Cc: guzheng1@huawei.com
Cc: izumi.taku@jp.fujitsu.com
Cc: lenb@kernel.org
Link: http://lkml.kernel.org/r/1488528147-2279-4-git-send-email-douly.fnst@=
cn.fujitsu.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/x86/kernel/acpi/boot.c |  7 ++++++-
 arch/x86/kernel/apic/apic.c | 26 +++++++-------------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index d3e0d049a0c2..b89bef95f63b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -176,10 +176,15 @@ static int acpi_register_lapic(int id, u32 acpiid, u8=
 enabled)
 		return -EINVAL;
 	}
=20
+	if (!enabled) {
+		++disabled_cpus;
+		return -EINVAL;
+	}
+
 	if (boot_cpu_physical_apicid !=3D -1U)
 		ver =3D boot_cpu_apic_version;
=20
-	cpu =3D __generic_processor_info(id, ver, enabled);
+	cpu =3D generic_processor_info(id, ver);
 	if (cpu >=3D 0)
 		early_per_cpu(x86_cpu_to_acpiid, cpu) =3D acpiid;
=20
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f2234918e494..e2ead34da465 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2070,7 +2070,7 @@ static int allocate_logical_cpuid(int apicid)
 	return nr_logical_cpuids++;
 }
=20
-int __generic_processor_info(int apicid, int version, bool enabled)
+int generic_processor_info(int apicid, int version)
 {
 	int cpu, max =3D nr_cpu_ids;
 	bool boot_cpu_detected =3D physid_isset(boot_cpu_physical_apicid,
@@ -2128,11 +2128,9 @@ int __generic_processor_info(int apicid, int version=
, bool enabled)
 	if (num_processors >=3D nr_cpu_ids) {
 		int thiscpu =3D max + disabled_cpus;
=20
-		if (enabled) {
-			pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
-				   "reached. Processor %d/0x%x ignored.\n",
-				   max, thiscpu, apicid);
-		}
+		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
+			   "reached. Processor %d/0x%x ignored.\n",
+			   max, thiscpu, apicid);
=20
 		disabled_cpus++;
 		return -EINVAL;
@@ -2184,23 +2182,13 @@ int __generic_processor_info(int apicid, int versio=
n, bool enabled)
 		apic->x86_32_early_logical_apicid(cpu);
 #endif
 	set_cpu_possible(cpu, true);
-
-	if (enabled) {
-		num_processors++;
-		physid_set(apicid, phys_cpu_present_map);
-		set_cpu_present(cpu, true);
-	} else {
-		disabled_cpus++;
-	}
+	physid_set(apicid, phys_cpu_present_map);
+	set_cpu_present(cpu, true);
+	num_processors++;
=20
 	return cpu;
 }
=20
-int generic_processor_info(int apicid, int version)
-{
-	return __generic_processor_info(apicid, version, true);
-}
-
 int hard_smp_processor_id(void)
 {
 	return read_apic_id();
--=20
2.11.0
