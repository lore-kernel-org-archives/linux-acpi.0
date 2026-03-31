Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D313E2771;
	Tue, 31 Mar 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961306; cv=none; b=CvalWBujMz9yxJ3Tm88JNNL8+8Yf9LOdTsccv2yCP/fztray0/qq/1zcS5XWT/7tTVWF7RPA96qDAhGIBNlWoDI8aBc0eWGjAY1kCUjTKY5VtWoAOsw3w4UkFnacFJytsL+t1u/dbSMHXxQ1l80AVw0GvvxMyln9vb7bEay32ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961306; c=relaxed/simple;
	bh=uH2Vc6Cq17FEd1pZf3p7f2otmb/lgbtFj5sT9pKQKSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B3tjoEX20cXJ+FlTYdgrF/WmMZlaWGVz+zILB2PEfMXWPbMPho+1vHyt9yuEhfsZhPg9wgOxavL1smkxEoNL+nmTD+zCgggsSopKK0s4OUyny9BOYW8F50w7Hz925kTEIlMQAe4ypp5lSJdrodhWp3nUIjOIlro82TeRAUYARWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ng0v+JdV; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ng0v+JdV"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k9e4ED/8rEqnoNpRsLd7OaKPs85nfeWS5gEYngR3nrA=;
	b=ng0v+JdV0iFmsKtiVYgVzJF/4YqGSkMPvIsavVESUbopr0R9a+/IRSPmN3Dkzs/BGlRMWIwLm
	BFJAxbCoOG3hQ/eI2LMqREj/KjK8zDQjQUibkNxHLSo30Wb/fM708dNJ+U5fhivIdjXHil+hRDu
	ZJ+C+LvIf6L8mSDrEdGAO1s=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4flSSY1nB1z1T4Gb;
	Tue, 31 Mar 2026 20:42:37 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id EDE8A40569;
	Tue, 31 Mar 2026 20:48:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 31 Mar 2026 20:48:16 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 31 Mar
 2026 20:48:16 +0800
Message-ID: <7ee19eab-60e0-456d-a513-b8837b757777@huawei.com>
Date: Tue, 31 Mar 2026 20:48:15 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Sudeep.Holla@arm.com>, <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
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
 <525c4cce-288e-447d-a890-d2d0b262984f@huawei.com>
 <CAJZ5v0gJcG2-TioBmc6DQf=fUQz+Aihb=_B9gmad_G54mVMvNA@mail.gmail.com>
 <CAJZ5v0gL=5r+drro7xQvPa2E4NCpWoWmAcTaAP_d49c4aMsg2A@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0gL=5r+drro7xQvPa2E4NCpWoWmAcTaAP_d49c4aMsg2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 3/31/2026 8:10 PM, Rafael J. Wysocki wrote:
> On Tue, Mar 31, 2026 at 2:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> Hi,
>>
>> On Tue, Mar 31, 2026 at 2:01 PM lihuisong (C) <lihuisong@huawei.com> wrote:
>>>
>>> On 3/28/2026 12:06 PM, lihuisong (C) wrote:
>>>> On 3/27/2026 7:33 PM, Rafael J. Wysocki wrote:
>>>>> On Fri, Mar 27, 2026 at 7:23 AM lihuisong (C) <lihuisong@huawei.com>
>>>>> wrote:
>>>>>> On 3/26/2026 9:39 PM, Rafael J. Wysocki wrote:
>>>>>>> On Thu, Mar 26, 2026 at 1:17 PM lihuisong (C)
>>>>>>> <lihuisong@huawei.com> wrote:
>>>>>>>> Hi Rafael,
>>>>>>>>
>>>>>>>> On 1/30/2026 9:59 AM, lihuisong (C) wrote:
>>>>>>>>> Hi Rafael,
>>>>>>>>>
>>>>>>>>> On 1/15/2026 8:18 PM, lihuisong (C) wrote:
>>>>>>>>>> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
>>>>>>>>>>> On Tue, Nov 25, 2025 at 8:29 AM Huisong Li <lihuisong@huawei.com>
>>>>>>>>>>> wrote:
>>>>>>>>>>>> The global switch of cpuidle can be turned back on in some case.
>>>>>>>>>>>> So add enable_cpuidle().
>>>>>>>>>>> No, this is not going to work.  The "off" switch only affects
>>>>>>>>>>> initialization AFAICS.
>>>>>>>>>> I think it would be work.
>>>>>>>>>> The cpuidle_not_available() also see the "off" on do_idle().
>>>>>>>>>> And cpuidle_idle_call() check this function first and then select
>>>>>>>>>> idle state.
>>>>>>>>>> Cpuidle doesn't select and enter idle state if this fuction
>>>>>>>>>> return true.
>>>>>>>>> I verified that disable_cpuidle() effectively prevents all CPUs from
>>>>>>>>> entering any idle states and the cpuidle function is correctly
>>>>>>>>> restored after calling enable_cpuidle().
>>>>>>>>> What do you think?
>>>>>>>> Could you pleasetake a look atmy reply?
>>>>>>>> If not ok, I will drop this from my upstream list.
>>>>>>> Sorry, can you please remind me what problem you wanted to address
>>>>>>> with the help of this?
>>>>>> Regarding the discussion in the link[1], if driver fail to get power
>>>>>> info in power notify,
>>>>>> the old idle states may no longer be reliable. Therefore, patch 2/3
>>>>>> disables ACPI idle
>>>>>> via the new interface introduced in patch 1/3.
>>>>>>
>>>>>> However, our discussion on whether this new interface can disable ACPI
>>>>>> idle has not yet reached a conclusion.
>>>>>> Could you please revisit this thread? It's quite brief, and I'd
>>>>>> appreciate your further input.
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei.com
>>>>>>
>>>>> The "off" variable has been intended for disabling cpuidle via kernel
>>>>> command line (note that the corresponding module param is read-only).
>>>>>
>>>>> disable_cpuidle() is only used by Xen now and only at the setup/init
>>>>> stage.
>>>>>
>>>>> I don't think that using it on idle state list change notifications is
>>>>> a good idea.
>>>> Understand.
>>>>
>>>>> Something like cpuidle_pause_and_lock() would be a better match I
>>>>> think.  acpi_processor_hotplug() uses it already for a similar
>>>>> purpose.
>>>> Interfaces like cpuidle_pause_and_lock() and cpuidle_pause() disable
>>>> cpuidle by clearing the global "initialized" flag,
>>>> which requires "enabled_devices" to be non-zero.
>>>> IIUC, cpuidle_disable_device() isn't called when a CPU goes offline;
>>>> instead, it's handled in acpi_processor_hotplug() during online.
>>>> This means "enabled_devices" stays above zero even if some CPUs are
>>>> offline.
>>>> In this case, the driver can still successfully set initialized to
>>>> zero when get power information failed in power notify.
>>>> So we can disable APCI idle on all CPUs.
>>>> But we need to ensure that other threads wouldn't resume the
>>>> "initialized" flag by interfaces like cpuidle_resume().
>>>>
>>>> I have found a scenario for that where acpi_processor_hotplug enables
>>>> the cpuidle_device and restores the "initialized" value.
>>>> In this case, special processing may be required.
>>>> For example, the cpuidle state of the cpuidle driver also need
>>>> reinitialize or the disable cpuilde state is still maintained.
>>>>
>>> Hi Rafel,
>>>
>>> I have thought about this issue for a long time. I feel that it is a bit
>>> tricky to handle.
>>>
>>> First, if the power information fails to be obtained from the power
>>> notify, we want to disable the ACPI idle of all CPUs by calling
>>> cpuidle_pause(). However, in the CPU hotplug scenario, when the idle
>>> state may be unavailable, the idle state needs to be set up again.
>>>
>>> Second, I found that the current driver only calls
>>> acpi_processor_setup_cpuidle_states() to update the idle states in
>>> acpi_idle_driver.
>>> Other variables in acpi_idle_driver also need to be initialized again.
>>> For example, target_residency_ns and exit_latency_ns need to be updated.
>>> For details, see the implementation of __cpuidle_register_driver().
>>> These variables are used when selecting the state to enter (please see
>>> cpuidle_enter_state()).
>>> Therefore, when the idle states information changes, the idle states we
>>> actually use are still the old values.
>>> This is also a problem.
>>>
>>> I am not sure whether we need to remove all cpuidle_device, remove
>>> acpi_idle_driver, and then re-initialize and register acpi_idle_driver
>>> and register all cpuidle_device in power notify.
>>> I think it is very likely that we need to do so.
>> Well, yes, we do, but only if the list of available states has
>> actually changed (that is, the number of states has changed or the
>> latency values have changed).
> What actually needs to be done there is to unregister the cpuidle
> driver and register it again because the list of idle states is a
> property of the driver.
We also need to unregister and register cpuidle device again.
Because the state count of ACPI idle driver may be changed, some 
releated sysfs need to be recreated.
