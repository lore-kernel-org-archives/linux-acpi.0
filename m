Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DA3B992A;
	Sat, 10 Oct 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615886; cv=none; b=jtXQyvJG2gwb5fiVowRN0OMbR1hcnX30VP491lxay+VmaPYEqCq2cWFdYd7NBHGBbaYh64kKAUMU7wTOz9caGRiZiGpe8UIb+qVEXJ9+wh1wb9TX9UYlqkOLbmbGlnQVnd1xBYRy0NCQBwVgAW5JpTSDImye2roilslZFZpBcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615886; c=relaxed/simple;
	bh=26xb9W5TIG/TQEnWucffAWqs4+UxAWBrviHP9QhEbKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tseFDKV2x67+ZlQ1gjquK1/Y3JAJ8iQPKeQpPQZ8ldJYKMemzl9Towv6kxjlOBBiD4z++vP1jpqwUPLIzFtyPbuuIBDr+0sOQIDCCmH0dGF/AVR7KZZcCpGvgxD5pSbUiLW7D2fqkWaIbas5IFmQgO3p9dlGjqi1H83j2drh/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j1vYK04Y6zRhXL;
	Sat, 10 Oct 2026 14:52:20 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id F2CC14056E;
	Sat, 10 Oct 2026 15:04:32 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 10 Oct
 2026 15:04:31 +0800
Message-ID: <67593620-1049-4ce1-9436-f7110f1e263e@hisilicon.com>
Date: Sat, 10 Oct 2026 15:04:31 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: cpufreq: Replace CPPC reviewer
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>
CC: <zhenglifeng1@huawei.com>, <zhongqiu.han@oss.qualcomm.com>,
	<viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Mario
 Limonciello <mario.limonciello@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>, Perry Yuan
	<perry.yuan@amd.com>, Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Shubhang Kaushik <sh@gentwo.org>, Pierre Gondois <pierre.gondois@arm.com>,
	Beata Michalska <beata.michalska@arm.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Sudeep
 Holla <sudeep.holla@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Jeremy
 Linton <jeremy.linton@arm.com>, <jonathanh@nvidia.com>
References: <20261008212832.354382-1-christian.loehle@arm.com>
 <20261008212832.354382-2-christian.loehle@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20261008212832.354382-2-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 10/9/2026 5:28 AM, Christian Loehle wrote:
> Take over CPPC cpufreq review duties from Pierre Gondois. Thanks to
> Pierre for his reviews and contributions to the driver.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Thanks for the great work of Pierre.
Thanks for getting involved, Christian.

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65e8a4b5c90b..3064942ef05c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6765,7 +6765,7 @@ M:	"Rafael J. Wysocki" <rafael@kernel.org>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  R:	Jie Zhan <zhanjie9@hisilicon.com>
>  R:	Lifeng Zheng <zhenglifeng1@huawei.com>
> -R:	Pierre Gondois <pierre.gondois@arm.com>
> +R:	Christian Loehle <christian.loehle@arm.com>
>  R:	Sumit Gupta <sumitg@nvidia.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
> 
