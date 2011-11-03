From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: some cpuidle code considerations and improvements
Date: Thu, 03 Nov 2011 20:18:11 +0100
Message-ID: <4EB2E8F3.6040209@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50067 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933862Ab1KCTSQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2011 15:18:16 -0400
Received: by faao14 with SMTP id o14so1859032faa.19
        for <linux-acpi@vger.kernel.org>; Thu, 03 Nov 2011 12:18:14 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi All,

I am investigating on how we consolidate the cpuidle code and factor ou=
t=20
some parts in order to move the duplicate code we found in the differen=
t=20
arch specific cpuidle code to the core where it is the place it belongs=
 to.

AFAICS, the cpuidle modules can only be loaded at once but we have in=20
each cpuidle file a struct cpuidle_driver global static variable duplic=
ated.

Would it makes sense to have single struct cpuidle_driver for=20
driver/cpuidle/driver.c and let the different arch specific to register=
=20
the module with their name ?

Here is an example to illustrate the idea:

  arch/arm/mach-at91/cpuidle.c          |    7 +------
  arch/arm/mach-davinci/cpuidle.c       |    7 +------
  arch/arm/mach-exynos4/cpuidle.c       |    7 +------
  arch/arm/mach-kirkwood/cpuidle.c      |    7 +------
  arch/arm/mach-omap2/cpuidle34xx.c     |    7 +------
  arch/arm/mach-shmobile/cpuidle.c      |    6 +-----
  arch/sh/kernel/cpu/shmobile/cpuidle.c |    6 +-----
  drivers/acpi/processor_driver.c       |    9 ++++-----
  drivers/acpi/processor_idle.c         |    5 -----
  drivers/cpuidle/driver.c              |   31=20
++++++++++++-------------------
  drivers/cpuidle/sysfs.c               |    2 +-
  drivers/idle/intel_idle.c             |   10 +++-------
  include/linux/cpuidle.h               |    5 +++--
  13 files changed, 30 insertions(+), 79 deletions(-)

Index: net/drivers/cpuidle/driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/drivers/cpuidle/driver.c   2011-11-03 16:50:57.866646738 +=
0100
+++ net/drivers/cpuidle/driver.c        2011-11-03 16:53:07.843291270 +=
0100
@@ -14,30 +14,30 @@

  #include "cpuidle.h"

-static struct cpuidle_driver *cpuidle_curr_driver;
+static struct cpuidle_driver driver =3D {
+       .owner =3D THIS_MODULE
+};
+
  DEFINE_SPINLOCK(cpuidle_driver_lock);

  /**
   * cpuidle_register_driver - registers a driver
   * @drv: the driver
   */
-int cpuidle_register_driver(struct cpuidle_driver *drv)
+int cpuidle_register_driver(const char *name)
  {
-       if (!drv)
+       if (!name)
                 return -EINVAL;

         if (cpuidle_disabled())
                 return -ENODEV;

         spin_lock(&cpuidle_driver_lock);
-       if (cpuidle_curr_driver) {
-               spin_unlock(&cpuidle_driver_lock);
-               return -EBUSY;
-       }
-       cpuidle_curr_driver =3D drv;
+       if (!driver.name)
+               driver.name =3D name;
         spin_unlock(&cpuidle_driver_lock);

-       return 0;
+       return driver.name =3D=3D name ? 0 : -EBUSY;
  }

  EXPORT_SYMBOL_GPL(cpuidle_register_driver);
@@ -47,7 +47,7 @@
   */
  struct cpuidle_driver *cpuidle_get_driver(void)
  {
-       return cpuidle_curr_driver;
+       return &driver;
  }
  EXPORT_SYMBOL_GPL(cpuidle_get_driver);

@@ -55,17 +55,10 @@
   * cpuidle_unregister_driver - unregisters a driver
   * @drv: the driver
   */
-void cpuidle_unregister_driver(struct cpuidle_driver *drv)
+void cpuidle_unregister_driver(void)
  {
-       if (drv !=3D cpuidle_curr_driver) {
-               WARN(1, "invalid cpuidle_unregister_driver(%s)\n",
-                       drv->name);
-               return;
-       }
-
         spin_lock(&cpuidle_driver_lock);
-       cpuidle_curr_driver =3D NULL;
+       driver.name =3D NULL;
         spin_unlock(&cpuidle_driver_lock);
  }
-
  EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
Index: net/include/linux/cpuidle.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/include/linux/cpuidle.h    2011-11-03 16:53:07.823291175 +=
0100
+++ net/include/linux/cpuidle.h 2011-11-03 16:53:07.843291270 +0100
@@ -125,9 +125,10 @@
  extern void disable_cpuidle(void);
  extern int cpuidle_idle_call(void);

-extern int cpuidle_register_driver(struct cpuidle_driver *drv);
+extern int cpuidle_register_driver(const char *name);
  struct cpuidle_driver *cpuidle_get_driver(void);
-extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
+extern void cpuidle_unregister_driver(void);
+
  extern int cpuidle_register_device(struct cpuidle_device *dev);
  extern void cpuidle_unregister_device(struct cpuidle_device *dev);

Index: net/arch/arm/mach-at91/cpuidle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/arch/arm/mach-at91/cpuidle.c       2011-11-03=20
16:50:57.914646997 +0100
+++ net/arch/arm/mach-at91/cpuidle.c    2011-11-03 16:53:07.843291270 +=
0100
@@ -26,11 +26,6 @@

  static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);

-static struct cpuidle_driver at91_idle_driver =3D {
-       .name =3D         "at91_idle",
-       .owner =3D        THIS_MODULE,
-};
-
  /* Actual code that puts the SoC in different idle states */
  static int at91_enter_idle(struct cpuidle_device *dev,
                                struct cpuidle_state *state)
@@ -63,7 +58,7 @@
  {
         struct cpuidle_device *device;

-       cpuidle_register_driver(&at91_idle_driver);
+       cpuidle_register_driver("at91_idle");

         device =3D &per_cpu(at91_cpuidle_device, smp_processor_id());
         device->state_count =3D AT91_MAX_STATES;
Index: net/arch/arm/mach-davinci/cpuidle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/arch/arm/mach-davinci/cpuidle.c    2011-11-03=20
16:50:57.906646945 +0100
+++ net/arch/arm/mach-davinci/cpuidle.c 2011-11-03 16:53:07.843291270 +=
0100
@@ -32,11 +32,6 @@
  /* fields in davinci_ops.flags */
  #define DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN        BIT(0)

-static struct cpuidle_driver davinci_idle_driver =3D {
-       .name   =3D "cpuidle-davinci",
-       .owner  =3D THIS_MODULE,
-};
-
  static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
  static void __iomem *ddr2_reg_base;

@@ -116,7 +111,7 @@

         ddr2_reg_base =3D pdata->ddr2_ctlr_base;

-       ret =3D cpuidle_register_driver(&davinci_idle_driver);
+       ret =3D cpuidle_register_driver("cpuidle-davinci");
         if (ret) {
                 dev_err(&pdev->dev, "failed to register driver\n");
                 return ret;
Index: net/arch/arm/mach-exynos4/cpuidle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/arch/arm/mach-exynos4/cpuidle.c    2011-11-03=20
16:50:57.882646829 +0100
+++ net/arch/arm/mach-exynos4/cpuidle.c 2011-11-03 16:53:07.843291270 +=
0100
@@ -31,11 +31,6 @@

  static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);

-static struct cpuidle_driver exynos4_idle_driver =3D {
-       .name           =3D "exynos4_idle",
-       .owner          =3D THIS_MODULE,
-};
-
  static int exynos4_enter_idle(struct cpuidle_device *dev,
                               struct cpuidle_state *state)
  {
@@ -60,7 +55,7 @@
         int i, max_cpuidle_state, cpu_id;
         struct cpuidle_device *device;

-       cpuidle_register_driver(&exynos4_idle_driver);
+       cpuidle_register_driver("exynos4_idle");

         for_each_cpu(cpu_id, cpu_online_mask) {
                 device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
Index: net/arch/arm/mach-kirkwood/cpuidle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/arch/arm/mach-kirkwood/cpuidle.c   2011-11-03=20
16:50:57.926647050 +0100
+++ net/arch/arm/mach-kirkwood/cpuidle.c        2011-11-03=20
16:53:07.847291288 +0100
@@ -23,11 +23,6 @@

  #define KIRKWOOD_MAX_STATES    2
-static struct cpuidle_driver kirkwood_idle_driver =3D {
-       .name =3D         "kirkwood_idle",
-       .owner =3D        THIS_MODULE,
-};
-
  static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device)=
;

  /* Actual code that puts the SoC in different idle states */
@@ -65,7 +60,7 @@
  {
         struct cpuidle_device *device;

-       cpuidle_register_driver(&kirkwood_idle_driver);
+       cpuidle_register_driver("kirkwood_idle");

         device =3D &per_cpu(kirkwood_cpuidle_device, smp_processor_id(=
));
         device->state_count =3D KIRKWOOD_MAX_STATES;
Index: net/arch/arm/mach-omap2/cpuidle34xx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/arch/arm/mach-omap2/cpuidle34xx.c  2011-11-03=20
16:50:57.890646862 +0100
+++ net/arch/arm/mach-omap2/cpuidle34xx.c       2011-11-03=20
16:53:07.847291288 +0100
@@ -296,11 +296,6 @@
         return;
  }

-struct cpuidle_driver omap3_idle_driver =3D {
-       .name =3D         "omap3_idle",
-       .owner =3D        THIS_MODULE,
-};
-
  /* Helper to fill the C-state common data and register the driver_dat=
a */
  static inline struct omap3_idle_statedata *_fill_cstate(
                                         struct cpuidle_device *dev,
@@ -337,7 +332,7 @@
         per_pd =3D pwrdm_lookup("per_pwrdm");
         cam_pd =3D pwrdm_lookup("cam_pwrdm");

-       cpuidle_register_driver(&omap3_idle_driver);
+       cpuidle_register_driver("omap3_idle");
         dev =3D &per_cpu(omap3_idle_dev, smp_processor_id());

         /* C1 . MPU WFI + Core active */
Index: net/arch/arm/mach-shmobile/cpuidle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/arch/arm/mach-shmobile/cpuidle.c   2011-11-03=20
16:50:57.898646916 +0100
+++ net/arch/arm/mach-shmobile/cpuidle.c        2011-11-03=20
16:53:07.847291288 +0100
@@ -47,10 +47,6 @@
  }

  static struct cpuidle_device shmobile_cpuidle_dev;
-static struct cpuidle_driver shmobile_cpuidle_driver =3D {
-       .name =3D         "shmobile_cpuidle",
-       .owner =3D        THIS_MODULE,
-};

  void (*shmobile_cpuidle_setup)(struct cpuidle_device *dev);

@@ -60,7 +56,7 @@
         struct cpuidle_state *state;
         int i;

-       cpuidle_register_driver(&shmobile_cpuidle_driver);
+       cpuidle_register_driver("shmobile_cpuidle");

         for (i =3D 0; i < CPUIDLE_STATE_MAX; i++) {
                 dev->states[i].name[0] =3D '\0';
Index: net/arch/sh/kernel/cpu/shmobile/cpuidle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/arch/sh/kernel/cpu/shmobile/cpuidle.c      2011-11-03=20
16:50:57.874646801 +0100
+++ net/arch/sh/kernel/cpu/shmobile/cpuidle.c   2011-11-03=20
16:53:07.847291288 +0100
@@ -54,10 +54,6 @@
  }

  static struct cpuidle_device cpuidle_dev;
-static struct cpuidle_driver cpuidle_driver =3D {
-       .name =3D         "sh_idle",
-       .owner =3D        THIS_MODULE,
-};

  void sh_mobile_setup_cpuidle(void)
  {
@@ -65,7 +61,7 @@
         struct cpuidle_state *state;
         int i;

-       cpuidle_register_driver(&cpuidle_driver);
+       cpuidle_register_driver("sh_idle");

         for (i =3D 0; i < CPUIDLE_STATE_MAX; i++) {
                 dev->states[i].name[0] =3D '\0';
Index: net/drivers/acpi/processor_driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/drivers/acpi/processor_driver.c    2011-11-03=20
16:53:07.831291213 +0100
+++ net/drivers/acpi/processor_driver.c 2011-11-03 16:53:07.847291288 +=
0100
@@ -801,9 +801,8 @@

         memset(&errata, 0, sizeof(errata));

-       if (!cpuidle_register_driver(&acpi_idle_driver)) {
-               printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
-                       acpi_idle_driver.name);
+       if (!cpuidle_register_driver("acpi_idle")) {
+               printk(KERN_DEBUG "ACPI: acpi_idle registered with=20
cpuidle\n");
                 acpi_cpuidle_driver =3D true;
         } else {
                 printk(KERN_DEBUG "ACPI: acpi_idle yielding to %s\n",
@@ -825,7 +824,7 @@
         return 0;

  out_cpuidle:
-       cpuidle_unregister_driver(&acpi_idle_driver);
+       cpuidle_unregister_driver();

         return result;
}
@@ -843,7 +842,7 @@

         acpi_bus_unregister_driver(&acpi_processor_driver);

-       cpuidle_unregister_driver(&acpi_idle_driver);
+       cpuidle_unregister_driver();

         return;
  }
Index: net/drivers/acpi/processor_idle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/drivers/acpi/processor_idle.c      2011-11-03=20
16:50:57.834646616 +0100
+++ net/drivers/acpi/processor_idle.c   2011-11-03 16:53:07.847291288 +=
0100
@@ -968,11 +968,6 @@
         return idle_time;
  }

-struct cpuidle_driver acpi_idle_driver =3D {
-       .name =3D         "acpi_idle",
-       .owner =3D        THIS_MODULE,
-};
-
  /**
   * acpi_processor_setup_cpuidle - prepares and configures CPUIDLE
   * @pr: the ACPI processor
Index: net/drivers/idle/intel_idle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/drivers/idle/intel_idle.c  2011-11-03 16:50:57.850646654 +=
0100
+++ net/drivers/idle/intel_idle.c       2011-11-03 17:25:15.750834746 +=
0100
@@ -67,10 +67,6 @@
  #define INTEL_IDLE_VERSION "0.4"
  #define PREFIX "intel_idle: "

-static struct cpuidle_driver intel_idle_driver =3D {
-       .name =3D "intel_idle",
-       .owner =3D THIS_MODULE,
-};
  /* intel_idle.max_cstate=3D0 disables driver */
  static int max_cstate =3D MWAIT_MAX_NUM_CSTATES - 1;

@@ -477,7 +473,7 @@
         if (retval)
                 return retval;

-       retval =3D cpuidle_register_driver(&intel_idle_driver);
+       retval =3D cpuidle_register_driver("intel_idle");
         if (retval) {
                 printk(KERN_DEBUG PREFIX "intel_idle yielding to %s",
                         cpuidle_get_driver()->name);
@@ -486,7 +482,7 @@

         retval =3D intel_idle_cpuidle_devices_init();
         if (retval) {
-               cpuidle_unregister_driver(&intel_idle_driver);
+               cpuidle_unregister_driver();
                 return retval;
         }

@@ -496,7 +492,7 @@
  static void __exit intel_idle_exit(void)
  {
         intel_idle_cpuidle_devices_uninit();
-       cpuidle_unregister_driver(&intel_idle_driver);
+       cpuidle_unregister_driver();

         if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIAB=
LE) {
                 smp_call_function(__setup_broadcast_timer, (void=20
*)false, 1);
Index: net/drivers/cpuidle/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net.orig/drivers/cpuidle/sysfs.c    2011-11-03 16:53:23.279367823 +=
0100
+++ net/drivers/cpuidle/sysfs.c 2011-11-03 16:54:02.123560434 +0100
@@ -50,7 +50,7 @@
         struct cpuidle_driver *cpuidle_driver =3D cpuidle_get_driver()=
;

         spin_lock(&cpuidle_driver_lock);
-       if (cpuidle_driver)
+       if (cpuidle_driver->name)
                 ret =3D sprintf(buf, "%s\n", cpuidle_driver->name);
         else
                 ret =3D sprintf(buf, "none\n");


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
