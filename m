Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8EB37106E;
	Tue,  4 Aug 2026 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846541; cv=none; b=qTbXGDCQWkF8ZiAsetr20LyGpyFFJZPRAo8oswhJ7k1j7nzkaxeiZZ57cGfpCRdNqmvTtM2r/23GkU8a9+hzonfC0Ug98QrseY8ejksEH4C6IM8cmVR9biRW2I8YU21z4Iyqlb9978jwb33cQg3Ny9d4d4mLsi/1s2g8iJFdQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846541; c=relaxed/simple;
	bh=RFjijuGBOfqMDDD06CRgUBWpe4Bi46Y+B4+xD23nhZM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MhAVWbOa+4Ed/vkmS2h20KSgkpnaYJ3S+qJwI1/RZ+7DDpVpYVyCIPya8yRCc2RESC6Umqz6uC2aZRarvVky5ks6pqQkxsrXTauKmFUUWtq38m3sZ9elvs21FXEQl7dgmC8H6QpVYESX2EO/g153mAnH/cX26gjZQ4vniptFRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EYcTj3Xh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EYcTj3Xh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18DA81476;
	Tue,  4 Aug 2026 05:28:55 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB89E3F66F;
	Tue,  4 Aug 2026 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785846539; bh=RFjijuGBOfqMDDD06CRgUBWpe4Bi46Y+B4+xD23nhZM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=EYcTj3XhGIKB/rY/kPSKyDdeqJjrUdGNBeB1eb8Dtwot7YUI0czWtmGoBkIfNM0+S
	 NZ+gUxCl4S2HRLrFOpVjkyKkRjBcPqq9le59PGCQxbK+zyjryNBedfGKPqBk9KIIzQ
	 azaTX6ZIdJRo+S8Jv7rUAbcoVD+roLjHyCmPt3hA=
Message-ID: <5d7433ff-f6e4-42cc-bc8a-08179b3d136b@arm.com>
Date: Tue, 4 Aug 2026 14:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/11] arm_mpam: Add MPAM-Fb firmware support
From: Andre Przywara <andre.przywara@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
 Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260804100627.3217149-1-andre.przywara@arm.com>
Content-Language: en-GB
In-Reply-To: <20260804100627.3217149-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/4/26 12:06, Andre Przywara wrote:
> this is v8 of the MPAM-Fb code, for firmware based MSC accesses.
> It fixes a potential use-after-free of the dev pointer on error
> prints, and disables the IRQ on the irqchip side in case doing it on
> the device side doesn't work. The rest are cosmetic fixes and adding
> the tags from the diligent reviewers and testers, many thanks for that!
> I dropped tags from the error IRQ patch (10/11) due to changes.
> Find the changelog below. Based on v7.2-rc1.
> 
> =======================
> The Arm MPAM specification defines Memory System Components (MSCs),
> which are devices that are programmed through an MMIO register frame. In
> some occasions this turned out to be too limiting: the MSC might be
> located behind a separate bus system (for instance inside an on-board
> controller), it might be mapped secure-only, or in a different processor
> socket without direct MMIO mapping. Also the MMIO access might be too slow
> or it would need to be filtered or otherwise access controlled. Finally
> there might be bugs in the MSC integration, which require a mediating
> firmware to be accessible.


For the records, I looked at the sashiko complaints, by my analysis most 
comments fall into one of those categories:

- Does this new early return / error return .... break MPAM logic?
It's concerned about just bailing out from the middle of a sequence of 
MPAM read or writes, leaving the MSC in a misconfigured state. This is 
true, but doesn't apply, because we tear down MPAM completely upon an 
MPAM-Fb access returning an error. And if the communication between the 
kernel and an MSC breaks down completely, there isn't much we can do 
anyway: attempts to recover would fail as well.

- Since xxx() now returns an error code, do the callers need
   to be updated to check it?
- Are there missing error checks in xxx() related to the new error
   return values?
Yes, this is done in one of the following patches. The series is 
constructed so that only the final patch enables MPAM-Fb, before that 
there is no way MPAM-Fb could be instantiated, so only MMIO accesses are 
happening. They always return 0, so no error could occur and error paths 
are never exercised.
This is used to construct the functionality gradually, and allow 
multiple, but smaller patches. Mentioned in the cover letter.

- This is a pre-existing issue, but ....
I haven't checked in detail, but from previous rounds those concerns 
were addressed by Ben's fixes, which IIUC are on its way already. This 
series is based on v7.2-rc1, so those fixes are not applied here.

Hope that helps,
Cheers,
Andre

> To accommodate all those different use cases, the MPAM-Fb specification
> [1] describes an alternative way to access MSCs. Accesses to an MSC
> would be wrapped in a message and communicated to the system using a
> shared-memory/mailbox system mostly mimicking the Arm SCMI spec.
> For ACPI systems, this would be abstracted through an ACPI PCC channel,
> which provides the shared-memory region and the mailbox trigger. We can
> lean on existing ACPI parsing code to register with these two
> subsystems, but cannot rely on the existing SCMI code in the kernel.
> This means we somewhat need to open code a very simplified SCMI handler,
> which just provides enough functionality for the very basic subset of
> SCMI that the MPAM-Fb spec requires.
> 
> The first seven patches rework all MSC access wrappers to propagate error
> information. Pure MMIO based MSC accesses would never fail, but the
> MPAM-Fb access can go wrong in multiple ways. The patches have been split
> up purely for reviewing reasons, if the number is a problem, we could as
> well squash them. Please note that until the very last patch of this series
> any MSC accesses would always only return 0, it's only the final enablement
> of MPAM-Fb that could possibly introduce errors. Hence all former patches
> can add error handling gradually, those code paths wouldn't be triggered
> before patch 11/11.
> Patch 8/11 solves a nasty problem: At the moment we protect stateful MSC
> register accesses (mon_sel) through a spinlock. Unfortunately the mailbox
> subsystem and the slow nature of the communication through this channel
> forbid MPAM-Fb access in atomic context. So this patch keeps using a
> spinlock for MMIO based accesses, but reverts to a mutex otherwise.
> We just deny taking the lock for MPAM-Fb in atomic context, ideally we
> wouldn't need that (no need to IPI another core when the MSC access does
> not need to be local to one particular core), or we simply deny that part
> of the functionality (access through perf).
> Patch 9/11 adds the code to redirect MSC accesses through the
> PCC shmem/mailbox system.
> Patch 10/11 reworks the error interrupt handler to use a threaded IRQ for
> MPAM-Fb, to be able to do MPAM-Fb MSC accesses inside (which might sleep).
> The final patch 11/11 then adds the code to detect and store the PCC
> channel information from the ACPI tables, and eventually enables
> MPAM-Fb accesses.
> 
> This would enable systems where some MSCs are not accessible via MMIO to
> use those components anyway.
> 
> Please have a look and test!
> 
> Cheers,
> Andre
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Changes in v8:
> - disable error IRQ on irqchip level when device side fails
> - use MSC dev pointer for dev_err() instead of mailbox one
> - smaller white space and formatting fixes
> - reorder MPAM-Fb definitions
> - rename error translation function to mpam_fb_to_linux_errno()
> - add review and test tags
> 
> Changes in v7:
> - add tags
> - add new patch to propagate errors in mpam_reprogram_ris_partid()
> - prevent loop when mpam_diable() tries MSC accesses again
> - register MMIO error IRQ handler without IRQF_ONESHOT
> - re-use existing "err" variable instead of declaring "ret"
> - initialise mon_sel_lock later, to wait for interface decision
> - convert timeout units for nominal latency, between us and ms
>   
> Changes in v6:
> - keep using hard IRQ handler for MMIO based accesses
> - move shmem buffer size and MPAM-Fb version check into mpam_fb.c
> - drop mutex guard in mpam_fb_send_request(), we use gotos anyway
> - factor out MPAM-Fb protocol error translation
> - add MPAM_FB_ERR_BUSY error code to translation
> - explicitly report also MPAM-Fb protocol error number when disabling MPAM
> - remove unneeded MPAM-Fb details from mpam_internal.h
> - drop leftover mpam_fb_msc_id usage
> 
> Changes in v5:
> - do not initialise _high variables early
> - fix whitespace issues
> - add Jonathan's Reviewed-by: tags
> - init only either the spinlock OR the mutex for the mon_sel_lock
> - drop warning about mapped_hwpage_sz for MPAM-Fb in mpam_msc_zero_mbwu_l()
> - change IRQ handler to threaded handler, to allow MPAM-Fb MSC accesses
> - disallow per-CPU IRQs (PPIs) for MPAM-Fb
> - trigger MPAM disabling on MPAM-Fb protocol errors
> - fix MPAM_PROTOCOL_VERSION_CMD name
> - use PCC driver defined symbol for PCC_CHAN_FLAGS_IRQ
> - add comment about usage of PCC's .signature field
> - check for illegal MPAM-Fb command before sending request
> - drop CPU accessibility check for MPAM-Fb based MSC accesses
> - move MPAM-Fb protocol message structs inside build functions
> - add comment about largest message size
> - drop extra msc->mpam_fb_msc_id, in favour using pdev->id
> - use already defined local dev variable instead of &pdev->dev
> - use FIELD_GET() macro for MPAM-Fb protocol check
> - drop devm_mutex_init() for pcc_chan_lock
> 
> Changes in v4:
> - unify error check patterns
> - use scoped_guard(mutex) and ACQUIRE to simplify error handling
> - use struct kref for PCC channel refcount
> - drop unused mailbox rx_callback function
> - increase size of props[] array to hold new msc_id property
> - set mailbox TX timeout based on ACPI MPAM table field
> - use devm_mutex_init() to allow automatic cleanup
> - avoid overwriting error value for arm,not-ready-us property read
> - prune MPAM-Fb protocol token to fit into bitmask inside register
> - check return value for AIDR read
> - use two separate MPAM-Fb protocol payload structs
> - prune header list for mpam_fb.c
> - drop "nrdy handled as an error" change
> - fix message size field in MPAM-Fb protocol shmem area
> - drop message size return from MPAM-Fb message build functions
> - bring back IRQ flag in MPAM-Fb protocol header
> 
> Changes in v3:
> - drop inner/outer mon_sel lock patch, replace with simpler version
> - harmonise code patterns in error propagation changes
> - drop mon_sel lock before erroring out in mpam_ris_hw_probe_csu_nrdy()
> - refactor mpam_msc_read_mbwu_l() to return an error
> - drop special NRDY handling in __ris_msmon_read()
> - add IRQ numbers in error interrupt handler to help pinpoint failure
> - refactor MPAM-Fb message generation to accommodate more than read/write
> - check MPAM-Fb protocol version at probe time
> - drop mpam_fb.h header, merge into mpam_internal.h
> - translate MPAM-Fb error code in Linux codes where needed
> - clear IRQ flag bit in MPAM-Fb protocol header
> - drop unneeded endianness conversions when crafting MPAM-Fb message
> - use C struct to model MPAM-Fb message payload
> 
> Changes in v2:
> - add patches to add error propagation to MSC access wrappers
> - drop former patch 1/5 (not needed)
> - drop lock in mpam_reprogram_msc(), to avoid double lock
> - add support for multiple MSCs per PCC channel
> - adjust SCMI protocol code to use a PCC subtype 3 channel
> - let PCC code handle the PCC channel negotiation (due to subtype 3)
> - drop SCMI names in shmem offsets, and use existing PCC type 3 struct
> - adjust shmem field offsets to match MPAM-Fb spec, not pure SCMI
> - prevent MPAM-Fb calls inside atomic smp_call_function_any() payload
> - skip all MSC accesses inside the IRQ handler when using MPAM-Fb
> 
> Andre Przywara (11):
>    arm_mpam: let low level MSC accessors return an error
>    arm_mpam: propagate MSC access errors for hw_probe functions
>    arm_mpam: propagate MSC access errors for MBWU counters
>    arm_mpam: propagate MSC access errors for msmon helpers
>    arm_mpam: propagate MSC access errors for __ris_msmon_read()
>    arm_mpam: propagate MSC access errors for state saving function
>    arm_mpam: propagate MSC access errors for mpam_reprogram_ris_partid()
>    arm_mpam: prepare mon_sel locking for MPAM-Fb
>    arm_mpam: add MPAM-Fb MSC firmware access support
>    arm_mpam: change MPAM-Fb error IRQ to use a threaded IRQ handler
>    arm_mpam: detect and enable MPAM-Fb PCC support
> 
>   drivers/resctrl/Makefile        |   2 +-
>   drivers/resctrl/mpam_devices.c  | 825 ++++++++++++++++++++++++--------
>   drivers/resctrl/mpam_fb.c       | 252 ++++++++++
>   drivers/resctrl/mpam_internal.h |  62 ++-
>   include/linux/arm_mpam.h        |   2 +-
>   5 files changed, 926 insertions(+), 217 deletions(-)
>   create mode 100644 drivers/resctrl/mpam_fb.c
> 
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

