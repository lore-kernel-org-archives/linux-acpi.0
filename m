Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485005;
	b=qxFGaQY+RZZIzw5cDqVeC4Ll25lQ13yHQ/ufov9Cv273bKthP77GjLaCxX+XN8MZGi2P
	 6wahulCJ0QpvLHpv3KP8/jCrbN6ti19SUdr90rSJ0OWLAZT9MQFkNTzFtlfjoCIT5RvcP
	 T2C9So/7vsphA4+I9NeQGRcRMSOMni5YeXcS+1m/EoRCVAF3hythSJUaG3h493MXG83qG
	 hN+5yU0JhskdFhMESqHIEDQ4ESUCkuOHBBp6RWR+ZKeLqJnf/CbiLsteMwYB6NoUYAIw5
	 HnPVclt/EYPvb9f6cO9ie5RutPghJVMruJoHQ54/zKLfvMS2PkxHsxT/IJWs2zWBbaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485005;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hRoqKUZrnvqxYXEqKXPVR7lsEaN83gJGvmXY5a33JLw=;
	b=4wqvhALIuTnQW8CBvXl8IPQl3zbg9pL8az/Nb9w15O3uUVDu3BA4if54iMyIe2kG9SV3
	 YoQBIuNxIvANf4NJXgm38L2k+rkiLE7YeZw/Y4hQu9gFJlW1Ngn0orT/e6jr7w6BbVUvC
	 xuNv56dAar3Xric0a0gjkL6NX0BEUek8mqMVUBaaASeozIpAVC/WiV8dFvPEI950K8AHJ
	 jBHRjPVTV/bEQK2uxu0UrFFQg5gSqB2XgZ5JXT3WK9XSNWD5/70PpbE4OXuJVfGRIv6hp
	 IpKqUQr6oB5aj6KD/hsTxae90NtGvCvjUJw3o2YblRYWO83eFG81Dha/oi6UdPQkcKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uCfATuv2;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700B606A31E;
	Tue, 24 Nov 2026 01:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7700B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uCfATuv2
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795485000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hRoqKUZrnvqxYXEqKXPVR7lsEaN83gJGvmXY5a33JLw=;
	b=uCfATuv2nA8tzCY1ovXG5Ch8U3LRVeqZCZ+/KzsgWVSGm0Go2mp3FmZfciz/JWwotsHOOnfJAhUfXdF0DFIRGn0CEzvGDn+Gc78Nx0/ozZrxtwTQLgTHmTlS6PIVhuwQANT4x/syQYihak9FfVnDdhUnbsIwL8Ugg3oPvpibIv4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0XFMo9EZ_1795484998;
Received: from 30.246.162.150(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XFMo9EZ_1795484998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 09:49:59 +0800
Message-ID: <115ef051-31c1-4201-b60d-bfea9d413bd8@linux.alibaba.com>
Date: Tue, 24 Nov 2026 09:49:58 +0800
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: GHES: Poll error sources at their poll
 interval
To: me@ahmedabdelfattah.dev, "Rafael J. Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Len Brown <lenb@kernel.org>,
 Ying Huang <huang.ying.caritas@gmail.com>, Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261119-acpi-ghes-poll-interval-v1-1-6f45cc65fd62@ahmedabdelfattah.dev>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20261119-acpi-ghes-poll-interval-v1-1-6f45cc65fd62@ahmedabdelfattah.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/20/26 2:36 AM, Ahmed Abdelfattah via B4 Relay wrote:
> From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
> 
> ghes_add_timer() passes an absolute time to round_jiffies_relative(),
> which takes a delay:
> 
> 	expire = jiffies + msecs_to_jiffies(g->notify.poll_interval);
> 	ghes->timer.expires = round_jiffies_relative(expire);
> 
> round_jiffies_relative(j) rounds jiffies + j to a whole second and
> subtracts jiffies again, so what gets rounded here is 2 * jiffies plus
> the interval, and the timer fires up to a second away from the Poll
> Interval in the HEST. With a 1000 ms interval, on some boots the polls
> come every 1.5 s on average, for seconds or for minutes, and the rest
> of the time they are anywhere from 0.75 s to 1.95 s apart. A 250 ms
> source settles at one poll a second.
> 
> Rounding the delay instead would still move every interval that is not
> a whole number of seconds; a 250 ms source would still be polled once a
> second. Drop the rounding and use the interval as it is.
> 
> Fixes: 81e88fdc432a ("ACPI, APEI, Generic Hardware Error Source POLL/IRQ/NMI notification type support")
> Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
> ---
> I found this while timing a polled GHES in a QEMU guest, with a HEST
> built for the test (one polled GHESv2) and given to the guest as an
> extra ACPI table.
> 
> Tested on v7.4-rc3+ (4405c18c95d2) at HZ=300, tracing ghes_poll_func()
> with a kprobe. With a 1000 ms Poll Interval and without the patch, the
> intervals on three 10-minute boots ranged from 0.77 s to 1.95 s: one
> boot averaged 1.5 s for its first two minutes, and the others
> alternated between 280 and 320 jiffies, and between 240 and 360. With
> the patch, every interval on three 3-minute boots was 304 jiffies
> (1.013 s). With a 250 ms Poll Interval, the polls settled at about one
> a second within the first minute without the patch; with it they come
> every 80 jiffies (267 ms). The extra 4 and 5 jiffies are the timer
> wheel's granularity at those timeouts.
> ---
>   drivers/acpi/apei/ghes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 5d888c82efea..92d54c6b209a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1276,7 +1276,7 @@ static void ghes_add_timer(struct ghes *ghes)
>   		return;
>   	}
>   	expire = jiffies + msecs_to_jiffies(g->notify.poll_interval);
> -	ghes->timer.expires = round_jiffies_relative(expire);
> +	ghes->timer.expires = expire;
>   	add_timer(&ghes->timer);
>   }
>   

LGTM.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
