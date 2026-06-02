Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123834752D;
	Tue,  2 Jun 2026 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384556; cv=none; b=ToVo1ia65Rfe81z6w5XRYOcnUr7+sMws16jPD+M5yZJuXLCVc+nwE8bSrmc3jLCWkn8ERM9bz8trG7MWP35WaPk5qi+u3PUr8VnUs3e4FaKID7PlAesU0vs7l31cpASc1KF9YqPmucvEUA3PtdekZ0HYxuOBK33k+4XeSDKvwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384556; c=relaxed/simple;
	bh=ocZXUpdpIGiIn0GrjJFfNfd1GPtqKf8E9b83K9Th010=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=drVySrJyseytO6hm9JXKvwfTnU4f6SwUPcq+JF2/6lmRcG9yR9aFnbkE5B2q1u5xNBu9IpWMGqJBZeIBZnkLgfHZ5BIjkKtT91PITF1n4VzlczlFJuDaZpK83GyGkaU0HFvEDKk4a39CxbMEVLcN8fjbMj2W4EgcuEkjAa9us9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=its8DDK5; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="its8DDK5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384546; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=w6hkoeGhvfChGgi9buPNr+bPKQ0bHNCrhge4y3Jc7oE=;
	b=its8DDK5xvjlXa+0RlK8PsGSkrDZ1gyTS0mMfO1CV8hBgSI42qpHVzhZFY31bwk9tE+UwfFAy0nI7OPPj4tZoPYq4itEnTJ81EpS7Lbr2ry2LM3xnALRkq5ezFvZ/gJqrnjYUyloPcHCOP+GzQJRQyOSf4I31NTf84zKicetwNk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2XC_1780384543;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2XC_1780384543 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:15:45 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v7 00/16] Support Armv8 RAS Extensions for Kernel-first error handling
Date: Tue,  2 Jun 2026 15:15:23 +0800
Message-ID: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch introduces an arm64 platform RAS driver to support the Armv8 RAS Extensions[0].
The features supported by this patch include:

1. ACPI frontend[1]
2. Driver probing and interrupt handling
3. CMN-700 support
4. Error thresholding and error statistics
5. Hardware error interrupt storm mitigation
6. Tracepoints for userspace monitoring

The following features are still required but are not included in this patch,
as they are highly platform-specific:

1. Error decoding
2. Address decoding
(It is also known as the EDAC driver.)

The devicetree frontend support will be implemented later by Umang Chheda[3].

Motivation and Background
================================

On current ARM platforms, RAS functionality is mainly implemented through the
APEI framework, also known as the Firmware-First model(FFM). In this model, RAS
errors are first handled by firmware and then reported to the kernel.

However, this model does not fit all use cases well. In particular:

1. Some platforms want to collect more error events with lower overhead,
avoiding the expensive firmware-kernel context switching.
2. Some platforms prefer to handle error collection directly in the kernel[3].

To address these requirements, a kernel-first error collection mechanism has
been implemented in the kernel based on the Armv8 RAS Extensions. This model
is also referred to as Kernel-First Mode(KFM).

Extended Use Cases
=====================

With support for both Kernel-First Mode (KFM) and Firmware-First Mode (FFM),
users can flexibly choose the most appropriate error handling path for their
platforms and workloads.

This enables additional use cases such as:

1. Predictive failure analysis (PFA)[4]
2. Large-scale error prediction in cloud environments[5][6][7][8]

Maintenance
=============================
This series is based on Tyler Baicar's preliminary patches [9]. I attempted
to follow up with Tyler in 2022 but received no reply. As he no longer
appears active on the mailing list, I have picked up this work, updated it
to align with the latest AEST v2.0 specification, and addressed pending
feedback to ensure this critical feature is integrated into the mainline.

Testing
===================
I have tested this series on THead Yitian710 SOC with customized BIOS. Someone
can also use QEMU[10] for preliminary driver testing.

1. Boot Qemu

qemu-system-aarch64 -smp 4 -m 32G \
  -cpu host --enable-kvm -machine virt,gic-version=3 \
  -kernel Image -initrd initrd.cpio.gz \
  -device virtio-net-pci,netdev=t0 -netdev user,id=t0 \
  -bios /usr/share/edk2/aarch64/QEMU_EFI.fd  \
  -append "rdinit=/sbin/init earlycon verbose debug console=ttyAMA0 aest.dyndbg='+pt'" \
  -nographic -d guest_errors -D qemu.log

2. inject error

echo 0xc4800390 > /sys/kernel/debug/ras/arm64/memory.90d0000/record0/inject/hard_inject
[13581.756132] arm64_ras: {119}[Hardware Error]: Hardware error from AEST memory.90d0000
[13581.756158] arm64_ras: {119}[Hardware Error]:  Error from memory at SRAT proximity domain 0x0
[13581.756162] arm64_ras: {119}[Hardware Error]:   ERR0FR: 0x40000080044081
[13581.756164] arm64_ras: {119}[Hardware Error]:   ERR0CTRL: 0x108
[13581.756165] arm64_ras: {119}[Hardware Error]:   ERR0STATUS: 0xc4800390
[13581.756169] arm64_ras: {119}[Hardware Error]:   ERR0ADDR: 0x8400000043344521
[13581.756170] arm64_ras: {119}[Hardware Error]:   ERR0MISC0: 0x7fff00000000
[13581.756171] arm64_ras: {119}[Hardware Error]:   ERR0MISC1: 0x0
[13581.756172] arm64_ras: {119}[Hardware Error]:   ERR0MISC2: 0x0
[13581.756173] arm64_ras: {119}[Hardware Error]:   ERR0MISC3: 0x0

[0]: https://developer.arm.com/documentation/ihi0100/
[1]: https://developer.arm.com/documentation/den0085/0201/
[3]: https://lore.kernel.org/all/20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com/
[4]: http://www.mcelog.org/glossary.html#pfa
[5]: Intel: Predicting Uncorrectable Memory Errors from the Correctable Error History
[6]: Alibaba. Predicting DRAM-Caused Risky VMs in Large-Scale Clouds. Published in HPCA2025
[7]: AMD: Physics-informed machinelearning for dram error modeling
[8]: Tencent: Predicting uncorrectablememory errors for proactive replacement: An empirical study
on large-scale field data
[9]: https://lore.kernel.org/all/20211124170708.3874-1-baicar@os.amperecomputing.com/
[10]: https://github.com/winterddd/qemu/tree/error_record

Change from V6:
https://lore.kernel.org/all/20260122094656.73399-1-tianruidong@linux.alibaba.com/
1. Comment by Robin Murphy
  - Use the information in the AEST table to calculate PERIPHBASE instead of 
    looking it up from the DSDT.
  - Support erratum #2732981: some nodes do not support ERRGSR, so fall back to
    polling for those nodes, while other nodes should continue using ERRGSR.
  - Other minor changes.
2. Architecture refactor:
  - Renamed the driver to the arm64_ras driver.
  - To support Umang Chheda’s changes[3] in the devicetree, the interaction logic between
    the driver (backend) and the device (frontend) was updated. The device property
    infrastructure is now used uniformly to pass properties, and the extra aest_device
    abstraction has been removed.
  - Removed the use of genpoll, since it is not needed in interrupt context.
3. New features:
  - Added support for hardware error interrupt storm mitigation.

Change from V5:
https://lore.kernel.org/all/20251230090945.43969-1-tianru...
1. Based on the feedback from Borislav Petkov, I've dropped the idea of a 
   unified address translation interface across ARM and AMD.

Change from V4:
https://lore.kernel.org/all/20251222094351.38792-1-tianru...
1. Fix build warning in 0010 and 0014 report by kernel test robot:
    https://lore.kernel.org/all/202512230122.CfXZcF76-lkp@int...
    https://lore.kernel.org/all/202512230007.Vs6IvFVD-lkp@int...
2. Dropped the extra patch(0014) that was mistakenly included in v4.

Change from V3:
https://lore.kernel.org/all/20250115084228.107573-1-tianr...
1. Add vendor AEST node framework and support CMN700
2. Borislav Petkov
    - Split into multiple smaller patches for easier review.
    - refined the English in the cover letter for better flow.
3. Accept Tomohiro Misono's comment

Change from V2:
https://lore.kernel.org/all/20240321025317.114621-1-tianr...
1. Tomohiro Misono
    - dump register before panic
2. Baolin Wang & Shuai Xue: accept all comment.
3. Support AEST V2.

Change from V1:
https://lore.kernel.org/all/20240304111517.33001-1-tianru...
1. Marc Zyngier
  - Use readq/writeq_relaxed instead of readq/writeq for MMIO address.
  - Add sync for system register operation.
  - Use irq_is_percpu_devid() helper to identify a per-CPU interrupt.
  - Other fix.
2. Set RAS CE threshold in AEST driver.
3. Enable RAS interrupt explicitly in driver.
4. UER and UEO trigger memory_failure other than panic.

Ruidong Tian (16):
  ACPI/AEST: Register arm64_ras platform devices from AEST v2
  arm64: ras: Add probe/remove for arm64_ras driver
  arm64: ras: Unify the read/write interface for system and MMIO
    registers
  arm64: ras: Support RAS Common Fault Injection Model Extension
  arm64: ras: Plumb AEST interrupts as platform IRQ resources
  arm64: ras: Enable error reporting
  arm64: ras: Add error record processing and interrupt handling
  arm64: ras: Handle memory failure for uncorrectable errors
  arm64: ras: Probe RAS architecture version
  arm64: ras: Support CE threshold of error record
  arm64: ras: Add RAS decode notifier chain
  arm64: ras: Expose config abi through debugfs
  arm64: ras: Introduce ras inject interface
  arm64: ras: support vendor node CMN700
  arm64: ras: Introduce ras error storm mitigation
  trace, ras: add ARM RAS extension trace event

 Documentation/ABI/testing/debugfs-arm64-ras |   87 ++
 MAINTAINERS                                 |   11 +
 arch/arm64/include/asm/ras.h                |   99 ++
 drivers/acpi/arm64/Kconfig                  |   10 +
 drivers/acpi/arm64/Makefile                 |    1 +
 drivers/acpi/arm64/aest.c                   |  423 ++++++++
 drivers/ras/Kconfig                         |    1 +
 drivers/ras/Makefile                        |    1 +
 drivers/ras/arm64/Kconfig                   |   16 +
 drivers/ras/arm64/Makefile                  |    9 +
 drivers/ras/arm64/ras-cmn.c                 |  479 +++++++++
 drivers/ras/arm64/ras-core.c                | 1026 +++++++++++++++++++
 drivers/ras/arm64/ras-inject.c              |  130 +++
 drivers/ras/arm64/ras-storm.c               |  198 ++++
 drivers/ras/arm64/ras-sysfs.c               |  319 ++++++
 drivers/ras/arm64/ras.h                     |  374 +++++++
 drivers/ras/debugfs.c                       |    3 +-
 drivers/ras/ras.c                           |    3 +
 include/linux/acpi_aest.h                   |   36 +
 include/linux/cpuhotplug.h                  |    1 +
 include/linux/ras.h                         |   10 +
 include/ras/ras_event.h                     |   79 ++
 22 files changed, 3315 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/debugfs-arm64-ras
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 drivers/ras/arm64/Kconfig
 create mode 100644 drivers/ras/arm64/Makefile
 create mode 100644 drivers/ras/arm64/ras-cmn.c
 create mode 100644 drivers/ras/arm64/ras-core.c
 create mode 100644 drivers/ras/arm64/ras-inject.c
 create mode 100644 drivers/ras/arm64/ras-storm.c
 create mode 100644 drivers/ras/arm64/ras-sysfs.c
 create mode 100644 drivers/ras/arm64/ras.h
 create mode 100644 include/linux/acpi_aest.h

-- 
2.51.2.612.gdc70283dfc

