Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90C3E0C62;
	Tue, 31 Mar 2026 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958475; cv=none; b=Q/PCkppc3liTQttzRg+ZDUyw+iMUw9wYVNA30wd34liVdo4LgUy38S3y2deh+ZDixnFCaZSMwWIJ3PKpwuU+4H9Y9031Nhtw47TYNgNphUWVUUcRMV8c9K7gFCtd/02sW/CSD2uqQibdXMJL4WxyxXYnyn2i9DlAuXYLgdJo0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958475; c=relaxed/simple;
	bh=vNFB1WBIPvoEUwzxt5cRm6Ry1Q7OUgFQ8vt8ZTw5Upk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=pwzdoynrbRprpu6uz8d56u6QsE2dYpiHDSAjJ1qhVHNC7m27kkzzIdzu9ryiysNBtJWlgmWKs/7BPe3ISODZ5lIiMS+fOlr8dJMO0TrB1GRiVcux3grbQ4yojgamLQkrucRCkiW81hD1Ga0c4C8UXOgGwPxEt4WubLTLQ43JNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=n5IU4sui; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="n5IU4sui"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QYHzTr7IsNpdqA+TvnsLi1Z0Py1cdkop4Xxq93jM+x8=;
	b=n5IU4suiWIOg0ne1rwLbOCk+Glq0BerDiHXP7DzH7a01RCCe2myuIWJiX77ul/R5lpAVV5NAV
	fzvatxADVDMnY9FKnEjCM/gh7WI1vgaesLDY7Z42i921W2RdsnsErJbOotBFxjCYUmb374DQtpY
	r6ytE4elLoZKggkp+aIC6PE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4flRPc1gfwzcb1W;
	Tue, 31 Mar 2026 19:55:00 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3581B40561;
	Tue, 31 Mar 2026 20:01:03 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 31 Mar 2026 20:01:02 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 31 Mar
 2026 20:01:02 +0800
Message-ID: <525c4cce-288e-447d-a890-d2d0b262984f@huawei.com>
Date: Tue, 31 Mar 2026 20:01:01 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
From: "lihuisong (C)" <lihuisong@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
References: <20251125072933.3706006-1-lihuisong@huawei.com>
 <20251125072933.3706006-2-lihuisong@huawei.com>
 <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
 <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com>
 <2d2d2d40-c73a-4988-90fe-fad75e35c75b@huawei.com>
 <f2be1178-28f4-4412-adb7-1530944a76ed@huawei.com>
 <CAJZ5v0heJsOWA5z7CwrON4zvaebj8-C_HBe5ymYa+FAbfJgy1A@mail.gmail.com>
 <3948b6fe-2aa6-4e38-9d58-c0e25e48fe93@huawei.com>
 <CAJZ5v0jPhW_spgjhfeig96G9pMEYb27_EKEYz17eZngrDLY7iA@mail.gmail.com>
 <47d38645-235b-43af-ac0b-300af338db31@huawei.com>
In-Reply-To: <47d38645-235b-43af-ac0b-300af338db31@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 3/28/2026 12:06 PM, lihuisong (C) wrote:
>
> On 3/27/2026 7:33 PM, Rafael J. Wysocki wrote:
>> On Fri, Mar 27, 2026 at 7:23 AM lihuisong (C) <lihuisong@huawei.com> 
>> wrote:
>>>
>>> On 3/26/2026 9:39 PM, Rafael J. Wysocki wrote:
>>>> On Thu, Mar 26, 2026 at 1:17 PM lihuisong (C) 
>>>> <lihuisong@huawei.com> wrote:
>>>>> Hi Rafael,
>>>>>
>>>>> On 1/30/2026 9:59 AM, lihuisong (C) wrote:
>>>>>> Hi Rafael,
>>>>>>
>>>>>> On 1/15/2026 8:18 PM, lihuisong (C) wrote:
>>>>>>> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
>>>>>>>> On Tue, Nov 25, 2025 at 8:29 AM Huisong Li <lihuisong@huawei.com>
>>>>>>>> wrote:
>>>>>>>>> The global switch of cpuidle can be turned back on in some case.
>>>>>>>>> So add enable_cpuidle().
>>>>>>>> No, this is not going to work.  The "off" switch only affects
>>>>>>>> initialization AFAICS.
>>>>>>> I think it would be work.
>>>>>>> The cpuidle_not_available() also see the "off" on do_idle().
>>>>>>> And cpuidle_idle_call() check this function first and then select
>>>>>>> idle state.
>>>>>>> Cpuidle doesn't select and enter idle state if this fuction 
>>>>>>> return true.
>>>>>> I verified that disable_cpuidle() effectively prevents all CPUs from
>>>>>> entering any idle states and the cpuidle function is correctly
>>>>>> restored after calling enable_cpuidle().
>>>>>> What do you think?
>>>>> Could you pleasetake a look atmy reply?
>>>>> If not ok, I will drop this from my upstream list.
>>>> Sorry, can you please remind me what problem you wanted to address
>>>> with the help of this?
>>> Regarding the discussion in the link[1], if driver fail to get power
>>> info in power notify,
>>> the old idle states may no longer be reliable. Therefore, patch 2/3
>>> disables ACPI idle
>>> via the new interface introduced in patch 1/3.
>>>
>>> However, our discussion on whether this new interface can disable ACPI
>>> idle has not yet reached a conclusion.
>>> Could you please revisit this thread? It's quite brief, and I'd
>>> appreciate your further input.
>>>
>>> [1]
>>> https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei.com 
>>>
>> The "off" variable has been intended for disabling cpuidle via kernel
>> command line (note that the corresponding module param is read-only).
>>
>> disable_cpuidle() is only used by Xen now and only at the setup/init 
>> stage.
>>
>> I don't think that using it on idle state list change notifications is
>> a good idea.
>
> Understand.
>
>>
>> Something like cpuidle_pause_and_lock() would be a better match I
>> think.  acpi_processor_hotplug() uses it already for a similar
>> purpose.
>
> Interfaces like cpuidle_pause_and_lock() and cpuidle_pause() disable 
> cpuidle by clearing the global "initialized" flag,
> which requires "enabled_devices" to be non-zero.
> IIUC, cpuidle_disable_device() isn't called when a CPU goes offline; 
> instead, it's handled in acpi_processor_hotplug() during online.
> This means "enabled_devices" stays above zero even if some CPUs are 
> offline.
> In this case, the driver can still successfully set initialized to 
> zero when get power information failed in power notify.
> So we can disable APCI idle on all CPUs.
> But we need to ensure that other threads wouldn't resume the 
> "initialized" flag by interfaces like cpuidle_resume().
>
> I have found a scenario for that where acpi_processor_hotplug enables 
> the cpuidle_device and restores the "initialized" value.
> In this case, special processing may be required.
> For example, the cpuidle state of the cpuidle driver also need 
> reinitialize or the disable cpuilde state is still maintained.
>
Hi Rafel,

I have thought about this issue for a long time. I feel that it is a bit 
tricky to handle.

First, if the power information fails to be obtained from the power 
notify, we want to disable the ACPI idle of all CPUs by calling 
cpuidle_pause(). However, in the CPU hotplug scenario, when the idle 
state may be unavailable, the idle state needs to be set up again.

Second, I found that the current driver only calls 
acpi_processor_setup_cpuidle_states() to update the idle states in 
acpi_idle_driver.
Other variables in acpi_idle_driver also need to be initialized again. 
For example, target_residency_ns and exit_latency_ns need to be updated.
For details, see the implementation of __cpuidle_register_driver().
These variables are used when selecting the state to enter (please see 
cpuidle_enter_state()).
Therefore, when the idle states information changes, the idle states we 
actually use are still the old values.
This is also a problem.

I am not sure whether we need to remove all cpuidle_device, remove 
acpi_idle_driver, and then re-initialize and register acpi_idle_driver 
and register all cpuidle_device in power notify.
I think it is very likely that we need to do so.

/Huisong
>
>
