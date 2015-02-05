From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 3/6] ACPICA: Events: Enable APIs to allow interrupt/polling adaptive request based GPE handling model.
Date: Thu,  5 Feb 2015 16:27:15 +0800
Message-ID: <47de4a724beed78bd9170618cb1f5b6d1dc052dc.1423123819.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1423123818.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423123818.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit da9a83e1a845f2d7332bdbc0632466b2595e5424

For acpi_set_gpe()/acpi_enable_gpe(), our target is to purify them to be APIs
that can be used for various GPE handling models, so we need them to be
pure GPE enabling APIs. GPE enabling/disabling has 2 use cases:
1. Driver may permanently enable/disable GPEs according to the usage
   counts.
   1. When upper layers (the users of the driver) submit requests to the
      driver, it means they care about the underlying hardware. GPE need
      to be enabled for the first request submission and disabled for the
      last request completion.
   2. When the GPE is shared between 2+ silicon logics. GPE need to be
      enabled for either silicon logic's driver and disabled when all of
      the drivers are not started.
   For these cases, acpi_enable_gpe()/acpi_disable_gpe() should be used. When
   the usage count is increased from 0 to 1, the GPE is enabled and it is
   disabled when the usage count is decrased from 1 to 0.
2. Driver may temporarily disables the GPE to enter an GPE polling mode and
   wants to re-enable it later.
   1. Prevent GPE storming: when a driver cannot fully solve the condition
      that triggered the GPE in the GPE context, in order not to trigger
      GPE storm, driver has to disable GPE to switch into the polling mode
      and re-enables it in the non interrupt context after the storming
      condition is cleared.
   2. Meet throughput requirement: some IO drivers need to poll hardware
      again and again until nothing indicated instead of just handling once
      for one interruption, this need to be done in the polling mode or the
      IO flood may prevent the GPE handler from returning.
   3. Meet realtime requirement: in order not to block CPU to handle higher
      realtime prioritized GPEs, lower priority GPEs can be handled in the
      polling mode.
   For these cases, acpi_set_gpe() should be used to switch to/from the
   polling mode.

This patch adds unconditional GPE enabling support into acpi_set_gpe() so
that this API can be used by the drivers to switch back from the GPE
polling mode unconditionally.

Originally this function includes GPE clearing logic in it.
First, the GPE clearing is typically used in the GPE handling code to:
1. Acknowledge the GPE when we know there is an edge triggered GPE raised
   and is about to handle it, otherwise the unexpected clearing may lead to
   a GPE loss;
2. Issue actions after we have handled a level triggered GPE, otherwise
   the unexpected clearing may trigger unwanted OSPM actions to the
   hardware (for example, clocking in out-dated write FIFO data).
Thus the GPE clearing is not suitable to be used in the GPE enabling APIs.
Second, the combination of acknowledging and enabling may also not be
expected by the hardware drivers. For GPE clearing, we have a seperate API
acpi_clear_gpe(). There are cases drivers do want the 2 operations to be
split. So splitting these 2 operations could facilitates drivers the
maximum possibilities to achieve success. For a combined one, we already
have acpi_finish_gpe() ready to be invoked.

Given the fact that drivers should complete all outstanding requests before
putting themselves into the sleep states, as this API is executed for
outstanding requests, it should also have nothing to do with the
"RUN"/"WAKE" distinguishing. That's why the acpi_set_gpe(ACPI_GPE_ENABLE)
should not be implemented by acpi_hw_low_set_gpe(ACPI_GPE_CONDITIONAL_ENABLE).

This patch thus converts acpi_set_gpe(ACPI_GPE_ENABLE) into
acpi_hw_low_set_gpe(ACPI_GPE_ENABLE) to achieve a seperate GPE enabling API.
Drivers then are encouraged to use this API when they need to switch
to/from the GPE polling mode.

Note that the acpi_set_gpe()/acpi_finish_gpe() should be first introduced to
Linux using a divergence reduction patch before sending a linuxized version
of this patch. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/da9a83e1
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxfgpe.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index caaeb1a..70eb47e 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -194,12 +194,21 @@ ACPI_EXPORT_SYMBOL(acpi_disable_gpe)
  * RETURN:      Status
  *
  * DESCRIPTION: Enable or disable an individual GPE. This function bypasses
- *              the reference count mechanism used in the acpi_enable_gpe and
- *              acpi_disable_gpe interfaces -- and should be used with care.
- *
- * Note: Typically used to disable a runtime GPE for short period of time,
- * then re-enable it, without disturbing the existing reference counts. This
- * is useful, for example, in the Embedded Controller (EC) driver.
+ *              the reference count mechanism used in the acpi_enable_gpe(),
+ *              acpi_disable_gpe() interfaces.
+ *              This API is typically used by the GPE raw handler mode driver
+ *              to switch between the polling mode and the interrupt mode after
+ *              the driver has enabled the GPE.
+ *              The APIs should be invoked in this order:
+ *               acpi_enable_gpe()            <- Ensure the reference count > 0
+ *               acpi_set_gpe(ACPI_GPE_DISABLE) <- Enter polling mode
+ *               acpi_set_gpe(ACPI_GPE_ENABLE) <- Leave polling mode
+ *               acpi_disable_gpe()           <- Decrease the reference count
+ *
+ * Note: If a GPE is shared by 2 silicon components, then both the drivers
+ *       should support GPE polling mode or disabling the GPE for long period
+ *       for one driver may break the other. So use it with care since all
+ *       firmware _Lxx/_Exx handlers currently rely on the GPE interrupt mode.
  *
  ******************************************************************************/
 acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
@@ -225,7 +234,7 @@ acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
 	switch (action) {
 	case ACPI_GPE_ENABLE:
 
-		status = acpi_ev_enable_gpe(gpe_event_info);
+		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 		break;
 
 	case ACPI_GPE_DISABLE:
-- 
1.7.10
