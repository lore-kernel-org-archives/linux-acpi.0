From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Restore error table definitions to reduce source code differences between Linux and ACPICA upstream.
Date: Tue,  3 Jun 2014 16:32:53 +0800
Message-ID: <1401784373-8599-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39386 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932130AbaFCIdF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jun 2014 04:33:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, "Chen, Gong" <gong.chen@linux.intel.com>, Tony Luck <tony.luck@intel.com>

The following commit has changed ACPICA table header definitions:
 Commit: 88f074f4871a8c212b212b725e4dcdcdb09613c1
 Subject: ACPI, CPER: Update cper info
While such definitions are currently maintained in ACPICA. As the
modifications applying to the table definitions affect other OSPMs'
drivers, it is very difficult for ACPICA to initiate a process to complete
the merge. Thus this commit finally only leaves us divergences.

This patch reverts such naming modifications to reduce the source code
differecnes between Linux and ACPICA upstream. No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Chen, Gong <gong.chen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/acpi_extlog.c        |   14 +++++++-------
 drivers/acpi/apei/apei-internal.h |   10 +++++-----
 drivers/acpi/apei/ghes.c          |   32 ++++++++++++++++----------------
 drivers/firmware/efi/cper.c       |   20 ++++++++++----------
 include/acpi/actbl1.h             |   14 +++++++-------
 include/acpi/ghes.h               |    2 +-
 6 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 1853341..340d095 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -69,11 +69,11 @@ static u32 l1_percpu_entry;
 #define ELOG_ENTRY_ADDR(phyaddr) \
 	(phyaddr - elog_base + (u8 *)elog_addr)
 
-static struct acpi_generic_status *extlog_elog_entry_check(int cpu, int bank)
+static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int bank)
 {
 	int idx;
 	u64 data;
-	struct acpi_generic_status *estatus;
+	struct acpi_hest_generic_status *estatus;
 
 	WARN_ON(cpu < 0);
 	idx = ELOG_IDX(cpu, bank);
@@ -82,7 +82,7 @@ static struct acpi_generic_status *extlog_elog_entry_check(int cpu, int bank)
 		return NULL;
 
 	data &= EXT_ELOG_ENTRY_MASK;
-	estatus = (struct acpi_generic_status *)ELOG_ENTRY_ADDR(data);
+	estatus = (struct acpi_hest_generic_status *)ELOG_ENTRY_ADDR(data);
 
 	/* if no valid data in elog entry, just return */
 	if (estatus->block_status == 0)
@@ -92,7 +92,7 @@ static struct acpi_generic_status *extlog_elog_entry_check(int cpu, int bank)
 }
 
 static void __print_extlog_rcd(const char *pfx,
-			       struct acpi_generic_status *estatus, int cpu)
+			       struct acpi_hest_generic_status *estatus, int cpu)
 {
 	static atomic_t seqno;
 	unsigned int curr_seqno;
@@ -111,7 +111,7 @@ static void __print_extlog_rcd(const char *pfx,
 }
 
 static int print_extlog_rcd(const char *pfx,
-			    struct acpi_generic_status *estatus, int cpu)
+			    struct acpi_hest_generic_status *estatus, int cpu)
 {
 	/* Not more than 2 messages every 5 seconds */
 	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
@@ -137,7 +137,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	struct mce *mce = (struct mce *)data;
 	int	bank = mce->bank;
 	int	cpu = mce->extcpu;
-	struct acpi_generic_status *estatus;
+	struct acpi_hest_generic_status *estatus;
 	int rc;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
@@ -148,7 +148,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	/* clear record status to enable BIOS to update it again */
 	estatus->block_status = 0;
 
-	rc = print_extlog_rcd(NULL, (struct acpi_generic_status *)elog_buf, cpu);
+	rc = print_extlog_rcd(NULL, (struct acpi_hest_generic_status *)elog_buf, cpu);
 
 	return NOTIFY_STOP;
 }
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index e5bcd91..16129c7 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -121,11 +121,11 @@ struct dentry;
 struct dentry *apei_get_debugfs_dir(void);
 
 #define apei_estatus_for_each_section(estatus, section)			\
-	for (section = (struct acpi_generic_data *)(estatus + 1);	\
+	for (section = (struct acpi_hest_generic_data *)(estatus + 1);	\
 	     (void *)section - (void *)estatus < estatus->data_length;	\
 	     section = (void *)(section+1) + section->error_data_length)
 
-static inline u32 cper_estatus_len(struct acpi_generic_status *estatus)
+static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 {
 	if (estatus->raw_data_length)
 		return estatus->raw_data_offset + \
@@ -135,9 +135,9 @@ static inline u32 cper_estatus_len(struct acpi_generic_status *estatus)
 }
 
 void cper_estatus_print(const char *pfx,
-			const struct acpi_generic_status *estatus);
-int cper_estatus_check_header(const struct acpi_generic_status *estatus);
-int cper_estatus_check(const struct acpi_generic_status *estatus);
+			const struct acpi_hest_generic_status *estatus);
+int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
+int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
 
 int apei_osc_setup(void);
 #endif
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index dab7cb7..7a38d14 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -74,13 +74,13 @@
 #define GHES_ESTATUS_CACHE_LEN(estatus_len)			\
 	(sizeof(struct ghes_estatus_cache) + (estatus_len))
 #define GHES_ESTATUS_FROM_CACHE(estatus_cache)			\
-	((struct acpi_generic_status *)				\
+	((struct acpi_hest_generic_status *)				\
 	 ((struct ghes_estatus_cache *)(estatus_cache) + 1))
 
 #define GHES_ESTATUS_NODE_LEN(estatus_len)			\
 	(sizeof(struct ghes_estatus_node) + (estatus_len))
 #define GHES_ESTATUS_FROM_NODE(estatus_node)			\
-	((struct acpi_generic_status *)				\
+	((struct acpi_hest_generic_status *)				\
 	 ((struct ghes_estatus_node *)(estatus_node) + 1))
 
 bool ghes_disable;
@@ -408,7 +408,7 @@ static void ghes_clear_estatus(struct ghes *ghes)
 	ghes->flags &= ~GHES_TO_CLEAR;
 }
 
-static void ghes_handle_memory_failure(struct acpi_generic_data *gdata, int sev)
+static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
 {
 #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
 	unsigned long pfn;
@@ -441,10 +441,10 @@ static void ghes_handle_memory_failure(struct acpi_generic_data *gdata, int sev)
 }
 
 static void ghes_do_proc(struct ghes *ghes,
-			 const struct acpi_generic_status *estatus)
+			 const struct acpi_hest_generic_status *estatus)
 {
 	int sev, sec_sev;
-	struct acpi_generic_data *gdata;
+	struct acpi_hest_generic_data *gdata;
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -498,7 +498,7 @@ static void ghes_do_proc(struct ghes *ghes,
 
 static void __ghes_print_estatus(const char *pfx,
 				 const struct acpi_hest_generic *generic,
-				 const struct acpi_generic_status *estatus)
+				 const struct acpi_hest_generic_status *estatus)
 {
 	static atomic_t seqno;
 	unsigned int curr_seqno;
@@ -520,7 +520,7 @@ static void __ghes_print_estatus(const char *pfx,
 
 static int ghes_print_estatus(const char *pfx,
 			      const struct acpi_hest_generic *generic,
-			      const struct acpi_generic_status *estatus)
+			      const struct acpi_hest_generic_status *estatus)
 {
 	/* Not more than 2 messages every 5 seconds */
 	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
@@ -542,13 +542,13 @@ static int ghes_print_estatus(const char *pfx,
  * GHES error status reporting throttle, to report more kinds of
  * errors, instead of just most frequently occurred errors.
  */
-static int ghes_estatus_cached(struct acpi_generic_status *estatus)
+static int ghes_estatus_cached(struct acpi_hest_generic_status *estatus)
 {
 	u32 len;
 	int i, cached = 0;
 	unsigned long long now;
 	struct ghes_estatus_cache *cache;
-	struct acpi_generic_status *cache_estatus;
+	struct acpi_hest_generic_status *cache_estatus;
 
 	len = cper_estatus_len(estatus);
 	rcu_read_lock();
@@ -573,12 +573,12 @@ static int ghes_estatus_cached(struct acpi_generic_status *estatus)
 
 static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
 	struct acpi_hest_generic *generic,
-	struct acpi_generic_status *estatus)
+	struct acpi_hest_generic_status *estatus)
 {
 	int alloced;
 	u32 len, cache_len;
 	struct ghes_estatus_cache *cache;
-	struct acpi_generic_status *cache_estatus;
+	struct acpi_hest_generic_status *cache_estatus;
 
 	alloced = atomic_add_return(1, &ghes_estatus_cache_alloced);
 	if (alloced > GHES_ESTATUS_CACHE_ALLOCED_MAX) {
@@ -621,7 +621,7 @@ static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
 
 static void ghes_estatus_cache_add(
 	struct acpi_hest_generic *generic,
-	struct acpi_generic_status *estatus)
+	struct acpi_hest_generic_status *estatus)
 {
 	int i, slot = -1, count;
 	unsigned long long now, duration, period, max_period = 0;
@@ -753,7 +753,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 	struct llist_node *llnode, *next;
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
-	struct acpi_generic_status *estatus;
+	struct acpi_hest_generic_status *estatus;
 	u32 len, node_len;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
@@ -786,7 +786,7 @@ static void ghes_print_queued_estatus(void)
 	struct llist_node *llnode;
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
-	struct acpi_generic_status *estatus;
+	struct acpi_hest_generic_status *estatus;
 	u32 len, node_len;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
@@ -845,7 +845,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 #ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 		u32 len, node_len;
 		struct ghes_estatus_node *estatus_node;
-		struct acpi_generic_status *estatus;
+		struct acpi_hest_generic_status *estatus;
 #endif
 		if (!(ghes->flags & GHES_TO_CLEAR))
 			continue;
@@ -925,7 +925,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	rc = -EIO;
 	if (generic->error_block_length <
-	    sizeof(struct acpi_generic_status)) {
+	    sizeof(struct acpi_hest_generic_status)) {
 		pr_warning(FW_BUG GHES_PFX "Invalid error block length: %u for generic hardware error source: %d\n",
 			   generic->error_block_length,
 			   generic->header.source_id);
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 1491dd4..65f2f3f 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -262,7 +262,7 @@ static const char *cper_pcie_port_type_strs[] = {
 };
 
 static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
-			    const struct acpi_generic_data *gdata)
+			    const struct acpi_hest_generic_data *gdata)
 {
 	if (pcie->validation_bits & CPER_PCIE_VALID_PORT_TYPE)
 		printk("%s""port_type: %d, %s\n", pfx, pcie->port_type,
@@ -298,7 +298,7 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 }
 
 static void cper_estatus_print_section(
-	const char *pfx, const struct acpi_generic_data *gdata, int sec_no)
+	const char *pfx, const struct acpi_hest_generic_data *gdata, int sec_no)
 {
 	uuid_le *sec_type = (uuid_le *)gdata->section_type;
 	__u16 severity;
@@ -344,9 +344,9 @@ err_section_too_small:
 }
 
 void cper_estatus_print(const char *pfx,
-			const struct acpi_generic_status *estatus)
+			const struct acpi_hest_generic_status *estatus)
 {
-	struct acpi_generic_data *gdata;
+	struct acpi_hest_generic_data *gdata;
 	unsigned int data_len, gedata_len;
 	int sec_no = 0;
 	char newpfx[64];
@@ -359,7 +359,7 @@ void cper_estatus_print(const char *pfx,
 		       "and requires no further action");
 	printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
 	data_len = estatus->data_length;
-	gdata = (struct acpi_generic_data *)(estatus + 1);
+	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
 	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
 	while (data_len >= sizeof(*gdata)) {
 		gedata_len = gdata->error_data_length;
@@ -371,10 +371,10 @@ void cper_estatus_print(const char *pfx,
 }
 EXPORT_SYMBOL_GPL(cper_estatus_print);
 
-int cper_estatus_check_header(const struct acpi_generic_status *estatus)
+int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus)
 {
 	if (estatus->data_length &&
-	    estatus->data_length < sizeof(struct acpi_generic_data))
+	    estatus->data_length < sizeof(struct acpi_hest_generic_data))
 		return -EINVAL;
 	if (estatus->raw_data_length &&
 	    estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
@@ -384,9 +384,9 @@ int cper_estatus_check_header(const struct acpi_generic_status *estatus)
 }
 EXPORT_SYMBOL_GPL(cper_estatus_check_header);
 
-int cper_estatus_check(const struct acpi_generic_status *estatus)
+int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
 {
-	struct acpi_generic_data *gdata;
+	struct acpi_hest_generic_data *gdata;
 	unsigned int data_len, gedata_len;
 	int rc;
 
@@ -394,7 +394,7 @@ int cper_estatus_check(const struct acpi_generic_status *estatus)
 	if (rc)
 		return rc;
 	data_len = estatus->data_length;
-	gdata = (struct acpi_generic_data *)(estatus + 1);
+	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
 	while (data_len >= sizeof(*gdata)) {
 		gedata_len = gdata->error_data_length;
 		if (gedata_len > data_len - sizeof(*gdata))
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 4ad7da8..9613e8e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -604,7 +604,7 @@ struct acpi_hest_generic {
 
 /* Generic Error Status block */
 
-struct acpi_generic_status {
+struct acpi_hest_generic_status {
 	u32 block_status;
 	u32 raw_data_offset;
 	u32 raw_data_length;
@@ -614,15 +614,15 @@ struct acpi_generic_status {
 
 /* Values for block_status flags above */
 
-#define ACPI_GEN_ERR_UC			BIT(0)
-#define ACPI_GEN_ERR_CE			BIT(1)
-#define ACPI_GEN_ERR_MULTI_UC		BIT(2)
-#define ACPI_GEN_ERR_MULTI_CE		BIT(3)
-#define ACPI_GEN_ERR_COUNT_SHIFT	(0xFF<<4) /* 8 bits, error count */
+#define ACPI_HEST_UNCORRECTABLE             (1)
+#define ACPI_HEST_CORRECTABLE               (1<<1)
+#define ACPI_HEST_MULTIPLE_UNCORRECTABLE    (1<<2)
+#define ACPI_HEST_MULTIPLE_CORRECTABLE      (1<<3)
+#define ACPI_HEST_ERROR_ENTRY_COUNT         (0xFF<<4)	/* 8 bits, error count */
 
 /* Generic Error Data entry */
 
-struct acpi_generic_data {
+struct acpi_hest_generic_data {
 	u8 section_type[16];
 	u32 error_severity;
 	u16 revision;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index dfd60d0..720446c 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -14,7 +14,7 @@
 
 struct ghes {
 	struct acpi_hest_generic *generic;
-	struct acpi_generic_status *estatus;
+	struct acpi_hest_generic_status *estatus;
 	u64 buffer_paddr;
 	unsigned long flags;
 	union {
-- 
1.7.10

