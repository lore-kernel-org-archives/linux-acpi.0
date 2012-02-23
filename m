From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 3/3] xen/processor-passthru: Provide an driver that passes struct acpi_processor data to the hypervisor.
Date: Thu, 23 Feb 2012 17:31:10 -0500
Message-ID: <1330036270-20015-4-git-send-email-konrad.wilk@oracle.com>
References: <1330036270-20015-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330036270-20015-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ke.yu@intel.com, kevin.tian@intel.com, JBeulich@novell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-acpi@vger.kernel.org

The ACPI processor processes the _Pxx and the _Cx state information
which are populated in the 'struct acpi_processor' per-cpu structure.
We read the contents of that structure and pass it up the Xen hyperviso=
r.

The ACPI processor along with the CPU freq driver does all the heavy-li=
fting
for us (filtering, calling ACPI functions, etc) so that the contents is=
 correct.
After we are done parsing the information, we wait in case of hotplug C=
PUs
get loaded and then pass that information to the hypervisor.

[v1-v2: Initial RFC implementations that were posted]
[v3: Changed the name to passthru suggested by Pasi K=C3=A4rkk=C3=A4ine=
n <pasik@iki.fi>]
[v4: Added vCPU !=3D pCPU support - aka dom0_max_vcpus support]
[v5: Cleaned up the driver, fix bug under Athlon XP]
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/xen/Kconfig              |   14 +
 drivers/xen/Makefile             |    2 +-
 drivers/xen/processor-passthru.c |  492 ++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 507 insertions(+), 1 deletions(-)
 create mode 100644 drivers/xen/processor-passthru.c

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index a1ced52..af5e062 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -178,4 +178,18 @@ config XEN_PRIVCMD
 	depends on XEN
 	default m
=20
+config XEN_PROCESSOR_PASSTHRU
+	tristate "Processor passthrough driver for Xen"
+	depends on XEN
+	depends on ACPI_PROCESSOR
+	depends on X86
+	depends on CPU_FREQ
+	help
+	  This driver parses the processor structure and passes the informati=
on
+	  to the Xen hypervisor. It is used to allow the Xen hypervisor to ha=
ve the
+	  full power management data and be able to select proper Cx and Pxx =
states.
+
+	  The driver should be loaded after acpi processor and cpufreq driver=
s have
+	  been loaded. If you do not know what to choose, select M here.
+
 endmenu
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index aa31337..ce235e7a 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_SWIOTLB_XEN)		+=3D swiotlb-xen.o
 obj-$(CONFIG_XEN_DOM0)			+=3D pci.o
 obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+=3D xen-pciback/
 obj-$(CONFIG_XEN_PRIVCMD)		+=3D xen-privcmd.o
-
+obj-$(CONFIG_XEN_PROCESSOR_PASSTHRU)	+=3D processor-passthru.o
 xen-evtchn-y				:=3D evtchn.o
 xen-gntdev-y				:=3D gntdev.o
 xen-gntalloc-y				:=3D gntalloc.o
diff --git a/drivers/xen/processor-passthru.c b/drivers/xen/processor-p=
assthru.c
new file mode 100644
index 0000000..e4dff42
--- /dev/null
+++ b/drivers/xen/processor-passthru.c
@@ -0,0 +1,492 @@
+/*
+ * Copyright 2012 by Oracle Inc
+ * Author: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
+ *
+ * This code borrows ideas from https://lkml.org/lkml/2011/11/30/249
+ * so many thanks go to Kevin Tian <kevin.tian@intel.com>
+ * and Yu Ke <ke.yu@intel.com>.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITH=
OUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
+ * more details.
+ *
+ */
+
+#include <linux/cpumask.h>
+#include <linux/cpufreq.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/processor.h>
+
+#include <xen/interface/platform.h>
+#include <asm/xen/hypercall.h>
+
+#define DRV_NAME "xen-processor-thru"
+MODULE_AUTHOR("Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>");
+MODULE_DESCRIPTION("ACPI Power Management driver to pass Cx and Pxx da=
ta to Xen hypervisor");
+MODULE_LICENSE("GPL");
+
+
+static int no_hypercall;
+MODULE_PARM_DESC(off, "Inhibit the hypercall.");
+module_param_named(off, no_hypercall, int, 0400);
+
+/*
+ * Mutex to protect the acpi_ids_done.
+ */
+static DEFINE_MUTEX(acpi_ids_mutex);
+/*
+ * Don't think convert this to cpumask_var_t or use cpumask_bit - as t=
hose
+ * shrink to nr_cpu_bits (which is dependent on possible_cpu), which c=
an be
+ * less than what we want to put in.
+ */
+#define NR_ACPI_CPUS	NR_CPUS
+#define MAX_ACPI_BITS	(BITS_TO_LONGS(NR_ACPI_CPUS))
+static unsigned long *acpi_ids_done;
+/*
+ * Again, don't convert to cpumask - as we are reading the raw ACPI CP=
U ids
+ * which can go beyond what we presently see.
+ */
+static unsigned long *acpi_id_present;
+
+
+#define POLL_TIMER	msecs_to_jiffies(5000 /* 5 sec */)
+static struct task_struct *xen_processor_thread;
+
+static int xen_push_cxx_to_hypervisor(struct acpi_processor *_pr)
+{
+	struct xen_platform_op op =3D {
+		.cmd			=3D XENPF_set_processor_pminfo,
+		.interface_version	=3D XENPF_INTERFACE_VERSION,
+		.u.set_pminfo.id	=3D _pr->acpi_id,
+		.u.set_pminfo.type	=3D XEN_PM_CX,
+	};
+	struct xen_processor_cx *xen_cx, *xen_cx_states =3D NULL;
+	struct acpi_processor_cx *cx;
+	int i, ok, ret =3D 0;
+
+	xen_cx_states =3D kcalloc(_pr->power.count,
+				sizeof(struct xen_processor_cx), GFP_KERNEL);
+	if (!xen_cx_states)
+		return -ENOMEM;
+
+	for (ok =3D 0, i =3D 1; i <=3D _pr->power.count; i++) {
+		cx =3D &_pr->power.states[i];
+		if (!cx->valid)
+			continue;
+
+		xen_cx =3D &(xen_cx_states[ok++]);
+
+		xen_cx->reg.space_id =3D ACPI_ADR_SPACE_SYSTEM_IO;
+		if (cx->entry_method =3D=3D ACPI_CSTATE_SYSTEMIO) {
+			xen_cx->reg.bit_width =3D 8;
+			xen_cx->reg.bit_offset =3D 0;
+			xen_cx->reg.access_size =3D 1;
+		} else {
+			xen_cx->reg.space_id =3D ACPI_ADR_SPACE_FIXED_HARDWARE;
+			if (cx->entry_method =3D=3D ACPI_CSTATE_FFH) {
+				/* NATIVE_CSTATE_BEYOND_HALT */
+				xen_cx->reg.bit_offset =3D 2;
+				xen_cx->reg.bit_width =3D 1; /* VENDOR_INTEL */
+			}
+			xen_cx->reg.access_size =3D 0;
+		}
+		xen_cx->reg.address =3D cx->address;
+
+		xen_cx->type =3D cx->type;
+		xen_cx->latency =3D cx->latency;
+		xen_cx->power =3D cx->power;
+
+		xen_cx->dpcnt =3D 0;
+		set_xen_guest_handle(xen_cx->dp, NULL);
+#ifdef DEBUG
+		pr_debug(DRV_NAME ": CX: ID:%d [C%d:%s] entry:%d\n", _pr->acpi_id,
+			 cx->type, cx->desc, cx->entry_method);
+#endif
+	}
+	if (!ok) {
+		pr_err(DRV_NAME ": No available Cx info for cpu %d\n", _pr->acpi_id)=
;
+		kfree(xen_cx_states);
+		return -EINVAL;
+	}
+	op.u.set_pminfo.power.count =3D ok;
+	op.u.set_pminfo.power.flags.bm_control =3D _pr->flags.bm_control;
+	op.u.set_pminfo.power.flags.bm_check =3D _pr->flags.bm_check;
+	op.u.set_pminfo.power.flags.has_cst =3D _pr->flags.has_cst;
+	op.u.set_pminfo.power.flags.power_setup_done =3D
+		_pr->flags.power_setup_done;
+
+	set_xen_guest_handle(op.u.set_pminfo.power.states, xen_cx_states);
+
+	if (!no_hypercall)
+		ret =3D HYPERVISOR_dom0_op(&op);
+
+	if (ret)
+		pr_err(DRV_NAME "(CX): Hypervisor returned (%d) for ACPI ID: %d\n",
+		       ret, _pr->acpi_id);
+
+	kfree(xen_cx_states);
+
+	return ret;
+}
+static struct xen_processor_px *xen_copy_pss_data(struct acpi_processo=
r *_pr,
+						  struct xen_processor_performance *xen_perf)
+{
+	struct xen_processor_px *xen_states =3D NULL;
+	int i;
+
+	BUILD_BUG_ON(sizeof(struct xen_processor_px) !=3D
+		     sizeof(struct acpi_processor_px));
+
+	xen_states =3D kcalloc(_pr->performance->state_count,
+			     sizeof(struct xen_processor_px), GFP_KERNEL);
+	if (!xen_states)
+		return ERR_PTR(-ENOMEM);
+
+	xen_perf->state_count =3D _pr->performance->state_count;
+	for (i =3D 0; i < _pr->performance->state_count; i++) {
+		/* Fortunatly for us, they are both the same size */
+		memcpy(&(xen_states[i]), &(_pr->performance->states[i]),
+		       sizeof(struct acpi_processor_px));
+	}
+	return xen_states;
+}
+static int xen_copy_psd_data(struct acpi_processor *_pr,
+			     struct xen_processor_performance *xen_perf)
+{
+	BUILD_BUG_ON(sizeof(struct xen_psd_package) !=3D
+		     sizeof(struct acpi_psd_package));
+
+	if (_pr->performance->shared_type !=3D CPUFREQ_SHARED_TYPE_NONE) {
+		xen_perf->shared_type =3D _pr->performance->shared_type;
+
+		memcpy(&(xen_perf->domain_info), &(_pr->performance->domain_info),
+		       sizeof(struct acpi_psd_package));
+	} else {
+		if ((&cpu_data(0))->x86_vendor !=3D X86_VENDOR_AMD)
+			return -EINVAL;
+
+		/* On AMD, the powernow-k8 is loaded before acpi_cpufreq
+		 * meaning that acpi_processor_preregister_performance never
+		 * gets called which would parse the _PSD. The only relevant
+		 * information from _PSD we need is whether it is HW_ALL or any
+		 * other type. AMD K8 >=3D are SW_ALL or SW_ANY, AMD K7<=3D HW_ANY.
+		 * This driver checks at the start whether it is K8 so it
+		 * if we get here it can only be K8.
+		 */
+		xen_perf->shared_type =3D CPUFREQ_SHARED_TYPE_ANY;
+		xen_perf->domain_info.coord_type =3D DOMAIN_COORD_TYPE_SW_ANY;
+		xen_perf->domain_info.num_processors =3D num_online_cpus();
+	}
+	return 0;
+}
+static int xen_copy_pct_data(struct acpi_pct_register *pct,
+			     struct xen_pct_register *_pct)
+{
+	/* It would be nice if you could just do 'memcpy(pct, _pct') but
+	 * sadly the Xen structure did not have the proper padding
+	 * so the descriptor field takes two (_pct) bytes instead of one (pct=
).
+	 */
+	_pct->descriptor =3D pct->descriptor;
+	_pct->length =3D pct->length;
+	_pct->space_id =3D pct->space_id;
+	_pct->bit_width =3D pct->bit_width;
+	_pct->bit_offset =3D pct->bit_offset;
+	_pct->reserved =3D pct->reserved;
+	_pct->address =3D pct->address;
+	return 0;
+}
+static int xen_push_pxx_to_hypervisor(struct acpi_processor *_pr)
+{
+	int ret =3D 0;
+	struct xen_platform_op op =3D {
+		.cmd			=3D XENPF_set_processor_pminfo,
+		.interface_version	=3D XENPF_INTERFACE_VERSION,
+		.u.set_pminfo.id	=3D _pr->acpi_id,
+		.u.set_pminfo.type	=3D XEN_PM_PX,
+	};
+	struct xen_processor_performance *xen_perf;
+	struct xen_processor_px *xen_states =3D NULL;
+
+	xen_perf =3D &op.u.set_pminfo.perf;
+
+	xen_perf->platform_limit =3D _pr->performance_platform_limit;
+	xen_perf->flags |=3D XEN_PX_PPC;
+	xen_copy_pct_data(&(_pr->performance->control_register),
+			  &xen_perf->control_register);
+	xen_copy_pct_data(&(_pr->performance->status_register),
+			  &xen_perf->status_register);
+	xen_perf->flags |=3D XEN_PX_PCT;
+	xen_states =3D xen_copy_pss_data(_pr, xen_perf);
+	if (!IS_ERR_OR_NULL(xen_states)) {
+		set_xen_guest_handle(xen_perf->states, xen_states);
+		xen_perf->flags |=3D XEN_PX_PSS;
+	}
+	if (!xen_copy_psd_data(_pr, xen_perf))
+		xen_perf->flags |=3D XEN_PX_PSD;
+
+	if (!no_hypercall)
+		ret =3D HYPERVISOR_dom0_op(&op);
+
+	if (ret)
+		pr_err(DRV_NAME "(_PXX): Hypervisor returned (%d) for ACPI ID %d\n",
+		       ret, _pr->acpi_id);
+
+	if (!IS_ERR_OR_NULL(xen_states))
+		kfree(xen_states);
+
+	return ret;
+}
+/*
+ * We read out the struct acpi_processor, and serialize access
+ * so that there is only one caller. This is so that we won't
+ * race with the CPU hotplug code (xen_cpu_soft_notify).
+ */
+static int xen_process_data(struct acpi_processor *_pr)
+{
+	int err =3D 0;
+
+	mutex_lock(&acpi_ids_mutex);
+	if (__test_and_set_bit(_pr->acpi_id, acpi_ids_done)) {
+		mutex_unlock(&acpi_ids_mutex);
+		return -EBUSY;
+	}
+	if (_pr->flags.power)
+		err =3D xen_push_cxx_to_hypervisor(_pr);
+
+	if (_pr->performance && _pr->performance->states)
+		err |=3D xen_push_pxx_to_hypervisor(_pr);
+
+	mutex_unlock(&acpi_ids_mutex);
+	return err;
+}
+static acpi_status
+xen_read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv=
)
+{
+	u32 acpi_id;
+	acpi_status status;
+	acpi_object_type acpi_type;
+	unsigned long long tmp;
+	union acpi_object object =3D { 0 };
+	struct acpi_buffer buffer =3D { sizeof(union acpi_object), &object };
+
+	status =3D acpi_get_type(handle, &acpi_type);
+	if (ACPI_FAILURE(status))
+		return AE_OK;
+
+	switch (acpi_type) {
+	case ACPI_TYPE_PROCESSOR:
+		status =3D acpi_evaluate_object(handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			return AE_OK;
+		acpi_id =3D object.processor.proc_id;
+		break;
+	case ACPI_TYPE_DEVICE:
+		status =3D acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
+		if (ACPI_FAILURE(status))
+			return AE_OK;
+		acpi_id =3D tmp;
+		break;
+	default:
+		return AE_OK;
+	}
+	if (acpi_id > NR_ACPI_CPUS) {
+		WARN_ONCE(1, "There are %d ACPI processors, but kernel can only do %=
d!\n",
+		     acpi_id, NR_ACPI_CPUS);
+		return AE_OK;
+	}
+	__set_bit(acpi_id, acpi_id_present);
+
+	return AE_OK;
+}
+static unsigned int xen_acpi_ids_more(void)
+{
+	unsigned int n =3D 0;
+
+	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+			    ACPI_UINT32_MAX,
+			    xen_read_acpi_id, NULL, NULL, NULL);
+	acpi_get_devices("ACPI0007", xen_read_acpi_id, NULL, NULL);
+
+	mutex_lock(&acpi_ids_mutex);
+	if (!bitmap_equal(acpi_id_present, acpi_ids_done, MAX_ACPI_BITS))
+		n =3D bitmap_weight(acpi_id_present, MAX_ACPI_BITS);
+	mutex_unlock(&acpi_ids_mutex);
+
+	return n;
+}
+
+static int xen_processor_check(void)
+{
+	struct cpufreq_policy *policy;
+	struct acpi_processor *pr_backup =3D NULL;
+	int cpu, err =3D 0;
+
+	cpu =3D get_cpu();
+	put_cpu();
+	policy =3D cpufreq_cpu_get(cpu);
+	if (!policy)
+		return -EBUSY;
+
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		struct acpi_processor *_pr;
+
+		_pr =3D per_cpu(processors, cpu /* APIC ID */);
+		if (!_pr)
+			continue;
+
+		if (!pr_backup) {
+			pr_backup =3D kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
+			memcpy(pr_backup, _pr, sizeof(struct acpi_processor));
+		}
+		(void)xen_process_data(_pr);
+	}
+	put_online_cpus();
+
+	cpufreq_cpu_put(policy);
+
+	/* All online CPUs have been processed at this stage. Now verify
+	 * whether in fact "online CPUs" =3D=3D physical CPUs.
+	 */
+	acpi_id_present =3D kcalloc(MAX_ACPI_BITS, sizeof(unsigned long), GFP=
_KERNEL);
+	if (!acpi_id_present) {
+		err =3D -ENOMEM;
+		goto err_out;
+	}
+	memset(acpi_id_present, 0, MAX_ACPI_BITS * sizeof(unsigned long));
+
+	if (xen_acpi_ids_more() && pr_backup) {
+		for_each_set_bit(cpu, acpi_id_present, MAX_ACPI_BITS) {
+			pr_backup->acpi_id =3D cpu;
+			/* We will get -EBUSY if it has been programmed already. */
+			(void)xen_process_data(pr_backup);
+		}
+	}
+	kfree(acpi_id_present);
+	acpi_id_present =3D NULL;
+err_out:
+	kfree(pr_backup);
+	pr_backup =3D NULL;
+	return err;
+}
+/*
+ * The purpose of this timer/thread is to wait for the ACPI processor
+ * and CPUfreq drivers to load up and parse the Pxx and Cxx informatio=
n
+ * before we attempt to read it.
+ */
+static void xen_processor_timeout(unsigned long arg)
+{
+	wake_up_process((struct task_struct *)arg);
+}
+static int xen_processor_thread_func(void *dummy)
+{
+	struct timer_list timer;
+	int err =3D 0;
+
+	setup_deferrable_timer_on_stack(&timer, xen_processor_timeout,
+					(unsigned long)current);
+	do {
+		__set_current_state(TASK_INTERRUPTIBLE);
+		mod_timer(&timer, jiffies + POLL_TIMER);
+		schedule();
+		err =3D xen_processor_check();
+		if (err !=3D -EBUSY)
+			break;
+	} while (!kthread_should_stop());
+
+	if (err)
+		pr_err(DRV_NAME ": Failed to upload data (%d)!\n", err);
+	del_timer_sync(&timer);
+	destroy_timer_on_stack(&timer);
+	return 0;
+}
+
+static int xen_cpu_soft_notify(struct notifier_block *nfb,
+			       unsigned long action, void *hcpu)
+{
+	unsigned int cpu =3D (unsigned long)hcpu;
+	struct acpi_processor *_pr =3D per_cpu(processors, cpu);
+
+	if (action =3D=3D CPU_ONLINE && _pr)
+		(void)xen_process_data(_pr);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block xen_cpu_notifier =3D {
+	.notifier_call =3D xen_cpu_soft_notify,
+	.priority =3D -1, /* Be the last one */
+};
+
+static int __init check_prereq(void)
+{
+	struct cpuinfo_x86 *c =3D &cpu_data(0);
+
+	if (!xen_initial_domain())
+		return -ENODEV;
+
+	if (!acpi_gbl_FADT.smi_command)
+		return -ENODEV;
+
+	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL) {
+		if (!cpu_has(c, X86_FEATURE_EST))
+			return -ENODEV;
+
+		return 0;
+	}
+	if (c->x86_vendor =3D=3D X86_VENDOR_AMD) {
+		u32 hi =3D 0, lo =3D 0;
+		/* Copied from powernow-k8.h, can't include ../cpufreq/powernow
+		 * as we get compile warnings for the static functions.
+		 */
+#define MSR_PSTATE_CUR_LIMIT    0xc0010061 /* pstate current limit MSR=
 */
+		rdmsr(MSR_PSTATE_CUR_LIMIT, lo, hi);
+
+		/* If the MSR cannot provide the data, the powernow-k8
+		 * won't process the data properly either.
+		 */
+		if (hi || lo)
+			return 0;
+	}
+	return -ENODEV;
+}
+
+static int __init xen_processor_passthru_init(void)
+{
+	int rc =3D check_prereq();
+
+	if (rc)
+		return rc;
+
+	acpi_ids_done =3D kcalloc(MAX_ACPI_BITS, sizeof(unsigned long), GFP_K=
ERNEL);
+	if (!acpi_ids_done)
+		return -ENOMEM;
+	memset(acpi_ids_done, 0, MAX_ACPI_BITS * sizeof(unsigned long));
+	xen_processor_thread =3D kthread_run(xen_processor_thread_func, NULL,=
 DRV_NAME);
+	if (IS_ERR(xen_processor_thread)) {
+		pr_err(DRV_NAME ": Failed to create thread. Aborting.\n");
+		return -ENOMEM;
+	}
+	register_hotcpu_notifier(&xen_cpu_notifier);
+	return 0;
+}
+static void __exit xen_processor_passthru_exit(void)
+{
+	unregister_hotcpu_notifier(&xen_cpu_notifier);
+	if (xen_processor_thread)
+		kthread_stop(xen_processor_thread);
+	kfree(acpi_ids_done);
+}
+late_initcall(xen_processor_passthru_init);
+module_exit(xen_processor_passthru_exit);
--=20
1.7.9.48.g85da4d
