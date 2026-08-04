Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F57175A99
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814170; cv=none; b=tJvclI9PTlEj/PUYSneGVIV53I8YIuRvtuIyLAbaCSplAWQBj7ItJ+BTjAMVazGW2N1FtNw/ZEDV5hsrvZGw/o6V+UhzNBVRo2r3m4fJ8KDP0xJy/yV4zjmY8NzG9FrMcz7ZG8BCFU6UnnfNNrXPaYur+7UR6LeFdhUM4lHA6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814170; c=relaxed/simple;
	bh=WmthJ5kcasnEkzaisn9P/6G/RU2Oxhz3DnvME3jrqeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avPQgZbcBWpG1Zb9xI8tvuxUEQogY6//Toom/1W5Mn3POD/Jmq+AUelr9NT5QbesPKvK7e4JdxIdRv15moaljulAWngtTFdVWRR1oFu0kujSfWuOeNg/6LrThKc/vlWIWkJvxhyYRPbmPVEaDCvklMIHc+Rp1TcHiBuEqf/k0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKJMHd0f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNMpdf8d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKJMHd0f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNMpdf8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785814168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73+Vcs8356c8UcX6JzaxNcxmLM11GF7IimgXsgpettQ=;
	b=VKJMHd0fRMQM/ATVaH0wbGRd5gfJOQ4ryMNWE3P0oswLCk+pkYJW1sQkohdot6poAk10lK
	8xwLABr82WyTJEnS+4O/RxbUn8gTh6dCcZTN2HsFDrQ+y5HmZwaR0nBndZ8CdSfpD67eSj
	OpOPJi5JViYH1O2xBtdFuvWqIbehKtA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-f9usQml1OdqiXXqAMl-yxQ-1; Mon, 03 Aug 2026 23:29:17 -0400
X-MC-Unique: f9usQml1OdqiXXqAMl-yxQ-1
X-Mimecast-MFC-AGG-ID: f9usQml1OdqiXXqAMl-yxQ_1785814156
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso4667552a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785814156; x=1786418956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73+Vcs8356c8UcX6JzaxNcxmLM11GF7IimgXsgpettQ=;
        b=TNMpdf8dALCGAtr688ZvaRzMIqsGhEcPicweJvLZb2QLP9QfIjcYSZPvVpcu6ndqpU
         n6bRUzj2zr223/f02wCJdbNanb8Ng1pv/MbUqKKjL2XLnYpPuNtsE5CMQ1pvnlFfz1aY
         oiFE1rbdePvOmpGtdwxaabx7TuBv7oK9q4Tzu88QRhNfQIkObGohY+w0eygWOEVnfGFh
         LrZro0kPOjCk6MoOC030iBjGFI+Y3WKMxpikKs5BSRezcXV7WvuA59yVyqGWNsLMdm8O
         Q9LBnUHM3Ni9hl1AuiFkFyIPbjMFHTF2QTr85kPb2MlDRpwbZrJ+Y0byDYs3rnhphGH+
         cfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785814156; x=1786418956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73+Vcs8356c8UcX6JzaxNcxmLM11GF7IimgXsgpettQ=;
        b=KMC+zrJg8gi8jKNjKcKqp6QjQ2f4Z7lPNUYzsebmLtnKmER+Si0fWOBS5VYyQqqn0r
         bt3rKKn6aDuk2A2Duz5fAPkLj73/L412xcDBSb+Trlpv66bLhyz27JyvBWBtfSqZ3Y2F
         DWhKJcgXRYdCzGcRfMj729wQ4eXd96991OQ0w/TfOJfnWI2W6+WKeI7zc9bPWVJVlEOF
         2G1FfgjlSqM5llM451FT2aj84ttzJI0KZL7oxawNyzJ0wlZcWTj50BwQc/EOCPqo1wJ4
         0Ygdz6t1ulOYXteYEqEiHzrLUxhF7kTE9N1NB5FyZbJjYlFbhIzfhmR3LQmAD5ODaA77
         anhg==
X-Forwarded-Encrypted: i=1; AHgh+RokZzuMXFP3Z4+gj+CxCYmjFOshFIx6Auhn1jQ2ONVQZ1P3PKhXsG4X3RFre8ghphXCvh+BLApWlm6H@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0OHqueD52kJezN9j97djNtowvgm43lyXe+J2Yjgmti2JKt/w
	HKIuhA6OhhQMMl7U1Jq38EY84fN0pQDEYxWkB8ox3KDsWD5hsahlhzQP40TjNirAcu92RV7bZNH
	cpHr6Y2YtF0rD3B6T9qD8B2tIrpRpkQA5Lb0iWzCeHfT8LapdbKzraOei33ThAjc=
X-Gm-Gg: AR+sD11sxuVWYwAUGuTtOjJidkb75/5an9x7lQM2d9uhoDSYlxuEN2v098pPKpHv8SY
	ezwtzg6QL3tGCYTagl5QYKPIYSdEFdW6c5CfW3A6LaIl2k+BLRXemTrqW1XyFF3r2QNY8z+v/l0
	Ddb3xz7Ch0bojwVV9LP0pcNGKgbkr9ZXvf3vyO2QkIKRAR10iPlYcNbVSu5aG5uFQ6d7iInD0TQ
	hddzS5zjLG7A9VaD1lRRHgP8aXcAuX5Kq0wV1sV8Pj6KRTr2iMs5lZP5eF+57GFthe+DQbPMGV3
	pdru5W9V+U54GaxDYWjbrcXemB1apCMbnF5j9uBYDFV1NVsx9cHFMzqaTe/KiuyV9eJ+VkTsCxn
	qpfHGdcYLHaCWaNFdKD54PRmD5KiguKpcfwT343221Os=
X-Received: by 2002:a17:90b:1b01:b0:387:e0db:bc2c with SMTP id 98e67ed59e1d1-38fbc548a91mr11429669a91.34.1785814155928;
        Mon, 03 Aug 2026 20:29:15 -0700 (PDT)
X-Received: by 2002:a17:90b:1b01:b0:387:e0db:bc2c with SMTP id 98e67ed59e1d1-38fbc548a91mr11429629a91.34.1785814155373;
        Mon, 03 Aug 2026 20:29:15 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04491dsm57772486eec.16.2026.08.03.20.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:29:14 -0700 (PDT)
Message-ID: <6f8bc358-91a0-4c44-9110-c071e10df385@redhat.com>
Date: Tue, 4 Aug 2026 13:29:04 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> v7 is another quick respin of the MPAM-Fb code, for firmware based MSC
> accesses. This propagates MSC access errors in a function where it was
> missing before, covering more functions that pass their return value
> to userspace (new patch 07/11). Also some bug fixes, formatting
> adjustments and adding the accumulated tags - many thanks to the
> reviewers. Find the changelog below. Based on v7.2-rc1.
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
> 
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
> Changes in v7:
> - add tags
> - add new patch to propagate errors in mpam_reprogram_ris_partid()
> - prevent loop when mpam_diable() tries MSC accesses again
> - register MMIO error IRQ handler without IRQF_ONESHOT
> - re-use existing "err" variable instead of declaring "ret"
> - initialise mon_sel_lock later, to wait for interface decision
> - convert timeout units for nominal latency, between us and ms
>   

[...]

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
>   drivers/resctrl/mpam_devices.c  | 820 +++++++++++++++++++++++---------
>   drivers/resctrl/mpam_fb.c       | 250 ++++++++++
>   drivers/resctrl/mpam_internal.h |  62 ++-
>   include/linux/arm_mpam.h        |   2 +-
>   5 files changed, 915 insertions(+), 221 deletions(-)
>   create mode 100644 drivers/resctrl/mpam_fb.c
> 

With this series (manually) applied to v7.2.rc6, the tests for the existing functions
like kunit-tests, L3 cache partitioning, MBW (soft) limiting, llc_occupancy monitor
look fine on NVidia's grace-hopper machine.

Tested-by: Gavin Shan <gshan@redhat.com>

Thanks,
Gavin

