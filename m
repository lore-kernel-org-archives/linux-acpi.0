From: Furquan Shaikh <furquan@google.com>
Subject: [PATCH] drivers/acpi: Clear status of an event before enabling it
Date: Wed, 20 Mar 2019 15:28:44 -0700
Message-ID: <20190320222844.134765-1-furquan@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, erik.schmauss@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: rajatja@google.com, evgreen@google.com, dlaurie@google.com, furquan@google.com
List-Id: linux-acpi@vger.kernel.org

Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
clearing ACPI IRQs during suspend/resume") was added to stop clearing
of event status bits unconditionally on suspend and resume paths. This
was done because of an issue
reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
lid status stays closed even on resume (which happens because event
status bits are cleared unconditionally on resume). Though this change
fixed the issue on suspend path, it introduced regressions on several
resume paths.

First regression was reported and fixed on S5 path by the following
change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
entering S5"). Next regression was reported and fixed on all legacy
sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
events when entering sleep states"). However, regression still exists
on S0ix sleep path since it does not follow the legacy sleep path.

In case of S0ix, events are enabled as part of device suspend path. If
status bits for the events are set when they are enabled, it could
result in premature wake from S0ix. This change ensures that status is
cleared for any event that is being enabled so that any stale events
are cleared out.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/acpi/acpica/evgpe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 62d3aa74277b4..61455ab42fc87 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	ACPI_FUNCTION_TRACE(ev_enable_gpe);
 
-	/* Enable the requested GPE */
+	/* Clear the GPE (of stale events) */
+	status = acpi_hw_clear_gpe(gpe_event_info);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
 
+	/* Enable the requested GPE */
 	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 	return_ACPI_STATUS(status);
 }
-- 
2.21.0.225.g810b269d1ac-goog
