From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH] ACPI / processor: Finish making acpi_processor_ppc_has_changed() void
Date: Tue, 19 Jun 2018 10:02:01 -0700
Message-ID: <20180619170201.36531-1-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Matthias Kaehlcke <mka@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-acpi@vger.kernel.org

Commit bca5f557dcea ("ACPI / processor: Make
acpi_processor_ppc_has_changed() void") changed one of the declarations
of acpi_processor_ppc_has_changed() to return void, but the !CPU_FREQ
version still return int. Let's return void to be consistent.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 include/acpi/processor.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 40a916efd7c0..1194a4c78d55 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -309,7 +309,7 @@ static inline void acpi_processor_ppc_exit(void)
 {
 	return;
 }
-static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
+static inline void acpi_processor_ppc_has_changed(struct acpi_processor *pr,
 								int event_flag)
 {
 	static unsigned int printout = 1;
@@ -320,7 +320,6 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
 		       "Consider compiling CPUfreq support into your kernel.\n");
 		printout = 0;
 	}
-	return 0;
 }
 static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 {
-- 
2.18.0.rc1.244.gcf134e6275-goog
