From: alexander.levin@verizon.com
Subject: [PATCH AUTOSEL for 4.9 083/156] Revert "x86/acpi: Set persistent
 cpuid <-> nodeid mapping when booting"
Date: Thu, 7 Dec 2017 15:49:15 +0000
Message-ID: <20171207154845.4814-83-alexander.levin@verizon.com>
References: <20171207154845.4814-1-alexander.levin@verizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:16856 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756516AbdLGQBg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Dec 2017 11:01:36 -0500
In-Reply-To: <20171207154845.4814-1-alexander.levin@verizon.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "guzheng1@huawei.com" <guzheng1@huawei.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "lenb@kernel.org" <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, alexander.levin@verizon.com

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

[ Upstream commit c962cff17dfa11f4a8227ac16de2b28aea3312e4 ]

Revert: dc6db24d2476 ("x86/acpi: Set persistent cpuid <-> nodeid mapping wh=
en booting")

The mapping of "cpuid <-> nodeid" is established at boot time via ACPI
tables to keep associations of workqueues and other node related items
consistent across cpu hotplug.

But, ACPI tables are unreliable and failures with that boot time mapping
have been reported on machines where the ACPI table and the physical
information which is retrieved at actual hotplug is inconsistent.

Revert the mapping implementation so it can be replaced with a less error
prone approach.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
Cc: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org
Cc: guzheng1@huawei.com
Cc: izumi.taku@jp.fujitsu.com
Cc: lenb@kernel.org
Link: http://lkml.kernel.org/r/1488528147-2279-2-git-send-email-douly.fnst@=
cn.fujitsu.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/x86/kernel/acpi/boot.c   |  2 +-
 drivers/acpi/acpi_processor.c |  5 ---
 drivers/acpi/bus.c            |  1 -
 drivers/acpi/processor_core.c | 73 ---------------------------------------=
----
 include/linux/acpi.h          |  3 --
 5 files changed, 1 insertion(+), 83 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index b89bef95f63b..11cc600f4df0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -720,7 +720,7 @@ static void __init acpi_set_irq_model_ioapic(void)
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 #include <acpi/processor.h>
=20
-int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
+static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
 	int nid;
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 3de3b6b8f0f1..f43a586236ea 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -182,11 +182,6 @@ int __weak arch_register_cpu(int cpu)
=20
 void __weak arch_unregister_cpu(int cpu) {}
=20
-int __weak acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
-{
-	return -ENODEV;
-}
-
 static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	unsigned long long sta;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 56190d00fd87..0a3ca20f99af 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1197,7 +1197,6 @@ static int __init acpi_init(void)
 	acpi_wakeup_device_init();
 	acpi_debugger_init();
 	acpi_setup_sb_notify_handler();
-	acpi_set_processor_mapping();
 	return 0;
 }
=20
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 5c78ee1860b0..fd59ae871db3 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -280,79 +280,6 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 a=
cpi_id)
 }
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
=20
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
-static bool __init
-map_processor(acpi_handle handle, phys_cpuid_t *phys_id, int *cpuid)
-{
-	int type, id;
-	u32 acpi_id;
-	acpi_status status;
-	acpi_object_type acpi_type;
-	unsigned long long tmp;
-	union acpi_object object =3D { 0 };
-	struct acpi_buffer buffer =3D { sizeof(union acpi_object), &object };
-
-	status =3D acpi_get_type(handle, &acpi_type);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	switch (acpi_type) {
-	case ACPI_TYPE_PROCESSOR:
-		status =3D acpi_evaluate_object(handle, NULL, NULL, &buffer);
-		if (ACPI_FAILURE(status))
-			return false;
-		acpi_id =3D object.processor.proc_id;
-
-		/* validate the acpi_id */
-		if(acpi_processor_validate_proc_id(acpi_id))
-			return false;
-		break;
-	case ACPI_TYPE_DEVICE:
-		status =3D acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
-		if (ACPI_FAILURE(status))
-			return false;
-		acpi_id =3D tmp;
-		break;
-	default:
-		return false;
-	}
-
-	type =3D (acpi_type =3D=3D ACPI_TYPE_DEVICE) ? 1 : 0;
-
-	*phys_id =3D __acpi_get_phys_id(handle, type, acpi_id, false);
-	id =3D acpi_map_cpuid(*phys_id, acpi_id);
-
-	if (id < 0)
-		return false;
-	*cpuid =3D id;
-	return true;
-}
-
-static acpi_status __init
-set_processor_node_mapping(acpi_handle handle, u32 lvl, void *context,
-			   void **rv)
-{
-	phys_cpuid_t phys_id;
-	int cpu_id;
-
-	if (!map_processor(handle, &phys_id, &cpu_id))
-		return AE_ERROR;
-
-	acpi_map_cpu2node(handle, cpu_id, phys_id);
-	return AE_OK;
-}
-
-void __init acpi_set_processor_mapping(void)
-{
-	/* Set persistent cpu <-> node mapping for all processors. */
-	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, set_processor_node_mapping,
-			    NULL, NULL, NULL);
-}
-#else
-void __init acpi_set_processor_mapping(void) {}
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
-
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
 			 u64 *phys_addr, int *ioapic_id)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 61a3d90f32b3..ca2b4c4aec42 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -276,11 +276,8 @@ bool acpi_processor_validate_proc_id(int proc_id);
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu);
 int acpi_unmap_cpu(int cpu);
-int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
=20
-void acpi_set_processor_mapping(void);
-
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
 #endif
--=20
2.11.0
