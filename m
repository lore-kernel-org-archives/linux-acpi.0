From: Andy Clayton <clayt055@umn.edu>
Subject: [PATCH] ACPICA: fix deadlock on recursion of entry method
Date: Tue, 23 Feb 2016 16:43:53 -0600
Message-ID: <1456267433-9735-2-git-send-email-clayt055@umn.edu>
References: <1456267433-9735-1-git-send-email-clayt055@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456267433-9735-1-git-send-email-clayt055@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Andy Clayton <clayt055@umn.edu>
List-Id: linux-acpi@vger.kernel.org

The execution of each control method is protected by a mutex.
acpi_ds_begin_method_execution avoids trying to reacquire a mutex during
recursion by checking if the mutex is already held by the current
thread. The mutex's thread_id is only set in
acpi_ds_begin_method_execution if a walk state is present (when the
method is being called by another method). This fails for the external
entry point method executed via acpi_ps_execute_method: the mutex is
acquired but as walk_state is null the thread_id is not set. Subsequent
recursion on the entry method then blocks indefinitely attempting to
grab the mutex that the thread already holds. Fix by initializing the
mutex's thread_id with acpi_os_get_thread_id when a walk state is not
available.

For me this bug is triggered by thunderbolt hotplug on a Dell XPS 15
9550, breaking hotplug and causing subsequent suspend or shutdown to
hang indefinitely.

	INFO: task kworker/0:1:60 blocked for more than 120 seconds.
	      Not tainted 4.4.0-4-generic #19
	"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
	message.
	kworker/0:1     D ffff8804a9f13a48     0    60      2 0x00000000
	Workqueue: kacpid acpi_os_execute_deferred
	 ffff8804a9f13a48 000000000000002f 0000000000000000 ffffffff81e11540
	 ffff8804a9ea9b40 ffff8804a9f14000 ffff880378947600 ffff8804a9ea9b40
	 ffff8804ac4e26b8 ffff8804ac4e26b8 ffff8804a9f13a60 ffffffff818c38c5
	Call Trace:
	 [<ffffffff818c38c5>] schedule+0x35/0x80
	 [<ffffffff818c842e>] schedule_timeout+0x22e/0x2f0
	 [<ffffffff810214f9>] ? sched_clock+0x9/0x10
	 [<ffffffff810b97ac>] ? local_clock+0x1c/0x20
	 [<ffffffff810da359>] ? mark_held_locks+0x79/0xa0
	 [<ffffffff818c941c>] ? _raw_spin_unlock_irq+0x2c/0x40
	 [<ffffffff810da4a9>] ? trace_hardirqs_on_caller+0x129/0x1b0
	 [<ffffffff818c7304>] __down_timeout+0x74/0xd0
	 [<ffffffff810d4169>] ? down_timeout+0x19/0x60
	 [<ffffffff810d419c>] down_timeout+0x4c/0x60
	 [<ffffffff814c646c>] acpi_os_wait_semaphore+0xaa/0x16c
	 [<ffffffff814f37b9>] acpi_ex_system_wait_mutex+0x81/0xfa
	 [<ffffffff814daefc>] acpi_ds_begin_method_execution+0x25e/0x378
	 [<ffffffff814db460>] acpi_ds_call_control_method+0x107/0x2de
	 [<ffffffff8150112f>] acpi_ps_parse_aml+0x17e/0x493
	 [<ffffffff81501e14>] acpi_ps_execute_method+0x1fa/0x2ba
	 [<ffffffff814f90fa>] acpi_ns_evaluate+0x2e6/0x42d
	 [<ffffffff814e203b>] acpi_ev_asynch_execute_gpe_method+0xbd/0x159
	 [<ffffffff814c55b0>] acpi_os_execute_deferred+0x14/0x20
	 [<ffffffff8109f93e>] process_one_work+0x1ee/0x570
	 [<ffffffff8109f8d2>] ? process_one_work+0x182/0x570
	 [<ffffffff8109fd08>] worker_thread+0x48/0x4a0
	 [<ffffffff8109fcc0>] ? process_one_work+0x570/0x570
	 [<ffffffff810a6456>] kthread+0xf6/0x110
	 [<ffffffff810da4a9>] ? trace_hardirqs_on_caller+0x129/0x1b0
	 [<ffffffff810a6360>] ? kthread_create_on_node+0x290/0x290
	 [<ffffffff818ca16f>] ret_from_fork+0x3f/0x70
	 [<ffffffff810a6360>] ? kthread_create_on_node+0x290/0x290

And part of the impacted method from the DSDT:

        Method (_E42, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
        {
            (...)

            ADBG ("TBT-HP-Handler")
            ADBG ("PEG WorkAround")
            PGWA ()
            Acquire (OSUM, 0xFFFF)
            Local1 = TBFF ()
            If ((Local1 == One))
            {
                Sleep (0x10)
                Release (OSUM)
                ADBG ("OS_Up_Received")
                If (((DPTF == One) && (DDDR == One)))
                {
                    If (((OSYS == 0x07DD) && (_REV == 0x05)))
                    {
                        Return (Zero)
                    }

                    _E42 ()
                }

                Return (Zero)
            }

            (...)
        }

Signed-off-by: Andy Clayton <clayt055@umn.edu>
---
 drivers/acpi/acpica/dsmethod.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 6a72047..c3a052d 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -428,6 +428,9 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 				obj_desc->method.mutex->mutex.
 				    original_sync_level =
 				    obj_desc->method.mutex->mutex.sync_level;
+
+				obj_desc->method.mutex->mutex.thread_id =
+				    acpi_os_get_thread_id();
 			}
 		}
 
-- 
2.7.0
