From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: ACPI P-States <-> cpufreq integration
Date: Wed, 23 Oct 2002 22:56:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021023225611.A12794@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch for kernel 2.5.44 (not for any additional later ACPI pat=
ch)
integrates ACPI P-States into the CPU frequency and voltage scaling
infrastructure - CPUfreq. It is a complies-only, should-work, non-tested
version (no hardware), so testing this patch is greatly appreciated.

CPUfreq offers one unified interface to various available CPU=20
frequency scaling methods - ACPI, SpeedStep, PowerNow!, LongRun, ...=20

Additionally, kernel constants like loops_per_jiffy, cpu_khz are updated;=
=20
drivers which need to force a certain speed limit (for example, display=20
drivers for the ARM architecture; ACPI thermal module might be a future=20
addition) can register cpufreq "notifiers" to voice their needs whenever
a frequency policy change occurs, or whenever a frequency transition occurs.

For further information about cpufreq, please check
linux/Documentation/cpufreq in recent 2.5. kernels, or
http://www.brodo.de/cpufreq

	Dominik

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq-2.5.44-acpi-1"
Content-Transfer-Encoding: quoted-printable

--- linux/drivers/acpi/processor.c.original	Wed Oct 23 21:25:16 2002
+++ linux/drivers/acpi/processor.c	Wed Oct 23 22:30:49 2002
@@ -40,6 +40,7 @@
 #include <asm/delay.h>
 #include <linux/compatmac.h>
 #include <linux/proc_fs.h>
+#include <linux/cpufreq.h>
 #include "acpi_bus.h"
 #include "acpi_drivers.h"
=20
@@ -224,6 +225,10 @@
 static struct acpi_processor_errata errata;
 static void (*pm_idle_save)(void) =3D NULL;
=20
+static unsigned int cpufreq_usage_count =3D 0;
+
+static struct cpufreq_driver *acpi_cpufreq_driver;
+
=20
 /* -----------------------------------------------------------------------=
---
                                 Errata Handling
@@ -1037,6 +1042,7 @@
 	u16			port =3D 0;
 	u8			value =3D 0;
 	int			i =3D 0;
+	struct cpufreq_freqs    cpufreq_freqs;
=20
 	ACPI_FUNCTION_TRACE("acpi_processor_set_performance");
=20
@@ -1068,6 +1074,14 @@
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Transitioning from P%d to P%d\n",
 		pr->performance.state, state));
=20
+	/* cpufreq frequency struct */
+	cpufreq_freqs.cpu =3D pr->id;
+	cpufreq_freqs.old =3D pr->performance.states[pr->performance.state].core_=
frequency;
+	cpufreq_freqs.new =3D pr->performance.states[state].core_frequency;
+
+	/* notify cpufreq */
+	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
+
 	/*
 	 * First we write the target state's 'control' value to the
 	 * control_register.
@@ -1101,7 +1115,15 @@
 		udelay(10);
 	}
=20
+	/* notify cpufreq */
+	cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
+
 	if (value !=3D pr->performance.states[state].status) {
+		unsigned int tmp =3D cpufreq_freqs.new;
+		cpufreq_freqs.new =3D cpufreq_freqs.old;
+		cpufreq_freqs.old =3D tmp;
+		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_PRECHANGE);
+		cpufreq_notify_transition(&cpufreq_freqs, CPUFREQ_POSTCHANGE);
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Transition failed\n"));
 		return_VALUE(-ENODEV);
 	}
@@ -1406,8 +1428,13 @@
 			px =3D pr->limit.user.px;
 		if (pr->limit.thermal.px > px)
 			px =3D pr->limit.thermal.px;
-
-		result =3D acpi_processor_set_performance(pr, px);
+		{
+			struct cpufreq_policy policy;
+			policy.cpu =3D pr->id;
+			cpufreq_get_policy(&policy, pr->id);
+			policy.max =3D pr->performance.states[px].core_frequency * 1000;
+			result =3D cpufreq_set_policy(&policy);
+		}
 		if (result)
 			goto end;
 	}
@@ -1562,6 +1589,253 @@
 	return_VALUE(0);
 }
=20
+/* -----------------------------------------------------------------------=
---
+                               cpufreq interface
+   -----------------------------------------------------------------------=
--- */
+
+static void
+acpi_cpufreq_setpolicy (
+	struct cpufreq_policy   *policy)
+{
+	unsigned int cpu =3D 0;
+	unsigned int i =3D 0;
+	struct acpi_processor *pr =3D NULL;
+	unsigned int next_state =3D 0;
+	unsigned int result =3D 0;
+
+	ACPI_FUNCTION_TRACE("acpi_cpufreq_setpolicy");
+
+	if (!policy)
+		return_VOID;
+
+	/* get a present, initialized CPU */
+	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS)
+	{
+		for (i=3D0; i<NR_CPUS; i++) {
+			if (processors[i] !=3D NULL) {
+				cpu =3D i;
+				pr =3D processors[cpu];
+				break;
+			}
+		}
+	}
+	else
+	{
+		cpu =3D policy->cpu;
+		pr =3D processors[cpu];
+		if (!pr)
+			return_VOID;
+	}
+
+	/* select appropriate P-State */
+	if (policy->policy =3D=3D CPUFREQ_POLICY_POWERSAVE)
+	{
+		for (i=3D(pr->performance.state_count - 1); i>=3D pr->limit.state.px; i-=
-)
+		{
+			unsigned int state_freq =3D pr->performance.states[i].core_frequency * =
1000;
+			if ((policy->min <=3D state_freq) &&
+			    (policy->max >=3D state_freq))=20
+			{
+				next_state =3D i;
+				break;
+			}
+		}
+	} else {
+		for (i=3Dpr->limit.state.px; i < pr->performance.state_count; i++)
+		{
+			unsigned int state_freq =3D pr->performance.states[i].core_frequency * =
1000;
+			if ((policy->min <=3D state_freq) &&
+			    (policy->max >=3D state_freq))=20
+			{
+				next_state =3D i;
+				break;
+			}
+		}
+	}
+
+	/* set one or all CPUs to the new state */
+	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS) {
+		for (i=3D0; i<NR_CPUS; i++)
+		{
+			pr =3D processors[cpu];
+			if (!pr || !cpu_online(cpu))
+				continue;
+			result =3D acpi_processor_set_performance (pr, next_state);
+		}
+	} else {
+		result =3D acpi_processor_set_performance (pr, next_state);
+	}
+
+	return_VOID;
+}
+
+
+static void
+acpi_cpufreq_verify (
+	struct cpufreq_policy   *policy)
+{
+	unsigned int cpu =3D 0;
+	unsigned int i =3D 0;
+	struct acpi_processor *pr =3D NULL;
+	unsigned int number_states =3D 0;
+	unsigned int next_larger_state =3D 0;
+
+	ACPI_FUNCTION_TRACE("acpi_cpufreq_verify");
+
+	if (!policy)
+		return_VOID;
+
+	/* get a present, initialized CPU */
+	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS)
+	{
+		for (i=3D0; i<NR_CPUS; i++) {
+			if (processors[i] !=3D NULL) {
+				cpu =3D i;
+				pr =3D processors[cpu];
+				break;
+			}
+		}
+	}
+	else
+	{
+		cpu =3D policy->cpu;
+		pr =3D processors[cpu];
+		if (!pr)
+			return_VOID;
+	}
+
+	/* first check if min and max are within valid limits */
+	cpufreq_verify_within_limits(
+		policy,=20
+		pr->performance.states[pr->performance.state_count - 1].core_frequency *=
 1000,
+		pr->performance.states[pr->limit.state.px].core_frequency * 1000);
+
+	/* now check if at least one value is within this limit */
+	for (i=3Dpr->limit.state.px; i < pr->performance.state_count; i++)
+	{
+		unsigned int state_freq =3D pr->performance.states[i].core_frequency * 1=
000;
+		if ((policy->min <=3D state_freq) &&
+		    (policy->max >=3D state_freq))
+			number_states++;
+		if (state_freq > policy->max)
+			next_larger_state =3D i;
+	}
+
+	if (number_states)
+		return_VOID;
+
+	/* round up now */
+	policy->max =3D pr->performance.states[next_larger_state].core_frequency =
* 1000;
+
+	return_VOID;
+}
+
+static int
+acpi_cpufreq_init (
+	struct acpi_processor   *pr)
+{
+	int                     result =3D 0;
+	int                     i =3D 0;
+	int                     current_state =3D 0;
+	struct cpufreq_driver   *driver;
+
+	ACPI_FUNCTION_TRACE("acpi_cpufreq_init");
+
+	if (cpufreq_usage_count) {
+		if (pr->flags.performance =3D=3D 1)
+			cpufreq_usage_count++;
+		return_VALUE(0);
+	}
+
+	/* test if it works */
+	current_state =3D pr->performance.state;
+
+	if (current_state =3D=3D pr->limit.state.px) {
+		result =3D acpi_processor_set_performance(pr, (pr->performance.state_cou=
nt - 1));
+		if (result) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure whil=
e switching.\n"));
+			pr->flags.performance =3D 0;
+			return_VALUE(-ENODEV);
+		}
+	}
+
+	result =3D acpi_processor_set_performance(pr, pr->limit.state.px);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while=
 switching.\n"));
+		pr->flags.performance =3D 0;
+		return_VALUE(-ENODEV);
+	}
+=09
+	if (current_state !=3D 0) {
+		result =3D acpi_processor_set_performance(pr, current_state);
+		if (result) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure whil=
e switching.\n"));
+			pr->flags.performance =3D 0;
+			return_VALUE(-ENODEV);
+		}
+	}
+
+	/* initialization of main "cpufreq" code*/
+	driver =3D kmalloc(sizeof(struct cpufreq_driver) +=20
+			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
+	if (!driver)
+		return_VALUE(-ENOMEM);
+
+	driver->policy =3D (struct cpufreq_policy *) (driver + 1);
+
+#ifdef CONFIG_CPU_FREQ_24_API
+	driver->cpu_min_freq    =3D pr->performance.states[pr->performance.state_=
count - 1].core_frequency * 1000;
+	for (i=3D0;i<NR_CPUS;i++)
+		driver->cpu_cur_freq[0] =3D pr->performance.states[current_state].core_f=
requency * 1000;
+#endif
+
+	driver->verify      =3D &acpi_cpufreq_verify;
+	driver->setpolicy   =3D &acpi_cpufreq_setpolicy;
+
+	for (i=3D0;i<NR_CPUS;i++) {
+		driver->policy[i].cpu    =3D pr->id;
+		driver->policy[i].min    =3D pr->performance.states[pr->performance.stat=
e_count - 1].core_frequency * 1000;
+		driver->policy[i].max    =3D pr->performance.states[pr->limit.state.px].=
core_frequency * 1000;
+		driver->policy[i].max_cpu_freq =3D pr->performance.states[0].core_freque=
ncy * 1000;
+		driver->policy[i].policy =3D ( pr->performance.states[current_state].cor=
e_frequency * 1000 =3D=3D driver->policy[i].max) ?=20
+			CPUFREQ_POLICY_PERFORMANCE : CPUFREQ_POLICY_POWERSAVE;
+	}
+
+	acpi_cpufreq_driver =3D driver;
+	result =3D cpufreq_register(driver);
+	if (result) {
+		kfree(driver);
+		acpi_cpufreq_driver =3D NULL;
+		return_VALUE(result);
+	}
+
+	cpufreq_usage_count++;
+
+	return_VALUE(0);
+}
+
+static int
+acpi_cpufreq_exit (
+	struct acpi_processor   *pr)
+{
+	int                     result =3D 0;
+
+	ACPI_FUNCTION_TRACE("acpi_cpufreq_exit");
+
+	if (!pr)
+		return_VALUE(-EINVAL);
+
+	if (pr->flags.performance)
+		cpufreq_usage_count--;
+
+	if (!cpufreq_usage_count) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,=20
+			"Removing cpufreq driver\n"));
+		result =3D cpufreq_unregister();
+	}
+
+	return_VALUE(result);
+}
=20
 /* -----------------------------------------------------------------------=
---
                               FS Interface (/proc)
@@ -1750,6 +2024,8 @@
 	int			result =3D 0;
 	struct acpi_processor	*pr =3D (struct acpi_processor *) data;
 	char			state_string[12] =3D {'\0'};
+	unsigned int            new_state =3D 0;
+	struct cpufreq_policy   policy;
=20
 	ACPI_FUNCTION_TRACE("acpi_processor_write_performance");
=20
@@ -1760,9 +2036,14 @@
 		return_VALUE(-EFAULT);
 =09
 	state_string[count] =3D '\0';
+	new_state =3D simple_strtoul(state_string, NULL, 0);
=20
-	result =3D acpi_processor_set_performance(pr,=20
-		simple_strtoul(state_string, NULL, 0));
+	cpufreq_get_policy(&policy, pr->id);
+
+	policy.cpu =3D pr->id;
+	policy.max =3D pr->performance.states[new_state].core_frequency * 1000;
+
+	result =3D cpufreq_set_policy(&policy);
 	if (result)
 		return_VALUE(result);
=20
@@ -2139,6 +2420,7 @@
=20
 	acpi_processor_get_power_info(pr);
 	acpi_processor_get_performance_info(pr);
+	acpi_cpufreq_init(pr);
 	acpi_processor_get_throttling_info(pr);
 	acpi_processor_get_limit_info(pr);
=20
@@ -2288,6 +2570,7 @@
 		return_VALUE(-ENODEV);
 	}
=20
+	acpi_cpufreq_exit(pr);
 	acpi_processor_remove_fs(device);
=20
 	processors[pr->id] =3D NULL;

--z6Eq5LdranGa6ru8--

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9twzrZ8MDCHJbN8YRAjD4AJ4jiv6CpgpBeVicYByiFMdoefTYXgCfVh8h
TDevv8hhMCygQGjklHPRrp4=
=qwFC
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
