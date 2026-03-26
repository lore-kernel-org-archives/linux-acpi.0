Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1183F788F;
	Thu, 26 Mar 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527430; cv=none; b=Igk5zPgWRIB0H9TikQg7Cp5v1rlXl5Gd7gSjD6kWhAjXjfnbqPcXGNOuHU34yg9upRtQXG7cLjPJmaucdt9tLWFBoZu4gUUD/OAUlE+gaBshw2mQzY3lMT3z7IvbkVHuTzoTJcIVIEOCCRX1LYFtB9EssULDwpX82iiYyDA1ROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527430; c=relaxed/simple;
	bh=IZ2hKnxaAbgeO9OmdtBKgzxSVFNzJtOiSaQtW3ERI7o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DXyjm20LpSBNOCx7SMAEq7r4mSa93JTb0SvH9kVKsHTkgh8LmnQSIjVt14MUWCK8oX0xFmDTTleNTdUBdDzJasGrqZ6l/WrhHfZtMTyN+p4jnyGjnprjzBEPivZAjHY/Dh77a15yytgmEb3JE5l6nvaf1/oh/uKEUJvLRfR8tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=X6sYJgGj; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="X6sYJgGj"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IRL7Uyiu03pL2gJCLxCmRMSvZxxJA4S/Nc4c93EOWd4=;
	b=X6sYJgGjUVIIFXd45FSW/jddQr7JzVzsvMJR9Yrn94s+MH/eJuv3rUwMhMWg3iKbZQtejIC2X
	C5QaP5lmQhzL5jd9v9begYOQnXH5Lt58Q0h62HqErkt9WsMfccCrND6vNLXsFUcSHwW8hApk1p0
	2VjPr8eZ5ZvF3Drk8q8RO2Q=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fhN0K332Tz1cyNq;
	Thu, 26 Mar 2026 20:10:57 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id DAB1E40565;
	Thu, 26 Mar 2026 20:17:02 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:17:02 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 26 Mar
 2026 20:17:02 +0800
Message-ID: <f2be1178-28f4-4412-adb7-1530944a76ed@huawei.com>
Date: Thu, 26 Mar 2026 20:17:01 +0800
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
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20251125072933.3706006-1-lihuisong@huawei.com>
 <20251125072933.3706006-2-lihuisong@huawei.com>
 <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
 <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com>
 <2d2d2d40-c73a-4988-90fe-fad75e35c75b@huawei.com>
In-Reply-To: <2d2d2d40-c73a-4988-90fe-fad75e35c75b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Rafael,

On 1/30/2026 9:59 AM, lihuisong (C) wrote:
> Hi Rafael,
>
> On 1/15/2026 8:18 PM, lihuisong (C) wrote:
>>
>> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
>>> On Tue, Nov 25, 2025 at 8:29 AM Huisong Li <lihuisong@huawei.com> 
>>> wrote:
>>>> The global switch of cpuidle can be turned back on in some case.
>>>> So add enable_cpuidle().
>>> No, this is not going to work.  The "off" switch only affects
>>> initialization AFAICS.
>> I think it would be work.
>> The cpuidle_not_available() also see the "off" on do_idle().
>> And cpuidle_idle_call() check this function first and then select 
>> idle state.
>> Cpuidle doesn't select and enter idle state if this fuction return true.
> I verified that disable_cpuidle() effectively prevents all CPUs from 
> entering any idle states and the cpuidle function is correctly 
> restored after calling enable_cpuidle().
> What do you think? 
Could you pleasetake a look atmy reply?
If not ok, I will drop this from my upstream list.

/Huisong
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>   drivers/cpuidle/cpuidle.c | 5 ++++-
>>>>   include/linux/cpuidle.h   | 2 ++
>>>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>>> index 56132e843c99..980ddfd3d930 100644
>>>> --- a/drivers/cpuidle/cpuidle.c
>>>> +++ b/drivers/cpuidle/cpuidle.c
>>>> @@ -48,7 +48,10 @@ void disable_cpuidle(void)
>>>>   {
>>>>          off = 1;
>>>>   }
>>>> -
>>>> +void enable_cpuidle(void)
>>>> +{
>>>> +       off = 0;
>>>> +}
>>>>   bool cpuidle_not_available(struct cpuidle_driver *drv,
>>>>                             struct cpuidle_device *dev)
>>>>   {
>>>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>>>> index a9ee4fe55dcf..94c030748af3 100644
>>>> --- a/include/linux/cpuidle.h
>>>> +++ b/include/linux/cpuidle.h
>>>> @@ -168,6 +168,7 @@ struct cpuidle_driver {
>>>>   };
>>>>
>>>>   #ifdef CONFIG_CPU_IDLE
>>>> +extern void enable_cpuidle(void);
>>>>   extern void disable_cpuidle(void);
>>>>   extern bool cpuidle_not_available(struct cpuidle_driver *drv,
>>>>                                    struct cpuidle_device *dev);
>>>> @@ -203,6 +204,7 @@ extern struct cpuidle_driver 
>>>> *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
>>>>   static inline struct cpuidle_device *cpuidle_get_device(void)
>>>>   {return __this_cpu_read(cpuidle_devices); }
>>>>   #else
>>>> +static inline void enable_cpuidle(void) { }
>>>>   static inline void disable_cpuidle(void) { }
>>>>   static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
>>>>                                           struct cpuidle_device *dev)
>>>> -- 
>>>> 2.33.0
>>>>
>
>
