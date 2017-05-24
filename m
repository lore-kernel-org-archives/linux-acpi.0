From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 22/32] ACPI/processor: Use cpu_hotplug_disable() instead of
 get_online_cpus()
Date: Wed, 24 May 2017 10:15:33 +0200
Message-ID: <20170524081548.851588594@linutronix.de>
References: <20170524081511.203800767@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=ACPIprocessor_Use_cpu_hotplug_disable()_instead_of_get_online_cpus().patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior <bigeasy@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Converting the hotplug locking, i.e. get_online_cpus(), to a percpu rwsem
unearthed a circular lock dependency which was hidden from lockdep due to
the lockdep annotation of get_online_cpus() which prevents lockdep from
creating full dependency chains.

CPU0                    CPU1
----                    ----
lock((&wfc.work));
                         lock(cpu_hotplug_lock.rw_sem);
                         lock((&wfc.work));
lock(cpu_hotplug_lock.rw_sem);

This dependency is established via acpi_processor_start() which calls into
the work queue code. And the work queue code establishes the reverse
dependency.

This is not a problem of get_online_cpus() recursion, it's a possible
deadlock undetected by lockdep so far.

The cure is to use cpu_hotplug_disable() instead of get_online_cpus() to
protect the probing from acpi_processor_start().

There is a side effect to this: cpu_hotplug_disable() makes a concurrent
cpu hotplug attempt via the sysfs interfaces fail with -EBUSY, but that
probing usually happens during the boot process where no interaction is
possible. Any later invocations are infrequent enough and concurrent
hotplug attempts are so unlikely that the danger of user space visible
regressions is very close to zero. Anyway, thats preferrable over a real
deadlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

---
 drivers/acpi/processor_driver.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/acpi/processor_driver.c
===================================================================
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -268,9 +268,9 @@ static int acpi_processor_start(struct d
 		return -ENODEV;
 
 	/* Protect against concurrent CPU hotplug operations */
-	get_online_cpus();
+	cpu_hotplug_disable();
 	ret = __acpi_processor_start(device);
-	put_online_cpus();
+	cpu_hotplug_enable();
 	return ret;
 }
 
