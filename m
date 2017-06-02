From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 3/6] acpi: HMAT support in acpi_parse_entries_array()
Date: Fri,  2 Jun 2017 14:59:53 -0600
Message-ID: <20170602205956.28351-4-ross.zwisler@linux.intel.com>
References: <20170602205956.28351-1-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170602205956.28351-1-ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Box,
 David E" <david.e.box-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zheng,
 Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Anaczkowski,
 Lukasz" <lukasz.anaczkowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Odzioba,
 Lukasz" <lukasz.odzioba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Schmauss, Erik" <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, "Kogut,
 Jaroslaw" <Jaroslaw.Kogut-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Nachimuthu,
 Murugasamy" <murugasamy.nachimuthu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "Lahtinen,
 Joonas" <joonas.lahtinen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The current implementation of acpi_parse_entries_array() assumes that each
subtable has a standard ACPI subtable entry of type struct
acpi_sutbable_header.  This standard subtable header has a one byte length
followed by a one byte type.

The HMAT subtables have to allow for a longer length so they have subtable
headers of type struct acpi_hmat_structure which has a 2 byte type and a 4
byte length.

Enhance the subtable parsing in acpi_parse_entries_array() so that it can
handle these new HMAT subtables.

Signed-off-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/numa.c   |  2 +-
 drivers/acpi/tables.c | 52 ++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index edb0c79..917f1cc 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -443,7 +443,7 @@ int __init acpi_numa_init(void)
 	 * So go over all cpu entries in SRAT to get apicid to node mapping.
 	 */
 
-	/* SRAT: Static Resource Affinity Table */
+	/* SRAT: System Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
 		struct acpi_subtable_proc srat_proc[3];
 
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index ff42539..7979171 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -218,6 +218,33 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
+static unsigned long __init
+acpi_get_entry_type(char *id, void *entry)
+{
+	if (!strncmp(id, ACPI_SIG_HMAT, 4))
+		return ((struct acpi_hmat_structure *)entry)->type;
+	else
+		return ((struct acpi_subtable_header *)entry)->type;
+}
+
+static unsigned long __init
+acpi_get_entry_length(char *id, void *entry)
+{
+	if (!strncmp(id, ACPI_SIG_HMAT, 4))
+		return ((struct acpi_hmat_structure *)entry)->length;
+	else
+		return ((struct acpi_subtable_header *)entry)->length;
+}
+
+static unsigned long __init
+acpi_get_subtable_header_length(char *id)
+{
+	if (!strncmp(id, ACPI_SIG_HMAT, 4))
+		return sizeof(struct acpi_hmat_structure);
+	else
+		return sizeof(struct acpi_subtable_header);
+}
+
 /**
  * acpi_parse_entries_array - for each proc_num find a suitable subtable
  *
@@ -242,10 +269,10 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 		struct acpi_subtable_proc *proc, int proc_num,
 		unsigned int max_entries)
 {
-	struct acpi_subtable_header *entry;
-	unsigned long table_end;
+	unsigned long table_end, subtable_header_length;
 	int count = 0;
 	int errs = 0;
+	void *entry;
 	int i;
 
 	if (acpi_disabled)
@@ -263,19 +290,23 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	}
 
 	table_end = (unsigned long)table_header + table_header->length;
+	subtable_header_length = acpi_get_subtable_header_length(id);
 
 	/* Parse all entries looking for a match. */
 
-	entry = (struct acpi_subtable_header *)
-	    ((unsigned long)table_header + table_size);
+	entry = (void *)table_header + table_size;
+
+	while (((unsigned long)entry) + subtable_header_length  < table_end) {
+		unsigned long entry_type, entry_length;
 
-	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
-	       table_end) {
 		if (max_entries && count >= max_entries)
 			break;
 
+		entry_type = acpi_get_entry_type(id, entry);
+		entry_length = acpi_get_entry_length(id, entry);
+
 		for (i = 0; i < proc_num; i++) {
-			if (entry->type != proc[i].id)
+			if (entry_type != proc[i].id)
 				continue;
 			if (!proc[i].handler ||
 			     (!errs && proc[i].handler(entry, table_end))) {
@@ -290,16 +321,15 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			count++;
 
 		/*
-		 * If entry->length is 0, break from this loop to avoid
+		 * If entry_length is 0, break from this loop to avoid
 		 * infinite loop.
 		 */
-		if (entry->length == 0) {
+		if (entry_length == 0) {
 			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
 			return -EINVAL;
 		}
 
-		entry = (struct acpi_subtable_header *)
-		    ((unsigned long)entry + entry->length);
+		entry += entry_length;
 	}
 
 	if (max_entries && count > max_entries) {
-- 
2.9.4
