From: "Yu, Ke" <ke.yu@intel.com>
Subject: RE: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Wed, 29 Jul 2009 22:47:20 +0800
Message-ID: <4D05DB80B95B23498C72C700BD6C2E0B315D671A@pdsmsx502.ccr.corp.intel.com>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
 <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_4D05DB80B95B23498C72C700BD6C2E0B315D671Apdsmsx502ccrcor_"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39999 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbZG2Ori (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jul 2009 10:47:38 -0400
In-Reply-To: <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "Tian, Kevin" <kevin.tian@intel.com>

--_002_4D05DB80B95B23498C72C700BD6C2E0B315D671Apdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>I'd like the patch better if you
>
>s/extcntl/xen/ to make it clear why this code exists --
>or is there an expected "external control" other than Xen?
>
>-Len

This attached is the revised patch per your suggestion, which move all the =
external control logic to xen specific file, thus reduce the modification t=
o acpi subsystem to only several places.

=3D=3D PATCH =3D=3D

Leverage domain0 ACPI parser for xen

From: Yu Ke <ke.yu@intel.com>

This patch reuse dom0 ACPI parser to get C/P state for Xen

=3D=3D=3D Overview =3D=3D=3D

Requirement: Xen hypervisor need Cx/Px ACPI info to do the Cx/Px states
power management. This info is provided by BIOS ACPI table. Since
hypervisor has no ACPI parser, this info has to be parsed by domain0
kernel ACPI sub-system, and then passed to hypervisor by hypercall.

To make this happen, the key point is to add hook in the kernel ACPI
sub-system. Fortunately, kernel already has good abstraction, and
only several places need to add hook. To be more detail, there is an
acpi_processor_driver (in drivers/acpi/processor_core.c) , which all the
Cx/Px parsing event will go to. This driver will call its acpi processor
event handler, e.g. add/remove, start/stop, notify to handle these
events. These event handlers in turn will call some library functions (in
drivers/acpi/processor_perflib.c), e.g. acpi_processor_ppc_has_changed,
acpi_processor_ppc_has_changed, acpi_processor_cst_has_changed, to finish
the acpi info parsing.

So this patch add the xen hook in these places to notify xen for the parsed
Cx/Px state information.

Signed-off-by: Yu Ke <ke.yu@intel.com>
Signed-off-by: Tian Kevin <kevin.tian@intel.com>
---

 drivers/acpi/processor_core.c    |   17 ++
 drivers/acpi/processor_idle.c    |   25 ++
 drivers/acpi/processor_perflib.c |   10 +
 drivers/xen/Kconfig              |    7 +
 drivers/xen/Makefile             |    3
 drivers/xen/processor_extcntl.c  |  413 ++++++++++++++++++++++++++++++++++=
++++
 include/acpi/processor.h         |    6 +
 include/xen/acpi.h               |   55 +++++
 8 files changed, 528 insertions(+), 8 deletions(-)
 create mode 100644 drivers/xen/processor_extcntl.c


diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 84e0f3c..2707d65 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -58,6 +58,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/processor.h>
+#include <xen/acpi.h>

 #define ACPI_PROCESSOR_CLASS           "processor"
 #define ACPI_PROCESSOR_DEVICE_NAME     "Processor"
@@ -751,6 +752,10 @@ static int __cpuinit acpi_processor_start(struct acpi_=
device *device)

        acpi_processor_power_init(pr, device);

+       result =3D processor_cntl_xen_prepare(pr);
+       if (result)
+               goto end;
+
        pr->cdev =3D thermal_cooling_device_register("Processor", device,
                                                &processor_cooling_ops);
        if (IS_ERR(pr->cdev)) {
@@ -963,6 +968,10 @@ int acpi_processor_device_add(acpi_handle handle, stru=
ct acpi_device **device)
        if (!pr)
                return -ENODEV;

+       if (processor_cntl_xen())
+               processor_cntl_xen_notify(pr,
+                       PROCESSOR_HOTPLUG, HOTPLUG_TYPE_ADD);
+
        if ((pr->id >=3D 0) && (pr->id < nr_cpu_ids)) {
                kobject_uevent(&(*device)->dev.kobj, KOBJ_ONLINE);
        }
@@ -1002,11 +1011,19 @@ static void __ref acpi_processor_hotplug_notify(acp=
i_handle handle,
                        break;
                }

+               if (processor_cntl_xen())
+                       processor_cntl_xen_notify(pr,
+                                       PROCESSOR_HOTPLUG, HOTPLUG_TYPE_ADD=
);
+
                if (pr->id >=3D 0 && (pr->id < nr_cpu_ids)) {
                        kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
                        break;
                }

+               if (processor_cntl_xen())
+                       processor_cntl_xen_notify(pr, PROCESSOR_HOTPLUG,
+                                                       HOTPLUG_TYPE_REMOVE=
);
+
                result =3D acpi_processor_start(device);
                if ((!result) && ((pr->id >=3D 0) && (pr->id < nr_cpu_ids))=
) {
                        kobject_uevent(&device->dev.kobj, KOBJ_ONLINE);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 0efa59e..8994aff 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -58,6 +58,7 @@

 #include <acpi/acpi_bus.h>
 #include <acpi/processor.h>
+#include <xen/acpi.h>
 #include <asm/processor.h>

 #define ACPI_PROCESSOR_CLASS            "processor"
@@ -455,6 +456,12 @@ static int acpi_processor_get_power_info_cst(struct ac=
pi_processor *pr)

                cx.power =3D obj->integer.value;

+#ifdef CONFIG_ACPI_PROCESSOR_XEN
+               /* cache control methods to notify xen*/
+               if (processor_cntl_xen_pm())
+                       memcpy(&cx.reg, reg, sizeof(*reg));
+#endif
+
                current_count++;
                memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx))=
;

@@ -1141,6 +1148,13 @@ int acpi_processor_cst_has_changed(struct acpi_proce=
ssor *pr)
        if (!pr->flags.power_setup_done)
                return -ENODEV;

+    if (processor_cntl_xen_pm()) {
+               acpi_processor_get_power_info(pr);
+               processor_cntl_xen_notify(pr,
+                       PROCESSOR_PM_CHANGE, PM_TYPE_IDLE);
+               return ret;
+       }
+
        cpuidle_pause_and_lock();
        cpuidle_disable_device(&pr->power.dev);
        acpi_processor_get_power_info(pr);
@@ -1204,9 +1218,14 @@ int __cpuinit acpi_processor_power_init(struct acpi_=
processor *pr,
         * platforms that only support C1.
         */
        if (pr->flags.power) {
-               acpi_processor_setup_cpuidle(pr);
-               if (cpuidle_register_device(&pr->power.dev))
-                       return -EIO;
+               if (processor_cntl_xen_pm())
+                       processor_cntl_xen_notify(pr,
+                                       PROCESSOR_PM_INIT, PM_TYPE_IDLE);
+               else {
+                       acpi_processor_setup_cpuidle(pr);
+                       if (cpuidle_register_device(&pr->power.dev))
+                               return -EIO;
+               }

                printk(KERN_INFO PREFIX "CPU%d (power states:", pr->id);
                for (i =3D 1; i <=3D pr->power.count; i++)
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perf=
lib.c
index 60e543d..8375075 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -38,6 +38,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/processor.h>
+#include <xen/acpi.h>

 #define ACPI_PROCESSOR_CLASS           "processor"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE        "performance"
@@ -154,13 +155,16 @@ int acpi_processor_ppc_has_changed(struct acpi_proces=
sor *pr)
 {
        int ret;

-       if (ignore_ppc)
+       if (ignore_ppc && !processor_cntl_xen_pmperf())
                return 0;

        ret =3D acpi_processor_get_platform_limit(pr);

        if (ret < 0)
                return (ret);
+       else if (processor_cntl_xen_pmperf())
+               return processor_cntl_xen_notify(pr,
+                               PROCESSOR_PM_CHANGE, PM_TYPE_PERF);
        else
                return cpufreq_update_policy(pr->id);
 }
@@ -330,7 +334,7 @@ static int acpi_processor_get_performance_states(struct=
 acpi_processor *pr)
        return result;
 }

-static int acpi_processor_get_performance_info(struct acpi_processor *pr)
+int acpi_processor_get_performance_info(struct acpi_processor *pr)
 {
        int result =3D 0;
        acpi_status status =3D AE_OK;
@@ -432,7 +436,7 @@ int acpi_processor_notify_smm(struct module *calling_mo=
dule)

 EXPORT_SYMBOL(acpi_processor_notify_smm);

-static int acpi_processor_get_psd(struct acpi_processor        *pr)
+int acpi_processor_get_psd(struct acpi_processor       *pr)
 {
        int result =3D 0;
        acpi_status status =3D AE_OK;
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 3b1c421..d303c25 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -90,4 +90,9 @@ config XEN_XENBUS_FRONTEND

 config XEN_S3
        def_bool y
-       depends on XEN_DOM0 && ACPI
\ No newline at end of file
+       depends on XEN_DOM0 && ACPI
+
+config ACPI_PROCESSOR_XEN
+       bool
+       depends on XEN_DOM0 && ACPI_PROCESSOR && CPU_FREQ
+       default y
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 386c775..42c9ace 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_XEN_BLKDEV_BACKEND)        +=3D blkback/
 obj-$(CONFIG_XEN_NETDEV_BACKEND)       +=3D netback/
 obj-$(CONFIG_XENFS)                    +=3D xenfs/
 obj-$(CONFIG_XEN_SYS_HYPERVISOR)       +=3D sys-hypervisor.o
-obj-$(CONFIG_XEN_S3)                   +=3D acpi.o
\ No newline at end of file
+obj-$(CONFIG_XEN_S3)                   +=3D acpi.o
+obj-$(CONFIG_ACPI_PROCESSOR_XEN) +=3D processor_extcntl.o
diff --git a/drivers/xen/processor_extcntl.c b/drivers/xen/processor_extcnt=
l.c
new file mode 100644
index 0000000..7307cd8
--- /dev/null
+++ b/drivers/xen/processor_extcntl.c
@@ -0,0 +1,413 @@
+/*
+ * processor_extcntl.c - interface to notify Xen
+ *
+ *  Copyright (C) 2008, Intel corporation
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License alon=
g
+ *  with this program; if not, write to the Free Software Foundation, Inc.=
,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/acpi.h>
+#include <linux/pm.h>
+#include <linux/cpu.h>
+
+#include <linux/cpufreq.h>
+#include <acpi/processor.h>
+#include <xen/acpi.h>
+
+#include <asm/xen/hypercall.h>
+#include <asm/xen/hypervisor.h>
+
+static int processor_cntl_xen_get_performance(struct acpi_processor *pr);
+static int xen_hotplug_notifier(struct acpi_processor *pr, int event);
+
+static struct processor_cntl_xen_ops xen_ops =3D {
+       .hotplug                =3D xen_hotplug_notifier,
+};
+
+int processor_cntl_xen(void)
+{
+       return 1;
+}
+
+int processor_cntl_xen_pm(void)
+{
+       return (xen_ops.pm_ops[PM_TYPE_IDLE] !=3D NULL);
+}
+
+int processor_cntl_xen_pmperf(void)
+{
+       return  (xen_ops.pm_ops[PM_TYPE_PERF] !=3D NULL);
+}
+
+int processor_cntl_xen_pmthr(void)
+{
+       return (xen_ops.pm_ops[PM_TYPE_THR] !=3D NULL);
+}
+
+static int processor_notify_smm(void)
+{
+       acpi_status status;
+       static int is_done =3D 0;
+
+       /* only need successfully notify BIOS once */
+       /* avoid double notification which may lead to unexpected result */
+       if (is_done)
+               return 0;
+
+       /* Can't write pstate_cnt to smi_cmd if either value is zero */
+       if ((!acpi_gbl_FADT.smi_command) || (!acpi_gbl_FADT.pstate_control)=
) {
+               ACPI_DEBUG_PRINT((ACPI_DB_INFO,"No SMI port or pstate_cnt\n=
"));
+               return 0;
+       }
+
+       ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+               "Writing pstate_cnt [0x%x] to smi_cmd [0x%x]\n",
+               acpi_gbl_FADT.pstate_control, acpi_gbl_FADT.smi_command));
+
+       status =3D acpi_os_write_port(acpi_gbl_FADT.smi_command,
+                                   (u32) acpi_gbl_FADT.pstate_control, 8);
+       if (ACPI_FAILURE(status))
+               return status;
+
+       is_done =3D 1;
+
+       return 0;
+}
+
+int processor_cntl_xen_notify(struct acpi_processor *pr, int event, int ty=
pe)
+{
+       int ret =3D -EINVAL;
+
+       switch (event) {
+       case PROCESSOR_PM_INIT:
+       case PROCESSOR_PM_CHANGE:
+               if ((type >=3D PM_TYPE_MAX) ||
+                       !xen_ops.pm_ops[type])
+                       break;
+
+               ret =3D xen_ops.pm_ops[type](pr, event);
+               break;
+       case PROCESSOR_HOTPLUG:
+               if (xen_ops.hotplug)
+                       ret =3D xen_ops.hotplug(pr, type);
+               break;
+       default:
+               printk(KERN_ERR "Unsupport processor events %d.\n", event);
+               break;
+       }
+
+       return ret;
+}
+
+/*
+ * This is called from ACPI processor init, and targeted to hold
+ * some tricky housekeeping jobs to satisfy xen.
+ * For example, we may put dependency parse stub here for idle
+ * and performance state. Those information may be not available
+ * if splitting from dom0 control logic like cpufreq driver.
+ */
+int processor_cntl_xen_prepare(struct acpi_processor *pr)
+{
+
+       /* Initialize performance states */
+       if (processor_cntl_xen_pmperf())
+               processor_cntl_xen_get_performance(pr);
+
+       return 0;
+}
+
+/*
+ * Existing ACPI module does parse performance states at some point,
+ * when acpi-cpufreq driver is loaded which however is something
+ * we'd like to disable to avoid confliction with xen PM
+ * logic. So we have to collect raw performance information here
+ * when ACPI processor object is found and started.
+ */
+static int processor_cntl_xen_get_performance(struct acpi_processor *pr)
+{
+       int ret;
+       struct acpi_processor_performance *perf;
+       struct acpi_psd_package *pdomain;
+
+       if (pr->performance)
+               return -EBUSY;
+
+       perf =3D kzalloc(sizeof(struct acpi_processor_performance), GFP_KER=
NEL);
+       if (!perf)
+               return -ENOMEM;
+
+       pr->performance =3D perf;
+       /* Get basic performance state information */
+       ret =3D acpi_processor_get_performance_info(pr);
+       if (ret < 0)
+               goto err_out;
+
+       /*
+        * Well, here we need retrieve performance dependency information
+        * from _PSD object. The reason why existing interface is not used
+        * is due to the reason that existing interface sticks to Linux cpu
+        * id to construct some bitmap, however we want to split ACPI
+        * processor objects from Linux cpu id logic. For example, even
+        * when Linux is configured as UP, we still want to parse all ACPI
+        * processor objects to xen. In this case, it's preferred
+        * to use ACPI ID instead.
+        */
+       pdomain =3D &pr->performance->domain_info;
+       pdomain->num_processors =3D 0;
+       ret =3D acpi_processor_get_psd(pr);
+       if (ret < 0) {
+               /*
+                * _PSD is optional - assume no coordination if absent (or
+                * broken), matching native kernels' behavior.
+                */
+               pdomain->num_entries =3D ACPI_PSD_REV0_ENTRIES;
+               pdomain->revision =3D ACPI_PSD_REV0_REVISION;
+               pdomain->domain =3D pr->acpi_id;
+               pdomain->coord_type =3D DOMAIN_COORD_TYPE_SW_ALL;
+               pdomain->num_processors =3D 1;
+       }
+
+       /* Some sanity check */
+       if ((pdomain->revision !=3D ACPI_PSD_REV0_REVISION) ||
+           (pdomain->num_entries !=3D ACPI_PSD_REV0_ENTRIES) ||
+           ((pdomain->coord_type !=3D DOMAIN_COORD_TYPE_SW_ALL) &&
+            (pdomain->coord_type !=3D DOMAIN_COORD_TYPE_SW_ANY) &&
+            (pdomain->coord_type !=3D DOMAIN_COORD_TYPE_HW_ALL))) {
+               ret =3D -EINVAL;
+               goto err_out;
+       }
+
+       /* Last step is to notify BIOS that xen exists */
+       processor_notify_smm();
+
+       processor_cntl_xen_notify(pr, PROCESSOR_PM_INIT, PM_TYPE_PERF);
+
+       return 0;
+err_out:
+       pr->performance =3D NULL;
+       kfree(perf);
+       return ret;
+}
+
+static inline void xen_convert_pct_reg(struct xen_pct_register *xpct,
+       struct acpi_pct_register *apct)
+{
+       xpct->descriptor =3D apct->descriptor;
+       xpct->length     =3D apct->length;
+       xpct->space_id   =3D apct->space_id;
+       xpct->bit_width  =3D apct->bit_width;
+       xpct->bit_offset =3D apct->bit_offset;
+       xpct->reserved   =3D apct->reserved;
+       xpct->address    =3D apct->address;
+}
+
+static inline void xen_convert_pss_states(struct xen_processor_px *xpss,
+       struct acpi_processor_px *apss, int state_count)
+{
+       int i;
+       for(i=3D0; i<state_count; i++) {
+               xpss->core_frequency     =3D apss->core_frequency;
+               xpss->power              =3D apss->power;
+               xpss->transition_latency =3D apss->transition_latency;
+               xpss->bus_master_latency =3D apss->bus_master_latency;
+               xpss->control            =3D apss->control;
+               xpss->status             =3D apss->status;
+               xpss++;
+               apss++;
+       }
+}
+
+static inline void xen_convert_psd_pack(struct xen_psd_package *xpsd,
+       struct acpi_psd_package *apsd)
+{
+       xpsd->num_entries    =3D apsd->num_entries;
+       xpsd->revision       =3D apsd->revision;
+       xpsd->domain         =3D apsd->domain;
+       xpsd->coord_type     =3D apsd->coord_type;
+       xpsd->num_processors =3D apsd->num_processors;
+}
+
+static int xen_cx_notifier(struct acpi_processor *pr, int action)
+{
+       int ret, count =3D 0, i;
+       xen_platform_op_t op =3D {
+               .cmd                    =3D XENPF_set_processor_pminfo,
+               .interface_version      =3D XENPF_INTERFACE_VERSION,
+               .u.set_pminfo.id        =3D pr->acpi_id,
+               .u.set_pminfo.type      =3D XEN_PM_CX,
+       };
+       struct xen_processor_cx *data, *buf;
+       struct acpi_processor_cx *cx;
+
+       if (action =3D=3D PROCESSOR_PM_CHANGE)
+               return -EINVAL;
+
+       /* Convert to Xen defined structure and hypercall */
+       buf =3D kzalloc(pr->power.count * sizeof(struct xen_processor_cx),
+                       GFP_KERNEL);
+       if (!buf)
+               return -ENOMEM;
+
+       data =3D buf;
+       for (i =3D 1; i <=3D pr->power.count; i++) {
+               cx =3D &pr->power.states[i];
+               /* Skip invalid cstate entry */
+               if (!cx->valid)
+                       continue;
+
+               data->type =3D cx->type;
+               data->latency =3D cx->latency;
+               data->power =3D cx->power;
+               data->reg.space_id =3D cx->reg.space_id;
+               data->reg.bit_width =3D cx->reg.bit_width;
+               data->reg.bit_offset =3D cx->reg.bit_offset;
+               data->reg.access_size =3D cx->reg.reserved;
+               data->reg.address =3D cx->reg.address;
+
+               /* Get dependency relationships, _CSD is not supported yet =
*/
+               data->dpcnt =3D 0;
+               set_xen_guest_handle(data->dp, NULL);
+
+               data++;
+               count++;
+       }
+
+       if (!count) {
+               printk("No available Cx info for cpu %d\n", pr->acpi_id);
+               kfree(buf);
+               return -EINVAL;
+       }
+
+       op.u.set_pminfo.power.count =3D count;
+       op.u.set_pminfo.power.flags.bm_control =3D pr->flags.bm_control;
+       op.u.set_pminfo.power.flags.bm_check =3D pr->flags.bm_check;
+       op.u.set_pminfo.power.flags.has_cst =3D pr->flags.has_cst;
+       op.u.set_pminfo.power.flags.power_setup_done =3D pr->flags.power_se=
tup_done;
+
+       set_xen_guest_handle(op.u.set_pminfo.power.states, buf);
+       ret =3D HYPERVISOR_dom0_op(&op);
+       kfree(buf);
+       return ret;
+}
+
+static int xen_px_notifier(struct acpi_processor *pr, int action)
+{
+       int ret =3D -EINVAL;
+       xen_platform_op_t op =3D {
+               .cmd                    =3D XENPF_set_processor_pminfo,
+               .interface_version      =3D XENPF_INTERFACE_VERSION,
+               .u.set_pminfo.id        =3D pr->acpi_id,
+               .u.set_pminfo.type      =3D XEN_PM_PX,
+       };
+       struct xen_processor_performance *perf;
+       struct xen_processor_px *states =3D NULL;
+       struct acpi_processor_performance *px;
+       struct acpi_psd_package *pdomain;
+
+       if (!pr)
+               return -EINVAL;
+
+       perf =3D &op.u.set_pminfo.perf;
+       px =3D pr->performance;
+
+       switch(action) {
+       case PROCESSOR_PM_CHANGE:
+               /* ppc dynamic handle */
+               perf->flags =3D XEN_PX_PPC;
+               perf->platform_limit =3D pr->performance_platform_limit;
+
+               ret =3D HYPERVISOR_dom0_op(&op);
+               break;
+
+       case PROCESSOR_PM_INIT:
+               /* px normal init */
+               perf->flags =3D XEN_PX_PPC |
+                             XEN_PX_PCT |
+                             XEN_PX_PSS |
+                             XEN_PX_PSD;
+
+               /* ppc */
+               perf->platform_limit =3D pr->performance_platform_limit;
+
+               /* pct */
+               xen_convert_pct_reg(&perf->control_register, &px->control_r=
egister);
+               xen_convert_pct_reg(&perf->status_register, &px->status_reg=
ister);
+
+               /* pss */
+               perf->state_count =3D px->state_count;
+               states =3D kzalloc(px->state_count*sizeof(xen_processor_px_=
t),GFP_KERNEL);
+               if (!states)
+                       return -ENOMEM;
+               xen_convert_pss_states(states, px->states, px->state_count)=
;
+               set_xen_guest_handle(perf->states, states);
+
+               /* psd */
+               pdomain =3D &px->domain_info;
+               xen_convert_psd_pack(&perf->domain_info, pdomain);
+               if (pdomain->coord_type =3D=3D DOMAIN_COORD_TYPE_SW_ALL)
+                       perf->shared_type =3D CPUFREQ_SHARED_TYPE_ALL;
+               else if (pdomain->coord_type =3D=3D DOMAIN_COORD_TYPE_SW_AN=
Y)
+                       perf->shared_type =3D CPUFREQ_SHARED_TYPE_ANY;
+               else if (pdomain->coord_type =3D=3D DOMAIN_COORD_TYPE_HW_AL=
L)
+                       perf->shared_type =3D CPUFREQ_SHARED_TYPE_HW;
+               else {
+                       ret =3D -ENODEV;
+                       kfree(states);
+                       break;
+               }
+
+               ret =3D HYPERVISOR_dom0_op(&op);
+               kfree(states);
+               break;
+
+       default:
+               break;
+       }
+
+       return ret;
+}
+
+static int xen_tx_notifier(struct acpi_processor *pr, int action)
+{
+       return -EINVAL;
+}
+static int xen_hotplug_notifier(struct acpi_processor *pr, int event)
+{
+       return -EINVAL;
+}
+
+static int __init xen_acpi_processor_extcntl_init(void)
+{
+       unsigned int pmbits =3D (xen_start_info->flags & SIF_PM_MASK) >> 8;
+
+       if (!pmbits)
+               return 0;
+       if (pmbits & XEN_PROCESSOR_PM_CX)
+               xen_ops.pm_ops[PM_TYPE_IDLE] =3D xen_cx_notifier;
+       if (pmbits & XEN_PROCESSOR_PM_PX)
+               xen_ops.pm_ops[PM_TYPE_PERF] =3D xen_px_notifier;
+       if (pmbits & XEN_PROCESSOR_PM_TX)
+               xen_ops.pm_ops[PM_TYPE_THR] =3D xen_tx_notifier;
+
+       return 0;
+}
+
+subsys_initcall(xen_acpi_processor_extcntl_init);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index baf1e0a..14c7e4c 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -77,6 +77,10 @@ struct acpi_processor_cx {
        struct acpi_processor_cx_policy promotion;
        struct acpi_processor_cx_policy demotion;
        char desc[ACPI_CX_DESC_LEN];
+#ifdef CONFIG_ACPI_PROCESSOR_XEN
+       /* Require raw information for xen*/
+       struct acpi_power_register reg;
+#endif /* CONFIG_ACPI_PROCESSOE_XEN */
 };

 struct acpi_processor_power {
@@ -295,6 +299,8 @@ static inline void acpi_processor_ffh_cstate_enter(stru=
ct acpi_processor_cx
 void acpi_processor_ppc_init(void);
 void acpi_processor_ppc_exit(void);
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr);
+int acpi_processor_get_performance_info(struct acpi_processor *pr);
+int acpi_processor_get_psd(struct acpi_processor *pr);
 #else
 static inline void acpi_processor_ppc_init(void)
 {
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index fea4cfb..636c3e6 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -20,4 +20,59 @@ static inline bool xen_pv_acpi(void)
 int acpi_notify_hypervisor_state(u8 sleep_state,
                                 u32 pm1a_cnt, u32 pm1b_cnd);

+/*
+ * Following are interfaces for xen acpi processor control
+ */
+
+/* Events notified to xen */
+#define PROCESSOR_PM_INIT      1
+#define PROCESSOR_PM_CHANGE    2
+#define PROCESSOR_HOTPLUG      3
+
+/* Objects for the PM events */
+#define PM_TYPE_IDLE           0
+#define PM_TYPE_PERF           1
+#define PM_TYPE_THR            2
+#define PM_TYPE_MAX            3
+
+/* Processor hotplug events */
+#define HOTPLUG_TYPE_ADD       0
+#define HOTPLUG_TYPE_REMOVE    1
+
+#ifdef CONFIG_ACPI_PROCESSOR_XEN
+#include <acpi/acpi_drivers.h>
+#include <acpi/processor.h>
+
+struct processor_cntl_xen_ops {
+       /* Transfer processor PM events to xen */
+int (*pm_ops[PM_TYPE_MAX])(struct acpi_processor *pr, int event);
+       /* Notify physical processor status to xen */
+       int (*hotplug)(struct acpi_processor *pr, int type);
+};
+
+extern int processor_cntl_xen(void);
+extern int processor_cntl_xen_pm(void);
+extern int processor_cntl_xen_pmperf(void);
+extern int processor_cntl_xen_pmthr(void);
+extern int processor_cntl_xen_prepare(struct acpi_processor *pr);
+extern int processor_cntl_xen_notify(struct acpi_processor *pr,
+                       int event, int type);
+
+#else
+
+static inline int processor_cntl_xen(void) {return 0;}
+static inline int processor_cntl_xen_pm(void) {return 0;}
+static inline int processor_cntl_xen_pmperf(void) {return 0;}
+static inline int processor_cntl_xen_pmthr(void) {return 0;}
+static inline int processor_cntl_xen_notify(struct acpi_processor *pr,
+                       int event, int type)
+{
+       return 0;
+}
+static inline int processor_cntl_xen_prepare(struct acpi_processor *pr)
+{
+       return 0;
+}
+#endif /* CONFIG_ACPI_PROCESSOR_XEN */
+
 #endif /* _XEN_ACPI_H */

--_002_4D05DB80B95B23498C72C700BD6C2E0B315D671Apdsmsx502ccrcor_
Content-Type: application/octet-stream;
	name="03-introduce-the-external-control.patch.patch"
Content-Description: 03-introduce-the-external-control.patch.patch
Content-Disposition: attachment;
	filename="03-introduce-the-external-control.patch.patch"; size=22203;
	creation-date="Wed, 29 Jul 2009 22:43:25 GMT";
	modification-date="Wed, 29 Jul 2009 22:40:19 GMT"
Content-Transfer-Encoding: base64

TGV2ZXJhZ2UgZG9tYWluMCBBQ1BJIHBhcnNlciBmb3IgeGVuCgpGcm9tOiBZdSBLZSA8a2UueXVA
aW50ZWwuY29tPgoKVGhpcyBwYXRjaCByZXVzZSBkb20wIEFDUEkgcGFyc2VyIHRvIGdldCBDL1Ag
c3RhdGUgZm9yIFhlbgoKPT09IE92ZXJ2aWV3ID09PQoKUmVxdWlyZW1lbnQ6IFhlbiBoeXBlcnZp
c29yIG5lZWQgQ3gvUHggQUNQSSBpbmZvIHRvIGRvIHRoZSBDeC9QeCBzdGF0ZXMKcG93ZXIgbWFu
YWdlbWVudC4gVGhpcyBpbmZvIGlzIHByb3ZpZGVkIGJ5IEJJT1MgQUNQSSB0YWJsZS4gU2luY2UK
aHlwZXJ2aXNvciBoYXMgbm8gQUNQSSBwYXJzZXIsIHRoaXMgaW5mbyBoYXMgdG8gYmUgcGFyc2Vk
IGJ5IGRvbWFpbjAKa2VybmVsIEFDUEkgc3ViLXN5c3RlbSwgYW5kIHRoZW4gcGFzc2VkIHRvIGh5
cGVydmlzb3IgYnkgaHlwZXJjYWxsLgoKVG8gbWFrZSB0aGlzIGhhcHBlbiwgdGhlIGtleSBwb2lu
dCBpcyB0byBhZGQgaG9vayBpbiB0aGUga2VybmVsIEFDUEkKc3ViLXN5c3RlbS4gRm9ydHVuYXRl
bHksIGtlcm5lbCBhbHJlYWR5IGhhcyBnb29kIGFic3RyYWN0aW9uLCBhbmQKb25seSBzZXZlcmFs
IHBsYWNlcyBuZWVkIHRvIGFkZCBob29rLiBUbyBiZSBtb3JlIGRldGFpbCwgdGhlcmUgaXMgYW4K
YWNwaV9wcm9jZXNzb3JfZHJpdmVyIChpbiBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYykg
LCB3aGljaCBhbGwgdGhlCkN4L1B4IHBhcnNpbmcgZXZlbnQgd2lsbCBnbyB0by4gVGhpcyBkcml2
ZXIgd2lsbCBjYWxsIGl0cyBhY3BpIHByb2Nlc3NvcgpldmVudCBoYW5kbGVyLCBlLmcuIGFkZC9y
ZW1vdmUsIHN0YXJ0L3N0b3AsIG5vdGlmeSB0byBoYW5kbGUgdGhlc2UKZXZlbnRzLiBUaGVzZSBl
dmVudCBoYW5kbGVycyBpbiB0dXJuIHdpbGwgY2FsbCBzb21lIGxpYnJhcnkgZnVuY3Rpb25zIChp
bgpkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3BlcmZsaWIuYyksIGUuZy4gYWNwaV9wcm9jZXNzb3Jf
cHBjX2hhc19jaGFuZ2VkLAphY3BpX3Byb2Nlc3Nvcl9wcGNfaGFzX2NoYW5nZWQsIGFjcGlfcHJv
Y2Vzc29yX2NzdF9oYXNfY2hhbmdlZCwgdG8gZmluaXNoCnRoZSBhY3BpIGluZm8gcGFyc2luZy4K
ClNvIHRoaXMgcGF0Y2ggYWRkIHRoZSB4ZW4gaG9vayBpbiB0aGVzZSBwbGFjZXMgdG8gbm90aWZ5
IHhlbiBmb3IgdGhlIHBhcnNlZApDeC9QeCBzdGF0ZSBpbmZvcm1hdGlvbi4KClNpZ25lZC1vZmYt
Ynk6IFl1IEtlIDxrZS55dUBpbnRlbC5jb20+ClNpZ25lZC1vZmYtYnk6IFRpYW4gS2V2aW4gPGtl
dmluLnRpYW5AaW50ZWwuY29tPgotLS0KCiBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYyAg
ICB8ICAgMTcgKysKIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jICAgIHwgICAyNSArKwog
ZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9wZXJmbGliLmMgfCAgIDEwICsKIGRyaXZlcnMveGVuL0tj
b25maWcgICAgICAgICAgICAgIHwgICAgNyArCiBkcml2ZXJzL3hlbi9NYWtlZmlsZSAgICAgICAg
ICAgICB8ICAgIDMgCiBkcml2ZXJzL3hlbi9wcm9jZXNzb3JfZXh0Y250bC5jICB8ICA0MTMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvYWNwaS9wcm9jZXNz
b3IuaCAgICAgICAgIHwgICAgNiArCiBpbmNsdWRlL3hlbi9hY3BpLmggICAgICAgICAgICAgICB8
ICAgNTUgKysrKysKIDggZmlsZXMgY2hhbmdlZCwgNTI4IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy94ZW4vcHJvY2Vzc29yX2V4dGNudGwu
YwoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYyBiL2RyaXZlcnMv
YWNwaS9wcm9jZXNzb3JfY29yZS5jCmluZGV4IDg0ZTBmM2MuLjI3MDdkNjUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfY29yZS5jCisrKyBiL2RyaXZlcnMvYWNwaS9wcm9jZXNz
b3JfY29yZS5jCkBAIC01OCw2ICs1OCw3IEBACiAjaW5jbHVkZSA8YWNwaS9hY3BpX2J1cy5oPgog
I2luY2x1ZGUgPGFjcGkvYWNwaV9kcml2ZXJzLmg+CiAjaW5jbHVkZSA8YWNwaS9wcm9jZXNzb3Iu
aD4KKyNpbmNsdWRlIDx4ZW4vYWNwaS5oPgogCiAjZGVmaW5lIEFDUElfUFJPQ0VTU09SX0NMQVNT
CQkicHJvY2Vzc29yIgogI2RlZmluZSBBQ1BJX1BST0NFU1NPUl9ERVZJQ0VfTkFNRQkiUHJvY2Vz
c29yIgpAQCAtNzUxLDYgKzc1MiwxMCBAQCBzdGF0aWMgaW50IF9fY3B1aW5pdCBhY3BpX3Byb2Nl
c3Nvcl9zdGFydChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkKIAogCWFjcGlfcHJvY2Vzc29y
X3Bvd2VyX2luaXQocHIsIGRldmljZSk7CiAKKwlyZXN1bHQgPSBwcm9jZXNzb3JfY250bF94ZW5f
cHJlcGFyZShwcik7CisJaWYgKHJlc3VsdCkKKwkJZ290byBlbmQ7CisKIAlwci0+Y2RldiA9IHRo
ZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIoIlByb2Nlc3NvciIsIGRldmljZSwKIAkJCQkJ
CSZwcm9jZXNzb3JfY29vbGluZ19vcHMpOwogCWlmIChJU19FUlIocHItPmNkZXYpKSB7CkBAIC05
NjMsNiArOTY4LDEwIEBAIGludCBhY3BpX3Byb2Nlc3Nvcl9kZXZpY2VfYWRkKGFjcGlfaGFuZGxl
IGhhbmRsZSwgc3RydWN0IGFjcGlfZGV2aWNlICoqZGV2aWNlKQogCWlmICghcHIpCiAJCXJldHVy
biAtRU5PREVWOwogCisJaWYgKHByb2Nlc3Nvcl9jbnRsX3hlbigpKQorCQlwcm9jZXNzb3JfY250
bF94ZW5fbm90aWZ5KHByLAorCQkJUFJPQ0VTU09SX0hPVFBMVUcsIEhPVFBMVUdfVFlQRV9BREQp
OworCiAJaWYgKChwci0+aWQgPj0gMCkgJiYgKHByLT5pZCA8IG5yX2NwdV9pZHMpKSB7CiAJCWtv
YmplY3RfdWV2ZW50KCYoKmRldmljZSktPmRldi5rb2JqLCBLT0JKX09OTElORSk7CiAJfQpAQCAt
MTAwMiwxMSArMTAxMSwxOSBAQCBzdGF0aWMgdm9pZCBfX3JlZiBhY3BpX3Byb2Nlc3Nvcl9ob3Rw
bHVnX25vdGlmeShhY3BpX2hhbmRsZSBoYW5kbGUsCiAJCQlicmVhazsKIAkJfQogCisJCWlmIChw
cm9jZXNzb3JfY250bF94ZW4oKSkKKwkJCXByb2Nlc3Nvcl9jbnRsX3hlbl9ub3RpZnkocHIsCisJ
CQkJCVBST0NFU1NPUl9IT1RQTFVHLCBIT1RQTFVHX1RZUEVfQUREKTsKKwogCQlpZiAocHItPmlk
ID49IDAgJiYgKHByLT5pZCA8IG5yX2NwdV9pZHMpKSB7CiAJCQlrb2JqZWN0X3VldmVudCgmZGV2
aWNlLT5kZXYua29iaiwgS09CSl9PRkZMSU5FKTsKIAkJCWJyZWFrOwogCQl9CiAKKwkJaWYgKHBy
b2Nlc3Nvcl9jbnRsX3hlbigpKQorCQkJcHJvY2Vzc29yX2NudGxfeGVuX25vdGlmeShwciwgUFJP
Q0VTU09SX0hPVFBMVUcsCisJCQkJCQkJSE9UUExVR19UWVBFX1JFTU9WRSk7CisKIAkJcmVzdWx0
ID0gYWNwaV9wcm9jZXNzb3Jfc3RhcnQoZGV2aWNlKTsKIAkJaWYgKCghcmVzdWx0KSAmJiAoKHBy
LT5pZCA+PSAwKSAmJiAocHItPmlkIDwgbnJfY3B1X2lkcykpKSB7CiAJCQlrb2JqZWN0X3VldmVu
dCgmZGV2aWNlLT5kZXYua29iaiwgS09CSl9PTkxJTkUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9h
Y3BpL3Byb2Nlc3Nvcl9pZGxlLmMgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYwppbmRl
eCAwZWZhNTllLi44OTk0YWZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lk
bGUuYworKysgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYwpAQCAtNTgsNiArNTgsNyBA
QAogCiAjaW5jbHVkZSA8YWNwaS9hY3BpX2J1cy5oPgogI2luY2x1ZGUgPGFjcGkvcHJvY2Vzc29y
Lmg+CisjaW5jbHVkZSA8eGVuL2FjcGkuaD4KICNpbmNsdWRlIDxhc20vcHJvY2Vzc29yLmg+CiAK
ICNkZWZpbmUgQUNQSV9QUk9DRVNTT1JfQ0xBU1MgICAgICAgICAgICAicHJvY2Vzc29yIgpAQCAt
NDU1LDYgKzQ1NiwxMiBAQCBzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX2dldF9wb3dlcl9pbmZv
X2NzdChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQogCiAJCWN4LnBvd2VyID0gb2JqLT5pbnRl
Z2VyLnZhbHVlOwogCisjaWZkZWYgQ09ORklHX0FDUElfUFJPQ0VTU09SX1hFTgorCQkvKiBjYWNo
ZSBjb250cm9sIG1ldGhvZHMgdG8gbm90aWZ5IHhlbiovCisJCWlmIChwcm9jZXNzb3JfY250bF94
ZW5fcG0oKSkKKwkJCW1lbWNweSgmY3gucmVnLCByZWcsIHNpemVvZigqcmVnKSk7CisjZW5kaWYK
KwogCQljdXJyZW50X2NvdW50Kys7CiAJCW1lbWNweSgmKHByLT5wb3dlci5zdGF0ZXNbY3VycmVu
dF9jb3VudF0pLCAmY3gsIHNpemVvZihjeCkpOwogCkBAIC0xMTQxLDYgKzExNDgsMTMgQEAgaW50
IGFjcGlfcHJvY2Vzc29yX2NzdF9oYXNfY2hhbmdlZChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnBy
KQogCWlmICghcHItPmZsYWdzLnBvd2VyX3NldHVwX2RvbmUpCiAJCXJldHVybiAtRU5PREVWOwog
CisgICAgaWYgKHByb2Nlc3Nvcl9jbnRsX3hlbl9wbSgpKSB7CisJCWFjcGlfcHJvY2Vzc29yX2dl
dF9wb3dlcl9pbmZvKHByKTsKKwkJcHJvY2Vzc29yX2NudGxfeGVuX25vdGlmeShwciwKKwkJCVBS
T0NFU1NPUl9QTV9DSEFOR0UsIFBNX1RZUEVfSURMRSk7CisJCXJldHVybiByZXQ7CisJfQorCiAJ
Y3B1aWRsZV9wYXVzZV9hbmRfbG9jaygpOwogCWNwdWlkbGVfZGlzYWJsZV9kZXZpY2UoJnByLT5w
b3dlci5kZXYpOwogCWFjcGlfcHJvY2Vzc29yX2dldF9wb3dlcl9pbmZvKHByKTsKQEAgLTEyMDQs
OSArMTIxOCwxNCBAQCBpbnQgX19jcHVpbml0IGFjcGlfcHJvY2Vzc29yX3Bvd2VyX2luaXQoc3Ry
dWN0IGFjcGlfcHJvY2Vzc29yICpwciwKIAkgKiBwbGF0Zm9ybXMgdGhhdCBvbmx5IHN1cHBvcnQg
QzEuCiAJICovCiAJaWYgKHByLT5mbGFncy5wb3dlcikgewotCQlhY3BpX3Byb2Nlc3Nvcl9zZXR1
cF9jcHVpZGxlKHByKTsKLQkJaWYgKGNwdWlkbGVfcmVnaXN0ZXJfZGV2aWNlKCZwci0+cG93ZXIu
ZGV2KSkKLQkJCXJldHVybiAtRUlPOworCQlpZiAocHJvY2Vzc29yX2NudGxfeGVuX3BtKCkpCisJ
CQlwcm9jZXNzb3JfY250bF94ZW5fbm90aWZ5KHByLAorCQkJCQlQUk9DRVNTT1JfUE1fSU5JVCwg
UE1fVFlQRV9JRExFKTsKKwkJZWxzZSB7CisJCQlhY3BpX3Byb2Nlc3Nvcl9zZXR1cF9jcHVpZGxl
KHByKTsKKwkJCWlmIChjcHVpZGxlX3JlZ2lzdGVyX2RldmljZSgmcHItPnBvd2VyLmRldikpCisJ
CQkJcmV0dXJuIC1FSU87CisJCX0KIAogCQlwcmludGsoS0VSTl9JTkZPIFBSRUZJWCAiQ1BVJWQg
KHBvd2VyIHN0YXRlczoiLCBwci0+aWQpOwogCQlmb3IgKGkgPSAxOyBpIDw9IHByLT5wb3dlci5j
b3VudDsgaSsrKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9wZXJmbGliLmMg
Yi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3BlcmZsaWIuYwppbmRleCA2MGU1NDNkLi44Mzc1MDc1
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3BlcmZsaWIuYworKysgYi9kcml2
ZXJzL2FjcGkvcHJvY2Vzc29yX3BlcmZsaWIuYwpAQCAtMzgsNiArMzgsNyBAQAogI2luY2x1ZGUg
PGFjcGkvYWNwaV9idXMuaD4KICNpbmNsdWRlIDxhY3BpL2FjcGlfZHJpdmVycy5oPgogI2luY2x1
ZGUgPGFjcGkvcHJvY2Vzc29yLmg+CisjaW5jbHVkZSA8eGVuL2FjcGkuaD4KIAogI2RlZmluZSBB
Q1BJX1BST0NFU1NPUl9DTEFTUwkJInByb2Nlc3NvciIKICNkZWZpbmUgQUNQSV9QUk9DRVNTT1Jf
RklMRV9QRVJGT1JNQU5DRQkicGVyZm9ybWFuY2UiCkBAIC0xNTQsMTMgKzE1NSwxNiBAQCBpbnQg
YWNwaV9wcm9jZXNzb3JfcHBjX2hhc19jaGFuZ2VkKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIp
CiB7CiAJaW50IHJldDsKIAotCWlmIChpZ25vcmVfcHBjKQorCWlmIChpZ25vcmVfcHBjICYmICFw
cm9jZXNzb3JfY250bF94ZW5fcG1wZXJmKCkpCiAJCXJldHVybiAwOwogCiAJcmV0ID0gYWNwaV9w
cm9jZXNzb3JfZ2V0X3BsYXRmb3JtX2xpbWl0KHByKTsKIAogCWlmIChyZXQgPCAwKQogCQlyZXR1
cm4gKHJldCk7CisJZWxzZSBpZiAocHJvY2Vzc29yX2NudGxfeGVuX3BtcGVyZigpKQorCQlyZXR1
cm4gcHJvY2Vzc29yX2NudGxfeGVuX25vdGlmeShwciwKKwkJCQlQUk9DRVNTT1JfUE1fQ0hBTkdF
LCBQTV9UWVBFX1BFUkYpOwogCWVsc2UKIAkJcmV0dXJuIGNwdWZyZXFfdXBkYXRlX3BvbGljeShw
ci0+aWQpOwogfQpAQCAtMzMwLDcgKzMzNCw3IEBAIHN0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3Jf
Z2V0X3BlcmZvcm1hbmNlX3N0YXRlcyhzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQogCXJldHVy
biByZXN1bHQ7CiB9CiAKLXN0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3JfZ2V0X3BlcmZvcm1hbmNl
X2luZm8oc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikKK2ludCBhY3BpX3Byb2Nlc3Nvcl9nZXRf
cGVyZm9ybWFuY2VfaW5mbyhzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQogewogCWludCByZXN1
bHQgPSAwOwogCWFjcGlfc3RhdHVzIHN0YXR1cyA9IEFFX09LOwpAQCAtNDMyLDcgKzQzNiw3IEBA
IGludCBhY3BpX3Byb2Nlc3Nvcl9ub3RpZnlfc21tKHN0cnVjdCBtb2R1bGUgKmNhbGxpbmdfbW9k
dWxlKQogCiBFWFBPUlRfU1lNQk9MKGFjcGlfcHJvY2Vzc29yX25vdGlmeV9zbW0pOwogCi1zdGF0
aWMgaW50IGFjcGlfcHJvY2Vzc29yX2dldF9wc2Qoc3RydWN0IGFjcGlfcHJvY2Vzc29yCSpwcikK
K2ludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfcHNkKHN0cnVjdCBhY3BpX3Byb2Nlc3NvcgkqcHIpCiB7
CiAJaW50IHJlc3VsdCA9IDA7CiAJYWNwaV9zdGF0dXMgc3RhdHVzID0gQUVfT0s7CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3hlbi9LY29uZmlnIGIvZHJpdmVycy94ZW4vS2NvbmZpZwppbmRleCAzYjFj
NDIxLi5kMzAzYzI1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3hlbi9LY29uZmlnCisrKyBiL2RyaXZl
cnMveGVuL0tjb25maWcKQEAgLTkwLDQgKzkwLDkgQEAgY29uZmlnIFhFTl9YRU5CVVNfRlJPTlRF
TkQKIAogY29uZmlnIFhFTl9TMwogICAgICAgIGRlZl9ib29sIHkKLSAgICAgICBkZXBlbmRzIG9u
IFhFTl9ET00wICYmIEFDUEkKXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCisgICAgICAgZGVw
ZW5kcyBvbiBYRU5fRE9NMCAmJiBBQ1BJCisKK2NvbmZpZyBBQ1BJX1BST0NFU1NPUl9YRU4KKwli
b29sCisJZGVwZW5kcyBvbiBYRU5fRE9NMCAmJiBBQ1BJX1BST0NFU1NPUiAmJiBDUFVfRlJFUQor
CWRlZmF1bHQgeQpkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vTWFrZWZpbGUgYi9kcml2ZXJzL3hl
bi9NYWtlZmlsZQppbmRleCAzODZjNzc1Li40MmM5YWNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3hl
bi9NYWtlZmlsZQorKysgYi9kcml2ZXJzL3hlbi9NYWtlZmlsZQpAQCAtOSw0ICs5LDUgQEAgb2Jq
LSQoQ09ORklHX1hFTl9CTEtERVZfQkFDS0VORCkJKz0gYmxrYmFjay8KIG9iai0kKENPTkZJR19Y
RU5fTkVUREVWX0JBQ0tFTkQpCSs9IG5ldGJhY2svCiBvYmotJChDT05GSUdfWEVORlMpCQkJKz0g
eGVuZnMvCiBvYmotJChDT05GSUdfWEVOX1NZU19IWVBFUlZJU09SKQkrPSBzeXMtaHlwZXJ2aXNv
ci5vCi1vYmotJChDT05GSUdfWEVOX1MzKQkJCSs9IGFjcGkubwpcIE5vIG5ld2xpbmUgYXQgZW5k
IG9mIGZpbGUKK29iai0kKENPTkZJR19YRU5fUzMpCQkJKz0gYWNwaS5vCitvYmotJChDT05GSUdf
QUNQSV9QUk9DRVNTT1JfWEVOKSArPSBwcm9jZXNzb3JfZXh0Y250bC5vCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3hlbi9wcm9jZXNzb3JfZXh0Y250bC5jIGIvZHJpdmVycy94ZW4vcHJvY2Vzc29yX2V4
dGNudGwuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi43MzA3Y2Q4Ci0tLSAv
ZGV2L251bGwKKysrIGIvZHJpdmVycy94ZW4vcHJvY2Vzc29yX2V4dGNudGwuYwpAQCAtMCwwICsx
LDQxMyBAQAorLyoKKyAqIHByb2Nlc3Nvcl9leHRjbnRsLmMgLSBpbnRlcmZhY2UgdG8gbm90aWZ5
IFhlbgorICoKKyAqICBDb3B5cmlnaHQgKEMpIDIwMDgsIEludGVsIGNvcnBvcmF0aW9uCisgKgor
ICogfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdh
cmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2Yg
dGhlIExpY2Vuc2UsIG9yIChhdAorICogIHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4K
KyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQg
d2lsbCBiZSB1c2VmdWwsIGJ1dAorICogIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2
ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVT
UyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlIEdOVQorICogIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJl
Y2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKKyAq
ICB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBG
b3VuZGF0aW9uLCBJbmMuLAorICogIDU5IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0b24s
IE1BIDAyMTExLTEzMDcgVVNBLgorICoKKyAqLworCisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+
CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CisjaW5j
bHVkZSA8bGludXgvYWNwaS5oPgorI2luY2x1ZGUgPGxpbnV4L3BtLmg+CisjaW5jbHVkZSA8bGlu
dXgvY3B1Lmg+CisKKyNpbmNsdWRlIDxsaW51eC9jcHVmcmVxLmg+CisjaW5jbHVkZSA8YWNwaS9w
cm9jZXNzb3IuaD4KKyNpbmNsdWRlIDx4ZW4vYWNwaS5oPgorCisjaW5jbHVkZSA8YXNtL3hlbi9o
eXBlcmNhbGwuaD4KKyNpbmNsdWRlIDxhc20veGVuL2h5cGVydmlzb3IuaD4KKworc3RhdGljIGlu
dCBwcm9jZXNzb3JfY250bF94ZW5fZ2V0X3BlcmZvcm1hbmNlKHN0cnVjdCBhY3BpX3Byb2Nlc3Nv
ciAqcHIpOworc3RhdGljIGludCB4ZW5faG90cGx1Z19ub3RpZmllcihzdHJ1Y3QgYWNwaV9wcm9j
ZXNzb3IgKnByLCBpbnQgZXZlbnQpOworCitzdGF0aWMgc3RydWN0IHByb2Nlc3Nvcl9jbnRsX3hl
bl9vcHMgeGVuX29wcyA9IHsKKwkuaG90cGx1ZwkJPSB4ZW5faG90cGx1Z19ub3RpZmllciwKK307
CisKK2ludCBwcm9jZXNzb3JfY250bF94ZW4odm9pZCkKK3sKKwlyZXR1cm4gMTsKK30KKworaW50
IHByb2Nlc3Nvcl9jbnRsX3hlbl9wbSh2b2lkKQoreworCXJldHVybiAoeGVuX29wcy5wbV9vcHNb
UE1fVFlQRV9JRExFXSAhPSBOVUxMKTsKK30KKworaW50IHByb2Nlc3Nvcl9jbnRsX3hlbl9wbXBl
cmYodm9pZCkKK3sKKwlyZXR1cm4JKHhlbl9vcHMucG1fb3BzW1BNX1RZUEVfUEVSRl0gIT0gTlVM
TCk7Cit9CisKK2ludCBwcm9jZXNzb3JfY250bF94ZW5fcG10aHIodm9pZCkKK3sKKwlyZXR1cm4g
KHhlbl9vcHMucG1fb3BzW1BNX1RZUEVfVEhSXSAhPSBOVUxMKTsKK30KKworc3RhdGljIGludCBw
cm9jZXNzb3Jfbm90aWZ5X3NtbSh2b2lkKQoreworCWFjcGlfc3RhdHVzIHN0YXR1czsKKwlzdGF0
aWMgaW50IGlzX2RvbmUgPSAwOworCisJLyogb25seSBuZWVkIHN1Y2Nlc3NmdWxseSBub3RpZnkg
QklPUyBvbmNlICovCisJLyogYXZvaWQgZG91YmxlIG5vdGlmaWNhdGlvbiB3aGljaCBtYXkgbGVh
ZCB0byB1bmV4cGVjdGVkIHJlc3VsdCAqLworCWlmIChpc19kb25lKQorCQlyZXR1cm4gMDsKKwor
CS8qIENhbid0IHdyaXRlIHBzdGF0ZV9jbnQgdG8gc21pX2NtZCBpZiBlaXRoZXIgdmFsdWUgaXMg
emVybyAqLworCWlmICgoIWFjcGlfZ2JsX0ZBRFQuc21pX2NvbW1hbmQpIHx8ICghYWNwaV9nYmxf
RkFEVC5wc3RhdGVfY29udHJvbCkpIHsKKwkJQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9JTkZP
LCJObyBTTUkgcG9ydCBvciBwc3RhdGVfY250XG4iKSk7CisJCXJldHVybiAwOworCX0KKworCUFD
UElfREVCVUdfUFJJTlQoKEFDUElfREJfSU5GTywKKwkJIldyaXRpbmcgcHN0YXRlX2NudCBbMHgl
eF0gdG8gc21pX2NtZCBbMHgleF1cbiIsCisJCWFjcGlfZ2JsX0ZBRFQucHN0YXRlX2NvbnRyb2ws
IGFjcGlfZ2JsX0ZBRFQuc21pX2NvbW1hbmQpKTsKKworCXN0YXR1cyA9IGFjcGlfb3Nfd3JpdGVf
cG9ydChhY3BpX2dibF9GQURULnNtaV9jb21tYW5kLAorCQkJCSAgICAodTMyKSBhY3BpX2dibF9G
QURULnBzdGF0ZV9jb250cm9sLCA4KTsKKwlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpCisJCXJl
dHVybiBzdGF0dXM7CisKKwlpc19kb25lID0gMTsKKworCXJldHVybiAwOworfQorCitpbnQgcHJv
Y2Vzc29yX2NudGxfeGVuX25vdGlmeShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByLCBpbnQgZXZl
bnQsIGludCB0eXBlKQoreworCWludCByZXQgPSAtRUlOVkFMOworCisJc3dpdGNoIChldmVudCkg
eworCWNhc2UgUFJPQ0VTU09SX1BNX0lOSVQ6CisJY2FzZSBQUk9DRVNTT1JfUE1fQ0hBTkdFOgor
CQlpZiAoKHR5cGUgPj0gUE1fVFlQRV9NQVgpIHx8CisJCQkheGVuX29wcy5wbV9vcHNbdHlwZV0p
CisJCQlicmVhazsKKworCQlyZXQgPSB4ZW5fb3BzLnBtX29wc1t0eXBlXShwciwgZXZlbnQpOwor
CQlicmVhazsKKwljYXNlIFBST0NFU1NPUl9IT1RQTFVHOgorCQlpZiAoeGVuX29wcy5ob3RwbHVn
KQorCQkJcmV0ID0geGVuX29wcy5ob3RwbHVnKHByLCB0eXBlKTsKKwkJYnJlYWs7CisJZGVmYXVs
dDoKKwkJcHJpbnRrKEtFUk5fRVJSICJVbnN1cHBvcnQgcHJvY2Vzc29yIGV2ZW50cyAlZC5cbiIs
IGV2ZW50KTsKKwkJYnJlYWs7CisJfQorCisJcmV0dXJuIHJldDsKK30KKworLyoKKyAqIFRoaXMg
aXMgY2FsbGVkIGZyb20gQUNQSSBwcm9jZXNzb3IgaW5pdCwgYW5kIHRhcmdldGVkIHRvIGhvbGQK
KyAqIHNvbWUgdHJpY2t5IGhvdXNla2VlcGluZyBqb2JzIHRvIHNhdGlzZnkgeGVuLgorICogRm9y
IGV4YW1wbGUsIHdlIG1heSBwdXQgZGVwZW5kZW5jeSBwYXJzZSBzdHViIGhlcmUgZm9yIGlkbGUK
KyAqIGFuZCBwZXJmb3JtYW5jZSBzdGF0ZS4gVGhvc2UgaW5mb3JtYXRpb24gbWF5IGJlIG5vdCBh
dmFpbGFibGUKKyAqIGlmIHNwbGl0dGluZyBmcm9tIGRvbTAgY29udHJvbCBsb2dpYyBsaWtlIGNw
dWZyZXEgZHJpdmVyLgorICovCitpbnQgcHJvY2Vzc29yX2NudGxfeGVuX3ByZXBhcmUoc3RydWN0
IGFjcGlfcHJvY2Vzc29yICpwcikKK3sKKworCS8qIEluaXRpYWxpemUgcGVyZm9ybWFuY2Ugc3Rh
dGVzICovCisJaWYgKHByb2Nlc3Nvcl9jbnRsX3hlbl9wbXBlcmYoKSkKKwkJcHJvY2Vzc29yX2Nu
dGxfeGVuX2dldF9wZXJmb3JtYW5jZShwcik7CisKKwlyZXR1cm4gMDsKK30KKworLyoKKyAqIEV4
aXN0aW5nIEFDUEkgbW9kdWxlIGRvZXMgcGFyc2UgcGVyZm9ybWFuY2Ugc3RhdGVzIGF0IHNvbWUg
cG9pbnQsCisgKiB3aGVuIGFjcGktY3B1ZnJlcSBkcml2ZXIgaXMgbG9hZGVkIHdoaWNoIGhvd2V2
ZXIgaXMgc29tZXRoaW5nCisgKiB3ZSdkIGxpa2UgdG8gZGlzYWJsZSB0byBhdm9pZCBjb25mbGlj
dGlvbiB3aXRoIHhlbiBQTQorICogbG9naWMuIFNvIHdlIGhhdmUgdG8gY29sbGVjdCByYXcgcGVy
Zm9ybWFuY2UgaW5mb3JtYXRpb24gaGVyZQorICogd2hlbiBBQ1BJIHByb2Nlc3NvciBvYmplY3Qg
aXMgZm91bmQgYW5kIHN0YXJ0ZWQuCisgKi8KK3N0YXRpYyBpbnQgcHJvY2Vzc29yX2NudGxfeGVu
X2dldF9wZXJmb3JtYW5jZShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQoreworCWludCByZXQ7
CisJc3RydWN0IGFjcGlfcHJvY2Vzc29yX3BlcmZvcm1hbmNlICpwZXJmOworCXN0cnVjdCBhY3Bp
X3BzZF9wYWNrYWdlICpwZG9tYWluOworCisJaWYgKHByLT5wZXJmb3JtYW5jZSkKKwkJcmV0dXJu
IC1FQlVTWTsKKworCXBlcmYgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgYWNwaV9wcm9jZXNzb3Jf
cGVyZm9ybWFuY2UpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIXBlcmYpCisJCXJldHVybiAtRU5PTUVN
OworCisJcHItPnBlcmZvcm1hbmNlID0gcGVyZjsKKwkvKiBHZXQgYmFzaWMgcGVyZm9ybWFuY2Ug
c3RhdGUgaW5mb3JtYXRpb24gKi8KKwlyZXQgPSBhY3BpX3Byb2Nlc3Nvcl9nZXRfcGVyZm9ybWFu
Y2VfaW5mbyhwcik7CisJaWYgKHJldCA8IDApCisJCWdvdG8gZXJyX291dDsKKworCS8qCisJICog
V2VsbCwgaGVyZSB3ZSBuZWVkIHJldHJpZXZlIHBlcmZvcm1hbmNlIGRlcGVuZGVuY3kgaW5mb3Jt
YXRpb24KKwkgKiBmcm9tIF9QU0Qgb2JqZWN0LiBUaGUgcmVhc29uIHdoeSBleGlzdGluZyBpbnRl
cmZhY2UgaXMgbm90IHVzZWQKKwkgKiBpcyBkdWUgdG8gdGhlIHJlYXNvbiB0aGF0IGV4aXN0aW5n
IGludGVyZmFjZSBzdGlja3MgdG8gTGludXggY3B1CisJICogaWQgdG8gY29uc3RydWN0IHNvbWUg
Yml0bWFwLCBob3dldmVyIHdlIHdhbnQgdG8gc3BsaXQgQUNQSQorCSAqIHByb2Nlc3NvciBvYmpl
Y3RzIGZyb20gTGludXggY3B1IGlkIGxvZ2ljLiBGb3IgZXhhbXBsZSwgZXZlbgorCSAqIHdoZW4g
TGludXggaXMgY29uZmlndXJlZCBhcyBVUCwgd2Ugc3RpbGwgd2FudCB0byBwYXJzZSBhbGwgQUNQ
SQorCSAqIHByb2Nlc3NvciBvYmplY3RzIHRvIHhlbi4gSW4gdGhpcyBjYXNlLCBpdCdzIHByZWZl
cnJlZAorCSAqIHRvIHVzZSBBQ1BJIElEIGluc3RlYWQuCisJICovCisJcGRvbWFpbiA9ICZwci0+
cGVyZm9ybWFuY2UtPmRvbWFpbl9pbmZvOworCXBkb21haW4tPm51bV9wcm9jZXNzb3JzID0gMDsK
KwlyZXQgPSBhY3BpX3Byb2Nlc3Nvcl9nZXRfcHNkKHByKTsKKwlpZiAocmV0IDwgMCkgeworCQkv
KgorCQkgKiBfUFNEIGlzIG9wdGlvbmFsIC0gYXNzdW1lIG5vIGNvb3JkaW5hdGlvbiBpZiBhYnNl
bnQgKG9yCisJCSAqIGJyb2tlbiksIG1hdGNoaW5nIG5hdGl2ZSBrZXJuZWxzJyBiZWhhdmlvci4K
KwkJICovCisJCXBkb21haW4tPm51bV9lbnRyaWVzID0gQUNQSV9QU0RfUkVWMF9FTlRSSUVTOwor
CQlwZG9tYWluLT5yZXZpc2lvbiA9IEFDUElfUFNEX1JFVjBfUkVWSVNJT047CisJCXBkb21haW4t
PmRvbWFpbiA9IHByLT5hY3BpX2lkOworCQlwZG9tYWluLT5jb29yZF90eXBlID0gRE9NQUlOX0NP
T1JEX1RZUEVfU1dfQUxMOworCQlwZG9tYWluLT5udW1fcHJvY2Vzc29ycyA9IDE7CisJfQorCisJ
LyogU29tZSBzYW5pdHkgY2hlY2sgKi8KKwlpZiAoKHBkb21haW4tPnJldmlzaW9uICE9IEFDUElf
UFNEX1JFVjBfUkVWSVNJT04pIHx8CisJICAgIChwZG9tYWluLT5udW1fZW50cmllcyAhPSBBQ1BJ
X1BTRF9SRVYwX0VOVFJJRVMpIHx8CisJICAgICgocGRvbWFpbi0+Y29vcmRfdHlwZSAhPSBET01B
SU5fQ09PUkRfVFlQRV9TV19BTEwpICYmCisJICAgICAocGRvbWFpbi0+Y29vcmRfdHlwZSAhPSBE
T01BSU5fQ09PUkRfVFlQRV9TV19BTlkpICYmCisJICAgICAocGRvbWFpbi0+Y29vcmRfdHlwZSAh
PSBET01BSU5fQ09PUkRfVFlQRV9IV19BTEwpKSkgeworCQlyZXQgPSAtRUlOVkFMOworCQlnb3Rv
IGVycl9vdXQ7CisJfQorCisJLyogTGFzdCBzdGVwIGlzIHRvIG5vdGlmeSBCSU9TIHRoYXQgeGVu
IGV4aXN0cyAqLworCXByb2Nlc3Nvcl9ub3RpZnlfc21tKCk7CisKKwlwcm9jZXNzb3JfY250bF94
ZW5fbm90aWZ5KHByLCBQUk9DRVNTT1JfUE1fSU5JVCwgUE1fVFlQRV9QRVJGKTsKKworCXJldHVy
biAwOworZXJyX291dDoKKwlwci0+cGVyZm9ybWFuY2UgPSBOVUxMOworCWtmcmVlKHBlcmYpOwor
CXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fY29udmVydF9wY3RfcmVn
KHN0cnVjdCB4ZW5fcGN0X3JlZ2lzdGVyICp4cGN0LAorCXN0cnVjdCBhY3BpX3BjdF9yZWdpc3Rl
ciAqYXBjdCkKK3sKKwl4cGN0LT5kZXNjcmlwdG9yID0gYXBjdC0+ZGVzY3JpcHRvcjsKKwl4cGN0
LT5sZW5ndGggICAgID0gYXBjdC0+bGVuZ3RoOworCXhwY3QtPnNwYWNlX2lkICAgPSBhcGN0LT5z
cGFjZV9pZDsKKwl4cGN0LT5iaXRfd2lkdGggID0gYXBjdC0+Yml0X3dpZHRoOworCXhwY3QtPmJp
dF9vZmZzZXQgPSBhcGN0LT5iaXRfb2Zmc2V0OworCXhwY3QtPnJlc2VydmVkICAgPSBhcGN0LT5y
ZXNlcnZlZDsKKwl4cGN0LT5hZGRyZXNzICAgID0gYXBjdC0+YWRkcmVzczsKK30KKworc3RhdGlj
IGlubGluZSB2b2lkIHhlbl9jb252ZXJ0X3Bzc19zdGF0ZXMoc3RydWN0IHhlbl9wcm9jZXNzb3Jf
cHggKnhwc3MsCisJc3RydWN0IGFjcGlfcHJvY2Vzc29yX3B4ICphcHNzLCBpbnQgc3RhdGVfY291
bnQpCit7CisJaW50IGk7CisJZm9yKGk9MDsgaTxzdGF0ZV9jb3VudDsgaSsrKSB7CisJCXhwc3Mt
PmNvcmVfZnJlcXVlbmN5ICAgICA9IGFwc3MtPmNvcmVfZnJlcXVlbmN5OworCQl4cHNzLT5wb3dl
ciAgICAgICAgICAgICAgPSBhcHNzLT5wb3dlcjsKKwkJeHBzcy0+dHJhbnNpdGlvbl9sYXRlbmN5
ID0gYXBzcy0+dHJhbnNpdGlvbl9sYXRlbmN5OworCQl4cHNzLT5idXNfbWFzdGVyX2xhdGVuY3kg
PSBhcHNzLT5idXNfbWFzdGVyX2xhdGVuY3k7CisJCXhwc3MtPmNvbnRyb2wgICAgICAgICAgICA9
IGFwc3MtPmNvbnRyb2w7CisJCXhwc3MtPnN0YXR1cyAgICAgICAgICAgICA9IGFwc3MtPnN0YXR1
czsKKwkJeHBzcysrOworCQlhcHNzKys7CisJfQorfQorCitzdGF0aWMgaW5saW5lIHZvaWQgeGVu
X2NvbnZlcnRfcHNkX3BhY2soc3RydWN0IHhlbl9wc2RfcGFja2FnZSAqeHBzZCwKKwlzdHJ1Y3Qg
YWNwaV9wc2RfcGFja2FnZSAqYXBzZCkKK3sKKwl4cHNkLT5udW1fZW50cmllcyAgICA9IGFwc2Qt
Pm51bV9lbnRyaWVzOworCXhwc2QtPnJldmlzaW9uICAgICAgID0gYXBzZC0+cmV2aXNpb247CisJ
eHBzZC0+ZG9tYWluICAgICAgICAgPSBhcHNkLT5kb21haW47CisJeHBzZC0+Y29vcmRfdHlwZSAg
ICAgPSBhcHNkLT5jb29yZF90eXBlOworCXhwc2QtPm51bV9wcm9jZXNzb3JzID0gYXBzZC0+bnVt
X3Byb2Nlc3NvcnM7Cit9CisKK3N0YXRpYyBpbnQgeGVuX2N4X25vdGlmaWVyKHN0cnVjdCBhY3Bp
X3Byb2Nlc3NvciAqcHIsIGludCBhY3Rpb24pCit7CisJaW50IHJldCwgY291bnQgPSAwLCBpOwor
CXhlbl9wbGF0Zm9ybV9vcF90IG9wID0geworCQkuY21kCQkJPSBYRU5QRl9zZXRfcHJvY2Vzc29y
X3BtaW5mbywKKwkJLmludGVyZmFjZV92ZXJzaW9uCT0gWEVOUEZfSU5URVJGQUNFX1ZFUlNJT04s
CisJCS51LnNldF9wbWluZm8uaWQJPSBwci0+YWNwaV9pZCwKKwkJLnUuc2V0X3BtaW5mby50eXBl
CT0gWEVOX1BNX0NYLAorCX07CisJc3RydWN0IHhlbl9wcm9jZXNzb3JfY3ggKmRhdGEsICpidWY7
CisJc3RydWN0IGFjcGlfcHJvY2Vzc29yX2N4ICpjeDsKKworCWlmIChhY3Rpb24gPT0gUFJPQ0VT
U09SX1BNX0NIQU5HRSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwkvKiBDb252ZXJ0IHRvIFhlbiBk
ZWZpbmVkIHN0cnVjdHVyZSBhbmQgaHlwZXJjYWxsICovCisJYnVmID0ga3phbGxvYyhwci0+cG93
ZXIuY291bnQgKiBzaXplb2Yoc3RydWN0IHhlbl9wcm9jZXNzb3JfY3gpLAorCQkJR0ZQX0tFUk5F
TCk7CisJaWYgKCFidWYpCisJCXJldHVybiAtRU5PTUVNOworCisJZGF0YSA9IGJ1ZjsKKwlmb3Ig
KGkgPSAxOyBpIDw9IHByLT5wb3dlci5jb3VudDsgaSsrKSB7CisJCWN4ID0gJnByLT5wb3dlci5z
dGF0ZXNbaV07CisJCS8qIFNraXAgaW52YWxpZCBjc3RhdGUgZW50cnkgKi8KKwkJaWYgKCFjeC0+
dmFsaWQpCisJCQljb250aW51ZTsKKworCQlkYXRhLT50eXBlID0gY3gtPnR5cGU7CisJCWRhdGEt
PmxhdGVuY3kgPSBjeC0+bGF0ZW5jeTsKKwkJZGF0YS0+cG93ZXIgPSBjeC0+cG93ZXI7CisJCWRh
dGEtPnJlZy5zcGFjZV9pZCA9IGN4LT5yZWcuc3BhY2VfaWQ7CisJCWRhdGEtPnJlZy5iaXRfd2lk
dGggPSBjeC0+cmVnLmJpdF93aWR0aDsKKwkJZGF0YS0+cmVnLmJpdF9vZmZzZXQgPSBjeC0+cmVn
LmJpdF9vZmZzZXQ7CisJCWRhdGEtPnJlZy5hY2Nlc3Nfc2l6ZSA9IGN4LT5yZWcucmVzZXJ2ZWQ7
CisJCWRhdGEtPnJlZy5hZGRyZXNzID0gY3gtPnJlZy5hZGRyZXNzOworCisJCS8qIEdldCBkZXBl
bmRlbmN5IHJlbGF0aW9uc2hpcHMsIF9DU0QgaXMgbm90IHN1cHBvcnRlZCB5ZXQgKi8KKwkJZGF0
YS0+ZHBjbnQgPSAwOworCQlzZXRfeGVuX2d1ZXN0X2hhbmRsZShkYXRhLT5kcCwgTlVMTCk7CisK
KwkJZGF0YSsrOworCQljb3VudCsrOworCX0KKworCWlmICghY291bnQpIHsKKwkJcHJpbnRrKCJO
byBhdmFpbGFibGUgQ3ggaW5mbyBmb3IgY3B1ICVkXG4iLCBwci0+YWNwaV9pZCk7CisJCWtmcmVl
KGJ1Zik7CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCW9wLnUuc2V0X3BtaW5mby5wb3dlci5j
b3VudCA9IGNvdW50OworCW9wLnUuc2V0X3BtaW5mby5wb3dlci5mbGFncy5ibV9jb250cm9sID0g
cHItPmZsYWdzLmJtX2NvbnRyb2w7CisJb3AudS5zZXRfcG1pbmZvLnBvd2VyLmZsYWdzLmJtX2No
ZWNrID0gcHItPmZsYWdzLmJtX2NoZWNrOworCW9wLnUuc2V0X3BtaW5mby5wb3dlci5mbGFncy5o
YXNfY3N0ID0gcHItPmZsYWdzLmhhc19jc3Q7CisJb3AudS5zZXRfcG1pbmZvLnBvd2VyLmZsYWdz
LnBvd2VyX3NldHVwX2RvbmUgPSBwci0+ZmxhZ3MucG93ZXJfc2V0dXBfZG9uZTsKKworCXNldF94
ZW5fZ3Vlc3RfaGFuZGxlKG9wLnUuc2V0X3BtaW5mby5wb3dlci5zdGF0ZXMsIGJ1Zik7CisJcmV0
ID0gSFlQRVJWSVNPUl9kb20wX29wKCZvcCk7CisJa2ZyZWUoYnVmKTsKKwlyZXR1cm4gcmV0Owor
fQorCitzdGF0aWMgaW50IHhlbl9weF9ub3RpZmllcihzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnBy
LCBpbnQgYWN0aW9uKQoreworCWludCByZXQgPSAtRUlOVkFMOworCXhlbl9wbGF0Zm9ybV9vcF90
IG9wID0geworCQkuY21kCQkJPSBYRU5QRl9zZXRfcHJvY2Vzc29yX3BtaW5mbywKKwkJLmludGVy
ZmFjZV92ZXJzaW9uCT0gWEVOUEZfSU5URVJGQUNFX1ZFUlNJT04sCisJCS51LnNldF9wbWluZm8u
aWQJPSBwci0+YWNwaV9pZCwKKwkJLnUuc2V0X3BtaW5mby50eXBlCT0gWEVOX1BNX1BYLAorCX07
CisJc3RydWN0IHhlbl9wcm9jZXNzb3JfcGVyZm9ybWFuY2UgKnBlcmY7CisJc3RydWN0IHhlbl9w
cm9jZXNzb3JfcHggKnN0YXRlcyA9IE5VTEw7CisJc3RydWN0IGFjcGlfcHJvY2Vzc29yX3BlcmZv
cm1hbmNlICpweDsKKwlzdHJ1Y3QgYWNwaV9wc2RfcGFja2FnZSAqcGRvbWFpbjsKKworCWlmICgh
cHIpCisJCXJldHVybiAtRUlOVkFMOworCisJcGVyZiA9ICZvcC51LnNldF9wbWluZm8ucGVyZjsK
KwlweCA9IHByLT5wZXJmb3JtYW5jZTsKKworCXN3aXRjaChhY3Rpb24pIHsKKwljYXNlIFBST0NF
U1NPUl9QTV9DSEFOR0U6CisJCS8qIHBwYyBkeW5hbWljIGhhbmRsZSAqLworCQlwZXJmLT5mbGFn
cyA9IFhFTl9QWF9QUEM7CisJCXBlcmYtPnBsYXRmb3JtX2xpbWl0ID0gcHItPnBlcmZvcm1hbmNl
X3BsYXRmb3JtX2xpbWl0OworCisJCXJldCA9IEhZUEVSVklTT1JfZG9tMF9vcCgmb3ApOworCQli
cmVhazsKKworCWNhc2UgUFJPQ0VTU09SX1BNX0lOSVQ6CisJCS8qIHB4IG5vcm1hbCBpbml0ICov
CisJCXBlcmYtPmZsYWdzID0gWEVOX1BYX1BQQyB8CisJCQkgICAgICBYRU5fUFhfUENUIHwKKwkJ
CSAgICAgIFhFTl9QWF9QU1MgfAorCQkJICAgICAgWEVOX1BYX1BTRDsKKworCQkvKiBwcGMgKi8K
KwkJcGVyZi0+cGxhdGZvcm1fbGltaXQgPSBwci0+cGVyZm9ybWFuY2VfcGxhdGZvcm1fbGltaXQ7
CisKKwkJLyogcGN0ICovCisJCXhlbl9jb252ZXJ0X3BjdF9yZWcoJnBlcmYtPmNvbnRyb2xfcmVn
aXN0ZXIsICZweC0+Y29udHJvbF9yZWdpc3Rlcik7CisJCXhlbl9jb252ZXJ0X3BjdF9yZWcoJnBl
cmYtPnN0YXR1c19yZWdpc3RlciwgJnB4LT5zdGF0dXNfcmVnaXN0ZXIpOworCisJCS8qIHBzcyAq
LworCQlwZXJmLT5zdGF0ZV9jb3VudCA9IHB4LT5zdGF0ZV9jb3VudDsKKwkJc3RhdGVzID0ga3ph
bGxvYyhweC0+c3RhdGVfY291bnQqc2l6ZW9mKHhlbl9wcm9jZXNzb3JfcHhfdCksR0ZQX0tFUk5F
TCk7CisJCWlmICghc3RhdGVzKQorCQkJcmV0dXJuIC1FTk9NRU07CisJCXhlbl9jb252ZXJ0X3Bz
c19zdGF0ZXMoc3RhdGVzLCBweC0+c3RhdGVzLCBweC0+c3RhdGVfY291bnQpOworCQlzZXRfeGVu
X2d1ZXN0X2hhbmRsZShwZXJmLT5zdGF0ZXMsIHN0YXRlcyk7CisKKwkJLyogcHNkICovCisJCXBk
b21haW4gPSAmcHgtPmRvbWFpbl9pbmZvOworCQl4ZW5fY29udmVydF9wc2RfcGFjaygmcGVyZi0+
ZG9tYWluX2luZm8sIHBkb21haW4pOworCQlpZiAocGRvbWFpbi0+Y29vcmRfdHlwZSA9PSBET01B
SU5fQ09PUkRfVFlQRV9TV19BTEwpCisJCQlwZXJmLT5zaGFyZWRfdHlwZSA9IENQVUZSRVFfU0hB
UkVEX1RZUEVfQUxMOworCQllbHNlIGlmIChwZG9tYWluLT5jb29yZF90eXBlID09IERPTUFJTl9D
T09SRF9UWVBFX1NXX0FOWSkKKwkJCXBlcmYtPnNoYXJlZF90eXBlID0gQ1BVRlJFUV9TSEFSRURf
VFlQRV9BTlk7CisJCWVsc2UgaWYgKHBkb21haW4tPmNvb3JkX3R5cGUgPT0gRE9NQUlOX0NPT1JE
X1RZUEVfSFdfQUxMKQorCQkJcGVyZi0+c2hhcmVkX3R5cGUgPSBDUFVGUkVRX1NIQVJFRF9UWVBF
X0hXOworCQllbHNlIHsKKwkJCXJldCA9IC1FTk9ERVY7CisJCQlrZnJlZShzdGF0ZXMpOworCQkJ
YnJlYWs7CisJCX0KKworCQlyZXQgPSBIWVBFUlZJU09SX2RvbTBfb3AoJm9wKTsKKwkJa2ZyZWUo
c3RhdGVzKTsKKwkJYnJlYWs7CisKKwlkZWZhdWx0OgorCQlicmVhazsKKwl9CisKKwlyZXR1cm4g
cmV0OworfQorCitzdGF0aWMgaW50IHhlbl90eF9ub3RpZmllcihzdHJ1Y3QgYWNwaV9wcm9jZXNz
b3IgKnByLCBpbnQgYWN0aW9uKQoreworCXJldHVybiAtRUlOVkFMOworfQorc3RhdGljIGludCB4
ZW5faG90cGx1Z19ub3RpZmllcihzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByLCBpbnQgZXZlbnQp
Cit7CisJcmV0dXJuIC1FSU5WQUw7Cit9CisKK3N0YXRpYyBpbnQgX19pbml0IHhlbl9hY3BpX3By
b2Nlc3Nvcl9leHRjbnRsX2luaXQodm9pZCkKK3sKKwl1bnNpZ25lZCBpbnQgcG1iaXRzID0gKHhl
bl9zdGFydF9pbmZvLT5mbGFncyAmIFNJRl9QTV9NQVNLKSA+PiA4OworCisJaWYgKCFwbWJpdHMp
CisJCXJldHVybiAwOworCWlmIChwbWJpdHMgJiBYRU5fUFJPQ0VTU09SX1BNX0NYKQorCQl4ZW5f
b3BzLnBtX29wc1tQTV9UWVBFX0lETEVdID0geGVuX2N4X25vdGlmaWVyOworCWlmIChwbWJpdHMg
JiBYRU5fUFJPQ0VTU09SX1BNX1BYKQorCQl4ZW5fb3BzLnBtX29wc1tQTV9UWVBFX1BFUkZdID0g
eGVuX3B4X25vdGlmaWVyOworCWlmIChwbWJpdHMgJiBYRU5fUFJPQ0VTU09SX1BNX1RYKQorCQl4
ZW5fb3BzLnBtX29wc1tQTV9UWVBFX1RIUl0gPSB4ZW5fdHhfbm90aWZpZXI7CisKKwlyZXR1cm4g
MDsKK30KKworc3Vic3lzX2luaXRjYWxsKHhlbl9hY3BpX3Byb2Nlc3Nvcl9leHRjbnRsX2luaXQp
OwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3BpL3Byb2Nlc3Nvci5oIGIvaW5jbHVkZS9hY3BpL3By
b2Nlc3Nvci5oCmluZGV4IGJhZjFlMGEuLjE0YzdlNGMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYWNw
aS9wcm9jZXNzb3IuaAorKysgYi9pbmNsdWRlL2FjcGkvcHJvY2Vzc29yLmgKQEAgLTc3LDYgKzc3
LDEwIEBAIHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9jeCB7CiAJc3RydWN0IGFjcGlfcHJvY2Vzc29y
X2N4X3BvbGljeSBwcm9tb3Rpb247CiAJc3RydWN0IGFjcGlfcHJvY2Vzc29yX2N4X3BvbGljeSBk
ZW1vdGlvbjsKIAljaGFyIGRlc2NbQUNQSV9DWF9ERVNDX0xFTl07CisjaWZkZWYgQ09ORklHX0FD
UElfUFJPQ0VTU09SX1hFTgorCS8qIFJlcXVpcmUgcmF3IGluZm9ybWF0aW9uIGZvciB4ZW4qLwor
CXN0cnVjdCBhY3BpX3Bvd2VyX3JlZ2lzdGVyIHJlZzsKKyNlbmRpZiAvKiBDT05GSUdfQUNQSV9Q
Uk9DRVNTT0VfWEVOICovCiB9OwogCiBzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfcG93ZXIgewpAQCAt
Mjk1LDYgKzI5OSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9mZmhfY3N0
YXRlX2VudGVyKHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9jeAogdm9pZCBhY3BpX3Byb2Nlc3Nvcl9w
cGNfaW5pdCh2b2lkKTsKIHZvaWQgYWNwaV9wcm9jZXNzb3JfcHBjX2V4aXQodm9pZCk7CiBpbnQg
YWNwaV9wcm9jZXNzb3JfcHBjX2hhc19jaGFuZ2VkKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIp
OworaW50IGFjcGlfcHJvY2Vzc29yX2dldF9wZXJmb3JtYW5jZV9pbmZvKHN0cnVjdCBhY3BpX3By
b2Nlc3NvciAqcHIpOworaW50IGFjcGlfcHJvY2Vzc29yX2dldF9wc2Qoc3RydWN0IGFjcGlfcHJv
Y2Vzc29yICpwcik7CiAjZWxzZQogc3RhdGljIGlubGluZSB2b2lkIGFjcGlfcHJvY2Vzc29yX3Bw
Y19pbml0KHZvaWQpCiB7CmRpZmYgLS1naXQgYS9pbmNsdWRlL3hlbi9hY3BpLmggYi9pbmNsdWRl
L3hlbi9hY3BpLmgKaW5kZXggZmVhNGNmYi4uNjM2YzNlNiAxMDA2NDQKLS0tIGEvaW5jbHVkZS94
ZW4vYWNwaS5oCisrKyBiL2luY2x1ZGUveGVuL2FjcGkuaApAQCAtMjAsNCArMjAsNTkgQEAgc3Rh
dGljIGlubGluZSBib29sIHhlbl9wdl9hY3BpKHZvaWQpCiBpbnQgYWNwaV9ub3RpZnlfaHlwZXJ2
aXNvcl9zdGF0ZSh1OCBzbGVlcF9zdGF0ZSwKIAkJCQkgdTMyIHBtMWFfY250LCB1MzIgcG0xYl9j
bmQpOwogCisvKgorICogRm9sbG93aW5nIGFyZSBpbnRlcmZhY2VzIGZvciB4ZW4gYWNwaSBwcm9j
ZXNzb3IgY29udHJvbAorICovCisKKy8qIEV2ZW50cyBub3RpZmllZCB0byB4ZW4gKi8KKyNkZWZp
bmUgUFJPQ0VTU09SX1BNX0lOSVQJMQorI2RlZmluZSBQUk9DRVNTT1JfUE1fQ0hBTkdFCTIKKyNk
ZWZpbmUgUFJPQ0VTU09SX0hPVFBMVUcJMworCisvKiBPYmplY3RzIGZvciB0aGUgUE0gZXZlbnRz
ICovCisjZGVmaW5lIFBNX1RZUEVfSURMRQkJMAorI2RlZmluZSBQTV9UWVBFX1BFUkYJCTEKKyNk
ZWZpbmUgUE1fVFlQRV9USFIJCTIKKyNkZWZpbmUgUE1fVFlQRV9NQVgJCTMKKworLyogUHJvY2Vz
c29yIGhvdHBsdWcgZXZlbnRzICovCisjZGVmaW5lIEhPVFBMVUdfVFlQRV9BREQJMAorI2RlZmlu
ZSBIT1RQTFVHX1RZUEVfUkVNT1ZFCTEKKworI2lmZGVmIENPTkZJR19BQ1BJX1BST0NFU1NPUl9Y
RU4KKyNpbmNsdWRlIDxhY3BpL2FjcGlfZHJpdmVycy5oPgorI2luY2x1ZGUgPGFjcGkvcHJvY2Vz
c29yLmg+CisKK3N0cnVjdCBwcm9jZXNzb3JfY250bF94ZW5fb3BzIHsKKwkvKiBUcmFuc2ZlciBw
cm9jZXNzb3IgUE0gZXZlbnRzIHRvIHhlbiAqLworaW50ICgqcG1fb3BzW1BNX1RZUEVfTUFYXSko
c3RydWN0IGFjcGlfcHJvY2Vzc29yICpwciwgaW50IGV2ZW50KTsKKwkvKiBOb3RpZnkgcGh5c2lj
YWwgcHJvY2Vzc29yIHN0YXR1cyB0byB4ZW4gKi8KKwlpbnQgKCpob3RwbHVnKShzdHJ1Y3QgYWNw
aV9wcm9jZXNzb3IgKnByLCBpbnQgdHlwZSk7Cit9OworCitleHRlcm4gaW50IHByb2Nlc3Nvcl9j
bnRsX3hlbih2b2lkKTsKK2V4dGVybiBpbnQgcHJvY2Vzc29yX2NudGxfeGVuX3BtKHZvaWQpOwor
ZXh0ZXJuIGludCBwcm9jZXNzb3JfY250bF94ZW5fcG1wZXJmKHZvaWQpOworZXh0ZXJuIGludCBw
cm9jZXNzb3JfY250bF94ZW5fcG10aHIodm9pZCk7CitleHRlcm4gaW50IHByb2Nlc3Nvcl9jbnRs
X3hlbl9wcmVwYXJlKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpOworZXh0ZXJuIGludCBwcm9j
ZXNzb3JfY250bF94ZW5fbm90aWZ5KHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIsCisJCQlpbnQg
ZXZlbnQsIGludCB0eXBlKTsKKworI2Vsc2UKKworc3RhdGljIGlubGluZSBpbnQgcHJvY2Vzc29y
X2NudGxfeGVuKHZvaWQpIHtyZXR1cm4gMDt9CitzdGF0aWMgaW5saW5lIGludCBwcm9jZXNzb3Jf
Y250bF94ZW5fcG0odm9pZCkge3JldHVybiAwO30KK3N0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3Nv
cl9jbnRsX3hlbl9wbXBlcmYodm9pZCkge3JldHVybiAwO30KK3N0YXRpYyBpbmxpbmUgaW50IHBy
b2Nlc3Nvcl9jbnRsX3hlbl9wbXRocih2b2lkKSB7cmV0dXJuIDA7fQorc3RhdGljIGlubGluZSBp
bnQgcHJvY2Vzc29yX2NudGxfeGVuX25vdGlmeShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByLAor
CQkJaW50IGV2ZW50LCBpbnQgdHlwZSkKK3sKKwlyZXR1cm4gMDsKK30KK3N0YXRpYyBpbmxpbmUg
aW50IHByb2Nlc3Nvcl9jbnRsX3hlbl9wcmVwYXJlKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIp
Cit7CisJcmV0dXJuIDA7Cit9CisjZW5kaWYgLyogQ09ORklHX0FDUElfUFJPQ0VTU09SX1hFTiAq
LworCiAjZW5kaWYJLyogX1hFTl9BQ1BJX0ggKi8K

--_002_4D05DB80B95B23498C72C700BD6C2E0B315D671Apdsmsx502ccrcor_--
