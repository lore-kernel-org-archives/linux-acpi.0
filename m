From: Larry Baker <baker@usgs.gov>
Subject: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Tue, 11 Jun 2013 14:30:30 -0700
Message-ID: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [137.227.28.11] ([137.227.28.11]:32943 "EHLO smtp5.doi.gov"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752574Ab3FKVa7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jun 2013 17:30:59 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so8963075pbc.32
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jun 2013 14:30:33 -0700
 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rob E Russell <robr@us.ibm.com>

I have an IBM System x3650 M3 with an Intel Xeon L5630 processor.  My I=
BM support team alerted me to an issue with C6 states for those process=
ors when running Linux and the intel_idle kernel module is used.  The I=
BM solutions page, http://www-947.ibm.com/support/entry/portal/docdispl=
ay?lndocid=3Dmigr-5091901, recommends disabling intel_idle.  I propose =
intel_idle disable C6 for the affected processors.

Description:

Intel Xeon 5600 and Core i7-900 processors (Family 6 Model 44) have a f=
law when the C6 state is used.  See Intel=AE Xeon=AE Processor 5600 Ser=
ies Specification Update May 2012 (http://www.intel.eu/content/dam/www/=
public/us/en/documents/specification-updates/xeon-5600-specification-up=
date.pdf) and Intel=AE CoreTM i7-900 Desktop Processor Extreme Edition =
Series and Intel=AE CoreTM i7-900 Desktop Processor Series on 32-nm Pro=
cess Specification Update June 2013 (http://www.intel.com/content/dam/w=
ww/public/us/en/documents/specification-updates/core-i7-900-ee-and-desk=
top-processor-series-32nm-spec-update.pdf):

> Package C6 Transitions May Cause Memory Bit Errors to be Observed
>=20
> Problem:
> During Package C6 transitions, internal signaling noise may cause the=
 DDRx_CKE signal to become asserted during self-refresh. These assertio=
ns may result in memory bit errors upon exiting from the package C6 sta=
te. Due to this erratum the DDRx_CKE signals can be driven during times=
 in which the DDR3 JEDEC specification requires that they are idle.
>=20
> Implication:
> DDRx_CKE signals can be driven during package C6 memory self-refresh =
creating an invalid memory DRAM state.  A system hang, memory ECC error=
s or unpredictable system behavior may occur when exiting the package C=
6 state.
>=20
> Workaround:=20
> It is possible for the BIOS to contain a workaround for this erratum.
>=20
> Status:
> For the steppings affected, see the Summary Table of Changes.

The intel_idle kernel module uses the standard Nehalem C states table f=
or these processors (boot_cpu_data.x86_model=3D=3D0x2c):

> static const struct x86_cpu_id intel_idle_ids[] =3D {
> <snip>
> 	ICPU(0x2c, idle_cpu_xeon5600),
> <snip>
> 	{}
> };
> MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);

I propose two alternatives for intel_idle.c to avoid the processor flaw=
=2E  (I didn't try to compile them -- I only modified intel_idle.c.)  T=
he first limits max_cstates=3D3, and prints in a console message if the=
 limit was forced.  The second creates a Xeon 5600-specific C states ta=
ble which leaves off the C6 state.  No message is printed in that case.=
  I like the idea of a message, and I like the idea of a proper C state=
s table.  I did not look to see if acpi_idle can also benefit from a si=
milar modification.

Thank you,

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov

=3D=3D=3D=3D=3D Version 1 Patch - Limit max_cstate=3D3 for Family 6 Mod=
el 44 Processors =3D=3D=3D=3D=3D

--- intel_idle.c.orig	2013-06-11 11:41:49.000000000 -0700
+++ intel_idle-fix-v1.c	2013-06-11 13:47:15.000000000 -0700
@@ -534,2 +534,13 @@
=20
+/*
+ * Disable C6-state for Xeon 5600 and Core i7-900.  Refer to Xeon 5600=
 errata
+ * BD104 and Core i7-900 errata BC82: Package C6 Transitions May Resul=
t in
+ * Single and Multi-Bit Memory Errors.
+ */
+	if (boot_cpu_data.x86_model =3D=3D 0x2c &&
+	    max_cstate > 3) {
+		pr_debug(PREFIX "limiting model 0x2c to max_cstate=3D3\n");
+		max_cstate =3D 3;
+	}
+
 	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",

=3D=3D=3D=3D=3D Version 2 Patch - Disable C6 for Family 6 Model 44 Proc=
essors =3D=3D=3D=3D=3D

--- intel_idle.c.orig	2013-06-11 11:41:49.000000000 -0700
+++ intel_idle-fix-v2.c	2013-06-11 13:51:32.000000000 -0700
@@ -158,2 +158,33 @@
=20
+/*
+ * Disable C6-state for Xeon 5600 and Core i7-900.  Refer to Xeon 5600=
 errata
+ * BD104 and Core i7-900 errata BC82: Package C6 Transitions May Resul=
t in
+ * Single and Multi-Bit Memory Errors.
+ */
+static struct cpuidle_state xeon5600_cstates[CPUIDLE_STATE_MAX] =3D {
+	{
+		.name =3D "C1-NHM",
+		.desc =3D "MWAIT 0x00",
+		.flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency =3D 3,
+		.target_residency =3D 6,
+		.enter =3D &intel_idle },
+	{
+		.name =3D "C1E-NHM",
+		.desc =3D "MWAIT 0x01",
+		.flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency =3D 10,
+		.target_residency =3D 20,
+		.enter =3D &intel_idle },
+	{
+		.name =3D "C3-NHM",
+		.desc =3D "MWAIT 0x10",
+		.flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_=
TLB_FLUSHED,
+		.exit_latency =3D 20,
+		.target_residency =3D 80,
+		.enter =3D &intel_idle },
+	{
+		.enter =3D NULL }
+};
+
 static struct cpuidle_state snb_cstates[CPUIDLE_STATE_MAX] =3D {
@@ -440,2 +471,8 @@
=20
+static const struct idle_cpu idle_cpu_xeon5600 =3D {
+	.state_table =3D xeon5600_cstates,
+	.auto_demotion_disable_flags =3D NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEM=
OTE,
+	.disable_promotion_to_c1e =3D true,
+};
+
 static const struct idle_cpu idle_cpu_atom =3D {
@@ -472,3 +509,3 @@
 	ICPU(0x25, idle_cpu_nehalem),
-	ICPU(0x2c, idle_cpu_nehalem),
+	ICPU(0x2c, idle_cpu_xeon5600),
 	ICPU(0x2e, idle_cpu_nehalem),

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
