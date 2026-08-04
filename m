Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFE5308F32;
	Tue,  4 Aug 2026 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833417; cv=none; b=tZwB1wcaHpBO91p/0bCGPiLdshQkXPrd9eFqtkj9/KxTq4pMP2fWRwWBHh46wMiC3/CUm7kFghOj74UZsl51wf2QPJ0K8MV0MxebT1lXJwYKTY/LPYHxvVNMVy9ikPdkpGtZ5b/wPBWiSG29lAWA/rAymdOf4hfVR+C935VRwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833417; c=relaxed/simple;
	bh=VcHnWDriYeddWLcOQ0hYalcfh87LwCkbuu62RlcfYbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioRvXf1o6gQq5XwGyS2SdO0D1qdO47mkLmwHC0rl5z17eR7COmILYlxODoJwCc9wNIR6BJiQ+cgAnkWePXXf4sdsVgNqk9uEXcLM2+tc3W3Lw7crWqBmqSaG6W+FTtgpqb5lJRJKtIoLkHn2d8u3nIuMZmMjLPL8u4/WcfPN9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PWSJKcRC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PWSJKcRC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A62681476;
	Tue,  4 Aug 2026 01:50:09 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CA673F66F;
	Tue,  4 Aug 2026 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785833413; bh=VcHnWDriYeddWLcOQ0hYalcfh87LwCkbuu62RlcfYbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWSJKcRCSX0elqSMxsjddTtGmAlvRcixtZ+JoG8sAF8m4eo/I4WLI+/QMrmrJWn9W
	 PrZAyfr4fSVkhWtfWwnZvn95f3c70KdoIj55O9P/imylHXiZsdPMV0nLcq9uxF5INK
	 TdnSmi0AS3VCS4dwVExE3dLgoO4bmM3Vga/PN3/o=
Message-ID: <afb75484-2739-4b75-a164-dd90433c7179@arm.com>
Date: Tue, 4 Aug 2026 10:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] arm_mpam: Add MPAM-Fb firmware support
To: Gavin Shan <gshan@redhat.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <6f8bc358-91a0-4c44-9110-c071e10df385@redhat.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <6f8bc358-91a0-4c44-9110-c071e10df385@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gavin,

many thanks for the review and the testing!

...

On 8/4/26 05:29, Gavin Shan wrote:
> On 8/1/26 3:03 AM, Andre Przywara wrote:
>> v7 is another quick respin of the MPAM-Fb code, for firmware based MSC
>> accesses. This propagates MSC access errors in a function where it was
>> missing before, covering more functions that pass their return value
>> to userspace (new patch 07/11). Also some bug fixes, formatting
>> adjustments and adding the accumulated tags - many thanks to the
>> reviewers. Find the changelog below. Based on v7.2-rc1.
>>
>> =======================
>> The Arm MPAM specification defines Memory System Components (MSCs),
>> which are devices that are programmed through an MMIO register frame. In
>> some occasions this turned out to be too limiting: the MSC might be
>> located behind a separate bus system (for instance inside an on-board
>> controller), it might be mapped secure-only, or in a different processor
>> socket without direct MMIO mapping. Also the MMIO access might be too 
>> slow
>> or it would need to be filtered or otherwise access controlled. Finally
>> there might be bugs in the MSC integration, which require a mediating
>> firmware to be accessible.
>>
>> To accommodate all those different use cases, the MPAM-Fb specification
>> [1] describes an alternative way to access MSCs. Accesses to an MSC
>> would be wrapped in a message and communicated to the system using a
>> shared-memory/mailbox system mostly mimicking the Arm SCMI spec.
>> For ACPI systems, this would be abstracted through an ACPI PCC channel,
>> which provides the shared-memory region and the mailbox trigger. We can
>> lean on existing ACPI parsing code to register with these two
>> subsystems, but cannot rely on the existing SCMI code in the kernel.
>> This means we somewhat need to open code a very simplified SCMI handler,
>> which just provides enough functionality for the very basic subset of
>> SCMI that the MPAM-Fb spec requires.
>>
>> The first seven patches rework all MSC access wrappers to propagate error
>> information. Pure MMIO based MSC accesses would never fail, but the
>> MPAM-Fb access can go wrong in multiple ways. The patches have been split
>> up purely for reviewing reasons, if the number is a problem, we could as
>> well squash them. Please note that until the very last patch of this 
>> series
>> any MSC accesses would always only return 0, it's only the final 
>> enablement
>> of MPAM-Fb that could possibly introduce errors. Hence all former patches
>> can add error handling gradually, those code paths wouldn't be triggered
>> before patch 11/11.
>> Patch 8/11 solves a nasty problem: At the moment we protect stateful MSC
>> register accesses (mon_sel) through a spinlock. Unfortunately the mailbox
>> subsystem and the slow nature of the communication through this channel
>> forbid MPAM-Fb access in atomic context. So this patch keeps using a
>> spinlock for MMIO based accesses, but reverts to a mutex otherwise.
>> We just deny taking the lock for MPAM-Fb in atomic context, ideally we
>> wouldn't need that (no need to IPI another core when the MSC access does
>> not need to be local to one particular core), or we simply deny that part
>> of the functionality (access through perf).
>> Patch 9/11 adds the code to redirect MSC accesses through the
>> PCC shmem/mailbox system.
>> Patch 10/11 reworks the error interrupt handler to use a threaded IRQ for
>> MPAM-Fb, to be able to do MPAM-Fb MSC accesses inside (which might 
>> sleep).
>> The final patch 11/11 then adds the code to detect and store the PCC
>> channel information from the ACPI tables, and eventually enables
>> MPAM-Fb accesses.
>>
>> This would enable systems where some MSCs are not accessible via MMIO to
>> use those components anyway.
>>
>> Please have a look and test!
>>
>> Cheers,
>> Andre
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Changes in v7:
>> - add tags
>> - add new patch to propagate errors in mpam_reprogram_ris_partid()
>> - prevent loop when mpam_diable() tries MSC accesses again
>> - register MMIO error IRQ handler without IRQF_ONESHOT
>> - re-use existing "err" variable instead of declaring "ret"
>> - initialise mon_sel_lock later, to wait for interface decision
>> - convert timeout units for nominal latency, between us and ms
> 
> [...]
> 
>>
>> Andre Przywara (11):
>>    arm_mpam: let low level MSC accessors return an error
>>    arm_mpam: propagate MSC access errors for hw_probe functions
>>    arm_mpam: propagate MSC access errors for MBWU counters
>>    arm_mpam: propagate MSC access errors for msmon helpers
>>    arm_mpam: propagate MSC access errors for __ris_msmon_read()
>>    arm_mpam: propagate MSC access errors for state saving function
>>    arm_mpam: propagate MSC access errors for mpam_reprogram_ris_partid()
>>    arm_mpam: prepare mon_sel locking for MPAM-Fb
>>    arm_mpam: add MPAM-Fb MSC firmware access support
>>    arm_mpam: change MPAM-Fb error IRQ to use a threaded IRQ handler
>>    arm_mpam: detect and enable MPAM-Fb PCC support
>>
>>   drivers/resctrl/Makefile        |   2 +-
>>   drivers/resctrl/mpam_devices.c  | 820 +++++++++++++++++++++++---------
>>   drivers/resctrl/mpam_fb.c       | 250 ++++++++++
>>   drivers/resctrl/mpam_internal.h |  62 ++-
>>   include/linux/arm_mpam.h        |   2 +-
>>   5 files changed, 915 insertions(+), 221 deletions(-)
>>   create mode 100644 drivers/resctrl/mpam_fb.c
>>
> 
> With this series (manually) applied to v7.2.rc6, the tests for the 
> existing functions
> like kunit-tests, L3 cache partitioning, MBW (soft) limiting, 
> llc_occupancy monitor
> look fine on NVidia's grace-hopper machine.

Awesome, many thanks for doing that!

> Tested-by: Gavin Shan <gshan@redhat.com>

I'd assume this is a regression test, as your machine uses the standard 
MMIO interface?
If you don't mind, I'd put this tag on the first refactoring patches, so 
01/11 - 08/11, and leave out the remaining 3, as they are about MPAM-Fb, 
which wasn't really tested, I guess? Also patch 10/11 (the error IRQ 
changes) changed, so I would drop all tags from this anyway.

Cheers,
Andre

