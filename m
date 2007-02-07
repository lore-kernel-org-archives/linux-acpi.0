From: Len Brown <lenb@kernel.org>
Subject: [PATCH 130/140] ACPICA: fix gcc build warnings
Date: Wed,  7 Feb 2007 13:52:24 -0500
Message-ID: <11708745471399-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <b0b7eaaf0c7aefd118d3ff8640fbed75a9fad9a1.1170873819.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:10552 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422877AbXBGSzt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:49 -0500
In-Reply-To: <1170874546646-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

drivers/acpi/namespace/nsparse.c:126: warning: int format, different type arg (arg 7)
drivers/acpi/tables/tbfadt.c:224: warning: unsigned int format, different type arg (arg 6)
drivers/acpi/utilities/utdebug.c:184: warning: cast from pointer to integer of different size
drivers/acpi/utilities/utdebug.c:184: warning: cast from pointer to integer of different size
drivers/acpi/utilities/utdebug.c:197: warning: cast from pointer to integer of different size
drivers/acpi/processor_idle.c:1093: warning: long long unsigned int format, u64 arg (arg 5)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsparse.c |    2 +-
 drivers/acpi/processor_idle.c    |    2 +-
 drivers/acpi/tables/tbfadt.c     |    4 ++--
 drivers/acpi/utilities/utdebug.c |    6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/namespace/nsparse.c b/drivers/acpi/namespace/nsparse.c
index 0e57cc6..e696aa8 100644
--- a/drivers/acpi/namespace/nsparse.c
+++ b/drivers/acpi/namespace/nsparse.c
@@ -124,7 +124,7 @@ acpi_ns_one_complete_parse(acpi_native_uint pass_number,
 	/* Parse the AML */
 
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "*PARSE* pass %d parse\n",
-			  pass_number));
+			  (unsigned)pass_number));
 	status = acpi_ps_parse_aml(walk_state);
 
 	acpi_ps_delete_parse_tree(parse_root);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 1d633f7..6c6751b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1090,7 +1090,7 @@ static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
 		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020llu]\n",
 			   pr->power.states[i].latency,
 			   pr->power.states[i].usage,
-			   pr->power.states[i].time);
+			   (unsigned long long)pr->power.states[i].time);
 	}
 
       end:
diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index a6723a2..807c711 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -222,8 +222,8 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 	 */
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_WARNING((AE_INFO,
-			      "FADT (revision %u) is longer than ACPI 2.0 version, truncating length 0x%X to 0x%X",
-			      table->revision, length,
+			      "FADT (revision %u) is longer than ACPI 2.0 version, truncating length 0x%X to 0x%zX",
+			      table->revision, (unsigned)length,
 			      sizeof(struct acpi_table_fadt)));
 	}
 
diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index 179ad18..61ad4f2 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -180,8 +180,8 @@ acpi_ut_debug_print(u32 requested_debug_level,
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %X to TID %X ****\n\n",
-			     (unsigned)acpi_gbl_prev_thread_id, (unsigned)thread_id);
+			    ("\n**** Context Switch from TID %lX to TID %lX ****\n\n",
+			     (unsigned long)acpi_gbl_prev_thread_id, (unsigned long)thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
@@ -194,7 +194,7 @@ acpi_ut_debug_print(u32 requested_debug_level,
 	acpi_os_printf("%8s-%04ld ", module_name, line_number);
 
 	if (ACPI_LV_THREADS & acpi_dbg_level) {
-		acpi_os_printf("[%04X] ", (unsigned)thread_id);
+		acpi_os_printf("[%04lX] ", (unsigned long)thread_id);
 	}
 
 	acpi_os_printf("[%02ld] %-22.22s: ",
-- 
1.5.0.rc3.39.gec804
