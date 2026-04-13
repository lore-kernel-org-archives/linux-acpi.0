Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0CD3C2761;
	Mon, 13 Apr 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080522; cv=none; b=qjzN1cZc0/P+dudzzdA3zr93AREp6lh6Xi805gwkVroifBXzYxDqfjP7h7ONco4yuutZN7BbWKKuxPeiiLlgG3SQGJjAEqzq3K3qUKYf1Fpyd5yJLzNHvS9UsSHrLJoD5mM2ZCZ1wW/kj71IcXTQxLS8F4CCDKauv7XRGPdciZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080522; c=relaxed/simple;
	bh=JSLQUHewh4PAmZNWRH2Y5yRBbWZBzbpX8NLpUZaRomY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UsAbu0U04QjnPGNgu0R2umzbS1S4uS48rUOMxbCNyBZb84w7tLeSQV08HMHV/j11neRWDEIkWOdXhnewOB+xJmH7iC59o2d7c+uX+SunUAO9gmeGVzxwvR2d2MGR7cvb0wv0ashKjQzm0Eb3tobsoNbnyqR8BApB354MpGQIIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CMP/qpIF; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CMP/qpIF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pBa58+Rnu6d7H4ovXPBl8Vi0R9NDOBEPB5Srzk6TSFM=;
	b=CMP/qpIFStbFtAAY9CpIptDISPHW7VK7yLQgiuBlgZ1nTk8Vcew5x0uFZmW26wCGQRj9WIpK5
	kCu525yReXzp0ChSCsWBRb6DGWxahizriEf0A+E943nowBpdxvy12+9TOphtorSAxSszvQsl8ED
	AMFW7l1d/pyKNBnPA8mjEBo=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fvQM35LpwzcZyv;
	Mon, 13 Apr 2026 19:35:27 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 59C5840561;
	Mon, 13 Apr 2026 19:41:54 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Apr 2026 19:41:53 +0800
Message-ID: <97c186b3-e9dc-464e-af0b-934aaa5a9538@huawei.com>
Date: Mon, 13 Apr 2026 19:41:52 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: add acpi_get_cpu_uid() stub helper
To: Arnd Bergmann <arnd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Gavin Shan <gshan@redhat.com>, Shaopeng
 Tan <tan.shaopeng@jp.fujitsu.com>, James Morse <james.morse@arm.com>, Marc
 Zyngier <maz@kernel.org>, Kees Cook <kees@kernel.org>, Ben Horgan
	<ben.horgan@arm.com>, Dave Jiang <dave.jiang@intel.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260413070132.3828606-1-arnd@kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260413070132.3828606-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Thanks

On 4/13/2026 3:01 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When ACPI is disabled, x86 Xen support fails to build:
> 
> arch/x86/xen/enlighten_hvm.c: In function 'xen_cpu_up_prepare_hvm':
> arch/x86/xen/enlighten_hvm.c:165:13: error: implicit declaration of function 'acpi_get_cpu_uid' [-Wimplicit-function-declaration]
>   165 |         if (acpi_get_cpu_uid(cpu, &cpu_uid) == 0)
>       |             ^~~~~~~~~~~~~~~~
> 
> Add a trivial stub that can be used in place of the real function.
> 
> Fixes: f652d0a4e13c ("ACPI: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

...

