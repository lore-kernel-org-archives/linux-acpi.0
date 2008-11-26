From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 6/8] acpi: use new public GPE group enable/disable
	interfaces
Date: Wed, 26 Nov 2008 10:55:52 +0800
Message-ID: <1227668152.7702.97.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60623 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbYKZDBN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2008 22:01:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Avoid using internal functions: =EF=BB=BFacpi_hw_disable_all_gpes and =EF=
=BB=BFacpi_hw_enable_all_runtime_gpes
Use new public GPE group enable/disable interfaces: acpi_disable_all_gp=
es and =EF=BB=BFacpi_enable_all_runtime_gpes
   =20
Also avoid using internal symbol ACPI_TABLE_INDEX_FACS, call acpi_get_t=
able.

=EF=BB=BFSigned-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/sleep/main.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 80c0868..4b73422 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -95,7 +95,7 @@ void __init acpi_old_suspend_ordering(void)
  */
 static int acpi_pm_disable_gpes(void)
 {
-	acpi_hw_disable_all_gpes();
+	acpi_disable_all_gpes();
 	return 0;
 }
=20
@@ -123,7 +123,7 @@ static int acpi_pm_prepare(void)
 	int error =3D __acpi_pm_prepare();
=20
 	if (!error)
-		acpi_hw_disable_all_gpes();
+		acpi_disable_all_gpes();
 	return error;
 }
=20
@@ -251,7 +251,7 @@ static int acpi_suspend_enter(suspend_state_t pm_st=
ate)
 	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire=
=2E
 	 * acpi_leave_sleep_state will reenable specific GPEs later
 	 */
-	acpi_hw_disable_all_gpes();
+	acpi_disable_all_gpes();
=20
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
@@ -398,7 +398,7 @@ static void acpi_hibernation_leave(void)
=20
 static void acpi_pm_enable_gpes(void)
 {
-	acpi_hw_enable_all_runtime_gpes();
+	acpi_enable_all_runtime_gpes();
 }
=20
 static struct platform_hibernation_ops acpi_hibernation_ops =3D {
@@ -584,7 +584,7 @@ static void acpi_power_off_prepare(void)
 {
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
-	acpi_hw_disable_all_gpes();
+	acpi_disable_all_gpes();
 }
=20
 static void acpi_power_off(void)
@@ -633,7 +633,7 @@ int __init acpi_sleep_init(void)
 		sleep_states[ACPI_STATE_S4] =3D 1;
 		printk(" S4");
 		if (!nosigcheck) {
-			acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+			acpi_get_table(ACPI_SIG_FACS, 1,
 				(struct acpi_table_header **)&facs);
 			if (facs)
 				s4_hardware_signature =3D


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
