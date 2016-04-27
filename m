From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] ACPI: fix Thunderbolt hotplug
Date: Wed, 27 Apr 2016 08:26:59 -0400
Message-ID: <1461760019-12930-1-git-send-email-prarit@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mario_Limonciello@dell.com, stable@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

Rafael, this patch is in the acpica.git tree as 7a3bd2d ("Dispatcher: Update
thread ID for recursive method calls").  I've had many positive testing
results from hardware vendors and users with this patch and this resolves
many of the problems seen here:

https://bugzilla.kernel.org/show_bug.cgi?id=115121

This does not fix the problems with the TB docking station.  Although this
patch will also be required, the docking station issues require a FW update.
Updated FW should be coming soon to resolve those problems.

P.

----8<----

The following hung task trace is seen when hotplugging
an ethernet dongle in a Thunderbolt port on Linux.

INFO: task kworker/0:4:1468 blocked for more than 120 seconds.
      Tainted: G        W       4.6.0-rc1+ #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 kworker/0:4     D ffff8802a265ba38 13344  1468      2 0x00000000
 Workqueue: kacpid acpi_os_execute_deferred
 ffff8802a265ba38 ffff8802a265ba00 ffffffff81130200 ffffffff81e0d580
 ffff88029e5eb340 ffff8802a265c000 ffff88029d69d000 ffff88029e5eb340
 ffffffff818c1b8d ffff8802b64e8758 ffff8802a265ba50 ffffffff818bdfcc
 Call Trace:
 [<ffffffff81130200>] ? test_callback+0x10/0x30
 [<ffffffff818c1b8d>] ? __down_timeout+0x5d/0xd0
 [<ffffffff818bdfcc>] schedule+0x3c/0x90
 [<ffffffff818c2d60>] schedule_timeout+0x210/0x360
 [<ffffffff8103fc89>] ? sched_clock+0x9/0x10
 [<ffffffff810ee51c>] ? local_clock+0x1c/0x20
 [<ffffffff81110c16>] ? mark_held_locks+0x76/0xa0
 [<ffffffff818c3cfc>] ? _raw_spin_unlock_irq+0x2c/0x40
 [<ffffffff818c1b8d>] ? __down_timeout+0x5d/0xd0
 [<ffffffff81110d35>] ? trace_hardirqs_on_caller+0xf5/0x1b0
 [<ffffffff818c1b8d>] ? __down_timeout+0x5d/0xd0
 [<ffffffff818c1bac>] __down_timeout+0x7c/0xd0
 [<ffffffff818c44b2>] ? _raw_spin_lock_irqsave+0x82/0x90
 [<ffffffff8110b87c>] down_timeout+0x4c/0x60
 [<ffffffff814e3a9c>] acpi_os_wait_semaphore+0xaa/0x16a
 [<ffffffff81510f37>] acpi_ex_system_wait_mutex+0x81/0xfa
 [<ffffffff814f8796>] acpi_ds_begin_method_execution+0x25a/0x373
 [<ffffffff814f8cea>] acpi_ds_call_control_method+0x107/0x2e0
 [<ffffffff8151ed60>] acpi_ps_parse_aml+0x177/0x495
 [<ffffffff8151fa46>] acpi_ps_execute_method+0x1f7/0x2b9
 [<ffffffff81516c9a>] acpi_ns_evaluate+0x2ee/0x435
 [<ffffffff814ff84a>] acpi_ev_asynch_execute_gpe_method+0xbd/0x159
 [<ffffffff814e2a69>] acpi_os_execute_deferred+0x17/0x23
 [<ffffffff810d1fc2>] process_one_work+0x242/0x700
 [<ffffffff810d1f3a>] ? process_one_work+0x1ba/0x700
 [<ffffffff810d24ce>] worker_thread+0x4e/0x490
 [<ffffffff810d2480>] ? process_one_work+0x700/0x700
 [<ffffffff810d2480>] ? process_one_work+0x700/0x700
 [<ffffffff810d98b1>] kthread+0x101/0x120
 [<ffffffff81110d35>] ? trace_hardirqs_on_caller+0xf5/0x1b0
 [<ffffffff818c4832>] ret_from_fork+0x22/0x50
 [<ffffffff810d97b0>] ? kthread_create_on_node+0x250/0x250
 2 locks held by kworker/0:4/1468:
 #0:  ("kacpid"){.+.+.+}, at: [<ffffffff810d1f3a>] process_one_work+0x1ba/0x700
 #1:  ((&dpc->work)){+.+.+.}, at: [<ffffffff810d1f3a>] process_one_work+0x1ba/0x700

The issue appears to be that the kworker thread attempts to acquire the
_E42 method's mutex twice when executing  acpi_ps_execute_method() and
recursing through the entry method.

The current code does take the possiblity of this recursion into account,
however, it is only for the case where the walk_state has been populated.

This can be fixed by setting the thread id in the !walk_state case to
allow for recursion.

Cc: Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: Mario_Limonciello@dell.com
Cc: stable@vger.kernel.org
Cc: devel@acpica.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/acpi/acpica/dsmethod.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 1982310..93799db 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -428,6 +428,9 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 				obj_desc->method.mutex->mutex.
 				    original_sync_level =
 				    obj_desc->method.mutex->mutex.sync_level;
+
+				obj_desc->method.mutex->mutex.thread_id =
+					acpi_os_get_thread_id();
 			}
 		}
 
-- 
1.7.9.3
