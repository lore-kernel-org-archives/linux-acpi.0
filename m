From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/5] ACPI / cpuidle: Drop flags.bm_check tests from acpi_idle_enter_bm()
Date: Thu, 29 Jan 2015 19:30:50 +0100
Message-ID: <1655008.kCptiqR5TN@vostro.rjw.lan>
References: <8966777.6Ih8y2AWPy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <8966777.6Ih8y2AWPy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acpi_idle_enter_bm() is only used if flags.bm_check is set for
the given acpi_processor object, it doesn't make sense to check that
flag in there.

For this reason, drop flags.bm_check tests (and some code depending
on them) from acpi_idle_enter_bm().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -842,28 +842,25 @@ static int acpi_idle_enter_bm(struct cpu
 	/*
 	 * disable bus master
 	 * bm_check implies we need ARB_DIS
-	 * !bm_check implies we need cache flush
 	 * bm_control implies whether we can do ARB_DIS
 	 *
 	 * That leaves a case where bm_check is set and bm_control is
 	 * not set. In that case we cannot do much, we enter C3
 	 * without doing anything.
 	 */
-	if (pr->flags.bm_check && pr->flags.bm_control) {
+	if (pr->flags.bm_control) {
 		raw_spin_lock(&c3_lock);
 		c3_cpu_count++;
 		/* Disable bus master arbitration when all CPUs are in C3 */
 		if (c3_cpu_count == num_online_cpus())
 			acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 1);
 		raw_spin_unlock(&c3_lock);
-	} else if (!pr->flags.bm_check) {
-		ACPI_FLUSH_CPU_CACHE();
 	}
 
 	acpi_idle_do_entry(cx);
 
 	/* Re-enable bus master arbitration */
-	if (pr->flags.bm_check && pr->flags.bm_control) {
+	if (pr->flags.bm_control) {
 		raw_spin_lock(&c3_lock);
 		acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
 		c3_cpu_count--;

