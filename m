From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC] acpi: Fix unprotected smp_processor_id() in
 acpi_processor_cst_has_changed()
Date: Thu, 23 Feb 2012 12:58:05 -0800
Message-ID: <20120223205805.GA31838@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:54868 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757015Ab2BWU6Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Feb 2012 15:58:16 -0500
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 23 Feb 2012 15:58:15 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: deepthi@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org

The acpi_processor_cst_has_changed() function is invoked from a
CPU_ONLINE or CPU_DEAD function, which might well execute on CPU 0
even though the CPU being hotplugged is some other CPU.  In addition,
acpi_processor_cst_has_changed() invokes smp_processor_id() without
protection, resulting in splats when onlining CPUs.

This commit therefore changes the smp_processor_id() to pr->id, as is
used elsewhere in the code, for example, in acpi_processor_add().

This works for me, but I don't claim to understand ACPI.

Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 0e8e2de..9e57b06 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1159,8 +1159,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 	 * to make the code that updates C-States be called once.
 	 */
 
-	if (smp_processor_id() == 0 &&
-			cpuidle_get_driver() == &acpi_idle_driver) {
+	if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
 
 		cpuidle_pause_and_lock();
 		/* Protect against cpu-hotplug */

