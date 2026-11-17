Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953506;
	b=5pI7EOqdG064dS1BpQ/PBp9Mk5T7g1wgnGCxW0OWCmuq6tReSgkEPtBDHeuF9rljnaFq
	 Fdnw/epsvzTyIXOW84IedOJ+hR8AYs90fViFR2BE36RPZrWdVXjHIQl7L/e8ZxpP8PgFB
	 yIM/a8C4goFYcpoKujbuNvF/T7U/69ui4X53PlKSAa8jDzCcB5XbkAGwFCD4JhLhZFdB5
	 crS0PVIcfZ8ahopzh17IYeLRMhX5iCwTgY9mceISyefFG9mTY4zyLylFraf3QdNfp2lO5
	 uGCV3uSCmE95JOSD3X2FuEZ7JltAZRVRiD8xnXrNJqNfBYOqE8YOsqaEYuAk/EPOk4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953506;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=W76m1kA29m11mitv66UWNu9BvE4/1RWqBsu/ibkYDmo=;
	b=Wveey58/HC1sEE1njt/t1G86gTvnO1b2VNQlaa8jH8InMnJYWPVL63kL5QK/gpm+outp
	 DtzBKf0ovlDaCrHu/cNFbvleunT08qAw8VpczwXY04+hWErPxlEg4KAxpwu1/D13Dmfa1
	 SV2uTJH1birsShNNXtE2iPHNOWQhsoZgg9Vk6d5ISY88AqIjI2/f8mfMSxfOfZ83pX0NF
	 F+MjowSq2uvD6sxUh2UZGxfYZzFvBfifBr4sg/dqmDtecj4pnEz/U7l6ceDBQL7WxiecE
	 gt/VDXRjfi7mwOpTsM+0jSMb2h0B4dxz2k4iAwnJ3cewtzVcAxK0QbioTyFCLhnHsbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKrsGAiM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DDE606A31C;
	Tue, 17 Nov 2026 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKrsGAiM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3551F000C4;
	Tue, 17 Nov 2026 22:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953506;
	bh=W76m1kA29m11mitv66UWNu9BvE4/1RWqBsu/ibkYDmo=;
	h=From:Subject:Date:To:Cc;
	b=fKrsGAiMFbMXfUQ/82fYhR2PbjROTe5AZKOWMl4Kn4d0oaZl1i1JalNfz2AR6L6R2
	 WU30jrdH9QsCjoidt1KY110hes1dAPSjJPE+RI4jHGK3H8gWAY8NnApg/xxRtM8IrK
	 Wz8/KfYFNBBjzuRFJro8ZqlqClk+ptAW3UMIqZz7D1lf3DDAyefZ10sL0k4ZsPCc4R
	 LvdQB8gbx/gHGmzGkXnP3FY0e91ttQkdWHQ5fA5RmGh/u6JiZKmUCd4TBPI1FL24T1
	 jrEdBUTWvHsk6OJyV48wDoMFv60pIjGtovSmZUFXH0sDShmNoNbxFrHYQsaulzlooo
	 96dJNCAEkxNHQ==
From: "Drew Fustini (Tenstorrent)" <fustini@kernel.org>
Subject: [PATCH 0/3] ACPI: RISC-V: Add support for the RQSC table
Date: Tue, 17 Nov 2026 14:11:26 -0800
Message-Id: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAA7R/GoC/0WO0WoDIRBFf2XxuQOOsWr3V0IedBzbKc0mq24oh
 Px73abQxwOXc+5dNa7CTc3TXVW+SZPLMgBfJkUfcXlnkDxYGW0cog4Q6SpQ10bgcgkeY3I6RDX
 218pFvn9dx9OT25Y+mfou+FtUXrcR6c/Zf2Oe9oJ2qCGXrXVZBGL/gtGhtFaB3MGipsDGI+Y83
 9DsyhQbA13OZ+nzFDklb7y13ll90Fbn12DIofVhfC02+lTeKB/U6fH4AaFsXGP6AAAA
X-Change-ID: 20261108-acpi-rqsc-6df871ab608a
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=fustini@kernel.org;
 h=from:subject:message-id; bh=WmnhmP2WahYjVuyNgnoCKqB9zmwoEfibIao2Z1EuyAE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWT9uSgjPsv6rd1VJXbV1U633gf/XOdycoeLf+1aljWLd
 deYF0f/7ihlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMxOcAw19xAbewfXYZKdtE
 VTy4JBKWl70LszV8a8/KdobFbFkhSxfDP12ZyEcver4zKGuJnxJy6HAPOFfXV3HMtv3xzXq+uT9
 esQAA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for the ACPI RISC-V Quality of Service Controllers (RQSC)
table [1] that describes the CBQRI controllers [2] present in a system.
Create a platform device for each controller so that the same CBQRI
driver can bind on device tree and ACPI systems.

Patch 1 adds the table definitions. They stay in drivers/acpi/riscv
until ACPICA carries them [3]. Patch 2 parses the table and creates
the platform devices. It is derived from the large RFC series that
implemented all of CBQRI [4]. Patch 3 makes the CBQRI capacity driver
bind to the capacity controller devices. I plan to add support for
bandwidth controller devices once the resctrl generic schema lands.

This series depends on:
 - "riscv: Add initial CBQRI resctrl support" v12 [5]

Tested on QEMU virt with the RQSC table support [6], two L2 capacity
controllers, one L3 capacity controller and one bandwidth controller:

  ACPI: RQSC 0x00000000BDD5B000 0000E0 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  ACPI: RQSC: 4 CBQRI controllers

  # ls /sys/bus/platform/devices | grep cbqri
  cbqri-bandwidth.2
  cbqri-capacity.0
  cbqri-capacity.1
  cbqri-capacity.3

  # grep cbqri /proc/iomem
  04820000-04820fff : cbqri-capacity.0
    04820000-04820fff : cbqri-capacity.0 cbqri-capacity.0
  04821000-04821fff : cbqri-capacity.1
    04821000-04821fff : cbqri-capacity.1 cbqri-capacity.1
  04828000-04828fff : cbqri-bandwidth.2
  0482b000-0482bfff : cbqri-capacity.3
    0482b000-0482bfff : cbqri-capacity.3 cbqri-capacity.3

The capacity driver binds and resctrl shows the L2 and L3 domains:

  cbqri-capacity cbqri-capacity.0: registered L2 capacity controller at 0x0000000004820000 (cache_id=33685504, rcid=64)
  cbqri-capacity cbqri-capacity.1: registered L2 capacity controller at 0x0000000004821000 (cache_id=33685508, rcid=64)
  cbqri-capacity cbqri-capacity.3: registered L3 capacity controller at 0x000000000482b000 (cache_id=33751040, rcid=64)

  # mount -t resctrl resctrl /sys/fs/resctrl
  # cat /sys/fs/resctrl/schemata
  L2:33685504=fff;33685508=fff
  L3:33751040=ffff

[1] https://github.com/riscv-non-isa/riscv-rqsc/releases/tag/v1.0.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://github.com/open-acpica/acpica/pull/1262
[4] https://lore.kernel.org/all/20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org/
[5] https://lore.kernel.org/all/20261114-dfustini-atl-sc-cbqri-dt-v12-0-6ef1f627072d@kernel.org/
[6] https://lore.kernel.org/qemu-devel/20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org/

Signed-off-by: Drew Fustini (Tenstorrent) <fustini@kernel.org>
---
Drew Fustini (Tenstorrent) (3):
      ACPI: RISC-V: Add RQSC table definitions
      ACPI: RISC-V: Enumerate CBQRI controllers from the RQSC table
      riscv_cbqri: Bind to RQSC platform devices

 drivers/acpi/riscv/Kconfig       |   3 +
 drivers/acpi/riscv/Makefile      |   1 +
 drivers/acpi/riscv/init.c        |   2 +
 drivers/acpi/riscv/init.h        |   1 +
 drivers/acpi/riscv/rqsc.c        | 210 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/rqsc.h        |  67 +++++++++++++
 drivers/resctrl/Kconfig          |  11 +-
 drivers/resctrl/cbqri_capacity.c | 111 +++++++++++++++------
 8 files changed, 371 insertions(+), 35 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261108-acpi-rqsc-6df871ab608a
prerequisite-change-id: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd:v12
prerequisite-patch-id: 492fe81aa4f3c885ac5bb48252def2fdc5527275
prerequisite-patch-id: b4f0bd4bf660c92dbf4ca0c7d871c1550b66df0d
prerequisite-patch-id: a2e36f0788f8e11c708d162dce653351dd99c4f0
prerequisite-patch-id: d1d359c5cf89b2b5018d64ca8f320892f6dbcca2
prerequisite-patch-id: 5b7fea6f1ad8f2137ffe45681d56b83e17f7cb2a

Best regards,
--  
Drew Fustini (Tenstorrent) <fustini@kernel.org>

