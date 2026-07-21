Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC436481FD7;
	Tue, 21 Jul 2026 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634787; cv=none; b=uh2OqPtwM2koWge7s+Pl45Onacb0ZXpPd63YNB/4dVq0qiHJpqVjNYOhIfZnF3L634FIB2+BQJTdhINt7C2njCGAIgLdfrQdtu8JyNpZwO6gA4iTJS5ymnMj1RhBUWgF6NfwgOOg5V4q33iw5R2YoaX0qHB+XIbtAuhwH5b6UUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634787; c=relaxed/simple;
	bh=s+r7TqV9xkMUXXPrxmitZvwVsko2aySwpX9+7JJcCkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UZJCDwCm8BDECM+Z3TY8Qdw0ii7H3GH3jBowFb6RInBC8XMI+JGrCmGZBd0fCCT5p3rN2gS0Wgkif0nCy+IjcaGKvVt7+rL/T3xq622Bunv3fz2qhjFYwiMeLC18b/WGw5ppFX8+Q8lA2qFh4IlW5Ccqnayt9eeNyIM29E7RzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=fKosoYob; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="fKosoYob"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s+r7TqV9xkMUXXPrxmitZvwVsko2aySwpX9+7JJcCkw=;
	b=fKosoYobcVKIiqOsRjhnre7HFXTCq5jt9ParQU3WhxUeAXKqs+0mTyoj++9OBOkoyYJRjqx+b
	vImTMPeoPApth5t1INO9IIkJNxPjhlWJuL+j0yja8JaRF54ewoM6jnsWsfmUuklhuipCep7j413
	sarvfUv8l9uZG9QqlthsyiI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h4Frq5sRnzLlTV;
	Tue, 21 Jul 2026 19:43:39 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id E3D5740578;
	Tue, 21 Jul 2026 19:53:01 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 21 Jul
 2026 19:53:01 +0800
Message-ID: <ca68550e-9ce3-4cad-aecf-090dcaf36cd6@huawei.com>
Date: Tue, 21 Jul 2026 19:53:00 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ACPI: PCC: Cache OpRegion command timeout
To: Sudeep Holla <sudeep.holla@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <acpica-devel@lists.linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>, <lihuisong@huawei.com>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
 <20260717081005.470013-5-sudeep.holla@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260717081005.470013-5-sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/17/2026 4:10 PM, Sudeep Holla wrote:
> The PCC OperationRegion handler computes the same command completion
> wait timeout each time it sends a command. The timeout is derived from
> static channel properties, so compute it once when the PCC channel is
> set up and store the millisecond value in the mailbox client timeout
> field.
>
> Use the cached timeout when waiting for the OperationRegion command to
> complete. This keeps the timeout calculation in one place and avoids
> recomputing it for every command.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
LGTM,
Reviewed-by: Huisong Li <lihuisong@huawei.com>
