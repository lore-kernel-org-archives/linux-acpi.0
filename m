Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B53BE636
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956392; cv=pass; b=eS52NJoFclstIqjIAJI6Rlj//IeJvp4D7Pu7SI+kHIMBXa++2Gc+qitqxvboNzG93pv8cvVtZt+17HrIbREsq6vFYvEaT0lVwY8bYAJebnB2lDzwQW6Wf4KPmAwpy8naLbptnCCWbHBBvFpMomTrFPAm1BI6FDJuedgB3D5PwK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956392; c=relaxed/simple;
	bh=uTbnda8uOUyubdToRS22NXXTi/L+6JZ/TRggEH+fM50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hz+UKDjSnG9iVt7HHt8/wxQhChW4B8Sra/eI2LtO5rYI6q57epz7R4FTinBKtnSu4CD7KY6ZVplQ+18No4W9VprM/HukK2KjwQn+pQHqnXMaoHTjKNQ8PwCDOfgS5h9C34FTEsLXxWJFzXVHAyGLplwsLrGiBDFEW+NmL7mZzaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iwk91X2V; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iwk91X2V"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de46b8e432so4592792a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2026 21:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777956390; cv=none;
        d=google.com; s=arc-20240605;
        b=LbvfKzCc3Jk1JZ0WrchU4DwmCbRY4p6DheY/2nhC3LcO7613itBlvXe+zqRcR54FKG
         RnJFl672LSY8ehw9HzM/TpD9CMr0vySVFCXoykLJuX+XHgkTZLgQMpjGk2Rs8tyXAsDN
         1urn+lEUSmUMc5F6G3npU35ZaId3szUxIeJSIIYzs5odkYyfFTl0vs+9wgxgSvEv36/h
         bIRDEVjyqJD9e6qxvtsOsPDKR6Grl19C6k4fZXIBgTFqiJfWrDK8xBR/QJ1VE9I9zwUy
         TfeoS5sFfpAiztkz6jhVZBcdYpnUvPb4FMf1i9MYFJMMFKY9oseihz/iDP0PCEZKfCBE
         YQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8yGl+Hr9fjC3YKMYNK0dZu8iKL0HA86CQ4mT9KcKOk=;
        fh=FFNo8trepGVuC+YA7PHY9gVWbls+bfZ3oHnKSgNfp8o=;
        b=Kft7fUFPBrLt/EnY9L94JxGsTeicHn6PM+gK1Hh2yE/dY/Uixo4yVH+NHYkjk1m4fS
         px/S85wLfIXG0HPsNse7smuUfeJ2DuqxlBAV5RJ9lMoCz4O6ZSmLQcXwJ1o3nZUlh/I+
         FG2UGDijr4ZEehlGeLU03o7ipp8CMCIZuurRwmQK+VRSCQZv+oNfGilxxCmOs19p+qku
         Ed+nicK2n1D1/dbn8TysQIRsFcxrLHw7xqpVQlw3qibKA1qpBYuxqFGU2NqadR6Ujkti
         xU5y3hUlmG8DUBQ2Ye3B2Qd3NLCnTjmq9IjHZddnwXmWASesqxANfcJGmCoBLK1+LzZB
         xnIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777956390; x=1778561190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8yGl+Hr9fjC3YKMYNK0dZu8iKL0HA86CQ4mT9KcKOk=;
        b=iwk91X2V2/ATBcThnLNbv1F0s42N1uclxmB5/FWo8vkmV0+3nRJ5T0n5HmJaAdAT1e
         bZPGo3OtDZY7WH72ZxRXvnpG8kr+oQaOjvJAG5ZkV3F75Vu+k3fT5LKvayOzSdp5zfi+
         cB1u4+JcjRjSuDIvLVJVi3iFUKMQf3fbFn50PSfsbzly/Uwk/m8iXAwLSs97VYOSgbzb
         +WCFyWGeiImvgJ6OTTgDdYAcSTvs5P+JLiMArVNcBbTHkQHwttfwoWqjNhDer6zWjEON
         2iNJdcXuozZEpsdGcPm6wzmOpV9bUiBvNqCQsi1mKnx4l5pUA4ZIufccNe4j/8B1tKJk
         5pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777956390; x=1778561190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8yGl+Hr9fjC3YKMYNK0dZu8iKL0HA86CQ4mT9KcKOk=;
        b=fzlZxCmYMoBV4rJPaHkgE/HwYiOQAf0xA+JqKy8hcUsrxcvJ8XA3Y8rBikzSdhgLMJ
         3kneVqkWiH49z2/4ntK0c3FFSMaMFuIBC55SdxLR4trHHmRPyu4lM7FBTEsuYeRGCPeR
         3nqFKjTBBm9zU5rkptrIEqC6YVxRZkluONoa/TuFSyeNOe22ihHAeTKfdSPRffgM2zSn
         wJjsTnBn4hh/+os3aCKwmggpHtRgfATFOOrAHUh2NtQnGmdO6tkVeL/3jkWae5+2z2Gh
         ay/K9qwHI8Hcf3k8vIuVNohoUvr+eUyal2bQkvC8j8Fh2ZJ0gJDKfPC19FwUu8xWk0/r
         ICHA==
X-Forwarded-Encrypted: i=1; AFNElJ9p09eng0Wp9Hr0l8+LgZ8u5cr7J+B0RjcMBRIUa0bcD0iOoz+CG/TmQTNLzjuLemK9MT6WV40vHhCA@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZSWRLNRvJBxjcXKzPywvSeeVy6DmwatlKFlNcQ/sMWdZXBIZ
	oT2jyQ8MUNlLWN+MzDJ7ND00McrY5i3dhjClktVLIy6TL3zQZ/rHiPOZhZPZd/GuWEI/PdniQT+
	zbi0qorunPd8Q8YXyY6A/C8GGSVcyoR6qY7zWpQ/6Hg==
X-Gm-Gg: AeBDietQDvgVhcVm9lBdvf9GPpcw8EIjRFuNt0LosneTjj9JiA6vOmVU0xhvhh0i/Vj
	um+rwcV9gyC5PlN2cmM7sQQsX57m4sEBEzQvvo3dR5kPWQo6jCtyYXFCV5We7YF28PnyJJgESPz
	O9k+CDFvUIfvu9zADu9AGoQExtlehETbfnBkUPz9WDvOzFdmvujPIpCZh9Gyq42TQz6ci2m+GWU
	4W5oaZCS+Yp/6ndzrq6JMtylbPmgbwudWhTsH9IeWY9SubqGUOXpQg3ZBcNu45AY1JojkdBq+03
	ELk8EBIUWG0ujSYNdg==
X-Received: by 2002:a05:6830:270a:b0:7d7:e59c:80e6 with SMTP id
 46e09a7af769-7dee127f28dmr8275314a34.12.1777956389387; Mon, 04 May 2026
 21:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 5 May 2026 12:46:14 +0800
X-Gm-Features: AVHnY4Lbz9xobMi2Ejre2OoBc7YiLqBPA7RApmoiKlfRYR15FBy4T_r2birU5bA
Message-ID: <CAEEQ3wn3F-Wg-Wi+d5znpcgt5pfJVuRQCPvi4W7q4an+SLrOdQ@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v3 00/11] RISC-V: QoS: add CBQRI resctrl interface
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Chen Pei <cp0613@linux.alibaba.com>, 
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
	guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
	Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Wed, Apr 15, 2026 at 9:57=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> This RFC series adds RISC-V Quality-of-Service support: the Ssqosid
> extension [1] (srmcfg register), the CBQRI controller interface [2]
> integrated with the kernel's resctrl subsystem [3], and ACPI RQSC [4]
> table support for controller discovery. Device tree support is possible
> but no platform drivers are included. All patches are available as a
> branch [5].
>
> There is a QEMU patch series [6] that implements Ssqosid and CBQRI. ACPI
> RQSC support is implemented as a set of additional patches [7]. All of
> the QEMU patches are available as a branch [8].
>
> [1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> [2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> [3] https://docs.kernel.org/filesystems/resctrl.html
> [4] https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log=
/?h=3Db4/ssqosid-cbqri-rqsc
> [6] https://lore.kernel.org/qemu-devel/20260105-riscv-ssqosid-cbqri-v4-0-=
9ad7671dde78@kernel.org/
> [7] https://lore.kernel.org/qemu-devel/20260202-riscv-rqsc-v1-0-dcf448a3e=
d73@kernel.org/
> [8] https://github.com/tt-fustini/qemu/tree/b4/riscv-rqsc
>
> Series organization
> -------------------
>  01:    DT binding for Ssqosid extension
>  02-03: Ssqosid ISA support (detection, srmcfg CSR and switch_to)
>  04-07: CBQRI resctrl (hw interface, arch callbacks, domain
>         management, Kconfig/build wiring)
>  08-11: ACPI support (PPTT helper, actbl2.h RQSC structs [DO NOT
>         MERGE], RQSC parser, controller initialization)
>
> RISC-V QoS
> ----------
> QoS (Quality of Service) in this context is concerned with shared
> resources on an SoC such as cache capacity and memory bandwidth.
>
> The Ssqosid extension defines the srmcfg CSR which configures a hart
> with two identifiers:
>
>  - Resource Control ID (RCID)
>  - Monitoring Counter ID (MCID)
>
> These identifiers accompany each request issued by the hart to shared
> resource controllers. This allows the capacity and bandwidth resources
> used by a software workload (e.g. a process or a set of processes) to be
> controlled and monitored.
>
> CBQRI defines operations to configure resource usage limits, in the form
> of capacity or bandwidth, for an RCID. CBQRI also defines operations to
> configure counters to track resource utilization per MCID. Furthermore,
> the Access Type (AT) field allows resource usage to be differentiated
> between data and code.
>
> x86 comparison
> --------------
> The existing QoS identifiers on x86 map well to RISC-V:
>
>   CLOSID (Class of Service ID) on x86 is RCID on RISC-V
>     RMID (Resource Monitoring ID) on x86 is MCID on RISC-V
>
> In addition, CDP (code data prioritization) on x86 is similar to the
> AT (access type) field in CBQRI which defines code and data types.
>
> One aspect of CBQRI that simplifies the RISC-V resctrl interface is that
> any CPU (technically a hart, or hardware thread, in RISC-V terminology)
> can access the memory-mapped registers of any CBQRI controller in the
> system. This means it does not matter which CPU runs the resctrl code.
>
> Example SoC
> -----------
> This series was developed and tested using the QEMU virt platform
> configured as a hypothetical SoC with a cache controller that implements
> CBQRI capacity operations and a memory controller that implements CBQRI
> bandwidth operations.
>
>   - L2 cache controllers
>     - Resource type: Capacity
>     - Number of capacity blocks (NCBLKS): 12
>         - In the context of a set-associative cache, the number of
>           capacity blocks can be thought of as the number of ways
>     - Number of access types: 2 (code and data)
>     - Usage monitoring not supported
>     - Capacity allocation operations: CONFIG_LIMIT, READ_LIMIT
>
>   - Last-level cache (LLC) controller
>     - Resource type: Capacity
>     - Number of capacity blocks (NCBLKS): 16
>     - Number of access types: 2 (code and data)
>     - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>     - Event IDs supported: None, Occupancy
>     - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID
>
>   - Memory controllers
>     - Resource type: Bandwidth
>     - Number of bandwidth blocks (NBWBLKS): 1024
>        - Bandwidth blocks do not have a unit but instead represent a
>          portion of the total bandwidth resource. For NBWBLKS of 1024,
>          each block represents about 0.1% of the bandwidth resource.
>     - Maximum reserved bandwidth blocks (MRBWB): 819 (80% of NBWBLKS)
>     - Number of access types: 1 (no code/data differentiation)
>     - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>     - Event IDs supported: None, Total read/write byte count, Total
>                            read byte count, Total write byte count
>     - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
>
> The memory map for this example SoC:
>
>   Base addr  Size
>   0x4820000  4KB  Cluster 0 L2 cache controller
>   0x4821000  4KB  Cluster 1 L2 cache controller
>   0x4828000  4KB  Memory controller 0
>   0x4829000  4KB  Memory controller 1
>   0x482a000  4KB  Memory controller 2
>   0x482b000  4KB  Shared LLC cache controller
>
> This configuration is only meant to provide a "concrete" example, and it
> represents just one of many possible ways that hardware can implement
> the CBQRI spec.
>
> The example SoC configuration is created with the following:
>
>   qemu-system-riscv64 \
>         -M virt,pflash0=3Dpflash0,pflash1=3Dpflash1,aia=3Daplic-imsic  \
>         -smp cpus=3D8,sockets=3D1,clusters=3D2,cores=3D4,threads=3D1 \
>         -m 1G \
>         -nographic \
>         -kernel ${LINUX}/arch/riscv/boot/Image \
>         -append "root=3D/dev/vda rootwait" \
>         -blockdev node-name=3Dpflash0,driver=3Dfile,read-only=3Don,filena=
me=3D${EDK}/RISCV_VIRT_CODE.fd \
>         -blockdev node-name=3Dpflash1,driver=3Dfile,filename=3D${EDK}/RIS=
CV_VIRT_VARS.fd \
>         -drive if=3Dnone,file=3D${ROOTFS}/rootfs.ext2,format=3Draw,id=3Dh=
d0 \
>         -device virtio-blk-device,drive=3Dhd0 \
>         -device qemu-xhci \
>         -device usb-kbd \
>         -device virtio-net-pci,netdev=3Dnet0 \
>         -netdev user,id=3Dnet0 \
>         -device riscv.cbqri.capacity,max_mcids=3D256,max_rcids=3D64,ncblk=
s=3D12,alloc_op_flush_rcid=3Dfalse,mon_op_config_event=3Dfalse,mon_op_read_=
counter=3Dfalse,mon_evt_id_none=3Dfalse,mon_evt_id_occupancy=3Dfalse,mmio_b=
ase=3D0x04820000 \
>         -device riscv.cbqri.capacity,max_mcids=3D256,max_rcids=3D64,ncblk=
s=3D12,alloc_op_flush_rcid=3Dfalse,mon_op_config_event=3Dfalse,mon_op_read_=
counter=3Dfalse,mon_evt_id_none=3Dfalse,mon_evt_id_occupancy=3Dfalse,mmio_b=
ase=3D0x04821000 \
>         -device riscv.cbqri.capacity,max_mcids=3D256,max_rcids=3D64,ncblk=
s=3D16,mmio_base=3D0x0482B000 \
>         -device riscv.cbqri.bandwidth,max_mcids=3D256,max_rcids=3D64,nbwb=
lks=3D1024,mrbwb=3D819,mmio_base=3D0x04828000 \
>         -device riscv.cbqri.bandwidth,max_mcids=3D256,max_rcids=3D64,nbwb=
lks=3D1024,mrbwb=3D819,mmio_base=3D0x04829000 \
>         -device riscv.cbqri.bandwidth,max_mcids=3D256,max_rcids=3D64,nbwb=
lks=3D1024,mrbwb=3D819,mmio_base=3D0x0482a000
>
> Open issues:
> ------------
>  - RQSC structs in actbl2.h must go through ACPICA upstream first. The
>    spec is in the final phase before ratification.
>
>  - No L2 and L3 cache occupancy monitoring
>    - This is not currently implemented and I have decided to leave
>      it for a followup series.
>
>  - No MBM (bandwidth monitoring)
>    - MBA schema works ok for the CBQRI-enabled memory controllers, but
>      resctrl does not currently have a solution for representing MBM for
>      bandwidth resources that are not associated with a L3 cache.
>    - For the old CBQRI proof-of-concept RFC, two separate domains were
>      created for each memory controller: one for MB (allocation) and one
>      for MBM (monitoring). The monitoring domains had to pretend that
>      these memory controllers were L3 caches which is not the case. I
>      have removed this as it was too complicated and not the right
>      solution.
>
> Changelog
> ---------
> Changes in v3:

Thanks for posting the series. Once the remaining issues are
addressed, are you considering moving this out of RFC in the next
revision?


>  Series restructuring:
>  - Restructure from 17 to 11 patches: introduce data structures
>    alongside their first users, consolidate build wiring into a
>    single "enable resctrl" commit
>  - Split the monolithic patch 08/17 into separate patches for HW
>    interface, arch callbacks, domain management, and Kconfig wiring
>  - Do not expose monitoring to resctrl; allocation only for now.
>    A separate followup series will add cache occupancy monitoring.
>    Bandwidth monitoring will have to wait for the larger issue of non-L3
>    bandwidth to be resolved first.
>
>  Bug fixes from v2 review:
>  - Fix cbqri_apply_bw_config() and resctrl_arch_get_config() using
>    capacity operation constants instead of bandwidth
>  - Fix missing err =3D -ENOMEM after ioremap() failure
>  - Fix ver_major not shifted after masking with GENMASK(7, 4)
>  - Fix ctrl->mcid_count =3D node->rcid in RQSC parser
>
>  Improvements from v2 review:
>  - Implement resctrl_arch_set_cpu_default_closid_rmid() (was no-op),
>    use per-cpu cpu_srmcfg_default for resctrl allocation rule 2
>  - Remove hw_dom->ctrl_val[] cache, read/write CBQRI registers directly
>  - Drop resctrl_arch_find_domain(), use resctrl_find_domain() directly
>  - Use sorted domain insertion via resctrl_find_domain()
>  - Set domain id from cache_id (capacity) or prox_dom (bandwidth)
>  - Define RISCV_RESCTRL_EMPTY_CLOSID instead of referencing x86 constant
>  - Find minimum mcid_count across controllers for max_rmid
>  - Convert SHIFT/MASK pairs to GENMASK() and FIELD_GET()/FIELD_PREP()
>  - Use acpi_pptt_get_cpumask_from_cache_id() instead of hardcoding
>  - Remove fixed-size f[6] array in RQSC; parse with ACPI_ADD_PTR and
>    flexible array for resource descriptors
>
>  Error handling and robustness:
>  - Implement resctrl_arch_reset_all_ctrls() to reset all CLOSID
>    allocations to defaults on unmount, including CDP code/data entries
>  - Capture resctrl_init() return and cleanup on failure
>  - Call resctrl_exit() on cpuhp_setup_state() failure
>  - Call resctrl_offline_ctrl_domain() before freeing in error path
>  - Check resctrl_find_domain() return to reject duplicate domain ids
>  - Validate nbwblks!=3D0 during probe; bounds-check RQSC res[0] access
>  - Skip controllers with bad cpumask instead of adding with empty mask
>  - Validate resource capabilities match across controllers at same
>    cache level
>
>  Bandwidth allocation:
>  - Derive max_bw from hardware MRBWB/NBWBLKS with DIV_ROUND_UP()
>  - Clamp rbwb to mrbwb so write/readback round-trips exactly
>  - Copy cpu_mask for bandwidth domains from proximity domain NUMA node
>
>  Hardware interface:
>  - Return final register from cbqri_wait_busy_flag() to eliminate
>    redundant MMIO reads after busy-wait
>  - Add per-controller spinlock for MMIO register sequence serialization
>  - Use readq_poll_timeout_atomic() instead of hand-rolled jiffies loop
>  - Move max_rmid update after successful controller probe
>
>  Cleanup:
>  - Add lockdep_assert_cpus_held() in resctrl_arch_update_domains()
>    and resctrl_arch_reset_all_ctrls()
>  - Mark acpi_parse_rqsc() __init
>  - Convert __switch_to_srmcfg() stub from macro to static inline to
>    make both checkpatch and clang happy
>  - Use pr_debug for per-controller details, pr_warn for non-fatal skips
>  - Remove unused arch stubs and dead code
>  - Use GENMASK_ULL for bits>=3D32, io-64-nonatomic-lo-hi.h for rv32
>
>  Link to v2: https://lore.kernel.org/r/20260128-ssqosid-cbqri-v2-0-dca586=
b091b9@kernel.org
>
> Changes in v2:
>  - Add support for ACPI RQSC table which provides the details needed to
>    discover the CBQRI controllers and support resctrl
>  - Drop the "not for upstream" platform drivers and QEMU dts patches.
>    Those can be found in v1 and were only for the RFC series. The
>    branch for the v1 series is preserved as ssqosid-cbqri-rfc-v1
>  - Change cbqri_wait_busy_flag() from 100 ms to 1 ms to avoid
>    unnecessary latency.
>  - Change resctrl_arch_get_config() to return resctrl_get_default_ctrl()
>    instead of a negative errno value which is not valid for u32.
>  - Change cbqri_probe_controller() to return -EBUSY when
>    request_mem_region() fails
>  - Change resctrl_arch_get_config() to no longer increment when rbwb
>    modulo ctrl->bc.nbwblks is true
>  - Fix indentation in cbqri_set_cbm(), cbqri_set_rbwb() and
>    cbqri_get_rbwb().
>  - Link to v1: https://lore.kernel.org/r/20260119-ssqosid-cbqri-v1-0-aa2a=
75153832@kernel.org
>
> ---
> Drew Fustini (11):
>       dt-bindings: riscv: Add Ssqosid extension description
>       RISC-V: Detect the Ssqosid extension
>       RISC-V: Add support for srmcfg CSR from Ssqosid extension
>       RISC-V: QoS: add CBQRI hardware interface
>       RISC-V: QoS: add resctrl arch callbacks for CBQRI controllers
>       RISC-V: QoS: add resctrl setup and domain management
>       RISC-V: QoS: enable resctrl support for Ssqosid
>       ACPI: PPTT: Add acpi_pptt_get_cache_size_from_id helper
>       DO NOT MERGE: include: acpi: actbl2: Add structs for RQSC table
>       ACPI: RISC-V: Parse RISC-V Quality of Service Controller (RQSC) tab=
le
>       ACPI: RISC-V: Add support for RISC-V Quality of Service Controller =
(RQSC)
>
>  .../devicetree/bindings/riscv/extensions.yaml      |    6 +
>  MAINTAINERS                                        |   11 +
>  arch/riscv/Kconfig                                 |   20 +
>  arch/riscv/include/asm/acpi.h                      |   10 +
>  arch/riscv/include/asm/csr.h                       |    6 +
>  arch/riscv/include/asm/hwcap.h                     |    1 +
>  arch/riscv/include/asm/processor.h                 |    3 +
>  arch/riscv/include/asm/qos.h                       |   52 +
>  arch/riscv/include/asm/resctrl.h                   |    7 +
>  arch/riscv/include/asm/switch_to.h                 |    3 +
>  arch/riscv/kernel/Makefile                         |    2 +
>  arch/riscv/kernel/cpufeature.c                     |    1 +
>  arch/riscv/kernel/qos/Makefile                     |    2 +
>  arch/riscv/kernel/qos/internal.h                   |   81 ++
>  arch/riscv/kernel/qos/qos.c                        |   40 +
>  arch/riscv/kernel/qos/qos_resctrl.c                | 1092 ++++++++++++++=
++++++
>  drivers/acpi/pptt.c                                |   63 ++
>  drivers/acpi/riscv/Makefile                        |    1 +
>  drivers/acpi/riscv/init.c                          |   23 +
>  drivers/acpi/riscv/rqsc.c                          |  136 +++
>  include/acpi/actbl2.h                              |   36 +
>  include/linux/acpi.h                               |    8 +
>  include/linux/riscv_qos.h                          |  109 ++
>  23 files changed, 1713 insertions(+)
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20260329-ssqosid-cbqri-rqsc-v7-0-b0c788bab48a
>
> Best regards,
> --
> Drew Fustini <fustini@kernel.org>
>

Thanks,
Yunhui
