Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358E3DDDAE;
	Thu, 25 Jun 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389456; cv=none; b=jxY49UY8cd4d2ZOBe9opEuvEryAErPgkRb3hguvwzwsn/0swEPugZMvbD/KusgXa+IE2souQMY+cqkNhvCn4ZRKcrD93XW4XyEHnqCUrLq51J21V1QCzzbXDSZP3VUOitN22HXIKfmdq+s++OAfWB4KhvSbaXQAynbSZC9d6MQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389456; c=relaxed/simple;
	bh=22f7CH2dQfPGOIw29GDs2B3pR3pFwtvnVMkaDGGUrX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mvDR89CUGla8qHKn9EHW4GsRotbfPyglDIYtv37RCz/vur0iYK6elW6LyJzZ8eSQLjommxMpd1/vbkl9J+x7dkPyCU3RsCjTmv8+MSQvF2zT6YJnIuAOYeyZycbuXrzgA2lHRm5slO7Z5pCpL+gr6LQ/MPjq5P2+SPHe0PhTuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gmHTg6X5fzLlVM;
	Thu, 25 Jun 2026 20:01:43 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E98264048B;
	Thu, 25 Jun 2026 20:10:49 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Jun
 2026 20:10:49 +0800
Message-ID: <53600467-51b6-438a-8d5f-fc11ed911c28@hisilicon.com>
Date: Thu, 25 Jun 2026 20:10:48 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: RISC-V: Fix false warning in cppc_read_ffh() for
 same-CPU reads
To: <wang.yechao255@zte.com.cn>, <linux-acpi@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sunilvl@ventanamicro.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <zhenglifeng1@huawei.com>, <pierre.gondois@arm.com>,
	<viresh.kumar@linaro.org>
References: <20260609192856874Y8AaPpKL5TnmbgiWI8DI3@zte.com.cn>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260609192856874Y8AaPpKL5TnmbgiWI8DI3@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 6/9/2026 7:28 PM, wang.yechao255@zte.com.cn wrote:
> From: Wang Yechao <wang.yechao255@zte.com.cn>
> 
> Commit 997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in
> ticks for non-PCC regs") changed the CPPC Frequency Invariance Engine
> to read AMU counters directly from the scheduler tick for non-PCC
> register spaces (like FFH), instead of deferring to a kthread. This
> means cppc_read_ffh() is now called with IRQs disabled from the tick
> handler, triggering the warning.
> 
> This is the same fix as commit df6e4ab654dc ("arm64: topology: Fix
> false warning in counters_read_on_cpu() for same-CPU reads").
> 
> Fixes: 997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Indeed.  Thanks for the fix.

Acked-by: Jie Zhan <zhanjie9@hisilicon.com>
