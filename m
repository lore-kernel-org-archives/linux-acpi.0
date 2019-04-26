Return-Path: <SRS0=A6Sl=S4=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E9C43218
	for <linux-acpi@archiver.kernel.org>; Fri, 26 Apr 2019 22:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A027720869
	for <linux-acpi@archiver.kernel.org>; Fri, 26 Apr 2019 22:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfDZWDZ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:03:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52882 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfDZWDZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Apr 2019 18:03:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7850A15BE;
        Fri, 26 Apr 2019 15:03:24 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.29.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E25CC3F557;
        Fri, 26 Apr 2019 15:03:23 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linuxarm@huawei.com, john.garry@huawei.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 3/5] ACPI/PPTT: Modify node flag detection to find last IDENTICAL
Date:   Fri, 26 Apr 2019 17:03:07 -0500
Message-Id: <20190426220309.55654-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426220309.55654-1-jeremy.linton@arm.com>
References: <20190426220309.55654-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426220307.l4iaIHS2awDSB6ddaYchgHvYBYgIKoequXp79R2lGdk@z>

The ACPI specification implies that the IDENTICAL flag should be
set on all non leaf nodes where the children are identical.
This means that we need to be searching for the last node with
the identical flag set rather than the first one.

To achieve this with the existing code we need to pass a
function through the tree traversal logic so we can check
the next node to assure that IDENTICAL isn't set before returning
a node with IDENTICAL set.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c | 62 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 1865515297ca..39f660d8be0a 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -432,17 +432,51 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 	}
 }
 
+
+typedef bool (*node_check)(struct acpi_table_header *table_hdr,
+			   struct acpi_pptt_processor *cpu);
+static bool flag_package(struct acpi_table_header *table_hdr,
+			 struct acpi_pptt_processor *cpu)
+{
+	return cpu->flags & ACPI_PPTT_PHYSICAL_PACKAGE;
+}
+
+static bool flag_identical(struct acpi_table_header *table_hdr,
+			   struct acpi_pptt_processor *cpu)
+{
+	struct acpi_pptt_processor *next;
+
+	/* heterogeneous machines must use PPTT revision > 1 */
+	if (table_hdr->revision < 2)
+		return false;
+
+	/* Locate the last node in the tree with IDENTICAL set */
+	if (cpu->flags & ACPI_PPTT_ACPI_IDENTICAL) {
+		next = fetch_pptt_node(table_hdr, cpu->parent);
+		if (!(next && next->flags & ACPI_PPTT_ACPI_IDENTICAL))
+			return true;
+	}
+
+	return false;
+}
+
+static bool flag_none(struct acpi_table_header *table_hdr,
+		      struct acpi_pptt_processor *cpu)
+{
+	return false;
+}
+
 /* Passing level values greater than this will result in search termination */
 #define PPTT_ABORT_PACKAGE 0xFF
 
-static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
-								  struct acpi_pptt_processor *cpu,
-								  int level, int flag)
+static struct acpi_pptt_processor *acpi_find_processor_tag_id(struct acpi_table_header *table_hdr,
+							      struct acpi_pptt_processor *cpu,
+							      int level, node_check chk)
 {
 	struct acpi_pptt_processor *prev_node;
 
 	while (cpu && level) {
-		if (cpu->flags & flag)
+		if (chk(table_hdr, cpu))
 			break;
 		pr_debug("level %d\n", level);
 		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
@@ -473,15 +507,15 @@ static void acpi_pptt_warn_missing(void)
  * Return: Unique value, or -ENOENT if unable to locate CPU
  */
 static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
-				     unsigned int cpu, int level, int flag)
+				     unsigned int cpu, int level, node_check chk)
 {
 	struct acpi_pptt_processor *cpu_node;
 	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (cpu_node) {
-		cpu_node = acpi_find_processor_package_id(table, cpu_node,
-							  level, flag);
+		cpu_node = acpi_find_processor_tag_id(table, cpu_node,
+							  level, chk);
 		/*
 		 * As per specification if the processor structure represents
 		 * an actual processor, then ACPI processor ID must be valid.
@@ -498,7 +532,7 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 	return -ENOENT;
 }
 
-static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
+static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, node_check chk)
 {
 	struct acpi_table_header *table;
 	acpi_status status;
@@ -509,7 +543,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 		acpi_pptt_warn_missing();
 		return -ENOENT;
 	}
-	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
+	retval = topology_get_acpi_cpu_tag(table, cpu, level, chk);
 	pr_debug("Topology Setup ACPI CPU %d, level %d ret = %d\n",
 		 cpu, level, retval);
 	acpi_put_table(table);
@@ -601,7 +635,7 @@ int cache_setup_acpi(unsigned int cpu)
  */
 int find_acpi_cpu_topology(unsigned int cpu, int level)
 {
-	return find_acpi_cpu_topology_tag(cpu, level, 0);
+	return find_acpi_cpu_topology_tag(cpu, level, flag_none);
 }
 
 /**
@@ -658,7 +692,7 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 int find_acpi_cpu_topology_package(unsigned int cpu)
 {
 	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
-					  ACPI_PPTT_PHYSICAL_PACKAGE);
+					  flag_package);
 }
 
 /**
@@ -670,8 +704,8 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
  *
  * The returned tag can be used to group peers with identical implementation.
  *
- * The search terminates when a level is found with the identical implementation
- * flag set or we reach a root node.
+ * The search terminates when a level is found without the identical
+ * implementation flag set following a node with it set, or we reach the root.
  *
  * Due to limitations in the PPTT data structure, there may be rare situations
  * where two cores in a heterogeneous machine may be identical, but won't have
@@ -684,5 +718,5 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 {
 	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
-					  ACPI_PPTT_ACPI_IDENTICAL);
+					  flag_identical);
 }
-- 
2.20.1

