From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4/8] ACPI: processor: Don't setup cpu idle driver and handler when we do not want them.
Date: Wed, 30 Nov 2011 12:21:00 -0500
Message-ID: <1322673664-14642-5-git-send-email-konrad.wilk@oracle.com>
References: <1322673664-14642-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:43195 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757983Ab1K3RVv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Nov 2011 12:21:51 -0500
In-Reply-To: <1322673664-14642-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ke.yu@intel.com, kevin.tian@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl
Cc: xen-devel@lists.xensource.com, jeremy@goop.org, konrad@kernel.org, stefan.bader@canonical.com, Ian.Campbell@citrix.com, mike.mcclurg@citrix.com, liang.tang@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

From: Kevin Tian <kevin.tian@intel.com>

This patch inhibits processing of the CPU idle handler if it is not
set to the appropiate one. This is needed by the Xen processor driver
which, while still needing processor details, wants to use the default_idle
call (which makes a yield hypercall).

Signed-off-by: Yu Ke <ke.yu@intel.com>
Signed-off-by: Tian Kevin <kevin.tian@intel.com>
Signed-off-by: Tang Liang <liang.tang@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/acpi/processor_idle.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d88974a..0ad347f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1127,7 +1127,7 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
 	cpuidle_pause_and_lock();
 	cpuidle_disable_device(&pr->power.dev);
 	acpi_processor_get_power_info(pr);
-	if (pr->flags.power) {
+	if (pr->flags.power  && (cpuidle_get_driver() == &acpi_idle_driver)) {
 		acpi_processor_setup_cpuidle_cx(pr);
 		ret = cpuidle_enable_device(&pr->power.dev);
 	}
@@ -1183,7 +1183,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 			if (!_pr || !_pr->flags.power_setup_done)
 				continue;
 			acpi_processor_get_power_info(_pr);
-			if (_pr->flags.power) {
+			if (_pr->flags.power && (cpuidle_get_driver()
+						== &acpi_idle_driver)) {
 				acpi_processor_setup_cpuidle_cx(_pr);
 				cpuidle_enable_device(&_pr->power.dev);
 			}
@@ -1237,7 +1238,8 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 	 * Note that we use previously set idle handler will be used on
 	 * platforms that only support C1.
 	 */
-	if (pr->flags.power) {
+	if (pr->flags.power && (__acpi_processor_register_driver ==
+				acpi_processor_register_driver)) {
 		/* Register acpi_idle_driver if not already registered */
 		if (!acpi_processor_registered) {
 			acpi_processor_setup_cpuidle_states(pr);
-- 
1.7.7.3

