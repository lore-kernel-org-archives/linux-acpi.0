From: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] ACPICA: Use 'jiffies' as the time bassis for acpi_os_get_timer()
Date: Wed, 17 Oct 2018 13:24:56 -0700
Message-ID: <20181017202456.136616-1-bvanassche@acm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Yu Chen <yu.c.chen@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Since acpi_os_get_timer() may be called after the timer subsystem has
been suspended, use the jiffies counter instead of ktime_get(). This
patch avoids that the following warning is reported during hibernation:

WARNING: CPU: 0 PID: 612 at kernel/time/timekeeping.c:751 ktime_get+0x116/0x120
RIP: 0010:ktime_get+0x116/0x120
Call Trace:
 acpi_os_get_timer+0xe/0x30
 acpi_ds_exec_begin_control_op+0x175/0x1de
 acpi_ds_exec_begin_op+0x2c7/0x39a
 acpi_ps_create_op+0x573/0x5e4
 acpi_ps_parse_loop+0x349/0x1220
 acpi_ps_parse_aml+0x25b/0x6da
 acpi_ps_execute_method+0x327/0x41b
 acpi_ns_evaluate+0x4e9/0x6f5
 acpi_ut_evaluate_object+0xd9/0x2f2
 acpi_rs_get_method_data+0x8f/0x114
 acpi_walk_resources+0x122/0x1b6
 acpi_pci_link_get_current.isra.2+0x157/0x280
 acpi_pci_link_set+0x32f/0x4a0
 irqrouter_resume+0x58/0x80
 syscore_resume+0x84/0x380
 hibernation_snapshot+0x20c/0x4f0
 hibernate+0x22d/0x3a6
 state_store+0x99/0xa0
 kobj_attr_store+0x37/0x50
 sysfs_kf_write+0x87/0xa0
 kernfs_fop_write+0x1a5/0x240
 __vfs_write+0xd2/0x410
 vfs_write+0x101/0x250
 ksys_write+0xab/0x120
 __x64_sys_write+0x43/0x50
 do_syscall_64+0x71/0x220
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 164a08cee135 ("ACPICA: Dispatcher: Introduce timeout mechanism for infinite loop detection")
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
References: https://lists.01.org/pipermail/lkp/2018-April/008406.html
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Cc: Yu Chen <yu.c.chen@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/acpi/osl.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 8df9abfa947b..ed73f6fb0779 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -617,15 +617,18 @@ void acpi_os_stall(u32 us)
 }
 
 /*
- * Support ACPI 3.0 AML Timer operand
- * Returns 64-bit free-running, monotonically increasing timer
- * with 100ns granularity
+ * Support ACPI 3.0 AML Timer operand. Returns a 64-bit free-running,
+ * monotonically increasing timer with 100ns granularity. Do not use
+ * ktime_get() to implement this function because this function may get
+ * called after timekeeping has been suspended. Note: calling this function
+ * after timekeeping has been suspended may lead to unexpected results
+ * because when timekeeping is suspended the jiffies counter is not
+ * incremented. See also timekeeping_suspend().
  */
 u64 acpi_os_get_timer(void)
 {
-	u64 time_ns = ktime_to_ns(ktime_get());
-	do_div(time_ns, 100);
-	return time_ns;
+	return (get_jiffies_64() - INITIAL_JIFFIES) *
+		(ACPI_100NSEC_PER_SEC / HZ);
 }
 
 acpi_status acpi_os_read_port(acpi_io_address port, u32 * value, u32 width)
-- 
2.19.1.568.g152ad8e336-goog
