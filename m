From: Carlos Garnacho <carlosg@gnome.org>
Subject: [PATCH] ACPI / battery: Add sysfs representation after checking _BST
Date: Wed, 10 Aug 2016 17:24:15 +0200
Message-ID: <1470842655-23882-1-git-send-email-carlosg@gnome.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32779 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S941241AbcHJTRB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Aug 2016 15:17:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so11445410wme.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Aug 2016 12:17:00 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, Carlos Garnacho <carlosg@gnome.org>

Thus move sysfs_add_battery() after acpi_battery_get_state(), which doesn't
require the power_supply. Prevents possible hanged tasks if
acpi_battery_get_state() fails consistently (and takes a long time in doing
so) when called inside acpi_battery_add().

In this situation the battery module first calls sysfs_add_battery(),
which creates a power_supply, which spawns an async
power_supply_deferred_register_work() task, which shall try to hold the
parent battery device mutex (being already held) so this register work
is set up after device initialization. If initialization takes long enough
the thread will be eventually run and try to hold the mutex before
acpi_battery_add() had the chance to finish.

Eventually the 5 retries in acpi_battery_update_retry() fail, the error
state is propagated, and results in sysfs_remove_battery() being called
within the error handling paths of acpi_battery_add(), and the power_supply
tear down too.

This triggers a cancel_delayed_work_sync() of the deferred_register_work
task, which ends up in schedule(). The end result is that the deferred
task is blocked trying to acquire the parent device mutex, which is not
released because the thread doing initialization (and failure handling)
went to sleep awaiting for the deferred task to be cancelled.

The hanged tasks look like this:

INFO: task kworker/u8:0:6 blocked for more than 120 seconds.
 ...
Call Trace:
 [<ffffffff815daec5>] schedule+0x35/0x80
 [<ffffffff815dda3c>] schedule_timeout+0x1ec/0x250
 [<ffffffff810a0572>] ? check_preempt_curr+0x52/0x90
 [<ffffffff810a05c9>] ? ttwu_do_wakeup+0x19/0xe0
 [<ffffffff815db915>] wait_for_common+0xc5/0x190
 [<ffffffff810a1500>] ? wake_up_q+0x70/0x70
 [<ffffffff815db9fd>] wait_for_completion+0x1d/0x20
 [<ffffffff8108ffb1>] flush_work+0x111/0x1c0
 [<ffffffff8108dfe0>] ? flush_workqueue_prep_pwqs+0x1a0/0x1a0
 [<ffffffff810909af>] __cancel_work_timer+0x9f/0x1d0
 [<ffffffff81090b13>] cancel_delayed_work_sync+0x13/0x20
 [<ffffffff8147ac67>] power_supply_unregister+0x37/0xc0
 [<ffffffffa058b03d>] sysfs_remove_battery+0x3d/0x52 [battery]
 [<ffffffffa058bf3a>] acpi_battery_add+0x112/0x181 [battery]
 [<ffffffff81366db6>] acpi_device_probe+0x54/0x19b
 [<ffffffff81427e9c>] driver_probe_device+0x22c/0x440
 [<ffffffff81428181>] __driver_attach+0xd1/0xf0
 [<ffffffff814280b0>] ? driver_probe_device+0x440/0x440
 [<ffffffff8142591c>] bus_for_each_dev+0x6c/0xc0
 [<ffffffff8142758e>] driver_attach+0x1e/0x20
 [<ffffffff81426fc3>] bus_add_driver+0x1c3/0x280
 [<ffffffff81428b00>] driver_register+0x60/0xe0
 [<ffffffff81366c80>] acpi_bus_register_driver+0x3b/0x43
 [<ffffffffa0591040>] acpi_battery_init_async+0x1c/0x1e [battery]
 [<ffffffff81099268>] async_run_entry_fn+0x48/0x150
 [<ffffffff81090d09>] process_one_work+0x1e9/0x440
 [<ffffffff81090fab>] worker_thread+0x4b/0x4f0
 [<ffffffff81090f60>] ? process_one_work+0x440/0x440
 [<ffffffff81096b58>] kthread+0xd8/0xf0
 [<ffffffff815de97f>] ret_from_fork+0x1f/0x40
 [<ffffffff81096a80>] ? kthread_worker_fn+0x180/0x180

INFO: task kworker/u8:4:282 blocked for more than 120 seconds.
 ...
Call Trace:
 [<ffffffff810ad745>] ? put_prev_entity+0x35/0x8b0
 [<ffffffff815daec5>] schedule+0x35/0x80
 [<ffffffff815db14e>] schedule_preempt_disabled+0xe/0x10
 [<ffffffff815dc533>] __mutex_lock_slowpath+0xb3/0x120
 [<ffffffff815dc5bf>] mutex_lock+0x1f/0x30
 [<ffffffff8147a59b>] power_supply_deferred_register_work+0x2b/0x50
 [<ffffffff81090d09>] process_one_work+0x1e9/0x440
 [<ffffffff81090fab>] worker_thread+0x4b/0x4f0
 [<ffffffff81090f60>] ? process_one_work+0x440/0x440
 [<ffffffff81090f60>] ? process_one_work+0x440/0x440
 [<ffffffff81096b58>] kthread+0xd8/0xf0
 [<ffffffff815de97f>] ret_from_fork+0x1f/0x40
 [<ffffffff81096a80>] ? kthread_worker_fn+0x180/0x180

Making sysfs_add_battery() the last operation here means that the
power_supply won't be created yet when the acpi_add_battery() failure
handling happens, the deferred task won't even spawn, and
sysfs_remove_battery will just skip over the NULL battery->bat.

Signed-off-by: Carlos Garnacho <carlosg@gnome.org>
---

Hi all,

This bug has been "reported" in
https://bugzilla.kernel.org/show_bug.cgi?id=83941#c47 , I have the same
device and can reproduce. What happens in this specific case is that
_BST ends up returning AE_BAD_PARAMETER if there is nothing in the
microUSB port, and takes a *long* time in doing so. The 5 retries take
the order of seconds rather than milliseconds overall, so there's plenty
of time for the deferred task to spawn.

Device specifics aside (something's clearly fubar in DSDTs here), this
might hint a larger problem: It's potentially unsafe to create+destroy a
power_supply if the overall operation holding the mutex on the parent
device takes longer than the 10ms specified by the deferred task since
the power_supply was created.

I'm not sure if this might be a problem somewhere else, moving the
power_supply creation after the potentially tardy operation here helps
enough to have this device boot with no blacklisted battery module,
albeit with still broken battery detection.

Cheers,
  Carlos


 drivers/acpi/battery.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ab23479..93ecae5 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -733,15 +733,17 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 			return result;
 		acpi_battery_init_alarm(battery);
 	}
+
+	result = acpi_battery_get_state(battery);
+	if (result)
+		return result;
+	acpi_battery_quirks(battery);
+
 	if (!battery->bat) {
 		result = sysfs_add_battery(battery);
 		if (result)
 			return result;
 	}
-	result = acpi_battery_get_state(battery);
-	if (result)
-		return result;
-	acpi_battery_quirks(battery);
 
 	/*
 	 * Wakeup the system if battery is critical low
-- 
2.7.4

