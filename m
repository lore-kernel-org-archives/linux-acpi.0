Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B027A10F
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 04:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052033; cv=none; b=NCfLV9OU1XAaH2wCL5T+q+mP0e8tWR5oCtWiKXw6QkIuJucBGrQMdO93MQk2hfGZlC/FypVA0+VBlnxtCKw3kxuluD3LTBvr4Qm318VYKJlvwXDgznfHhIIm1QFaYvHVbuvEit78lqS93rhUFEftKNqQH5bIH1ZnncES9NxJoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052033; c=relaxed/simple;
	bh=OUpPeEes/y+ArXs2upxEA1BNgKsnrkR9ayItzVy6vm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inzVTj/F18QKAcoTRq369AjF6MjcgouA2RVBjtYBx/REsaBM3lvXs1sWkDN/ZFi8Vx/iOynQhCnE0Anzr0YuQE8C9E1U2Q7tJfH5CDJxjb/LmZqaNWOkKn86DHAppOT8S28uz474m9JpwDCD8koZy94QUE/BR4XjPcUz+LMh0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKoDTSBU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKoDTSBU"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so126312b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2026 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783052021; x=1783656821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6npnmvUqCM8/66CqqYCk/mzyWieSpjEbi8Gph9LP44=;
        b=HKoDTSBUA6sKXVIX114K/UqgKvUb6Gw/qUAwGquRpCIDKfRQm6O6djVy11KUutiK9E
         5QX2ldxj4DHothJbfWBU7eMHJdDM6R6lJ2i3nIJuEfI4f/fQw5Z1xp0VrbC2CanGVbJi
         /arT5ZcjVb1sQTSa61TBP8X4y9dTm7icCFQA3Dt5xpTBOXgj2oP170LUsJPv4QKdQz9g
         r0EBzkiczKVwyd06TjzuTBDLbU/ICaHi6UEt0SEZJb8rxvhdBKjaGZrJaqJAzpSQ+NDa
         jbVwG7v1+FRWHnwwFYR9tNknIdGGKM3L61YngGLscSpCig2F60cWMJlSDfe+6g0jFrpx
         1+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783052021; x=1783656821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6npnmvUqCM8/66CqqYCk/mzyWieSpjEbi8Gph9LP44=;
        b=FVT2UxMvsBSMj1+D2r50ECWue6/bzsnoyKwrnswCgPG0j3luCzyeveV57ZRWmXDdPH
         aKCnmAhzpsmYJSjJk+kitNMkSSrr3sODUwjgfaQhAVKJRI8VDzdNvkGiEoFs/K7cCKIv
         gV7hTlZmuc1qpNMWqg0w3k2Q5ANjKGLdhFOvTLLQVJYGnr603WSqP8I6WuxUvqt4Nv8X
         Qa51fHd0xgbBrc805kvT2ZuVWhrv2xYX8RyLEDI83kAMeH2GWV0JoLVP8jSV2zQ+w1Uq
         iLqT3zMkYnIj7qsmIc6clvejoP9FAck0O8BEIYxZTM0g6HnaFHvPp2tIFMzvK8unsgNx
         z+lA==
X-Forwarded-Encrypted: i=1; AHgh+RpqdeRRT6w25P3/DrO3mZzmj22Iwn+xemvs/B2BAQ5wQKGEgISFMpimuy7AZY+BK0fzAYkL2f12J1Ng@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7dwLozaTdrkpa/GGzXhySClA42xLQIGYqIuCx4L5K3R8ppTF
	LhFSN7t2xNlnTQLIkidg5iv/H7DCbUPQLD4JiXmxmoFg7EqYTEh3SJMz
X-Gm-Gg: AfdE7cmy97e2hxWGZnbFRaEGYsihtrzh37RYf6hZWYZ5vR8w+lgVXv1fMHat6MPX8zZ
	1dmj7wf55+iCJ8GNGEXoen6jDXWPleDHYBVRiNBfqKWiMGPyansPyeKSQPeN6J+siNwPqUMUzSv
	LLYYXJq5dOcB6rir3871I0ObMHy9EBZlsdD+912Bm3iLM9J8IHheVvcMRHfr4iG9YCshcD3hABM
	j6Y8u39FWAEs+IaZAZZsGT2/p/OTO4coBsB7uXTNUPeu5HSOHh65OYbJEbMxHHX+6N0KRwmrGiz
	U/Hv2jTKRsuMqEthX/6hJerl4oPCWcxk8WwZ1RwwOr5rHnDPIIv9gCNq3cnb/n/sVxLIUtrzH3e
	DdrmZ1zEUBmmkjV2dAkTSTe3pZGxKxoGhFvdEnYUUGyY21a6aVLqxmKeN6sJr05fyedDwXIr2Vi
	aFt4V9HoQ8sv2u68Nx9A==
X-Received: by 2002:a05:6a00:244d:b0:842:63f5:d097 with SMTP id d2e1a72fcca58-847e17360d9mr2456212b3a.3.1783052020555;
        Thu, 02 Jul 2026 21:13:40 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94bd7esm2207768b3a.38.2026.07.02.21.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:13:40 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	devicetree@vger.kernel.org,
	driver-core@lists.linux.dev,
	"H. Peter Anvin" <hpa@zytor.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	WANG Xuerui <kernel@xen0n.name>,
	x86@kernel.org
Subject: [PATCH v2 0/9] treewide, numa_memblks: remove redundant work during NUMA init
Date: Fri,  3 Jul 2026 13:13:20 +0900
Message-ID: <20260703041329.2797584-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every existing numa_add_memblk() caller passes a valid node id and
separately marks that node in numa_nodes_parsed with node_set(). In
addition, numa_nodemask_from_meminfo() recomputes the same "nodes that own
memory" set from numa_meminfo, which numa_nodes_parsed already contains.

This redundancy implicitly depends on the callers' node_set(). So, before
removing the redundancy, make numa_add_memblk() set the node in
numa_nodes_parsed explicitly. Then remove the per-caller node_set() and
numa_nodemask_from_meminfo().

Also, since the generic numa_register_meminfo() already sets
node_possible_map to numa_nodes_parsed, remove the duplicate assignment in
arch_numa's numa_register_nodes().

Patch 1 adds the node_set() to numa_add_memblk() itself, so every memblk's
node is set in numa_nodes_parsed on add.

Patches 2-6 depend on patch 1 and remove the redundant per-caller node_set()
from all callers.

Patch 7 removes both numa_nodemask_from_meminfo() call sites and the unused
function itself.

Patch 8 removes the duplicate node_possible_map assignment in arch_numa.

Patch 9 is a minor cleanup, using the existing numa_add_reserved_memblk()
wrapper in numa_cleanup_meminfo().

No functional change.

---
Changes from v1 [1]
- remove warning in numa_add_memblk_to() when start == end
- add Acked-by tag
- rebased onto latest mm-new

[1] https://lore.kernel.org/all/20260628135828.1393120-1-ekffu200098@gmail.com/
--- 

Sang-Heon Jeon (9):
  mm: numa_memblks: set numa_nodes_parsed in numa_add_memblk()
  ACPI: NUMA: remove redundant numa_nodes_parsed node_set()
  of/numa: remove redundant numa_nodes_parsed node_set()
  x86/numa: remove redundant numa_nodes_parsed node_set()
  arch_numa: remove redundant numa_nodes_parsed node_set()
  LoongArch: remove redundant numa_nodes_parsed node_set()
  mm: numa_memblks: remove redundant numa_nodemask_from_meminfo()
  arch_numa: remove redundant node_possible_map assignment
  mm: numa_memblks: use numa_add_reserved_memblk() in
    numa_cleanup_meminfo()

 arch/loongarch/kernel/numa.c |  1 -
 arch/x86/mm/amdtopology.c    |  1 -
 arch/x86/mm/numa.c           |  1 -
 drivers/acpi/numa/srat.c     |  2 --
 drivers/base/arch_numa.c     |  4 ----
 drivers/of/of_numa.c         |  5 +----
 mm/numa_memblks.c            | 39 +++++++++++++++++-------------------
 7 files changed, 19 insertions(+), 34 deletions(-)

-- 
2.43.0

