Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953506;
	b=cRTIFSyfyqg8bl+uMgrINH/PE0QLbkWwyb6uKq6uZETMAFiBCIWMSfs7HE+xUIW1C9Je
	 6Q8kR68eYIDUdMhmWmYtrjEK72SyBpVi0h9oULCuqi1QK3uQKFzwLdnBl9j8YJGH686Lv
	 hp+IcNJIOTvXBisrF1vMLL1gC79IIN3uxbcGXaNFtq2JTg3MtRlUl1fvcpN5Q/8OR8xCx
	 m/XxyJ1QFqm0E4h7X2T3NeRZLxRkScI6KIk/7lKRYx/KXXMQDqaUvAnLqjhRImwXYCCQA
	 vPEMkbVMCN5G6KqtEE1V5Znpgg7vCIN3faIjk4NSI3dn9y0fAeCFLLMq4yWkPwxzemA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953506;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/1hNtICneGhne8iXWQ6cBiRvaRi+/d+2W/uyM2swnSk=;
	b=nPY2DLJHzuDt3izLoH+rFhzJvCGQYqdGmsQo2nOgLxqfLvatnvua32qQYjMKxC/EAlcd
	 PDlEOJvdBbmGljsEyAU1ngXV+f/sApMxnd7aD3VEs4aK403hHQ8PPfNTYJ0pvkxxFUbN0
	 HjTQnBQ0T2XGfbmi5Hm8Q999HBT+xOPveY4MitXMcDZJKvY6LPCI/xgIY5TwxaQgTQw76
	 AaI4KQb4TUHf8E3omn6ePht2j7OwhpNH5s70NO/AFOjv2ifXVRYryRT6YAjgOUDeXw3+4
	 gw216b9ZWHzBNOKmZlhlSpUpbspGgv/tggd1qUhHq78VT4ohUfl5JwuIhrmtVuFffqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AL71nTsW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE3606A331;
	Tue, 17 Nov 2026 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AL71nTsW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145741F000C9;
	Tue, 17 Nov 2026 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953506;
	bh=/1hNtICneGhne8iXWQ6cBiRvaRi+/d+2W/uyM2swnSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AL71nTsWd/A+a2L7joLavNbLv16P8IohWifGOlQt/wWV1ImH7SHi/AaKsdYeZ4O6+
	 A6KQ8fHVQlxgXOYEjjeaftAtKO8CKOy+RrO0R2brBre1EEhwXKtFofS5pxvBBqY0/i
	 bEcssK4wKxczdIkvma1JK7kiDUbDLB6pC5PxIgoVOyg7y9aNK58BOvMi5dgfoXhbTh
	 FaCK6hkM5AHIRYEF3tsXF6qm+EdbdNv6cHnt/mgd/nLid3iGiTHDicpUwJ8QWHaSyx
	 97e3bcDaIZ79gdsZ29hKJ5J4hwkORWoNJlqV0A/8jT2YvZwoloAP6pfh0nLSNv4TVp
	 ou6Ak3Rk9ObMw==
From: "Drew Fustini (Tenstorrent)" <fustini@kernel.org>
Date: Tue, 17 Nov 2026 14:11:27 -0800
Subject: [PATCH 1/3] ACPI: RISC-V: Add RQSC table definitions
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-acpi-rqsc-v1-1-381ce645751e@kernel.org>
References: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
In-Reply-To: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Atish Patra <atish.patra@linux.dev>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, 
 Chen Pei <cp0613@linux.alibaba.com>, yunhui cui <cuiyunhui@bytedance.com>, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Zeng Heng <zengheng@picoheart.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Ben Horgan <ben.horgan@arm.com>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Samuel Holland <samuel.holland@sifive.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, Dave Martin <Dave.Martin@arm.com>, 
 Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghuay@nvidia.com>, 
 Peter Newman <peternewman@google.com>, 
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Drew Fustini (Tenstorrent)" <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620; i=fustini@kernel.org;
 h=from:subject:message-id; bh=vPNGObNCWR27c+GVYcHocchqXfN4ljgXbem+P0wwc+U=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWT9uajgfdM/XcJ/X8j0z9P/FO3ZLdR3Zfv39H7JhgkyZ
 vWpZfmXO0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQAT4ddnZHglWJN5q+3tr8Mi
 1049mSt1d+ahN3417J8WfbeZGLY3cakNI8O+/UeuKBkcC+YoX2I7N6hqmvcRbYfip1EMhlMCWXu
 4uDgB
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

The RISC-V Quality of Service Controllers (RQSC) table describes the
CBQRI capacity and bandwidth controllers in a system. RQSC v1.0 was
ratified in June 2026. Add structure definitions for RQSC.

The definitions stay in drivers/acpi/riscv until ACPICA carries them
in actbl2.h.

Link: https://github.com/open-acpica/acpica/pull/1262
Signed-off-by: Drew Fustini (Tenstorrent) <fustini@kernel.org>
---
 drivers/acpi/riscv/rqsc.h | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/acpi/riscv/rqsc.h b/drivers/acpi/riscv/rqsc.h
new file mode 100644
index 000000000000..d9a4ce0f1c10
--- /dev/null
+++ b/drivers/acpi/riscv/rqsc.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Definitions for the RISC-V Quality of Service Controllers (RQSC) ACPI
+ * table, kept here until ACPICA carries them in actbl2.h.
+ */
+#ifndef _DRIVERS_ACPI_RISCV_RQSC_H
+#define _DRIVERS_ACPI_RISCV_RQSC_H
+
+#include <linux/acpi.h>
+#include <linux/types.h>
+
+#define ACPI_SIG_RQSC	"RQSC"	/* RISC-V Quality of Service Controllers Table */
+
+#define ACPI_RQSC_REVISION	1
+
+/* QoS Controller Type */
+#define ACPI_RQSC_CONTROLLER_TYPE_CAPACITY	0
+#define ACPI_RQSC_CONTROLLER_TYPE_BANDWIDTH	1
+
+/* Resource Type */
+#define ACPI_RQSC_RESOURCE_TYPE_CACHE	0
+#define ACPI_RQSC_RESOURCE_TYPE_MEMORY	1
+
+/* Resource ID Type */
+#define ACPI_RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE	0
+#define ACPI_RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE		1
+#define ACPI_RQSC_RESOURCE_ID_TYPE_MEMORY_SIDE_CACHE	2
+#define ACPI_RQSC_RESOURCE_ID_TYPE_ACPI_DEVICE		3
+#define ACPI_RQSC_RESOURCE_ID_TYPE_PCI_DEVICE		4
+
+/* Controller Flags */
+#define ACPI_RQSC_CONTROLLER_ZERO_BLOCKS	(1) /* Zero blocks can be allocated to an RCID */
+
+struct acpi_rqsc_resource {
+	u8 type;
+	u8 reserved;
+	u16 length;
+	u16 flags;
+	u8 reserved2;
+	u8 id_type;
+	u64 id1;
+	u32 id2;
+} __packed;
+
+/* Resource Specific Data that follows a memory resource */
+struct acpi_rqsc_memory_data {
+	u64 bandwidth_per_block;	/* In bytes per second, 0 if not provided */
+} __packed;
+
+struct acpi_rqsc_controller {
+	u8 type;
+	u8 reserved;
+	u16 length;
+	struct acpi_generic_address address;
+	u16 rcid_count;
+	u16 mcid_count;
+	u16 flags;
+	u16 num_resources;
+	/* Followed by num_resources struct acpi_rqsc_resource */
+} __packed;
+
+struct acpi_table_rqsc {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 num_controllers;
+} __packed;
+
+#endif /* _DRIVERS_ACPI_RISCV_RQSC_H */

-- 
2.43.0

