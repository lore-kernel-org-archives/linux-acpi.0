Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C433B1006;
	Wed, 26 Aug 2026 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731203; cv=none; b=EDJcBRrtUDQq4E8PYRo15tyoc/MdV7Y0I5iFtxfBT0rEKNHLToAJEJykp/i5jtNrk+gWy7xHglZY/NmyhHTIaXvsB7zCPLo7nLHkPRf1qnJmRfxsr4T5ONHQGG47ZYHDHlFJnAf1iP4elQjyTZtp7mmwVPM0kKPKmCO/NnkvttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731203; c=relaxed/simple;
	bh=lr+rIjWdo4vv+UHdVg2aaFWrTgrbTVhfcpFAq1j+gEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D5T5WKXtwxNHHQ/+oMsEEwOUajSk7Q97WG4wv4PA7QjdHTaEg1aYgwX5gRLsPMf6PjoLkPuKJXIoFwTYXJvOirlT3wADpjSDVyblcf0WDHCE64p5QIajl83t/jaH20OIz5HkDm4zex8fpNCmyOvhTo2oHn9dQ6EQNUriesB8sc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c6Jri0BB; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c6Jri0BB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x1KWjaNvJ6+Tv8l7r/tws4/ss73PvPhsX07zL3SQsEM=;
	b=c6Jri0BBaLwySOADRXzwWkxiV2lsYcNrTC6wDOji2RxICMeoxcsnk01Dy9DulGWy/PAwNvfhh
	+1540BgHFC8iTkAIu2RpWHz6opebBwrDQAwSJgKhBCmDut6PgsHFrP8LkEPeduRwq37Vx0hNZ0D
	HXEoJCNTIjyGDZTmiNQTfMI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hVGy61xHHznTVn;
	Wed, 26 Aug 2026 15:49:34 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id BC80440572;
	Wed, 26 Aug 2026 15:59:48 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 15:59:47 +0800
Message-ID: <e83096fc-d6f8-46bf-91e6-2922ac35b751@huawei.com>
Date: Wed, 26 Aug 2026 15:59:47 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: processor: Add acpi_processor_start() back to parse
 _CPC tables before CPU online
To: Lifeng Zheng <zhenglifeng1@huawei.com>, <rafael@kernel.org>,
	<catalin.marinas@arm.com>, <Jonathan.Cameron@huawei.com>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <gshan@redhat.com>, <miguel.luis@oracle.com>,
	<guohanjun@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <wangzhi12@huawei.com>, <linhongye@h-partners.com>
References: <20260120113242.3843463-1-zhenglifeng1@huawei.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <20260120113242.3843463-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Hi Lifeng,

On 1/20/2026 7:32 PM, Lifeng Zheng wrote:
> Currently, if boot with maxcpus less than NR_CPUS, the cppc_cpufreq driver
> will fail to register. Because it requires the domain information of all
> possible CPUs to construct shared_cpu_map, which shows the CPUs that share
> the same domain.
>
> Commit c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use
> same path for cold and hotplug") removes probe() of acpi_processor_driver
> and makes acpi_cppc_processor_probe() only being called the first time CPU
> goes online. This means that CPUs that haven't yet gone online will not
> have pre-parsed _CPC objects and causes cppc_cpufreq driver register fail.
>
> Add acpi_processor_start() back as the probe() callback of
> acpi_processor_driver and call acpi_cppc_processor_probe() in it to make
> sure all _CPC tables will be parsed when acpi_processor_driver registered.
>
> Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>   drivers/acpi/processor_driver.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 65e779be64ff..c8b4daf580b0 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>   MODULE_DESCRIPTION("ACPI Processor Driver");
>   MODULE_LICENSE("GPL");
>   
> +static int acpi_processor_start(struct device *dev);
>   static int acpi_processor_stop(struct device *dev);
>   
>   static const struct acpi_device_id processor_device_ids[] = {
> @@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver = {
>   	.name = "processor",
>   	.bus = &cpu_subsys,
>   	.acpi_match_table = processor_device_ids,
> +	.probe = acpi_processor_start,
>   	.remove = acpi_processor_stop,
>   };
>   
> @@ -162,10 +164,6 @@ static int __acpi_processor_start(struct acpi_device *device)
>   	if (!pr)
>   		return -ENODEV;
>   
> -	result = acpi_cppc_processor_probe(pr);
> -	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> -		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
> -
>   	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>   		acpi_processor_power_init(pr);
>   
> @@ -192,6 +190,30 @@ static int __acpi_processor_start(struct acpi_device *device)
>   	return result;
>   }
>   
> +static int acpi_processor_start(struct device *dev)
> +{
> +	struct acpi_device *device = ACPI_COMPANION(dev);
> +	struct acpi_processor *pr;
> +	int result;
> +
> +	if (!device)
> +		return -ENODEV;
> +
> +	pr = acpi_driver_data(device);
> +	if (!pr)
> +		return -ENODEV;
> +
> +	/* Protect against concurrent CPU hotplug operations */
> +	cpu_hotplug_disable();
> +	result = acpi_cppc_processor_probe(pr);
> +	cpu_hotplug_enable();
> +
> +	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> +		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
> +
> +	return 0;
> +}
> +
>   static int acpi_processor_stop(struct device *dev)
>   {
>   	struct acpi_device *device = ACPI_COMPANION(dev);
I reproduced the issue described by this patch on the latest kernel at
commit 45c13f3f9e3bb15f.

On my system, CPU0 and CPU1 belong to the same software-coordinated
frequency domain. After booting with maxcpus=1, CPU1 is present but
offline, and its CPC descriptor is not parsed.

Consequently, acpi_get_psd_map() skips CPU1 and constructs an
incomplete shared_cpu_map containing only CPU0.

When CPU1 is subsequently brought online:

echo 1 > /sys/devices/system/cpu/cpu1/online

the cpufreq core creates an overlapping policy and attempts to create
the existing cpu0/cpufreq symbolic link again, resulting in the
following warnings:
...
sysfs_warn_dup
sysfs_do_create_link_sd
sysfs_create_link
add_cpu_dev_symlink
cpufreq_policy_online
cpufreq_online
cpuhp_cpufreq_online
...
processor cpu0: cpufreq symlink creation failed

freq_qos_add_request() called for active request
WARNING: kernel/power/qos.c:658 at freq_qos_add_request

The affected CPU masks are also inconsistent:

$ cat /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus
0

$ cat /sys/devices/system/cpu/cpu1/cpufreq/affected_cpus
0 1

After applying this patch on top of commit 45c13f3f9e3bb15f, the CPC
descriptors are parsed before the CPUs are brought online. The
shared_cpu_map is constructed correctly, and CPU1 can be brought
online without triggering the duplicate sysfs link or active QoS
request warnings.

This patch fixes the issue in my testing. so，

Tested-by: Pengjie Zhang <zhangpengjie2@huawei.com>
Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>

