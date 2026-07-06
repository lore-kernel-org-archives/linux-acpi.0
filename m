Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44F4189D4
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329337; cv=none; b=nxbtYPSHbbaTs2xBZKmDkTpwi8Q4mEvUioXPpM2zmlxCXy35OzsrR3GpoYcik4oyfn4lP9gzkVVHD7/jyA/t9/PSL+GRAsT5n2PiGBONkUYrDMtKx7cFpay18KLkkDg4f2a9raOVkOt4ZB/cLT4ZhijUJjiRgx1sIjTX7F8PMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329337; c=relaxed/simple;
	bh=rCRwPw588Br8aVy9nVo4y7fd5ip1+kmS99ZYNLghsBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dWYmS0QUx/3td9jhYzLJ7/iW29htCAnNfyeD9NBYQD07L/HieEbzrq5t1q2vCoMgDkaPgz4nc66JFhW3jzUBD+0pRG5FhO2J1uXCMu0UXimyjzQ4S7EPZpe2eQPME1PiRlV3f/rty/QzxazsZQrEhdYicgUAccCd9jnHkZV5xPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=HtqSeenj; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="HtqSeenj"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GNdQvWOx1ZJgK0lSnqpExTuQatv86MLlbe82lrAmD9A=;
	b=HtqSeenjY9Tv3CScmqfMZhTxp2DZ6G6HjGqyPk9fKg0kjCrffvSlEipeMJzrdNtd++4xxrO6M
	bRsL2iozS0qlEHtUgVmPuetTaQlKscU0LyOxXtRw8d0cW6B2l4my80fHOB6ZQMGkCbOfm8FANzH
	YYiJ9CIFQacMzaCpamRchfk=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gtz3w2VlnzmVZr;
	Mon,  6 Jul 2026 17:06:04 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 526E240565;
	Mon,  6 Jul 2026 17:15:17 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 6 Jul
 2026 17:15:16 +0800
Message-ID: <42b67228-ccbd-4272-8ffb-af5fbf6c2083@huawei.com>
Date: Mon, 6 Jul 2026 17:15:15 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] devfreq: hisi_uncore: Preserve PCC shared memory
 signature
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, <linux-acpi@vger.kernel.org>,
	<lihuisong@huawei.com>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-4-c1b7268d4fdc@kernel.org>
 <20260702-nondescript-scrupulous-dalmatian-da23be@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260702-nondescript-scrupulous-dalmatian-da23be@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/2/2026 6:25 PM, Sudeep Holla wrote:
> On Sat, Jun 27, 2026 at 05:37:32PM +0100, Sudeep Holla wrote:
>> ACPI specification defines the generic PCC shared memory signature as
>> the PCC base signature ORed with the subspace ID.
>>
>> ACPI 6.6 added clarification that the signature is populated by the
>> platform and verified by OSPM.
>>
>> The PCC mailbox controller now validates the signature when the channel
>> is requested. Stop copying a complete local PCC header into shared
>> memory and write only the command, status and payload fields, leaving
>> the platform-populated signature intact.
>>
> Based on the discussions in 1/6, I assume 4/6 and 5/6 doesn't work well
> for Hisilicon platforms. So I will drop them. I will just post 1/6 reducing
> it to a warning.
Thanks for reducing error level.
We will test them to make sure if these driver work well after removing 
the signature filling.
Then will update these code in driver if it's ok.
>
