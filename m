Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213143C0A14;
	Tue, 21 Jul 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634247; cv=none; b=MsIt5+/IuxDOGyQBw8CIR7zo3Ti5OZxD4/B8toRMc12PUu8xoL4CEf9M1vRPanNe+qe+b1GCrqEAa36au8b6Sc76D1MHBokcQGrjzRzYdI/aOb/JRXde7hQcR21XtbBp9qbgry/dfDIVd9eYrSJStvXYDYpIckHBursvN3iukKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634247; c=relaxed/simple;
	bh=cTmfMXnP4qp9z+00SWBVM3fFYrcq6YAhuwvrUhER9dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kxGs/S8C4G0+ZLDPhT1TN54w0s19YpcvyIwIk72t6qa1weLFpyZhiS7iNQhhiKU5lIYXixcFWPgVQo7NYLYi6YWyOl9GOmbcOFyCQj/HnVN5bDq1yWYSTnyNx+b2gtPUfyPH3kL9yNcpzpzpGKQpq30yMlwiigHuix+G15wibuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=VoXKOwTK; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="VoXKOwTK"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QMzY7Nnk9Lp8Hstc8hQjv8jo0R0nilYhCpc6NzV8NQw=;
	b=VoXKOwTK52TOSyZpIpEKqIgEUHiV+m4wqW1zX3GmE7qjv5TAdkBiw0SUNBtXtFYiwLeIwDFSn
	mLyA+JknAA5LfYaCQCSQEn2utWarowaBpf4KEOS9lXuOpFyqy0ZQhAOkmpShEV54U3fpOIq1WzN
	EJKa84TsiiVYXzr8Z8BSjTM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h4FfK3hlSzRhQm;
	Tue, 21 Jul 2026 19:34:33 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B08A4058C;
	Tue, 21 Jul 2026 19:43:54 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 21 Jul
 2026 19:43:53 +0800
Message-ID: <b75fc80b-6d1c-44d9-986c-be2c0a6e7711@huawei.com>
Date: Tue, 21 Jul 2026 19:43:53 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
To: Sudeep Holla <sudeep.holla@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <acpica-devel@lists.linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>, <lihuisong@huawei.com>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
 <20260717081005.470013-3-sudeep.holla@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260717081005.470013-3-sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/17/2026 4:10 PM, Sudeep Holla wrote:
> ACPI 6.3 introduced PCC OperationRegions. Section 5.5.2.4.7.3,
> "Declaring message fields within a PCC OperationRegion", states that,
> for all PCC subspace types, the PCC Operation Region pertains to the
> region of PCC subspace that succeeds the PCC signature.
>
> The PCC address space handler currently copies the OperationRegion
> buffer to and from the start of the PCC shared memory region. That can
> overwrite or expose the signature at byte offset 0, and it also misses
> the last 4 bytes of the actual PCC OperationRegion data.
>
> Offset OperationRegion copies by the size of the signature and reject
> regions that do not fit in the shared memory after that signature. AML
> that sizes the PCC OperationRegion to include the signature is not
> conforming to the PCC OperationRegion definition.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
The below commit description said the PCC operationRegion contains the 
signature field.
"77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC 
Type 3 subtype")"
And I find that the definition of this OperationRegion in ACPI spec 6.3 
is the same with spec 6.5 and 6.6.
That is, the original implementation already didn't comply with ACPI spec.

Patch 1/4 also requires the change of platform AML about PCC 
OperationRegion.
These modification may lead to the existed PCC OperationRegion method in 
some drivers doesn't work.
Because the platform AML still contains signature field in PCC 
OperationRegion method.
I don't know how many drivers in linux have used this method.
IMO, we at least need to reclarify this usage change and provide a new 
usage example in the commit log like the original commit did.

Anyway, this patch also makes the driver more compliant with the 
specifications.
So I agree.
Reviewed-by: Huisong Li <lihuisong@huawei.com>
