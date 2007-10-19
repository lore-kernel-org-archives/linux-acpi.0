From: Alex Chiang <achiang@hp.com>
Subject: [PATCH RFC] Expose _SUN in /proc/acpi/processor/<...>/info
Date: Fri, 19 Oct 2007 13:38:44 -0600
Message-ID: <20071019193844.GL8122@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:52327 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764747AbXJSTjL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Oct 2007 15:39:11 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Hello,

I'm looking for comments on the following patch that exposes _SUN
on processor objects in /proc/acpi/processor/<...>/info.

I notice that acpiphp exposes _SUN for PCI slots in
/sys/bus/pci/slots/N/, where N is the value of _SUN. I'm not so
sure we want to go *exactly* in the same direction for CPUs,
because:

  - x86 systems might not implement _SUN for processors
  - ia64 systems that implement ACPI 2.x do not have unique
    values for _SUN across the entire system

Nonetheless, even non-unique values of _SUN are still helpful for
userspace to figure out which physical socket a CPU might be in,
especially when combined with information from /proc/cpuinfo.

Thoughts?

Thanks.

/ac

From: Alex Chiang <achiang@hp.com>

On platforms that provide _SUN for the processor object, higher
level software can consume the data to learn physical topology
information, so let's expose it.

Platforms that do not implement _SUN will see <not supported>.

Signed-off-by: Alex Chiang <achiang@hp.com>
---
 drivers/acpi/processor_core.c |   11 +++++++++++
 include/acpi/processor.h      |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9f11dc2..b44d733 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -301,6 +301,11 @@ static int acpi_processor_info_seq_show(struct seq_file *seq, void *offset)
 		   pr->flags.throttling ? "yes" : "no",
 		   pr->flags.limit ? "yes" : "no");
 
+	if (pr->sun == -1)
+		seq_printf(seq, "slot user number:        <not supported>\n");
+	else
+		seq_printf(seq, "slot user number:        %d\n", pr->sun);
+
       end:
 	return 0;
 }
@@ -595,6 +600,12 @@ static int acpi_processor_get_info(struct acpi_processor *pr, unsigned has_uid)
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
 			  pr->acpi_id));
 
+	status = acpi_evaluate_object(pr->handle, "_SUN", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		object.integer.value = -1;
+
+	pr->sun = object.integer.value;
+
 	if (!object.processor.pblk_address)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
 	else if (object.processor.pblk_length != 6)
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 99934a9..326a3da 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -206,6 +206,7 @@ struct acpi_processor {
 	u32 acpi_id;
 	u32 id;
 	u32 pblk;
+	u32 sun;
 	int performance_platform_limit;
 	int throttling_platform_limit;
 	/* 0 - states 0..n-th state available */
-- 
1.5.3.1.1.g1e61

