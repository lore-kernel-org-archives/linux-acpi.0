Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07353749F4;
	Tue, 16 Jun 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615577; cv=none; b=Hvwi8gnW8J7ZriM8KpndguTj68rI27L4+f3tP5o15titW05Q+HJE6dqK0EEGtZW61ld0SpzY4qbhD+PKTppq+EDG4qvOHIRtXsAqMP3P5LVcMD5XbqALNhxZtPGBmN7VbdLna0hOpCQiYqmrPCNYOLj2q7gwp8x0QpLBygJq4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615577; c=relaxed/simple;
	bh=2YMS1TPdKj8YZTAzLmxweixUsQJT5reuFUutt0QorUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TFjki6QJrykaBY4G6hIVZGPGQZgINn4PPAkFSSHKAgDjPmnSFswCcQERHE97pN4yZBWDX7ipCdu/u5d7i4v3Cg/V3fnYpKAoDCD/qVWYjb3nxL18S0MVc80rW1CY0kYuH78C6VsWGBgTmQWGXTVR4m82xpHcM1W1n5WUZsMl920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=os/ptCz2; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="os/ptCz2"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9E0DuBf96JZkkmK5Hg++NskVSILbsCcyEZOXqhBthHU=;
	b=os/ptCz2VFlDM8YHnUy1o9aLibmW0ZIaOUjlp4LDeF21B0lCQck4WzMmPjMlGKODqmUqY7eQ/
	wa0jx8iA8p7Z1K7eQioXtEEpGwyp23Pz3BIpmAohk5ibtG/Ky8abGIXMX4NCTT4ppx05VSEexwp
	btkXIa6Rccro3Dp3pmTlyKE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gfnHg0bwwz12LF5;
	Tue, 16 Jun 2026 21:03:59 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 9441540569;
	Tue, 16 Jun 2026 21:12:50 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 16 Jun
 2026 21:12:49 +0800
Message-ID: <a2483bf9-0a78-43df-ae03-b017bc72c380@huawei.com>
Date: Tue, 16 Jun 2026 21:12:46 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v2] ACPI: processor_idle: Mark LPI enter functions as
 __cpuidle
To: lirongqing <lirongqing@baidu.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sunil V L
	<sunilvl@ventanamicro.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Sudeep Holla <Sudeep.Holla@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
References: <20260616072617.2272-1-lirongqing@baidu.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260616072617.2272-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 6/16/2026 3:26 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> When function tracing or Kprobes is enabled, entering an ACPI Low
> Power Idle (LPI) state triggers the following RCU splat:
>
>    RCU not on for: acpi_idle_lpi_enter+0x4/0xd8
>    WARNING: CPU: 8 PID: 0 at include/linux/trace_recursion.h:162 function_trace_call+0x1e8/0x228
>
> The acpi_idle_lpi_enter() function is invoked within the cpuidle
> path after RCU has already been disabled for the current local CPU.
> Consequently, ftrace's function_trace_call() expects RCU to be
> actively watching before recording trace data, emitting a warning
> if it is not.
>
> Fix this by annotating acpi_idle_lpi_enter(), the generic __weak
> stub, and the RISC-V implementation of acpi_processor_ffh_lpi_enter()
> with __cpuidle. This moves these functions into the '.cpuidle.text'
> section, implicitly disabling ftrace instrumentation (notrace) along
> this sensitive path and preventing trace-induced RCU warnings during
> idle entry.
>
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
LGTM,
Acked-by: lihuisong@huawei.com
