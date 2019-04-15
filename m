Return-Path: <SRS0=A1TZ=SR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2529C10F0E
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Apr 2019 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E70520848
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Apr 2019 17:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfDORtv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:49:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727992AbfDORtt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Apr 2019 13:49:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E4BA485083B4B38C348A;
        Tue, 16 Apr 2019 01:49:46 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Tue, 16 Apr 2019 01:49:37 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/4 V3] arm64: Support Generic Initiator only domains
Date:   Tue, 16 Apr 2019 01:49:05 +0800
Message-ID: <20190415174907.102307-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190415174907.102307-1-Jonathan.Cameron@huawei.com>
References: <20190415174907.102307-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190415174905.02dWwbTEP_X0mr6meXtsbK08b4tLWu9w2NEEgegWaEk@z>

The one thing that currently needs doing from an architecture
point of view is associating the GI domain with its nearest
memory domain.  This allows all the standard NUMA aware code
to get a 'reasonable' answer.

A clever driver might elect to do load balancing etc
if there are multiple host / memory domains nearby, but
that's a decision for the driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 824de7038967..7c419bf92374 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -731,6 +731,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int err;
 	unsigned int cpu;
+	unsigned int node;
 	unsigned int this_cpu;
 
 	init_cpu_topology();
@@ -769,6 +770,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		set_cpu_present(cpu, true);
 		numa_store_cpu_info(cpu);
 	}
+
+	/*
+	 * Walk the numa domains and set the node to numa memory reference
+	 * for any that are Generic Initiator Only.
+	 */
+	for_each_node_state(node, N_GENERIC_INITIATOR)
+		set_gi_numa_mem(node, local_memory_node(node));
 }
 
 void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-- 
2.19.1

