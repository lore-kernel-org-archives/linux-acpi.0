Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241C429CF2
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833816; cv=none; b=Ml4R+nnMa8ibaPs1E3dGPW9gx7dtTdCcVA1ulZHIWhTzzigHXz6zTU111hw2mJp4doHubsPu9eSmkEYM0ElDiTJZ4JOF+fyQDu7H+c11aBWNUTExF1Xsfnn1bMBJDI+jjQWESYnweWy5l2z//WEKHoMYgdDhCD+ZayNrhOavRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833816; c=relaxed/simple;
	bh=h6wQ/gBgYU8sEnHG7gKIOXfVVIysv10bJ53XQ7jVs+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdWO6V0iEXC8/2g8ePZl79IMFVjYMNLPtSSq5oEpzxYb72dDcYTo9VWhqOMC7hB0QzAnrlpKxuSps45mbujEMy257rrCEsxA1Qtpu24w8WwOoGFqISzsqlt89FcGwm3G+nJwWMYS40pNVT+WERSOoybTjXpqr1K1xBoNwW4nvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQD1prZ0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qa+FYKMs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQD1prZ0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qa+FYKMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785833812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHMZ+hX0V0vr0a9Nft0AKjYbaEjQK6WSHNPIE5IxYn0=;
	b=aQD1prZ0/iwJo1Rx0E/nCx0O1b+TuXXTw5Y8yVtLOUIpkvjSQo0xdV7C+VO+YBWVqYTDaO
	/ZV9K7+DQmKdhQZVnyeOsxwGkssW6dNkeGvhiQPA11rQz5Qi+9I4JPnDzgdCumzZ4JFqrC
	dL6QZ5eNt+yiZ9LURWkIj7VMKwsvEIc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-XCNK7NXqNZ-TDT19B7__Ow-1; Tue, 04 Aug 2026 04:56:51 -0400
X-MC-Unique: XCNK7NXqNZ-TDT19B7__Ow-1
X-Mimecast-MFC-AGG-ID: XCNK7NXqNZ-TDT19B7__Ow_1785833811
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfc52ddc55so58447255ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 04 Aug 2026 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785833810; x=1786438610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHMZ+hX0V0vr0a9Nft0AKjYbaEjQK6WSHNPIE5IxYn0=;
        b=qa+FYKMs94Wz7+hHqk/fs7+A/V4aOA/BLKLnK12ZMXvgNYOz+dL+yW0FQmRZuOkGSl
         pNKkcmNrOYHqNfx56VxEBZxSvMwZ5sy1/CyC47ar364fCIPlVnLJi8R3RzgUVxdksQJo
         eFM+oLo0BtUUXRkB+sCiY7rGZgxJH5v9oFUI0Wnl2VOWOtY8zP+bpmezrOMOjRMkwZmF
         /oWKq01ZRZUptJUH+TQi+WYu2oF93QwwK1D7OVR+uIbkbC3WXAJS5LPHBNfoyHrwK7DV
         Z4/cvKXTRQqSz7RjbWwSRfnDA5cRz4z2pQXTbTlFPXLiTCF466HINmCglxbnLjYFfBjh
         9N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833810; x=1786438610;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHMZ+hX0V0vr0a9Nft0AKjYbaEjQK6WSHNPIE5IxYn0=;
        b=lQOIZvUumEOWetvQv9B1tk84/56MzbFyr5zI1/dYXVJNpU0Pe25cVwumY6IpZ6h8Yw
         1/vxdkZb9nVVTu9NSvEVnYH+5bE9EOKpawJDC4x6YmgVOv+xvtSvIulG40c33i856yGz
         dM7lp6NEwXLJxS6A85oTMAA/wjsX3h/oqFYzJIFcdB9Z7xGpRF+3uJ0Mwpxw+ziy3pBq
         pK5qa6gypNbctxyLg1oVXxKnEyYtvRdR2x0u7ZPADZe+6TOk9fqcM6EFiQnjA0NA39MV
         Y8S4a+zgKYKb18vn8Zzn4CDHsj8OObVPZrBIG005c3bB0zmOlL0vFP9nAhmIGyAloybg
         U5sg==
X-Forwarded-Encrypted: i=1; AHgh+Rqjj/YitdUmLpJMTMFqhE0zBPUtWssB/h6OxWAkKrnCM4F8KH92N79p3nAXE7XbH9pdrjrGkZ7kVePI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QjEZpHc/GzcNi9n8hujxDoCEpTJ9OTNkG6Ldw0JY49dzsAby
	AtHtHSS6RLso/qMneXtAYEHFL4g2T9WXBr3ris2cyRaiVPuiW1DyoiHWLeYrOqIrjqGxHjgIelJ
	HKs7pd8uFtszcdLuEWV6KnYfXQoZXHxQz18tUi3E0xqYUE4/JqAP8r7KxVVhgsVM=
X-Gm-Gg: AR+sD12d+3t8i4ZxO/1lNdnZ3lXvQ895eCYBIVI/iMc5EyNfexwkkRYEJdCT1eGSRpJ
	2p0LwZlkPR+sl7nSTKB6dhI7QjOXX4OK9tpd5r1Aa85AjQXFQ/sFeSm3wivRrbtb4dBK5+mrzmJ
	WdTlGJjx/V1SsN8BQ6/olid+9egy4CiCkar3i9L8i9vzt9CVIqIIc5F2wcf5WxuSk9kxno00jDx
	uBgR/eBNwWOljLNbfnmmt2OW7/7val7JVMq1K3lp6moBTcH84NqMs/PMu5hcjDYPcUjGuXFoPuR
	bfzGwFfpcQilHtxSP9ukUBKTY2BCv5tZFF8K6fb0zdnAltgXjHBjMVZJLKWu8lu4Y4oHIvNNevu
	ISvpnctUQN68kUjSslW54z3P9/0GIDhfQ1hEXlECMi6Y=
X-Received: by 2002:a17:902:d48f:b0:2ca:bf8e:35fe with SMTP id d9443c01a7336-2d0521e2704mr122370795ad.16.1785833810472;
        Tue, 04 Aug 2026 01:56:50 -0700 (PDT)
X-Received: by 2002:a17:902:d48f:b0:2ca:bf8e:35fe with SMTP id d9443c01a7336-2d0521e2704mr122370395ad.16.1785833809903;
        Tue, 04 Aug 2026 01:56:49 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4d9b86sm2899145ad.76.2026.08.04.01.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 01:56:49 -0700 (PDT)
Message-ID: <8a5e291f-f547-4dad-8a90-1ebb1511a280@redhat.com>
Date: Tue, 4 Aug 2026 18:56:37 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] arm_mpam: Add MPAM-Fb firmware support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
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
 <afb75484-2739-4b75-a164-dd90433c7179@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <afb75484-2739-4b75-a164-dd90433c7179@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andre,

On 8/4/26 6:50 PM, Andre Przywara wrote:
> Hi Gavin,
> 
> many thanks for the review and the testing!
> 
> ...
> 
> On 8/4/26 05:29, Gavin Shan wrote:
>> On 8/1/26 3:03 AM, Andre Przywara wrote:
>>> v7 is another quick respin of the MPAM-Fb code, for firmware based MSC
>>> accesses. This propagates MSC access errors in a function where it was
>>> missing before, covering more functions that pass their return value
>>> to userspace (new patch 07/11). Also some bug fixes, formatting
>>> adjustments and adding the accumulated tags - many thanks to the
>>> reviewers. Find the changelog below. Based on v7.2-rc1.
>>>
>>> =======================
>>> The Arm MPAM specification defines Memory System Components (MSCs),
>>> which are devices that are programmed through an MMIO register frame. In
>>> some occasions this turned out to be too limiting: the MSC might be
>>> located behind a separate bus system (for instance inside an on-board
>>> controller), it might be mapped secure-only, or in a different processor
>>> socket without direct MMIO mapping. Also the MMIO access might be too slow
>>> or it would need to be filtered or otherwise access controlled. Finally
>>> there might be bugs in the MSC integration, which require a mediating
>>> firmware to be accessible.
>>>
>>> To accommodate all those different use cases, the MPAM-Fb specification
>>> [1] describes an alternative way to access MSCs. Accesses to an MSC
>>> would be wrapped in a message and communicated to the system using a
>>> shared-memory/mailbox system mostly mimicking the Arm SCMI spec.
>>> For ACPI systems, this would be abstracted through an ACPI PCC channel,
>>> which provides the shared-memory region and the mailbox trigger. We can
>>> lean on existing ACPI parsing code to register with these two
>>> subsystems, but cannot rely on the existing SCMI code in the kernel.
>>> This means we somewhat need to open code a very simplified SCMI handler,
>>> which just provides enough functionality for the very basic subset of
>>> SCMI that the MPAM-Fb spec requires.
>>>
>>> The first seven patches rework all MSC access wrappers to propagate error
>>> information. Pure MMIO based MSC accesses would never fail, but the
>>> MPAM-Fb access can go wrong in multiple ways. The patches have been split
>>> up purely for reviewing reasons, if the number is a problem, we could as
>>> well squash them. Please note that until the very last patch of this series
>>> any MSC accesses would always only return 0, it's only the final enablement
>>> of MPAM-Fb that could possibly introduce errors. Hence all former patches
>>> can add error handling gradually, those code paths wouldn't be triggered
>>> before patch 11/11.
>>> Patch 8/11 solves a nasty problem: At the moment we protect stateful MSC
>>> register accesses (mon_sel) through a spinlock. Unfortunately the mailbox
>>> subsystem and the slow nature of the communication through this channel
>>> forbid MPAM-Fb access in atomic context. So this patch keeps using a
>>> spinlock for MMIO based accesses, but reverts to a mutex otherwise.
>>> We just deny taking the lock for MPAM-Fb in atomic context, ideally we
>>> wouldn't need that (no need to IPI another core when the MSC access does
>>> not need to be local to one particular core), or we simply deny that part
>>> of the functionality (access through perf).
>>> Patch 9/11 adds the code to redirect MSC accesses through the
>>> PCC shmem/mailbox system.
>>> Patch 10/11 reworks the error interrupt handler to use a threaded IRQ for
>>> MPAM-Fb, to be able to do MPAM-Fb MSC accesses inside (which might sleep).
>>> The final patch 11/11 then adds the code to detect and store the PCC
>>> channel information from the ACPI tables, and eventually enables
>>> MPAM-Fb accesses.
>>>
>>> This would enable systems where some MSCs are not accessible via MMIO to
>>> use those components anyway.
>>>
>>> Please have a look and test!
>>>
>>> Cheers,
>>> Andre
>>>
>>> [1] https://developer.arm.com/documentation/den0144/latest
>>>
>>> Changes in v7:
>>> - add tags
>>> - add new patch to propagate errors in mpam_reprogram_ris_partid()
>>> - prevent loop when mpam_diable() tries MSC accesses again
>>> - register MMIO error IRQ handler without IRQF_ONESHOT
>>> - re-use existing "err" variable instead of declaring "ret"
>>> - initialise mon_sel_lock later, to wait for interface decision
>>> - convert timeout units for nominal latency, between us and ms
>>
>> [...]
>>
>>>
>>> Andre Przywara (11):
>>>    arm_mpam: let low level MSC accessors return an error
>>>    arm_mpam: propagate MSC access errors for hw_probe functions
>>>    arm_mpam: propagate MSC access errors for MBWU counters
>>>    arm_mpam: propagate MSC access errors for msmon helpers
>>>    arm_mpam: propagate MSC access errors for __ris_msmon_read()
>>>    arm_mpam: propagate MSC access errors for state saving function
>>>    arm_mpam: propagate MSC access errors for mpam_reprogram_ris_partid()
>>>    arm_mpam: prepare mon_sel locking for MPAM-Fb
>>>    arm_mpam: add MPAM-Fb MSC firmware access support
>>>    arm_mpam: change MPAM-Fb error IRQ to use a threaded IRQ handler
>>>    arm_mpam: detect and enable MPAM-Fb PCC support
>>>
>>>   drivers/resctrl/Makefile        |   2 +-
>>>   drivers/resctrl/mpam_devices.c  | 820 +++++++++++++++++++++++---------
>>>   drivers/resctrl/mpam_fb.c       | 250 ++++++++++
>>>   drivers/resctrl/mpam_internal.h |  62 ++-
>>>   include/linux/arm_mpam.h        |   2 +-
>>>   5 files changed, 915 insertions(+), 221 deletions(-)
>>>   create mode 100644 drivers/resctrl/mpam_fb.c
>>>
>>
>> With this series (manually) applied to v7.2.rc6, the tests for the existing functions
>> like kunit-tests, L3 cache partitioning, MBW (soft) limiting, llc_occupancy monitor
>> look fine on NVidia's grace-hopper machine.
> 
> Awesome, many thanks for doing that!
> 

Glad to give it a try :-)

>> Tested-by: Gavin Shan <gshan@redhat.com>
> 
> I'd assume this is a regression test, as your machine uses the standard MMIO interface?
> If you don't mind, I'd put this tag on the first refactoring patches, so 01/11 - 08/11, and leave out the remaining 3, as they are about MPAM-Fb, which wasn't really tested, I guess? Also patch 10/11 (the error IRQ changes) changed, so I would drop all tags from this anyway.
> 

Yes, it's a regression test. My Tested-by tag are only applied to 01/11 - 08/11.
I don't have a machine where MPAM-fb is available to test 09/11 - 11/11.

Thanks,
Gavin

> Cheers,
> Andre
> 



