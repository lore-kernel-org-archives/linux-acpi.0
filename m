From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 034/190] ACPI/processor: Replace racy task
 affinity logic
Date: Thu, 8 Mar 2018 04:59:06 +0000
Message-ID: <20180308045810.8041-34-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Siewior <bigeasy@linutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Len Brown <lenb@kernel.org>, Sasha Levin <Alexander.Levin@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 8153f9ac43897f9f4786b30badc134fcc1a4fb11 ]

acpi_processor_get_throttling() requires to invoke the getter function on
the target CPU. This is achieved by temporarily setting the affinity of the
calling user space thread to the requested CPU and reset it to the original
affinity afterwards.

That's racy vs. CPU hotplug and concurrent affinity settings for that
thread resulting in code executing on the wrong CPU and overwriting the
new affinity setting.

acpi_processor_get_throttling() is invoked in two ways:

1) The CPU online callback, which is already running on the target CPU and
   obviously protected against hotplug and not affected by affinity
   settings.

2) The ACPI driver probe function, which is not protected against hotplug
   during modprobe.

Switch it over to work_on_cpu() and protect the probe function against CPU
hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-acpi@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.785920903@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/processor_driver.c     |  7 ++++-
 drivers/acpi/processor_throttling.c | 62 +++++++++++++++++++++------------=
----
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_drive=
r.c
index eab8cdad7dc3..8697a82bd465 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -262,11 +262,16 @@ static int __acpi_processor_start(struct acpi_device =
*device)
 static int acpi_processor_start(struct device *dev)
 {
 	struct acpi_device *device =3D ACPI_COMPANION(dev);
+	int ret;
=20
 	if (!device)
 		return -ENODEV;
=20
-	return __acpi_processor_start(device);
+	/* Protect against concurrent CPU hotplug operations */
+	get_online_cpus();
+	ret =3D __acpi_processor_start(device);
+	put_online_cpus();
+	return ret;
 }
=20
 static int acpi_processor_stop(struct device *dev)
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_t=
hrottling.c
index d51ca1c05619..207e9bbb9490 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -62,8 +62,8 @@ struct acpi_processor_throttling_arg {
 #define THROTTLING_POSTCHANGE      (2)
=20
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force);
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct);
=20
 static int acpi_processor_update_tsd_coord(void)
 {
@@ -891,7 +891,8 @@ static int acpi_processor_get_throttling_ptc(struct acp=
i_processor *pr)
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"Invalid throttling state, reset\n"));
 			state =3D 0;
-			ret =3D acpi_processor_set_throttling(pr, state, true);
+			ret =3D __acpi_processor_set_throttling(pr, state, true,
+							      true);
 			if (ret)
 				return ret;
 		}
@@ -901,36 +902,31 @@ static int acpi_processor_get_throttling_ptc(struct a=
cpi_processor *pr)
 	return 0;
 }
=20
-static int acpi_processor_get_throttling(struct acpi_processor *pr)
+static long __acpi_processor_get_throttling(void *data)
 {
-	cpumask_var_t saved_mask;
-	int ret;
+	struct acpi_processor *pr =3D data;
+
+	return pr->throttling.acpi_processor_get_throttling(pr);
+}
=20
+static int acpi_processor_get_throttling(struct acpi_processor *pr)
+{
 	if (!pr)
 		return -EINVAL;
=20
 	if (!pr->flags.throttling)
 		return -ENODEV;
=20
-	if (!alloc_cpumask_var(&saved_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	/*
-	 * Migrate task to the cpu pointed by pr.
+	 * This is either called from the CPU hotplug callback of
+	 * processor_driver or via the ACPI probe function. In the latter
+	 * case the CPU is not guaranteed to be online. Both call sites are
+	 * protected against CPU hotplug.
 	 */
-	cpumask_copy(saved_mask, &current->cpus_allowed);
-	/* FIXME: use work_on_cpu() */
-	if (set_cpus_allowed_ptr(current, cpumask_of(pr->id))) {
-		/* Can't migrate to the target pr->id CPU. Exit */
-		free_cpumask_var(saved_mask);
+	if (!cpu_online(pr->id))
 		return -ENODEV;
-	}
-	ret =3D pr->throttling.acpi_processor_get_throttling(pr);
-	/* restore the previous state */
-	set_cpus_allowed_ptr(current, saved_mask);
-	free_cpumask_var(saved_mask);
=20
-	return ret;
+	return work_on_cpu(pr->id, __acpi_processor_get_throttling, pr);
 }
=20
 static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
@@ -1080,8 +1076,15 @@ static long acpi_processor_throttling_fn(void *data)
 			arg->target_state, arg->force);
 }
=20
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force)
+static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct=
)
+{
+	if (direct)
+		return fn(arg);
+	return work_on_cpu(cpu, fn, arg);
+}
+
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct)
 {
 	int ret =3D 0;
 	unsigned int i;
@@ -1130,7 +1133,8 @@ int acpi_processor_set_throttling(struct acpi_process=
or *pr,
 		arg.pr =3D pr;
 		arg.target_state =3D state;
 		arg.force =3D force;
-		ret =3D work_on_cpu(pr->id, acpi_processor_throttling_fn, &arg);
+		ret =3D call_on_cpu(pr->id, acpi_processor_throttling_fn, &arg,
+				  direct);
 	} else {
 		/*
 		 * When the T-state coordination is SW_ALL or HW_ALL,
@@ -1163,8 +1167,8 @@ int acpi_processor_set_throttling(struct acpi_process=
or *pr,
 			arg.pr =3D match_pr;
 			arg.target_state =3D state;
 			arg.force =3D force;
-			ret =3D work_on_cpu(pr->id, acpi_processor_throttling_fn,
-				&arg);
+			ret =3D call_on_cpu(pr->id, acpi_processor_throttling_fn,
+					  &arg, direct);
 		}
 	}
 	/*
@@ -1182,6 +1186,12 @@ int acpi_processor_set_throttling(struct acpi_proces=
sor *pr,
 	return ret;
 }
=20
+int acpi_processor_set_throttling(struct acpi_processor *pr, int state,
+				  bool force)
+{
+	return __acpi_processor_set_throttling(pr, state, force, false);
+}
+
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result =3D 0;
--=20
2.14.1
