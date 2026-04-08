Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9138A728;
	Wed,  8 Apr 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639488; cv=none; b=PCbsgmYyQ0toqki3Br5etufT1jmOkhWZIsOWC8fIOHZupmdc0bwyssTq14u8cdBrmoxZ4ZJlLWEWqnmuZcX+n29yc3BASV2L70cc/YZOV6xfrPbEwmyx3D3zPBsu8nnRrHaDl5bmE54DVZAqgk1FUOAI/z4oCen+4o9fJv0sxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639488; c=relaxed/simple;
	bh=e7L4fcc4SgvYn3Ny1tL65vVITmhfMAwWocfUwheAaPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RDNu71ZLc8L6o60jgNMKXsB7VGqvuKbYt6O2DZZcPXR23HF+lvZa/W9KB+rDoDVfuob/vv+Zcjcu9dcSw8Mf7INkG0Uabrn5N/wBNr+GlVIOHUXm7/gUo2aS/I5u7YWpfbDTZ3flQnVNiYB6ahvtklgT7e+riJlYLJ+nSDM6I1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=iGOjNftD; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="iGOjNftD"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Au78roX8QpQw4m58ImPb6sqXVu4pWYPo0vnBBc8oAB4=;
	b=iGOjNftDze9u8uKFK51adF3sj35ko7Yiwfkuri8TAZha4h7X3qw8Vx7d/9lkz9XcD5B4CMKai
	YsqLyqXvEGRfoB1OVJM2CHsJNy6fPrKkmmABL4hnm+hDVpcf7bnU7KF6iebitpXRt2szK0V7Pmp
	Qy9YJvA4NgCJAke3gZJUmz0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4frHFn2qQfzKm4k;
	Wed,  8 Apr 2026 17:05:01 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5386240572;
	Wed,  8 Apr 2026 17:11:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Apr 2026 17:11:17 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 8 Apr
 2026 17:11:16 +0800
Message-ID: <f59a6b33-7955-42b2-8604-64f8891313d6@huawei.com>
Date: Wed, 8 Apr 2026 17:11:14 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpuidle: Extract and export no-lock variants of
 cpuidle_unregister_device
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <wangzhi12@huawei.com>,
	<zhangpengjie2@huawei.com>, <wanghuiqiang@huawei.com>, <lihuisong@huawei.com>
References: <20260407081141.2493581-1-lihuisong@huawei.com>
 <20260407081141.2493581-2-lihuisong@huawei.com>
 <CAJZ5v0i6eTz2EyKAd9jKK6V8S-qUhGHM7Dk+f-FYLzSrBJ0A0g@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0i6eTz2EyKAd9jKK6V8S-qUhGHM7Dk+f-FYLzSrBJ0A0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 4/7/2026 9:36 PM, Rafael J. Wysocki wrote:
> On Tue, Apr 7, 2026 at 10:11 AM Huisong Li <lihuisong@huawei.com> wrote:
>> The cpuidle_unregister_device() function always acquire the internal
>> cpuidle_lock (or pause/resume idle) during their execution.
>> However, in some power notification scenarios (e.g., when old idle
>> states may become unavailable), it is necessary to efficiently disable
>> cpuidle first, then remove and re-create all cpuidle devices for all
>> CPUs. To avoid frequent lock overhead and ensure atomicity across the
>> entire batch operation, the caller needs to hold the cpuidle_lock once
>> outside the loop.
>>
>> To address this, extract the core logic into the new function
>> cpuidle_unregister_device_no_lock() and export it.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/cpuidle/cpuidle.c | 22 +++++++++++++++-------
>>   include/linux/cpuidle.h   |  2 ++
>>   2 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index c7876e9e024f..1a55542efead 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -714,16 +714,12 @@ int cpuidle_register_device(struct cpuidle_device *dev)
>>
>>   EXPORT_SYMBOL_GPL(cpuidle_register_device);
>>
>> -/**
>> - * cpuidle_unregister_device - unregisters a CPU's idle PM feature
>> - * @dev: the cpu
>> - */
>> -void cpuidle_unregister_device(struct cpuidle_device *dev)
>> +void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev)
>>   {
>>          if (!dev || dev->registered == 0)
>>                  return;
>>
>> -       cpuidle_pause_and_lock();
>> +       lockdep_assert_held(&cpuidle_lock);
>>
>>          cpuidle_disable_device(dev);
>>
>> @@ -732,10 +728,22 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
>>          __cpuidle_unregister_device(dev);
>>
>>          cpuidle_coupled_unregister_device(dev);
>> +}
>> +EXPORT_SYMBOL_GPL(cpuidle_unregister_device_no_lock);
>> +
>> +/**
>> + * cpuidle_unregister_device - unregisters a CPU's idle PM feature
>> + * @dev: the cpu
>> + */
>> +void cpuidle_unregister_device(struct cpuidle_device *dev)
>> +{
>> +       if (!dev || dev->registered == 0)
>> +               return;
>>
>> +       cpuidle_pause_and_lock();
>> +       cpuidle_unregister_device_no_lock(dev);
>>          cpuidle_resume_and_unlock();
>>   }
>> -
>>   EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
>>
>>   /**
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 4073690504a7..2ead2d8c57e6 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -188,6 +188,7 @@ extern void cpuidle_driver_state_disabled(struct cpuidle_driver *drv, int idx,
>>   extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
>>   extern int cpuidle_register_device(struct cpuidle_device *dev);
>>   extern void cpuidle_unregister_device(struct cpuidle_device *dev);
>> +extern void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev);
>>   extern int cpuidle_register(struct cpuidle_driver *drv,
>>                              const struct cpumask *const coupled_cpus);
>>   extern void cpuidle_unregister(struct cpuidle_driver *drv);
>> @@ -226,6 +227,7 @@ static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
>>   static inline int cpuidle_register_device(struct cpuidle_device *dev)
>>   {return -ENODEV; }
>>   static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
>> +static void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev) {}
>>   static inline int cpuidle_register(struct cpuidle_driver *drv,
>>                                     const struct cpumask *const coupled_cpus)
>>   {return -ENODEV; }
>> --
> Both patches applied as 7.1 material, though I'm somewhat nervous
> about removing sysfs entries under cpus_read_lock().
Thanks.

The sysfs entries has been removed using cpuidle_disable_device() before 
this change.
 From this perspective, we don't change this behavor.🙂
> Note that I've changed the subject of the second patch to "ACPI:
> processor: idle: Reset cpuidle on C-state list changes".
>
> Thanks!
