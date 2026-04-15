Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732878C9C;
	Wed, 15 Apr 2026 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218212; cv=none; b=uB7/UbzFTOxvbP3kEMn8AIIta52/IOVEPx1RFe/n0wmrCfiAbyHXMFid76rpxcju9zcWw6dGaptbuqnxC5xPm8l7tZmvVMWZFwVPKQHP7L13DuFP10AmJDRmGF8hgD27vQsDhtD6iXfold+2jY6rBj5pgyianmehSpkKIux2zBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218212; c=relaxed/simple;
	bh=eGuXhlim7GxEjVvbvxWqPHczFhFF5K21YPs2upqlNIY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eshJFHnIRFcUBYYD6aOKxfWMsAcXprDx22wHkAbTVbF6RkNUBl0+UXimaVgM09ULiw0Q+5O7XuNP1kpkBkHn6QPfA8lPzNRW2RWDVBDXmJYI15Crsy6AJ03PHPgCrS/0cC4kX3v6PvmMn/weFYUYZFNxt+5EDI3VX+ZzLPlwkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYIc9NrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYIc9NrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F02C19425;
	Wed, 15 Apr 2026 01:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218212;
	bh=eGuXhlim7GxEjVvbvxWqPHczFhFF5K21YPs2upqlNIY=;
	h=From:Subject:Date:To:Cc:From;
	b=RYIc9NrET70ahLVdLOkcUFt4BPLUTsfSzwtdz3a5NDBR9GJGjQssx4nKHPSFgyvgV
	 o5V7FhtVMzzSkKAQKsK2ly6gWoMTlEBs/30q9Baz0texuTvWqN2P+6zyr6PZL9PvKn
	 /3bINBpqVZugUdgUQVyXqVyRNAFWi7PpwPE2vAD2yXghDiSIkdvCxyeWjNTvHSPmK2
	 IsU7ZjxRBq0VQcgUMd5mHVh07cPhONY57ek9r+bSTRKUdNje6l30BKtmT7Ju/vgeTy
	 DmkXl/XwvAIHO21g3lEE7FuJWQUlzoMJMX6RodZS6dq54hP/kxeziaewJtFYhHEzsv
	 27DiHvIjO0N1g==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH RFC v3 00/11] RISC-V: QoS: add CBQRI resctrl interface
Date: Tue, 14 Apr 2026 18:53:54 -0700
Message-Id: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPv3mkC/x3MMQqEMBBA0avI1DsQomjWVtgD2IpFEsd1GjUzI
 IJ4d4PlK/6/QEmYFNriAqGDlbc1o/wUEBe//gl5ygZrbG1K+0XVtClPGEMSRkka8WjQYDCxcS7
 4UDkPud6FZj7f8wD9r4Pxvh+RLfcRbgAAAA==
X-Change-ID: 20260329-ssqosid-cbqri-rqsc-v7-0-b0c788bab48a
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
 Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14552; i=fustini@kernel.org;
 h=from:subject:message-id; bh=eGuXhlim7GxEjVvbvxWqPHczFhFF5K21YPs2upqlNIY=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTe+5DUk/n88qdHzdcUX256mxfDkuz36VcKY3Tem1X9E
 jmqR2S3dJSyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmYsXCyDCn2s1h/ts3fM5/
 XuknPHvl+zXTeqZQrk2Y8Io1nvutdYMZGRY6z+v1/7fd57hXhETmTSN9i7ePneoLPRXWCpy+7XS
 GhRsA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

This RFC series adds RISC-V Quality-of-Service support: the Ssqosid
extension [1] (srmcfg register), the CBQRI controller interface [2]
integrated with the kernel's resctrl subsystem [3], and ACPI RQSC [4]
table support for controller discovery. Device tree support is possible
but no platform drivers are included. All patches are available as a
branch [5].

There is a QEMU patch series [6] that implements Ssqosid and CBQRI. ACPI
RQSC support is implemented as a set of additional patches [7]. All of
the QEMU patches are available as a branch [8].

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
[5] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=b4/ssqosid-cbqri-rqsc
[6] https://lore.kernel.org/qemu-devel/20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org/
[7] https://lore.kernel.org/qemu-devel/20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org/
[8] https://github.com/tt-fustini/qemu/tree/b4/riscv-rqsc

Series organization
-------------------
 01:    DT binding for Ssqosid extension
 02-03: Ssqosid ISA support (detection, srmcfg CSR and switch_to)
 04-07: CBQRI resctrl (hw interface, arch callbacks, domain
        management, Kconfig/build wiring)
 08-11: ACPI support (PPTT helper, actbl2.h RQSC structs [DO NOT
        MERGE], RQSC parser, controller initialization)

RISC-V QoS
----------
QoS (Quality of Service) in this context is concerned with shared
resources on an SoC such as cache capacity and memory bandwidth.

The Ssqosid extension defines the srmcfg CSR which configures a hart
with two identifiers:

 - Resource Control ID (RCID)
 - Monitoring Counter ID (MCID)

These identifiers accompany each request issued by the hart to shared
resource controllers. This allows the capacity and bandwidth resources
used by a software workload (e.g. a process or a set of processes) to be
controlled and monitored.

CBQRI defines operations to configure resource usage limits, in the form
of capacity or bandwidth, for an RCID. CBQRI also defines operations to
configure counters to track resource utilization per MCID. Furthermore,
the Access Type (AT) field allows resource usage to be differentiated
between data and code.

x86 comparison
--------------
The existing QoS identifiers on x86 map well to RISC-V:

  CLOSID (Class of Service ID) on x86 is RCID on RISC-V
    RMID (Resource Monitoring ID) on x86 is MCID on RISC-V

In addition, CDP (code data prioritization) on x86 is similar to the
AT (access type) field in CBQRI which defines code and data types.

One aspect of CBQRI that simplifies the RISC-V resctrl interface is that
any CPU (technically a hart, or hardware thread, in RISC-V terminology)
can access the memory-mapped registers of any CBQRI controller in the
system. This means it does not matter which CPU runs the resctrl code.

Example SoC
-----------
This series was developed and tested using the QEMU virt platform
configured as a hypothetical SoC with a cache controller that implements
CBQRI capacity operations and a memory controller that implements CBQRI
bandwidth operations.

  - L2 cache controllers
    - Resource type: Capacity
    - Number of capacity blocks (NCBLKS): 12
    	- In the context of a set-associative cache, the number of
	  capacity blocks can be thought of as the number of ways
    - Number of access types: 2 (code and data)
    - Usage monitoring not supported
    - Capacity allocation operations: CONFIG_LIMIT, READ_LIMIT

  - Last-level cache (LLC) controller
    - Resource type: Capacity
    - Number of capacity blocks (NCBLKS): 16
    - Number of access types: 2 (code and data)
    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
    - Event IDs supported: None, Occupancy
    - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID

  - Memory controllers
    - Resource type: Bandwidth
    - Number of bandwidth blocks (NBWBLKS): 1024
       - Bandwidth blocks do not have a unit but instead represent a
         portion of the total bandwidth resource. For NBWBLKS of 1024,
	 each block represents about 0.1% of the bandwidth resource.
    - Maximum reserved bandwidth blocks (MRBWB): 819 (80% of NBWBLKS)
    - Number of access types: 1 (no code/data differentiation)
    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
    - Event IDs supported: None, Total read/write byte count, Total
                           read byte count, Total write byte count
    - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT

The memory map for this example SoC:

  Base addr  Size
  0x4820000  4KB  Cluster 0 L2 cache controller
  0x4821000  4KB  Cluster 1 L2 cache controller
  0x4828000  4KB  Memory controller 0
  0x4829000  4KB  Memory controller 1
  0x482a000  4KB  Memory controller 2
  0x482b000  4KB  Shared LLC cache controller

This configuration is only meant to provide a "concrete" example, and it
represents just one of many possible ways that hardware can implement
the CBQRI spec.

The example SoC configuration is created with the following:

  qemu-system-riscv64 \
	-M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic  \
	-smp cpus=8,sockets=1,clusters=2,cores=4,threads=1 \
	-m 1G \
	-nographic \
	-kernel ${LINUX}/arch/riscv/boot/Image \
	-append "root=/dev/vda rootwait" \
	-blockdev node-name=pflash0,driver=file,read-only=on,filename=${EDK}/RISCV_VIRT_CODE.fd \
	-blockdev node-name=pflash1,driver=file,filename=${EDK}/RISCV_VIRT_VARS.fd \
	-drive if=none,file=${ROOTFS}/rootfs.ext2,format=raw,id=hd0 \
	-device virtio-blk-device,drive=hd0 \
	-device qemu-xhci \
	-device usb-kbd \
	-device virtio-net-pci,netdev=net0 \
	-netdev user,id=net0 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04820000 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=12,alloc_op_flush_rcid=false,mon_op_config_event=false,mon_op_read_counter=false,mon_evt_id_none=false,mon_evt_id_occupancy=false,mmio_base=0x04821000 \
	-device riscv.cbqri.capacity,max_mcids=256,max_rcids=64,ncblks=16,mmio_base=0x0482B000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04828000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x04829000 \
	-device riscv.cbqri.bandwidth,max_mcids=256,max_rcids=64,nbwblks=1024,mrbwb=819,mmio_base=0x0482a000

Open issues:
------------
 - RQSC structs in actbl2.h must go through ACPICA upstream first. The
   spec is in the final phase before ratification.

 - No L2 and L3 cache occupancy monitoring
   - This is not currently implemented and I have decided to leave
     it for a followup series.

 - No MBM (bandwidth monitoring)
   - MBA schema works ok for the CBQRI-enabled memory controllers, but
     resctrl does not currently have a solution for representing MBM for
     bandwidth resources that are not associated with a L3 cache.
   - For the old CBQRI proof-of-concept RFC, two separate domains were
     created for each memory controller: one for MB (allocation) and one
     for MBM (monitoring). The monitoring domains had to pretend that
     these memory controllers were L3 caches which is not the case. I
     have removed this as it was too complicated and not the right
     solution.

Changelog
---------
Changes in v3:
 Series restructuring:
 - Restructure from 17 to 11 patches: introduce data structures
   alongside their first users, consolidate build wiring into a
   single "enable resctrl" commit
 - Split the monolithic patch 08/17 into separate patches for HW
   interface, arch callbacks, domain management, and Kconfig wiring
 - Do not expose monitoring to resctrl; allocation only for now.
   A separate followup series will add cache occupancy monitoring.
   Bandwidth monitoring will have to wait for the larger issue of non-L3
   bandwidth to be resolved first.

 Bug fixes from v2 review:
 - Fix cbqri_apply_bw_config() and resctrl_arch_get_config() using
   capacity operation constants instead of bandwidth
 - Fix missing err = -ENOMEM after ioremap() failure
 - Fix ver_major not shifted after masking with GENMASK(7, 4)
 - Fix ctrl->mcid_count = node->rcid in RQSC parser

 Improvements from v2 review:
 - Implement resctrl_arch_set_cpu_default_closid_rmid() (was no-op),
   use per-cpu cpu_srmcfg_default for resctrl allocation rule 2
 - Remove hw_dom->ctrl_val[] cache, read/write CBQRI registers directly
 - Drop resctrl_arch_find_domain(), use resctrl_find_domain() directly
 - Use sorted domain insertion via resctrl_find_domain()
 - Set domain id from cache_id (capacity) or prox_dom (bandwidth)
 - Define RISCV_RESCTRL_EMPTY_CLOSID instead of referencing x86 constant
 - Find minimum mcid_count across controllers for max_rmid
 - Convert SHIFT/MASK pairs to GENMASK() and FIELD_GET()/FIELD_PREP()
 - Use acpi_pptt_get_cpumask_from_cache_id() instead of hardcoding
 - Remove fixed-size f[6] array in RQSC; parse with ACPI_ADD_PTR and
   flexible array for resource descriptors

 Error handling and robustness:
 - Implement resctrl_arch_reset_all_ctrls() to reset all CLOSID
   allocations to defaults on unmount, including CDP code/data entries
 - Capture resctrl_init() return and cleanup on failure
 - Call resctrl_exit() on cpuhp_setup_state() failure
 - Call resctrl_offline_ctrl_domain() before freeing in error path
 - Check resctrl_find_domain() return to reject duplicate domain ids
 - Validate nbwblks!=0 during probe; bounds-check RQSC res[0] access
 - Skip controllers with bad cpumask instead of adding with empty mask
 - Validate resource capabilities match across controllers at same
   cache level

 Bandwidth allocation:
 - Derive max_bw from hardware MRBWB/NBWBLKS with DIV_ROUND_UP()
 - Clamp rbwb to mrbwb so write/readback round-trips exactly
 - Copy cpu_mask for bandwidth domains from proximity domain NUMA node

 Hardware interface:
 - Return final register from cbqri_wait_busy_flag() to eliminate
   redundant MMIO reads after busy-wait
 - Add per-controller spinlock for MMIO register sequence serialization
 - Use readq_poll_timeout_atomic() instead of hand-rolled jiffies loop
 - Move max_rmid update after successful controller probe

 Cleanup:
 - Add lockdep_assert_cpus_held() in resctrl_arch_update_domains()
   and resctrl_arch_reset_all_ctrls()
 - Mark acpi_parse_rqsc() __init
 - Convert __switch_to_srmcfg() stub from macro to static inline to
   make both checkpatch and clang happy
 - Use pr_debug for per-controller details, pr_warn for non-fatal skips
 - Remove unused arch stubs and dead code
 - Use GENMASK_ULL for bits>=32, io-64-nonatomic-lo-hi.h for rv32

 Link to v2: https://lore.kernel.org/r/20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org

Changes in v2:
 - Add support for ACPI RQSC table which provides the details needed to
   discover the CBQRI controllers and support resctrl
 - Drop the "not for upstream" platform drivers and QEMU dts patches.
   Those can be found in v1 and were only for the RFC series. The
   branch for the v1 series is preserved as ssqosid-cbqri-rfc-v1
 - Change cbqri_wait_busy_flag() from 100 ms to 1 ms to avoid
   unnecessary latency.
 - Change resctrl_arch_get_config() to return resctrl_get_default_ctrl()
   instead of a negative errno value which is not valid for u32.
 - Change cbqri_probe_controller() to return -EBUSY when
   request_mem_region() fails
 - Change resctrl_arch_get_config() to no longer increment when rbwb
   modulo ctrl->bc.nbwblks is true
 - Fix indentation in cbqri_set_cbm(), cbqri_set_rbwb() and
   cbqri_get_rbwb().
 - Link to v1: https://lore.kernel.org/r/20260119-ssqosid-cbqri-v1-0-aa2a75153832@kernel.org

---
Drew Fustini (11):
      dt-bindings: riscv: Add Ssqosid extension description
      RISC-V: Detect the Ssqosid extension
      RISC-V: Add support for srmcfg CSR from Ssqosid extension
      RISC-V: QoS: add CBQRI hardware interface
      RISC-V: QoS: add resctrl arch callbacks for CBQRI controllers
      RISC-V: QoS: add resctrl setup and domain management
      RISC-V: QoS: enable resctrl support for Ssqosid
      ACPI: PPTT: Add acpi_pptt_get_cache_size_from_id helper
      DO NOT MERGE: include: acpi: actbl2: Add structs for RQSC table
      ACPI: RISC-V: Parse RISC-V Quality of Service Controller (RQSC) table
      ACPI: RISC-V: Add support for RISC-V Quality of Service Controller (RQSC)

 .../devicetree/bindings/riscv/extensions.yaml      |    6 +
 MAINTAINERS                                        |   11 +
 arch/riscv/Kconfig                                 |   20 +
 arch/riscv/include/asm/acpi.h                      |   10 +
 arch/riscv/include/asm/csr.h                       |    6 +
 arch/riscv/include/asm/hwcap.h                     |    1 +
 arch/riscv/include/asm/processor.h                 |    3 +
 arch/riscv/include/asm/qos.h                       |   52 +
 arch/riscv/include/asm/resctrl.h                   |    7 +
 arch/riscv/include/asm/switch_to.h                 |    3 +
 arch/riscv/kernel/Makefile                         |    2 +
 arch/riscv/kernel/cpufeature.c                     |    1 +
 arch/riscv/kernel/qos/Makefile                     |    2 +
 arch/riscv/kernel/qos/internal.h                   |   81 ++
 arch/riscv/kernel/qos/qos.c                        |   40 +
 arch/riscv/kernel/qos/qos_resctrl.c                | 1092 ++++++++++++++++++++
 drivers/acpi/pptt.c                                |   63 ++
 drivers/acpi/riscv/Makefile                        |    1 +
 drivers/acpi/riscv/init.c                          |   23 +
 drivers/acpi/riscv/rqsc.c                          |  136 +++
 include/acpi/actbl2.h                              |   36 +
 include/linux/acpi.h                               |    8 +
 include/linux/riscv_qos.h                          |  109 ++
 23 files changed, 1713 insertions(+)
---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260329-ssqosid-cbqri-rqsc-v7-0-b0c788bab48a

Best regards,
-- 
Drew Fustini <fustini@kernel.org>

