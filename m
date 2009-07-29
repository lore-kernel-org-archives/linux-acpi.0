From: "Yu, Ke" <ke.yu@intel.com>
Subject: FW: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Wed, 29 Jul 2009 10:55:45 +0800
Message-ID: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CCpdsmsx502ccrcor_"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63919 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbZG2C4t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Jul 2009 22:56:49 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "Tian, Kevin" <kevin.tian@intel.com>

--_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CCpdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Len,

This patch is the pv_ops domain0 changes to the acpi subsystem. The followi=
ng has the detail description on its purpose and implementation. May I have=
 your comments?

Best Regards
Ke

-----Original Message-----
From: xen-devel-bounces@lists.xensource.com [mailto:xen-devel-bounces@lists=
.xensource.com] On Behalf Of Yu, Ke
Sent: Sunday, July 19, 2009 2:46 PM
To: Jeremy Fitzhardinge
Cc: Tian, Kevin; xen-devel@lists.xensource.com
Subject: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external contro=
l operation interface for domain0 ACPI parser

Introduce the external control operation interface for domain0 ACPI parser

From: Yu Ke <ke.yu@intel.com>

This patch introduces the interface of external control operation, and
adds hooks to the acpi sub-system, including the acpi_processor_driver,
and the related library functions.

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

So the conclusion is: adding hooks in acpi_processor_driver and those
related library functions will satisfy our requirement.

To make the added hook cleaner, we introduce an interface called
external control operation (struct processor_extcntl_ops). All the hooks
are encapsulated in this interface processor_extcntl_ops . Here the
"external" means the acpi processor is controlled by external entity,
e.g. VMM. Every kind of external entity can has its implementation of
this interface. In this patch, the interface for Xen is implemented.

Signed-off-by: Yu Ke <ke.yu@intel.com>
Signed-off-by: Tian Kevin <kevin.tian@intel.com>
---

 drivers/acpi/Kconfig             |    5 +
 drivers/acpi/Makefile            |    1
 drivers/acpi/processor_core.c    |   16 +++
 drivers/acpi/processor_extcntl.c |  208 ++++++++++++++++++++++++++++++++++=
++++
 drivers/acpi/processor_idle.c    |   24 ++++
 drivers/acpi/processor_perflib.c |    9 +-
 include/acpi/processor.h         |   81 +++++++++++++++
 7 files changed, 338 insertions(+), 6 deletions(-)
 create mode 100644 drivers/acpi/processor_extcntl.c


diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 431f8b4..e932ee6 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -332,4 +332,9 @@ config ACPI_SBS
          To compile this driver as a module, choose M here:
          the modules will be called sbs and sbshc.

+config PROCESSOR_EXTERNAL_CONTROL
+       bool
+       depends on ACPI_PROCESSOR && CPU_FREQ
+       default y
+
 endif  # ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 03a985b..2a42a08 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_ACPI_SBS)                +=3D sbs.o
 processor-y                    :=3D processor_core.o processor_throttling.=
o
 processor-y                    +=3D processor_idle.o processor_thermal.o
 processor-$(CONFIG_CPU_FREQ)   +=3D processor_perflib.o
+processor-$(CONFIG_PROCESSOR_EXTERNAL_CONTROL) +=3D processor_extcntl.o
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 45ad328..0b6facc 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -740,6 +740,10 @@ static int __cpuinit acpi_processor_start(struct acpi_=
device *device)

        acpi_processor_power_init(pr, device);

+       result =3D processor_extcntl_prepare(pr);
+       if (result)
+               goto end;
+
        pr->cdev =3D thermal_cooling_device_register("Processor", device,
                                                &processor_cooling_ops);
        if (IS_ERR(pr->cdev)) {
@@ -952,6 +956,10 @@ int acpi_processor_device_add(acpi_handle handle, stru=
ct acpi_device **device)
        if (!pr)
                return -ENODEV;

+       if (processor_cntl_external())
+               processor_notify_external(pr,
+                       PROCESSOR_HOTPLUG, HOTPLUG_TYPE_ADD);
+
        if ((pr->id >=3D 0) && (pr->id < nr_cpu_ids)) {
                kobject_uevent(&(*device)->dev.kobj, KOBJ_ONLINE);
        }
@@ -991,11 +999,19 @@ static void __ref acpi_processor_hotplug_notify(acpi_=
handle handle,
                        break;
                }

+               if (processor_cntl_external())
+                       processor_notify_external(pr,
+                                       PROCESSOR_HOTPLUG, HOTPLUG_TYPE_ADD=
);
+
                if (pr->id >=3D 0 && (pr->id < nr_cpu_ids)) {
                        kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
                        break;
                }

+               if (processor_cntl_external())
+                       processor_notify_external(pr, PROCESSOR_HOTPLUG,
+                                                       HOTPLUG_TYPE_REMOVE=
);
+
                result =3D acpi_processor_start(device);
                if ((!result) && ((pr->id >=3D 0) && (pr->id < nr_cpu_ids))=
) {
                        kobject_uevent(&device->dev.kobj, KOBJ_ONLINE);
diff --git a/drivers/acpi/processor_extcntl.c b/drivers/acpi/processor_extc=
ntl.c
new file mode 100644
index 0000000..af3191f
--- /dev/null
+++ b/drivers/acpi/processor_extcntl.c
@@ -0,0 +1,208 @@
+/*
+ * processor_extcntl.c - channel to external control logic
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
+#include <acpi/processor.h>
+
+#define ACPI_PROCESSOR_CLASS            "processor"
+#define ACPI_PROCESSOR_DRIVER_NAME      "ACPI Processor Driver"
+#define _COMPONENT              ACPI_PROCESSOR_COMPONENT
+ACPI_MODULE_NAME("acpi_processor")
+
+static int processor_extcntl_get_performance(struct acpi_processor *pr);
+/*
+ * External processor control logic may register with its own set of
+ * ops to get ACPI related notification. One example is like VMM.
+ */
+const struct processor_extcntl_ops *processor_extcntl_ops;
+EXPORT_SYMBOL(processor_extcntl_ops);
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
+int processor_notify_external(struct acpi_processor *pr, int event, int ty=
pe)
+{
+       int ret =3D -EINVAL;
+
+       if (!processor_cntl_external())
+               return -EINVAL;
+
+       switch (event) {
+       case PROCESSOR_PM_INIT:
+       case PROCESSOR_PM_CHANGE:
+               if ((type >=3D PM_TYPE_MAX) ||
+                       !processor_extcntl_ops->pm_ops[type])
+                       break;
+
+               ret =3D processor_extcntl_ops->pm_ops[type](pr, event);
+               break;
+       case PROCESSOR_HOTPLUG:
+               if (processor_extcntl_ops->hotplug)
+                       ret =3D processor_extcntl_ops->hotplug(pr, type);
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
+ * External control logic can decide to grab full or part of physical
+ * processor control bits. Take a VMM for example, physical processors
+ * are owned by VMM and thus existence information like hotplug is
+ * always required to be notified to VMM. Similar is processor idle
+ * state which is also necessarily controlled by VMM. But for other
+ * control bits like performance/throttle states, VMM may choose to
+ * control or not upon its own policy.
+ */
+void processor_extcntl_register(struct processor_extcntl_ops* ops)
+{
+       if (!processor_extcntl_ops)
+               processor_extcntl_ops=3Dops;
+}
+EXPORT_SYMBOL(processor_extcntl_register);
+
+/*
+ * This is called from ACPI processor init, and targeted to hold
+ * some tricky housekeeping jobs to satisfy external control model.
+ * For example, we may put dependency parse stub here for idle
+ * and performance state. Those information may be not available
+ * if splitting from dom0 control logic like cpufreq driver.
+ */
+int processor_extcntl_prepare(struct acpi_processor *pr)
+{
+
+       /* Initialize performance states */
+       if (processor_pmperf_external())
+               processor_extcntl_get_performance(pr);
+
+       return 0;
+}
+
+/*
+ * Existing ACPI module does parse performance states at some point,
+ * when acpi-cpufreq driver is loaded which however is something
+ * we'd like to disable to avoid confliction with external control
+ * logic. So we have to collect raw performance information here
+ * when ACPI processor object is found and started.
+ */
+static int processor_extcntl_get_performance(struct acpi_processor *pr)
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
+        * processor objects to external logic. In this case, it's preferre=
d
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
+       /* Last step is to notify BIOS that external logic exists */
+       processor_notify_smm();
+
+       processor_notify_external(pr, PROCESSOR_PM_INIT, PM_TYPE_PERF);
+
+       return 0;
+err_out:
+       pr->performance =3D NULL;
+       kfree(perf);
+       return ret;
+}
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index abbe2bb..49ccb84 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -425,6 +425,12 @@ static int acpi_processor_get_power_info_cst(struct ac=
pi_processor *pr)

                cx.power =3D obj->integer.value;

+#ifdef CONFIG_PROCESSOR_EXTERNAL_CONTROL
+               /* cache control methods to notify external logic */
+               if (processor_pm_external())
+                       memcpy(&cx.reg, reg, sizeof(*reg));
+#endif /* CONFIG_PROCESSOR_EXTERNAL_CONTROL */
+
                current_count++;
                memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx))=
;

@@ -1120,6 +1126,13 @@ int acpi_processor_cst_has_changed(struct acpi_proce=
ssor *pr)
        if (!pr->flags.power_setup_done)
                return -ENODEV;

+    if (processor_pm_external()) {
+               acpi_processor_get_power_info(pr);
+               processor_notify_external(pr,
+                       PROCESSOR_PM_CHANGE, PM_TYPE_IDLE);
+               return ret;
+       }
+
        cpuidle_pause_and_lock();
        cpuidle_disable_device(&pr->power.dev);
        acpi_processor_get_power_info(pr);
@@ -1183,9 +1196,14 @@ int __cpuinit acpi_processor_power_init(struct acpi_=
processor *pr,
         * platforms that only support C1.
         */
        if (pr->flags.power) {
-               acpi_processor_setup_cpuidle(pr);
-               if (cpuidle_register_device(&pr->power.dev))
-                       return -EIO;
+               if (processor_pm_external())
+                       processor_notify_external(pr,
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
index cafb410..b222cdb 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -154,13 +154,16 @@ int acpi_processor_ppc_has_changed(struct acpi_proces=
sor *pr)
 {
        int ret;

-       if (ignore_ppc)
+       if (ignore_ppc && !processor_pmperf_external())
                return 0;

        ret =3D acpi_processor_get_platform_limit(pr);

        if (ret < 0)
                return (ret);
+       else if (processor_pmperf_external())
+               return processor_notify_external(pr,
+                               PROCESSOR_PM_CHANGE, PM_TYPE_PERF);
        else
                return cpufreq_update_policy(pr->id);
 }
@@ -324,7 +327,7 @@ static int acpi_processor_get_performance_states(struct=
 acpi_processor *pr)
        return result;
 }

-static int acpi_processor_get_performance_info(struct acpi_processor *pr)
+int acpi_processor_get_performance_info(struct acpi_processor *pr)
 {
        int result =3D 0;
        acpi_status status =3D AE_OK;
@@ -426,7 +429,7 @@ int acpi_processor_notify_smm(struct module *calling_mo=
dule)

 EXPORT_SYMBOL(acpi_processor_notify_smm);

-static int acpi_processor_get_psd(struct acpi_processor        *pr)
+int acpi_processor_get_psd(struct acpi_processor       *pr)
 {
        int result =3D 0;
        acpi_status status =3D AE_OK;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index b09c4fd..d6bb2d2 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -77,6 +77,10 @@ struct acpi_processor_cx {
        struct acpi_processor_cx_policy promotion;
        struct acpi_processor_cx_policy demotion;
        char desc[ACPI_CX_DESC_LEN];
+#ifdef CONFIG_PROCESSOR_EXTERNAL_CONTROL
+       /* Require raw information for external control logic */
+       struct acpi_power_register reg;
+#endif /* CONFIG_PROCESSOR_EXTERNAL_CONTROL */
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
@@ -352,4 +358,79 @@ static inline void acpi_thermal_cpufreq_exit(void)
 }
 #endif

+/*
+ * Following are interfaces geared to external processor PM control
+ * logic like a VMM
+ */
+/* Events notified to external control logic */
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
+#ifdef CONFIG_PROCESSOR_EXTERNAL_CONTROL
+struct processor_extcntl_ops {
+       /* Transfer processor PM events to external control logic */
+int (*pm_ops[PM_TYPE_MAX])(struct acpi_processor *pr, int event);
+       /* Notify physical processor status to external control logic */
+       int (*hotplug)(struct acpi_processor *pr, int type);
+};
+extern const struct processor_extcntl_ops *processor_extcntl_ops;
+
+static inline int processor_cntl_external(void)
+{
+       return (processor_extcntl_ops !=3D NULL);
+}
+
+static inline int processor_pm_external(void)
+{
+       return processor_cntl_external() &&
+               (processor_extcntl_ops->pm_ops[PM_TYPE_IDLE] !=3D NULL);
+}
+
+static inline int processor_pmperf_external(void)
+{
+       return processor_cntl_external() &&
+               (processor_extcntl_ops->pm_ops[PM_TYPE_PERF] !=3D NULL);
+}
+
+static inline int processor_pmthr_external(void)
+{
+       return processor_cntl_external() &&
+               (processor_extcntl_ops->pm_ops[PM_TYPE_THR] !=3D NULL);
+}
+
+extern int processor_notify_external(struct acpi_processor *pr,
+                       int event, int type);
+extern void processor_extcntl_register(struct processor_extcntl_ops* ops);
+extern int processor_extcntl_prepare(struct acpi_processor *pr);
+#else
+static inline int processor_cntl_external(void) {return 0;}
+static inline int processor_pm_external(void) {return 0;}
+static inline int processor_pmperf_external(void) {return 0;}
+static inline int processor_pmthr_external(void) {return 0;}
+static inline int processor_notify_external(struct acpi_processor *pr,
+                       int event, int type)
+{
+       return 0;
+}
+static inline void processor_extcntl_register(struct processor_extcntl_ops=
* ops)
+{
+       return 0;
+}
+static inline int processor_extcntl_prepare(struct acpi_processor *pr)
+{
+       return 0;
+}
+#endif /* CONFIG_PROCESSOR_EXTERNAL_CONTROL */
+
 #endif


--_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CCpdsmsx502ccrcor_
Content-Type: application/octet-stream;
	name="external-control-framework.patch"
Content-Description: external-control-framework.patch
Content-Disposition: attachment;
	filename="external-control-framework.patch"; size=17666;
	creation-date="Sun, 19 Jul 2009 21:49:23 GMT";
	modification-date="Sun, 19 Jul 2009 21:36:11 GMT"
Content-Transfer-Encoding: base64

SW50cm9kdWNlIHRoZSBleHRlcm5hbCBjb250cm9sIG9wZXJhdGlvbiBpbnRlcmZhY2UgZm9yIGRv
bWFpbjAgQUNQSSBwYXJzZXIKCkZyb206IFl1IEtlIDxrZS55dUBpbnRlbC5jb20+CgpUaGlzIHBh
dGNoIGludHJvZHVjZXMgdGhlIGludGVyZmFjZSBvZiBleHRlcm5hbCBjb250cm9sIG9wZXJhdGlv
biwgYW5kCmFkZHMgaG9va3MgdG8gdGhlIGFjcGkgc3ViLXN5c3RlbSwgaW5jbHVkaW5nIHRoZSBh
Y3BpX3Byb2Nlc3Nvcl9kcml2ZXIsCmFuZCB0aGUgcmVsYXRlZCBsaWJyYXJ5IGZ1bmN0aW9ucy4K
Cj09PSBPdmVydmlldyA9PT0KClJlcXVpcmVtZW50OiBYZW4gaHlwZXJ2aXNvciBuZWVkIEN4L1B4
IEFDUEkgaW5mbyB0byBkbyB0aGUgQ3gvUHggc3RhdGVzCnBvd2VyIG1hbmFnZW1lbnQuIFRoaXMg
aW5mbyBpcyBwcm92aWRlZCBieSBCSU9TIEFDUEkgdGFibGUuIFNpbmNlCmh5cGVydmlzb3IgaGFz
IG5vIEFDUEkgcGFyc2VyLCB0aGlzIGluZm8gaGFzIHRvIGJlIHBhcnNlZCBieSBkb21haW4wCmtl
cm5lbCBBQ1BJIHN1Yi1zeXN0ZW0sIGFuZCB0aGVuIHBhc3NlZCB0byBoeXBlcnZpc29yIGJ5IGh5
cGVyY2FsbC4KClRvIG1ha2UgdGhpcyBoYXBwZW4sIHRoZSBrZXkgcG9pbnQgaXMgdG8gYWRkIGhv
b2sgaW4gdGhlIGtlcm5lbCBBQ1BJCnN1Yi1zeXN0ZW0uIEZvcnR1bmF0ZWx5LCBrZXJuZWwgYWxy
ZWFkeSBoYXMgZ29vZCBhYnN0cmFjdGlvbiwgYW5kCm9ubHkgc2V2ZXJhbCBwbGFjZXMgbmVlZCB0
byBhZGQgaG9vay4gVG8gYmUgbW9yZSBkZXRhaWwsIHRoZXJlIGlzIGFuCmFjcGlfcHJvY2Vzc29y
X2RyaXZlciAoaW4gZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9jb3JlLmMpICwgd2hpY2ggYWxsIHRo
ZQpDeC9QeCBwYXJzaW5nIGV2ZW50IHdpbGwgZ28gdG8uIFRoaXMgZHJpdmVyIHdpbGwgY2FsbCBp
dHMgYWNwaSBwcm9jZXNzb3IKZXZlbnQgaGFuZGxlciwgZS5nLiBhZGQvcmVtb3ZlLCBzdGFydC9z
dG9wLCBub3RpZnkgdG8gaGFuZGxlIHRoZXNlCmV2ZW50cy4gVGhlc2UgZXZlbnQgaGFuZGxlcnMg
aW4gdHVybiB3aWxsIGNhbGwgc29tZSBsaWJyYXJ5IGZ1bmN0aW9ucyAoaW4KZHJpdmVycy9hY3Bp
L3Byb2Nlc3Nvcl9wZXJmbGliLmMpLCBlLmcuIGFjcGlfcHJvY2Vzc29yX3BwY19oYXNfY2hhbmdl
ZCwKYWNwaV9wcm9jZXNzb3JfcHBjX2hhc19jaGFuZ2VkLCBhY3BpX3Byb2Nlc3Nvcl9jc3RfaGFz
X2NoYW5nZWQsIHRvIGZpbmlzaAp0aGUgYWNwaSBpbmZvIHBhcnNpbmcuCgpTbyB0aGUgY29uY2x1
c2lvbiBpczogYWRkaW5nIGhvb2tzIGluIGFjcGlfcHJvY2Vzc29yX2RyaXZlciBhbmQgdGhvc2UK
cmVsYXRlZCBsaWJyYXJ5IGZ1bmN0aW9ucyB3aWxsIHNhdGlzZnkgb3VyIHJlcXVpcmVtZW50LgoK
VG8gbWFrZSB0aGUgYWRkZWQgaG9vayBjbGVhbmVyLCB3ZSBpbnRyb2R1Y2UgYW4gaW50ZXJmYWNl
IGNhbGxlZApleHRlcm5hbCBjb250cm9sIG9wZXJhdGlvbiAoc3RydWN0IHByb2Nlc3Nvcl9leHRj
bnRsX29wcykuIEFsbCB0aGUgaG9va3MKYXJlIGVuY2Fwc3VsYXRlZCBpbiB0aGlzIGludGVyZmFj
ZSBwcm9jZXNzb3JfZXh0Y250bF9vcHMgLiBIZXJlIHRoZQoiZXh0ZXJuYWwiIG1lYW5zIHRoZSBh
Y3BpIHByb2Nlc3NvciBpcyBjb250cm9sbGVkIGJ5IGV4dGVybmFsIGVudGl0eSwKZS5nLiBWTU0u
IEV2ZXJ5IGtpbmQgb2YgZXh0ZXJuYWwgZW50aXR5IGNhbiBoYXMgaXRzIGltcGxlbWVudGF0aW9u
IG9mCnRoaXMgaW50ZXJmYWNlLiBJbiB0aGlzIHBhdGNoLCB0aGUgaW50ZXJmYWNlIGZvciBYZW4g
aXMgaW1wbGVtZW50ZWQuCgpTaWduZWQtb2ZmLWJ5OiBZdSBLZSA8a2UueXVAaW50ZWwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBUaWFuIEtldmluIDxrZXZpbi50aWFuQGludGVsLmNvbT4KLS0tCgogZHJp
dmVycy9hY3BpL0tjb25maWcgICAgICAgICAgICAgfCAgICA1ICsKIGRyaXZlcnMvYWNwaS9NYWtl
ZmlsZSAgICAgICAgICAgIHwgICAgMSAKIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfY29yZS5jICAg
IHwgICAxNiArKysKIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfZXh0Y250bC5jIHwgIDIwOCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9hY3BpL3Byb2Nlc3Nv
cl9pZGxlLmMgICAgfCAgIDI0ICsrKysKIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfcGVyZmxpYi5j
IHwgICAgOSArLQogaW5jbHVkZS9hY3BpL3Byb2Nlc3Nvci5oICAgICAgICAgfCAgIDgxICsrKysr
KysrKysrKysrKwogNyBmaWxlcyBjaGFuZ2VkLCAzMzggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2V4dGNudGwu
YwoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvS2NvbmZpZyBiL2RyaXZlcnMvYWNwaS9LY29u
ZmlnCmluZGV4IDQzMWY4YjQuLmU5MzJlZTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9LY29u
ZmlnCisrKyBiL2RyaXZlcnMvYWNwaS9LY29uZmlnCkBAIC0zMzIsNCArMzMyLDkgQEAgY29uZmln
IEFDUElfU0JTCiAJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2Ug
TSBoZXJlOgogCSAgdGhlIG1vZHVsZXMgd2lsbCBiZSBjYWxsZWQgc2JzIGFuZCBzYnNoYy4KIAor
Y29uZmlnIFBST0NFU1NPUl9FWFRFUk5BTF9DT05UUk9MCisJYm9vbAorCWRlcGVuZHMgb24gQUNQ
SV9QUk9DRVNTT1IgJiYgQ1BVX0ZSRVEKKwlkZWZhdWx0IHkKKwogZW5kaWYJIyBBQ1BJCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2FjcGkvTWFrZWZpbGUgYi9kcml2ZXJzL2FjcGkvTWFrZWZpbGUKaW5k
ZXggMDNhOTg1Yi4uMmE0MmEwOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL01ha2VmaWxlCisr
KyBiL2RyaXZlcnMvYWNwaS9NYWtlZmlsZQpAQCAtNjEsMyArNjEsNCBAQCBvYmotJChDT05GSUdf
QUNQSV9TQlMpCQkrPSBzYnMubwogcHJvY2Vzc29yLXkJCQk6PSBwcm9jZXNzb3JfY29yZS5vIHBy
b2Nlc3Nvcl90aHJvdHRsaW5nLm8KIHByb2Nlc3Nvci15CQkJKz0gcHJvY2Vzc29yX2lkbGUubyBw
cm9jZXNzb3JfdGhlcm1hbC5vCiBwcm9jZXNzb3ItJChDT05GSUdfQ1BVX0ZSRVEpCSs9IHByb2Nl
c3Nvcl9wZXJmbGliLm8KK3Byb2Nlc3Nvci0kKENPTkZJR19QUk9DRVNTT1JfRVhURVJOQUxfQ09O
VFJPTCkgKz0gcHJvY2Vzc29yX2V4dGNudGwubwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3By
b2Nlc3Nvcl9jb3JlLmMgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYwppbmRleCA0NWFk
MzI4Li4wYjZmYWNjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYwor
KysgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYwpAQCAtNzQwLDYgKzc0MCwxMCBAQCBz
dGF0aWMgaW50IF9fY3B1aW5pdCBhY3BpX3Byb2Nlc3Nvcl9zdGFydChzdHJ1Y3QgYWNwaV9kZXZp
Y2UgKmRldmljZSkKIAogCWFjcGlfcHJvY2Vzc29yX3Bvd2VyX2luaXQocHIsIGRldmljZSk7CiAK
KwlyZXN1bHQgPSBwcm9jZXNzb3JfZXh0Y250bF9wcmVwYXJlKHByKTsKKwlpZiAocmVzdWx0KQor
CQlnb3RvIGVuZDsKKwogCXByLT5jZGV2ID0gdGhlcm1hbF9jb29saW5nX2RldmljZV9yZWdpc3Rl
cigiUHJvY2Vzc29yIiwgZGV2aWNlLAogCQkJCQkJJnByb2Nlc3Nvcl9jb29saW5nX29wcyk7CiAJ
aWYgKElTX0VSUihwci0+Y2RldikpIHsKQEAgLTk1Miw2ICs5NTYsMTAgQEAgaW50IGFjcGlfcHJv
Y2Vzc29yX2RldmljZV9hZGQoYWNwaV9oYW5kbGUgaGFuZGxlLCBzdHJ1Y3QgYWNwaV9kZXZpY2Ug
KipkZXZpY2UpCiAJaWYgKCFwcikKIAkJcmV0dXJuIC1FTk9ERVY7CiAKKwlpZiAocHJvY2Vzc29y
X2NudGxfZXh0ZXJuYWwoKSkKKwkJcHJvY2Vzc29yX25vdGlmeV9leHRlcm5hbChwciwKKwkJCVBS
T0NFU1NPUl9IT1RQTFVHLCBIT1RQTFVHX1RZUEVfQUREKTsKKwogCWlmICgocHItPmlkID49IDAp
ICYmIChwci0+aWQgPCBucl9jcHVfaWRzKSkgewogCQlrb2JqZWN0X3VldmVudCgmKCpkZXZpY2Up
LT5kZXYua29iaiwgS09CSl9PTkxJTkUpOwogCX0KQEAgLTk5MSwxMSArOTk5LDE5IEBAIHN0YXRp
YyB2b2lkIF9fcmVmIGFjcGlfcHJvY2Vzc29yX2hvdHBsdWdfbm90aWZ5KGFjcGlfaGFuZGxlIGhh
bmRsZSwKIAkJCWJyZWFrOwogCQl9CiAKKwkJaWYgKHByb2Nlc3Nvcl9jbnRsX2V4dGVybmFsKCkp
CisJCQlwcm9jZXNzb3Jfbm90aWZ5X2V4dGVybmFsKHByLAorCQkJCQlQUk9DRVNTT1JfSE9UUExV
RywgSE9UUExVR19UWVBFX0FERCk7CisKIAkJaWYgKHByLT5pZCA+PSAwICYmIChwci0+aWQgPCBu
cl9jcHVfaWRzKSkgewogCQkJa29iamVjdF91ZXZlbnQoJmRldmljZS0+ZGV2LmtvYmosIEtPQkpf
T0ZGTElORSk7CiAJCQlicmVhazsKIAkJfQogCisJCWlmIChwcm9jZXNzb3JfY250bF9leHRlcm5h
bCgpKQorCQkJcHJvY2Vzc29yX25vdGlmeV9leHRlcm5hbChwciwgUFJPQ0VTU09SX0hPVFBMVUcs
CisJCQkJCQkJSE9UUExVR19UWVBFX1JFTU9WRSk7CisKIAkJcmVzdWx0ID0gYWNwaV9wcm9jZXNz
b3Jfc3RhcnQoZGV2aWNlKTsKIAkJaWYgKCghcmVzdWx0KSAmJiAoKHByLT5pZCA+PSAwKSAmJiAo
cHItPmlkIDwgbnJfY3B1X2lkcykpKSB7CiAJCQlrb2JqZWN0X3VldmVudCgmZGV2aWNlLT5kZXYu
a29iaiwgS09CSl9PTkxJTkUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9l
eHRjbnRsLmMgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2V4dGNudGwuYwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwLi5hZjMxOTFmCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVy
cy9hY3BpL3Byb2Nlc3Nvcl9leHRjbnRsLmMKQEAgLTAsMCArMSwyMDggQEAKKy8qCisgKiBwcm9j
ZXNzb3JfZXh0Y250bC5jIC0gY2hhbm5lbCB0byBleHRlcm5hbCBjb250cm9sIGxvZ2ljCisgKgor
ICogIENvcHlyaWdodCAoQykgMjAwOCwgSW50ZWwgY29ycG9yYXRpb24KKyAqCisgKiB+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhl
IEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5z
ZSwgb3IgKGF0CisgKiAgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBU
aGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVz
ZWZ1bCwgYnV0CisgKiAgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1w
bGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBB
UlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VCisgKiAgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBj
b3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZworICogIHdpdGggdGhp
cyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24s
IEluYy4sCisgKiAgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEt
MTMwNyBVU0EuCisgKgorICovCisKKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRl
IDxsaW51eC9pbml0Lmg+CisjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KKyNpbmNsdWRlIDxsaW51
eC9hY3BpLmg+CisjaW5jbHVkZSA8bGludXgvcG0uaD4KKyNpbmNsdWRlIDxsaW51eC9jcHUuaD4K
KworI2luY2x1ZGUgPGFjcGkvcHJvY2Vzc29yLmg+CisKKyNkZWZpbmUgQUNQSV9QUk9DRVNTT1Jf
Q0xBU1MgICAgICAgICAgICAicHJvY2Vzc29yIgorI2RlZmluZSBBQ1BJX1BST0NFU1NPUl9EUklW
RVJfTkFNRSAgICAgICJBQ1BJIFByb2Nlc3NvciBEcml2ZXIiCisjZGVmaW5lIF9DT01QT05FTlQg
ICAgICAgICAgICAgIEFDUElfUFJPQ0VTU09SX0NPTVBPTkVOVAorQUNQSV9NT0RVTEVfTkFNRSgi
YWNwaV9wcm9jZXNzb3IiKQorCitzdGF0aWMgaW50IHByb2Nlc3Nvcl9leHRjbnRsX2dldF9wZXJm
b3JtYW5jZShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKTsKKy8qCisgKiBFeHRlcm5hbCBwcm9j
ZXNzb3IgY29udHJvbCBsb2dpYyBtYXkgcmVnaXN0ZXIgd2l0aCBpdHMgb3duIHNldCBvZgorICog
b3BzIHRvIGdldCBBQ1BJIHJlbGF0ZWQgbm90aWZpY2F0aW9uLiBPbmUgZXhhbXBsZSBpcyBsaWtl
IFZNTS4KKyAqLworY29uc3Qgc3RydWN0IHByb2Nlc3Nvcl9leHRjbnRsX29wcyAqcHJvY2Vzc29y
X2V4dGNudGxfb3BzOworRVhQT1JUX1NZTUJPTChwcm9jZXNzb3JfZXh0Y250bF9vcHMpOworCitz
dGF0aWMgaW50IHByb2Nlc3Nvcl9ub3RpZnlfc21tKHZvaWQpCit7CisJYWNwaV9zdGF0dXMgc3Rh
dHVzOworCXN0YXRpYyBpbnQgaXNfZG9uZSA9IDA7CisKKwkvKiBvbmx5IG5lZWQgc3VjY2Vzc2Z1
bGx5IG5vdGlmeSBCSU9TIG9uY2UgKi8KKwkvKiBhdm9pZCBkb3VibGUgbm90aWZpY2F0aW9uIHdo
aWNoIG1heSBsZWFkIHRvIHVuZXhwZWN0ZWQgcmVzdWx0ICovCisJaWYgKGlzX2RvbmUpCisJCXJl
dHVybiAwOworCisJLyogQ2FuJ3Qgd3JpdGUgcHN0YXRlX2NudCB0byBzbWlfY21kIGlmIGVpdGhl
ciB2YWx1ZSBpcyB6ZXJvICovCisJaWYgKCghYWNwaV9nYmxfRkFEVC5zbWlfY29tbWFuZCkgfHwg
KCFhY3BpX2dibF9GQURULnBzdGF0ZV9jb250cm9sKSkgeworCQlBQ1BJX0RFQlVHX1BSSU5UKChB
Q1BJX0RCX0lORk8sIk5vIFNNSSBwb3J0IG9yIHBzdGF0ZV9jbnRcbiIpKTsKKwkJcmV0dXJuIDA7
CisJfQorCisJQUNQSV9ERUJVR19QUklOVCgoQUNQSV9EQl9JTkZPLAorCQkiV3JpdGluZyBwc3Rh
dGVfY250IFsweCV4XSB0byBzbWlfY21kIFsweCV4XVxuIiwKKwkJYWNwaV9nYmxfRkFEVC5wc3Rh
dGVfY29udHJvbCwgYWNwaV9nYmxfRkFEVC5zbWlfY29tbWFuZCkpOworCisJc3RhdHVzID0gYWNw
aV9vc193cml0ZV9wb3J0KGFjcGlfZ2JsX0ZBRFQuc21pX2NvbW1hbmQsCisJCQkJICAgICh1MzIp
IGFjcGlfZ2JsX0ZBRFQucHN0YXRlX2NvbnRyb2wsIDgpOworCWlmIChBQ1BJX0ZBSUxVUkUoc3Rh
dHVzKSkKKwkJcmV0dXJuIHN0YXR1czsKKworCWlzX2RvbmUgPSAxOworCisJcmV0dXJuIDA7Cit9
CisKK2ludCBwcm9jZXNzb3Jfbm90aWZ5X2V4dGVybmFsKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAq
cHIsIGludCBldmVudCwgaW50IHR5cGUpCit7CisJaW50IHJldCA9IC1FSU5WQUw7CisKKwlpZiAo
IXByb2Nlc3Nvcl9jbnRsX2V4dGVybmFsKCkpCisJCXJldHVybiAtRUlOVkFMOworCisJc3dpdGNo
IChldmVudCkgeworCWNhc2UgUFJPQ0VTU09SX1BNX0lOSVQ6CisJY2FzZSBQUk9DRVNTT1JfUE1f
Q0hBTkdFOgorCQlpZiAoKHR5cGUgPj0gUE1fVFlQRV9NQVgpIHx8CisJCQkhcHJvY2Vzc29yX2V4
dGNudGxfb3BzLT5wbV9vcHNbdHlwZV0pCisJCQlicmVhazsKKworCQlyZXQgPSBwcm9jZXNzb3Jf
ZXh0Y250bF9vcHMtPnBtX29wc1t0eXBlXShwciwgZXZlbnQpOworCQlicmVhazsKKwljYXNlIFBS
T0NFU1NPUl9IT1RQTFVHOgorCQlpZiAocHJvY2Vzc29yX2V4dGNudGxfb3BzLT5ob3RwbHVnKQor
CQkJcmV0ID0gcHJvY2Vzc29yX2V4dGNudGxfb3BzLT5ob3RwbHVnKHByLCB0eXBlKTsKKwkJYnJl
YWs7CisJZGVmYXVsdDoKKwkJcHJpbnRrKEtFUk5fRVJSICJVbnN1cHBvcnQgcHJvY2Vzc29yIGV2
ZW50cyAlZC5cbiIsIGV2ZW50KTsKKwkJYnJlYWs7CisJfQorCisJcmV0dXJuIHJldDsKK30KKwor
LyoKKyAqIEV4dGVybmFsIGNvbnRyb2wgbG9naWMgY2FuIGRlY2lkZSB0byBncmFiIGZ1bGwgb3Ig
cGFydCBvZiBwaHlzaWNhbAorICogcHJvY2Vzc29yIGNvbnRyb2wgYml0cy4gVGFrZSBhIFZNTSBm
b3IgZXhhbXBsZSwgcGh5c2ljYWwgcHJvY2Vzc29ycworICogYXJlIG93bmVkIGJ5IFZNTSBhbmQg
dGh1cyBleGlzdGVuY2UgaW5mb3JtYXRpb24gbGlrZSBob3RwbHVnIGlzCisgKiBhbHdheXMgcmVx
dWlyZWQgdG8gYmUgbm90aWZpZWQgdG8gVk1NLiBTaW1pbGFyIGlzIHByb2Nlc3NvciBpZGxlCisg
KiBzdGF0ZSB3aGljaCBpcyBhbHNvIG5lY2Vzc2FyaWx5IGNvbnRyb2xsZWQgYnkgVk1NLiBCdXQg
Zm9yIG90aGVyCisgKiBjb250cm9sIGJpdHMgbGlrZSBwZXJmb3JtYW5jZS90aHJvdHRsZSBzdGF0
ZXMsIFZNTSBtYXkgY2hvb3NlIHRvCisgKiBjb250cm9sIG9yIG5vdCB1cG9uIGl0cyBvd24gcG9s
aWN5LgorICovCit2b2lkIHByb2Nlc3Nvcl9leHRjbnRsX3JlZ2lzdGVyKHN0cnVjdCBwcm9jZXNz
b3JfZXh0Y250bF9vcHMqIG9wcykKK3sKKwlpZiAoIXByb2Nlc3Nvcl9leHRjbnRsX29wcykKKwkJ
cHJvY2Vzc29yX2V4dGNudGxfb3BzPW9wczsKK30KK0VYUE9SVF9TWU1CT0wocHJvY2Vzc29yX2V4
dGNudGxfcmVnaXN0ZXIpOworCisvKgorICogVGhpcyBpcyBjYWxsZWQgZnJvbSBBQ1BJIHByb2Nl
c3NvciBpbml0LCBhbmQgdGFyZ2V0ZWQgdG8gaG9sZAorICogc29tZSB0cmlja3kgaG91c2VrZWVw
aW5nIGpvYnMgdG8gc2F0aXNmeSBleHRlcm5hbCBjb250cm9sIG1vZGVsLgorICogRm9yIGV4YW1w
bGUsIHdlIG1heSBwdXQgZGVwZW5kZW5jeSBwYXJzZSBzdHViIGhlcmUgZm9yIGlkbGUKKyAqIGFu
ZCBwZXJmb3JtYW5jZSBzdGF0ZS4gVGhvc2UgaW5mb3JtYXRpb24gbWF5IGJlIG5vdCBhdmFpbGFi
bGUKKyAqIGlmIHNwbGl0dGluZyBmcm9tIGRvbTAgY29udHJvbCBsb2dpYyBsaWtlIGNwdWZyZXEg
ZHJpdmVyLgorICovCitpbnQgcHJvY2Vzc29yX2V4dGNudGxfcHJlcGFyZShzdHJ1Y3QgYWNwaV9w
cm9jZXNzb3IgKnByKQoreworCisJLyogSW5pdGlhbGl6ZSBwZXJmb3JtYW5jZSBzdGF0ZXMgKi8K
KwlpZiAocHJvY2Vzc29yX3BtcGVyZl9leHRlcm5hbCgpKQorCQlwcm9jZXNzb3JfZXh0Y250bF9n
ZXRfcGVyZm9ybWFuY2UocHIpOworCisJcmV0dXJuIDA7Cit9CisKKy8qCisgKiBFeGlzdGluZyBB
Q1BJIG1vZHVsZSBkb2VzIHBhcnNlIHBlcmZvcm1hbmNlIHN0YXRlcyBhdCBzb21lIHBvaW50LAor
ICogd2hlbiBhY3BpLWNwdWZyZXEgZHJpdmVyIGlzIGxvYWRlZCB3aGljaCBob3dldmVyIGlzIHNv
bWV0aGluZworICogd2UnZCBsaWtlIHRvIGRpc2FibGUgdG8gYXZvaWQgY29uZmxpY3Rpb24gd2l0
aCBleHRlcm5hbCBjb250cm9sCisgKiBsb2dpYy4gU28gd2UgaGF2ZSB0byBjb2xsZWN0IHJhdyBw
ZXJmb3JtYW5jZSBpbmZvcm1hdGlvbiBoZXJlCisgKiB3aGVuIEFDUEkgcHJvY2Vzc29yIG9iamVj
dCBpcyBmb3VuZCBhbmQgc3RhcnRlZC4KKyAqLworc3RhdGljIGludCBwcm9jZXNzb3JfZXh0Y250
bF9nZXRfcGVyZm9ybWFuY2Uoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikKK3sKKwlpbnQgcmV0
OworCXN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9wZXJmb3JtYW5jZSAqcGVyZjsKKwlzdHJ1Y3QgYWNw
aV9wc2RfcGFja2FnZSAqcGRvbWFpbjsKKworCWlmIChwci0+cGVyZm9ybWFuY2UpCisJCXJldHVy
biAtRUJVU1k7CisKKwlwZXJmID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGFjcGlfcHJvY2Vzc29y
X3BlcmZvcm1hbmNlKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFwZXJmKQorCQlyZXR1cm4gLUVOT01F
TTsKKworCXByLT5wZXJmb3JtYW5jZSA9IHBlcmY7CisJLyogR2V0IGJhc2ljIHBlcmZvcm1hbmNl
IHN0YXRlIGluZm9ybWF0aW9uICovCisJcmV0ID0gYWNwaV9wcm9jZXNzb3JfZ2V0X3BlcmZvcm1h
bmNlX2luZm8ocHIpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIGVycl9vdXQ7CisKKwkvKgorCSAq
IFdlbGwsIGhlcmUgd2UgbmVlZCByZXRyaWV2ZSBwZXJmb3JtYW5jZSBkZXBlbmRlbmN5IGluZm9y
bWF0aW9uCisJICogZnJvbSBfUFNEIG9iamVjdC4gVGhlIHJlYXNvbiB3aHkgZXhpc3RpbmcgaW50
ZXJmYWNlIGlzIG5vdCB1c2VkCisJICogaXMgZHVlIHRvIHRoZSByZWFzb24gdGhhdCBleGlzdGlu
ZyBpbnRlcmZhY2Ugc3RpY2tzIHRvIExpbnV4IGNwdQorCSAqIGlkIHRvIGNvbnN0cnVjdCBzb21l
IGJpdG1hcCwgaG93ZXZlciB3ZSB3YW50IHRvIHNwbGl0IEFDUEkKKwkgKiBwcm9jZXNzb3Igb2Jq
ZWN0cyBmcm9tIExpbnV4IGNwdSBpZCBsb2dpYy4gRm9yIGV4YW1wbGUsIGV2ZW4KKwkgKiB3aGVu
IExpbnV4IGlzIGNvbmZpZ3VyZWQgYXMgVVAsIHdlIHN0aWxsIHdhbnQgdG8gcGFyc2UgYWxsIEFD
UEkKKwkgKiBwcm9jZXNzb3Igb2JqZWN0cyB0byBleHRlcm5hbCBsb2dpYy4gSW4gdGhpcyBjYXNl
LCBpdCdzIHByZWZlcnJlZAorCSAqIHRvIHVzZSBBQ1BJIElEIGluc3RlYWQuCisJICovCisJcGRv
bWFpbiA9ICZwci0+cGVyZm9ybWFuY2UtPmRvbWFpbl9pbmZvOworCXBkb21haW4tPm51bV9wcm9j
ZXNzb3JzID0gMDsKKwlyZXQgPSBhY3BpX3Byb2Nlc3Nvcl9nZXRfcHNkKHByKTsKKwlpZiAocmV0
IDwgMCkgeworCQkvKgorCQkgKiBfUFNEIGlzIG9wdGlvbmFsIC0gYXNzdW1lIG5vIGNvb3JkaW5h
dGlvbiBpZiBhYnNlbnQgKG9yCisJCSAqIGJyb2tlbiksIG1hdGNoaW5nIG5hdGl2ZSBrZXJuZWxz
JyBiZWhhdmlvci4KKwkJICovCisJCXBkb21haW4tPm51bV9lbnRyaWVzID0gQUNQSV9QU0RfUkVW
MF9FTlRSSUVTOworCQlwZG9tYWluLT5yZXZpc2lvbiA9IEFDUElfUFNEX1JFVjBfUkVWSVNJT047
CisJCXBkb21haW4tPmRvbWFpbiA9IHByLT5hY3BpX2lkOworCQlwZG9tYWluLT5jb29yZF90eXBl
ID0gRE9NQUlOX0NPT1JEX1RZUEVfU1dfQUxMOworCQlwZG9tYWluLT5udW1fcHJvY2Vzc29ycyA9
IDE7CisJfQorCisJLyogU29tZSBzYW5pdHkgY2hlY2sgKi8KKwlpZiAoKHBkb21haW4tPnJldmlz
aW9uICE9IEFDUElfUFNEX1JFVjBfUkVWSVNJT04pIHx8CisJICAgIChwZG9tYWluLT5udW1fZW50
cmllcyAhPSBBQ1BJX1BTRF9SRVYwX0VOVFJJRVMpIHx8CisJICAgICgocGRvbWFpbi0+Y29vcmRf
dHlwZSAhPSBET01BSU5fQ09PUkRfVFlQRV9TV19BTEwpICYmCisJICAgICAocGRvbWFpbi0+Y29v
cmRfdHlwZSAhPSBET01BSU5fQ09PUkRfVFlQRV9TV19BTlkpICYmCisJICAgICAocGRvbWFpbi0+
Y29vcmRfdHlwZSAhPSBET01BSU5fQ09PUkRfVFlQRV9IV19BTEwpKSkgeworCQlyZXQgPSAtRUlO
VkFMOworCQlnb3RvIGVycl9vdXQ7CisJfQorCisJLyogTGFzdCBzdGVwIGlzIHRvIG5vdGlmeSBC
SU9TIHRoYXQgZXh0ZXJuYWwgbG9naWMgZXhpc3RzICovCisJcHJvY2Vzc29yX25vdGlmeV9zbW0o
KTsKKworCXByb2Nlc3Nvcl9ub3RpZnlfZXh0ZXJuYWwocHIsIFBST0NFU1NPUl9QTV9JTklULCBQ
TV9UWVBFX1BFUkYpOworCisJcmV0dXJuIDA7CitlcnJfb3V0OgorCXByLT5wZXJmb3JtYW5jZSA9
IE5VTEw7CisJa2ZyZWUocGVyZik7CisJcmV0dXJuIHJldDsKK30KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMK
aW5kZXggYWJiZTJiYi4uNDljY2I4NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nv
cl9pZGxlLmMKKysrIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMKQEAgLTQyNSw2ICs0
MjUsMTIgQEAgc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfcG93ZXJfaW5mb19jc3Qoc3Ry
dWN0IGFjcGlfcHJvY2Vzc29yICpwcikKIAogCQljeC5wb3dlciA9IG9iai0+aW50ZWdlci52YWx1
ZTsKIAorI2lmZGVmIENPTkZJR19QUk9DRVNTT1JfRVhURVJOQUxfQ09OVFJPTAorCQkvKiBjYWNo
ZSBjb250cm9sIG1ldGhvZHMgdG8gbm90aWZ5IGV4dGVybmFsIGxvZ2ljICovCisJCWlmIChwcm9j
ZXNzb3JfcG1fZXh0ZXJuYWwoKSkKKwkJCW1lbWNweSgmY3gucmVnLCByZWcsIHNpemVvZigqcmVn
KSk7CisjZW5kaWYgLyogQ09ORklHX1BST0NFU1NPUl9FWFRFUk5BTF9DT05UUk9MICovCisKIAkJ
Y3VycmVudF9jb3VudCsrOwogCQltZW1jcHkoJihwci0+cG93ZXIuc3RhdGVzW2N1cnJlbnRfY291
bnRdKSwgJmN4LCBzaXplb2YoY3gpKTsKIApAQCAtMTEyMCw2ICsxMTI2LDEzIEBAIGludCBhY3Bp
X3Byb2Nlc3Nvcl9jc3RfaGFzX2NoYW5nZWQoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikKIAlp
ZiAoIXByLT5mbGFncy5wb3dlcl9zZXR1cF9kb25lKQogCQlyZXR1cm4gLUVOT0RFVjsKIAorICAg
IGlmIChwcm9jZXNzb3JfcG1fZXh0ZXJuYWwoKSkgeworCQlhY3BpX3Byb2Nlc3Nvcl9nZXRfcG93
ZXJfaW5mbyhwcik7CisJCXByb2Nlc3Nvcl9ub3RpZnlfZXh0ZXJuYWwocHIsCisJCQlQUk9DRVNT
T1JfUE1fQ0hBTkdFLCBQTV9UWVBFX0lETEUpOworCQlyZXR1cm4gcmV0OworCX0KKwogCWNwdWlk
bGVfcGF1c2VfYW5kX2xvY2soKTsKIAljcHVpZGxlX2Rpc2FibGVfZGV2aWNlKCZwci0+cG93ZXIu
ZGV2KTsKIAlhY3BpX3Byb2Nlc3Nvcl9nZXRfcG93ZXJfaW5mbyhwcik7CkBAIC0xMTgzLDkgKzEx
OTYsMTQgQEAgaW50IF9fY3B1aW5pdCBhY3BpX3Byb2Nlc3Nvcl9wb3dlcl9pbml0KHN0cnVjdCBh
Y3BpX3Byb2Nlc3NvciAqcHIsCiAJICogcGxhdGZvcm1zIHRoYXQgb25seSBzdXBwb3J0IEMxLgog
CSAqLwogCWlmIChwci0+ZmxhZ3MucG93ZXIpIHsKLQkJYWNwaV9wcm9jZXNzb3Jfc2V0dXBfY3B1
aWRsZShwcik7Ci0JCWlmIChjcHVpZGxlX3JlZ2lzdGVyX2RldmljZSgmcHItPnBvd2VyLmRldikp
Ci0JCQlyZXR1cm4gLUVJTzsKKwkJaWYgKHByb2Nlc3Nvcl9wbV9leHRlcm5hbCgpKQorCQkJcHJv
Y2Vzc29yX25vdGlmeV9leHRlcm5hbChwciwKKwkJCQkJUFJPQ0VTU09SX1BNX0lOSVQsIFBNX1RZ
UEVfSURMRSk7CisJCWVsc2UgeworCQkJYWNwaV9wcm9jZXNzb3Jfc2V0dXBfY3B1aWRsZShwcik7
CisJCQlpZiAoY3B1aWRsZV9yZWdpc3Rlcl9kZXZpY2UoJnByLT5wb3dlci5kZXYpKQorCQkJCXJl
dHVybiAtRUlPOworCQl9CiAKIAkJcHJpbnRrKEtFUk5fSU5GTyBQUkVGSVggIkNQVSVkIChwb3dl
ciBzdGF0ZXM6IiwgcHItPmlkKTsKIAkJZm9yIChpID0gMTsgaSA8PSBwci0+cG93ZXIuY291bnQ7
IGkrKykKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfcGVyZmxpYi5jIGIvZHJp
dmVycy9hY3BpL3Byb2Nlc3Nvcl9wZXJmbGliLmMKaW5kZXggY2FmYjQxMC4uYjIyMmNkYiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9wZXJmbGliLmMKKysrIGIvZHJpdmVycy9h
Y3BpL3Byb2Nlc3Nvcl9wZXJmbGliLmMKQEAgLTE1NCwxMyArMTU0LDE2IEBAIGludCBhY3BpX3By
b2Nlc3Nvcl9wcGNfaGFzX2NoYW5nZWQoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikKIHsKIAlp
bnQgcmV0OwogCi0JaWYgKGlnbm9yZV9wcGMpCisJaWYgKGlnbm9yZV9wcGMgJiYgIXByb2Nlc3Nv
cl9wbXBlcmZfZXh0ZXJuYWwoKSkKIAkJcmV0dXJuIDA7CiAKIAlyZXQgPSBhY3BpX3Byb2Nlc3Nv
cl9nZXRfcGxhdGZvcm1fbGltaXQocHIpOwogCiAJaWYgKHJldCA8IDApCiAJCXJldHVybiAocmV0
KTsKKwllbHNlIGlmIChwcm9jZXNzb3JfcG1wZXJmX2V4dGVybmFsKCkpCisJCXJldHVybiBwcm9j
ZXNzb3Jfbm90aWZ5X2V4dGVybmFsKHByLAorCQkJCVBST0NFU1NPUl9QTV9DSEFOR0UsIFBNX1RZ
UEVfUEVSRik7CiAJZWxzZQogCQlyZXR1cm4gY3B1ZnJlcV91cGRhdGVfcG9saWN5KHByLT5pZCk7
CiB9CkBAIC0zMjQsNyArMzI3LDcgQEAgc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfcGVy
Zm9ybWFuY2Vfc3RhdGVzKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpCiAJcmV0dXJuIHJlc3Vs
dDsKIH0KIAotc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfcGVyZm9ybWFuY2VfaW5mbyhz
dHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQoraW50IGFjcGlfcHJvY2Vzc29yX2dldF9wZXJmb3Jt
YW5jZV9pbmZvKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpCiB7CiAJaW50IHJlc3VsdCA9IDA7
CiAJYWNwaV9zdGF0dXMgc3RhdHVzID0gQUVfT0s7CkBAIC00MjYsNyArNDI5LDcgQEAgaW50IGFj
cGlfcHJvY2Vzc29yX25vdGlmeV9zbW0oc3RydWN0IG1vZHVsZSAqY2FsbGluZ19tb2R1bGUpCiAK
IEVYUE9SVF9TWU1CT0woYWNwaV9wcm9jZXNzb3Jfbm90aWZ5X3NtbSk7CiAKLXN0YXRpYyBpbnQg
YWNwaV9wcm9jZXNzb3JfZ2V0X3BzZChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IJKnByKQoraW50IGFj
cGlfcHJvY2Vzc29yX2dldF9wc2Qoc3RydWN0IGFjcGlfcHJvY2Vzc29yCSpwcikKIHsKIAlpbnQg
cmVzdWx0ID0gMDsKIAlhY3BpX3N0YXR1cyBzdGF0dXMgPSBBRV9PSzsKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvYWNwaS9wcm9jZXNzb3IuaCBiL2luY2x1ZGUvYWNwaS9wcm9jZXNzb3IuaAppbmRleCBi
MDljNGZkLi5kNmJiMmQyIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FjcGkvcHJvY2Vzc29yLmgKKysr
IGIvaW5jbHVkZS9hY3BpL3Byb2Nlc3Nvci5oCkBAIC03Nyw2ICs3NywxMCBAQCBzdHJ1Y3QgYWNw
aV9wcm9jZXNzb3JfY3ggewogCXN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9jeF9wb2xpY3kgcHJvbW90
aW9uOwogCXN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9jeF9wb2xpY3kgZGVtb3Rpb247CiAJY2hhciBk
ZXNjW0FDUElfQ1hfREVTQ19MRU5dOworI2lmZGVmIENPTkZJR19QUk9DRVNTT1JfRVhURVJOQUxf
Q09OVFJPTAorCS8qIFJlcXVpcmUgcmF3IGluZm9ybWF0aW9uIGZvciBleHRlcm5hbCBjb250cm9s
IGxvZ2ljICovCisJc3RydWN0IGFjcGlfcG93ZXJfcmVnaXN0ZXIgcmVnOworI2VuZGlmIC8qIENP
TkZJR19QUk9DRVNTT1JfRVhURVJOQUxfQ09OVFJPTCAqLwogfTsKIAogc3RydWN0IGFjcGlfcHJv
Y2Vzc29yX3Bvd2VyIHsKQEAgLTI5NSw2ICsyOTksOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYWNw
aV9wcm9jZXNzb3JfZmZoX2NzdGF0ZV9lbnRlcihzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfY3gKIHZv
aWQgYWNwaV9wcm9jZXNzb3JfcHBjX2luaXQodm9pZCk7CiB2b2lkIGFjcGlfcHJvY2Vzc29yX3Bw
Y19leGl0KHZvaWQpOwogaW50IGFjcGlfcHJvY2Vzc29yX3BwY19oYXNfY2hhbmdlZChzdHJ1Y3Qg
YWNwaV9wcm9jZXNzb3IgKnByKTsKK2ludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfcGVyZm9ybWFuY2Vf
aW5mbyhzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKTsKK2ludCBhY3BpX3Byb2Nlc3Nvcl9nZXRf
cHNkKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpOwogI2Vsc2UKIHN0YXRpYyBpbmxpbmUgdm9p
ZCBhY3BpX3Byb2Nlc3Nvcl9wcGNfaW5pdCh2b2lkKQogewpAQCAtMzUyLDQgKzM1OCw3OSBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgYWNwaV90aGVybWFsX2NwdWZyZXFfZXhpdCh2b2lkKQogfQogI2Vu
ZGlmCiAKKy8qCisgKiBGb2xsb3dpbmcgYXJlIGludGVyZmFjZXMgZ2VhcmVkIHRvIGV4dGVybmFs
IHByb2Nlc3NvciBQTSBjb250cm9sCisgKiBsb2dpYyBsaWtlIGEgVk1NCisgKi8KKy8qIEV2ZW50
cyBub3RpZmllZCB0byBleHRlcm5hbCBjb250cm9sIGxvZ2ljICovCisjZGVmaW5lIFBST0NFU1NP
Ul9QTV9JTklUCTEKKyNkZWZpbmUgUFJPQ0VTU09SX1BNX0NIQU5HRQkyCisjZGVmaW5lIFBST0NF
U1NPUl9IT1RQTFVHCTMKKworLyogT2JqZWN0cyBmb3IgdGhlIFBNIGV2ZW50cyAqLworI2RlZmlu
ZSBQTV9UWVBFX0lETEUJCTAKKyNkZWZpbmUgUE1fVFlQRV9QRVJGCQkxCisjZGVmaW5lIFBNX1RZ
UEVfVEhSCQkyCisjZGVmaW5lIFBNX1RZUEVfTUFYCQkzCisKKy8qIFByb2Nlc3NvciBob3RwbHVn
IGV2ZW50cyAqLworI2RlZmluZSBIT1RQTFVHX1RZUEVfQURECTAKKyNkZWZpbmUgSE9UUExVR19U
WVBFX1JFTU9WRQkxCisKKyNpZmRlZiBDT05GSUdfUFJPQ0VTU09SX0VYVEVSTkFMX0NPTlRST0wK
K3N0cnVjdCBwcm9jZXNzb3JfZXh0Y250bF9vcHMgeworCS8qIFRyYW5zZmVyIHByb2Nlc3NvciBQ
TSBldmVudHMgdG8gZXh0ZXJuYWwgY29udHJvbCBsb2dpYyAqLworaW50ICgqcG1fb3BzW1BNX1RZ
UEVfTUFYXSkoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwciwgaW50IGV2ZW50KTsKKwkvKiBOb3Rp
ZnkgcGh5c2ljYWwgcHJvY2Vzc29yIHN0YXR1cyB0byBleHRlcm5hbCBjb250cm9sIGxvZ2ljICov
CisJaW50ICgqaG90cGx1Zykoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwciwgaW50IHR5cGUpOwor
fTsKK2V4dGVybiBjb25zdCBzdHJ1Y3QgcHJvY2Vzc29yX2V4dGNudGxfb3BzICpwcm9jZXNzb3Jf
ZXh0Y250bF9vcHM7CisKK3N0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3Nvcl9jbnRsX2V4dGVybmFs
KHZvaWQpCit7CisJcmV0dXJuIChwcm9jZXNzb3JfZXh0Y250bF9vcHMgIT0gTlVMTCk7Cit9CisK
K3N0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3Nvcl9wbV9leHRlcm5hbCh2b2lkKQoreworCXJldHVy
biBwcm9jZXNzb3JfY250bF9leHRlcm5hbCgpICYmCisJCShwcm9jZXNzb3JfZXh0Y250bF9vcHMt
PnBtX29wc1tQTV9UWVBFX0lETEVdICE9IE5VTEwpOworfQorCitzdGF0aWMgaW5saW5lIGludCBw
cm9jZXNzb3JfcG1wZXJmX2V4dGVybmFsKHZvaWQpCit7CisJcmV0dXJuIHByb2Nlc3Nvcl9jbnRs
X2V4dGVybmFsKCkgJiYKKwkJKHByb2Nlc3Nvcl9leHRjbnRsX29wcy0+cG1fb3BzW1BNX1RZUEVf
UEVSRl0gIT0gTlVMTCk7Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3Nvcl9wbXRocl9l
eHRlcm5hbCh2b2lkKQoreworCXJldHVybiBwcm9jZXNzb3JfY250bF9leHRlcm5hbCgpICYmCisJ
CShwcm9jZXNzb3JfZXh0Y250bF9vcHMtPnBtX29wc1tQTV9UWVBFX1RIUl0gIT0gTlVMTCk7Cit9
CisKK2V4dGVybiBpbnQgcHJvY2Vzc29yX25vdGlmeV9leHRlcm5hbChzdHJ1Y3QgYWNwaV9wcm9j
ZXNzb3IgKnByLAorCQkJaW50IGV2ZW50LCBpbnQgdHlwZSk7CitleHRlcm4gdm9pZCBwcm9jZXNz
b3JfZXh0Y250bF9yZWdpc3RlcihzdHJ1Y3QgcHJvY2Vzc29yX2V4dGNudGxfb3BzKiBvcHMpOwor
ZXh0ZXJuIGludCBwcm9jZXNzb3JfZXh0Y250bF9wcmVwYXJlKHN0cnVjdCBhY3BpX3Byb2Nlc3Nv
ciAqcHIpOworI2Vsc2UKK3N0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3Nvcl9jbnRsX2V4dGVybmFs
KHZvaWQpIHtyZXR1cm4gMDt9CitzdGF0aWMgaW5saW5lIGludCBwcm9jZXNzb3JfcG1fZXh0ZXJu
YWwodm9pZCkge3JldHVybiAwO30KK3N0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3Nvcl9wbXBlcmZf
ZXh0ZXJuYWwodm9pZCkge3JldHVybiAwO30KK3N0YXRpYyBpbmxpbmUgaW50IHByb2Nlc3Nvcl9w
bXRocl9leHRlcm5hbCh2b2lkKSB7cmV0dXJuIDA7fQorc3RhdGljIGlubGluZSBpbnQgcHJvY2Vz
c29yX25vdGlmeV9leHRlcm5hbChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByLAorCQkJaW50IGV2
ZW50LCBpbnQgdHlwZSkKK3sKKwlyZXR1cm4gMDsKK30KK3N0YXRpYyBpbmxpbmUgdm9pZCBwcm9j
ZXNzb3JfZXh0Y250bF9yZWdpc3RlcihzdHJ1Y3QgcHJvY2Vzc29yX2V4dGNudGxfb3BzKiBvcHMp
Cit7CisJcmV0dXJuIDA7Cit9CitzdGF0aWMgaW5saW5lIGludCBwcm9jZXNzb3JfZXh0Y250bF9w
cmVwYXJlKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpCit7CisJcmV0dXJuIDA7Cit9CisjZW5k
aWYgLyogQ09ORklHX1BST0NFU1NPUl9FWFRFUk5BTF9DT05UUk9MICovCisKICNlbmRpZgo=

--_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CCpdsmsx502ccrcor_
Content-Type: text/plain; name="ATT00001.txt"
Content-Description: ATT00001.txt
Content-Disposition: attachment; filename="ATT00001.txt"; size=142;
	creation-date="Sun, 19 Jul 2009 14:47:27 GMT";
	modification-date="Sun, 19 Jul 2009 14:47:27 GMT"
Content-Transfer-Encoding: base64

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClhlbi1kZXZl
bCBtYWlsaW5nIGxpc3QNClhlbi1kZXZlbEBsaXN0cy54ZW5zb3VyY2UuY29tDQpodHRwOi8vbGlz
dHMueGVuc291cmNlLmNvbS94ZW4tZGV2ZWwNCg==

--_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CCpdsmsx502ccrcor_--
