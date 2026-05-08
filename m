Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CD363087;
	Fri,  8 May 2026 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228437; cv=none; b=Tg82iDpplYVEHVdb8O8P0hrhTqDZbiI4YWbEbK2FdMnKmdSpF0qt6u8nVKzYD7oJsu++APWOSpWxxO05q4FL0ZBhTOd++zZmxOjSjkihdeCjPIqF68tfp47jeKG+aXvz/fVxJIBja1DkZBmtxtyq8M9esip/AYuRUEuJWwrsOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228437; c=relaxed/simple;
	bh=Wr3XT2/tW7zSvgi5fTELVXgSjAUFhLbxW9RVaNkB0rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8TvHMDWw0hvqvzcDPMgxrfDbx+p4VP6InpOdG7rBFI/vRo2pGD//L0R+wQizXOk9RehhQaXoWepQIrJEc4JhjXJyVOwgHjPrAor2Tzh31bHh3kfFFE1r5P+6RCu93M7eDql3jS6BjJ1B8MlCc/8wul48n5ZfeHBWtBP9LRnGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jzh/9ERu; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jzh/9ERu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778228426; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+7QdPcCzeWAnAa1oaJ9PNAr6xemcX6oyHA0viBSsOL0=;
	b=Jzh/9ERu5GjSqy/deTK9Zx0jehWIPkU4e9DgZFGpOql/qW8MV4N4OGrBWwH+U05CAM2RglAe2vVjArqSV1dUy7rXEUUvgDp6kLSo7CvUl9p36+zR8s3HVEdqYA66RvUnouIhVIrxYeZZmFMkhvK1pyHircPSfqNtQAmiwTdfn/I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X2WlM8y_1778228422;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X2WlM8y_1778228422 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 16:20:24 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	lenb@kernel.org,
	saket.dumbre@intel.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 0/3] riscv: log Hardware Error Exception via APEI
Date: Fri,  8 May 2026 16:20:17 +0800
Message-ID: <20260508082020.3368109-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the handling of do_trap_hardware_error() based on
the works in [1].

RISC-V already dispatches Hardware Error Exception (cause 19, "HEE") via
do_trap_hardware_error(), but today the trap handler has no way to learn
*what* went wrong: the offending task is killed (or the kernel panics)
with no diagnostic about the underlying hardware fault, no error record
is logged, no page is isolated, and memory_failure() is never invoked.

There are two principal ways to obtain hardware error information on
HEE:

  1. Let firmware parse platform error registers and hand the kernel a
     standardized CPER record through ACPI / APEI / GHES.
  2. Have the kernel read the error registers directly.

Option (2) is not yet viable on RISC-V: the architecture does not
define a unified, mandatory layout for hardware error status registers
across implementations, so there is nothing stable for common code to
decode. This series therefore implements option (1) and wires HEE into
the existing APEI / GHES path, mirroring how arm64 treats SEA.

Future work: option (2) is not ruled out. Once the RISC-V architecture
standardizes a common hardware error register layout (either as part
of the privileged spec or via a well-defined SBI / ACPI namespace
interface), a kernel-native decoder could be added alongside the
ACPI/APEI path. The two can then coexist and be selected per
platform through a Kconfig choice. This series keeps the door open
by routing HEE through apei_claim_hee() behind CONFIG_ACPI_APEI_HEE,
so disabling that config already restores the legacy path and does
not block a future native decoder from being wired in.

After this series:

  * Firmware reports RAS events to the OS as CPER records through a
    HEST GHES entry whose notification type is HEE (new value 13).
  * If CONFIG_ACPI_APEI_HEE is set, do_trap_hardware_error() calls
    apei_claim_hee() first. On success GHES queues the record, drains
    irq_work inline, and delivers a BUS_MCEERR_AR SIGBUS to the faulting
    user task via task_work after isolating the poisoned page with 
    memory_failure(MF_ACTION_REQUIRED).
  * If firmware does not claim the error or CONFIG_ACPI_APEI_HEE not set:
      - user mode falls back to SIGBUS / BUS_MCEERR_AR via do_trap_error(),
      - kernel mode tries fixup_exception() to let MC-safe copy routines
        recover; otherwise die().

References:
----------
[1] [RISC-V RAS patch]: https://lore.kernel.org/all/20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com/

Ruidong Tian (3):
  acpi: Introduce HEE in HEST notification types
  riscv: Introduce HEST HEE notification handlers for APEI
  riscv: collect hardware error information via APEI on HEE

 arch/riscv/include/asm/acpi.h   |  2 +
 arch/riscv/include/asm/fixmap.h |  3 ++
 arch/riscv/kernel/acpi.c        | 54 ++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c       | 35 ++++++++++++++++-
 drivers/acpi/apei/Kconfig       | 12 ++++++
 drivers/acpi/apei/ghes.c        | 68 ++++++++++++++++++++++++++++++++-
 include/acpi/actbl1.h           |  3 +-
 include/acpi/ghes.h             |  6 +++
 8 files changed, 178 insertions(+), 5 deletions(-)

-- 
2.51.2.612.gdc70283dfc

