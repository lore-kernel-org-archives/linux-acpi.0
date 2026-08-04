Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0941A925
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815940; cv=none; b=kDqe+KLCDv8Znvn1G7Rzu2BMTX+R35+0hw/ciihMDfBjVDcKVofGviGD5ZfUBQREVrgHfx/BVL6ZVza7FQpWfeskythFXMEq4OAf4sywwb98F07i55mha7T8BLtKga0OGL2kSSCmqSiqJXKNpitnxuwaBDLI+UmkgWTUC3EsHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815940; c=relaxed/simple;
	bh=GYrV5WXVFDKzioOg3KyofDBBe3T2r6zuWt8jbfiWebQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+DOQIzS8AiJH7QGivA3ZhXKCxkshkToi+UOxt5nkFnqsVtdwr6Te93/iCkFm58JLKpWeTNBtDIntw1eMLCSnDFSQeyGDTt1/hOks+2Wd+5Hz91jeTKPFdLD8BVOc714IBZr/rn6oyi0cUDstWcoCP9c670z+B1wREwH6mZpBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1RjuQOh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5HTwSnY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1RjuQOh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5HTwSnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785815937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWuE3aPXJBBk1sgCezb0nxhHgt0/Tjj+1abOM/7n6xE=;
	b=b1RjuQOhKq15BSD0qxfBNCCtiALo+7oTeFgRNSTywGFfUB/C/yE0qC9qCMpuEd5IOCnB8s
	gqdMYKrnqXk9uTkRALKSMagxU58xiReMW3XsKD+cYicLrLhu4aYiROcplrygHUHHDR3BHd
	N/8Mm7/HuOU7SL7rMvfRzW//+uu3UjE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-9-uGg9qAM8aLkHPTZyVa-Q-1; Mon, 03 Aug 2026 23:58:51 -0400
X-MC-Unique: 9-uGg9qAM8aLkHPTZyVa-Q-1
X-Mimecast-MFC-AGG-ID: 9-uGg9qAM8aLkHPTZyVa-Q_1785815931
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848860def2cso4903280b3a.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785815931; x=1786420731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hWuE3aPXJBBk1sgCezb0nxhHgt0/Tjj+1abOM/7n6xE=;
        b=R5HTwSnYunIKYS/okkC8isY9Iy6FyLVS1vZ4f9mGfvEkMexKJgzrqgXDqh3rYgCTw7
         fd3gG7iRnmyMag50U6qUhy4ES/E3FRTgiv2SjcmP1cp5+r0YG6OgvS4VLIWpzWt2faKJ
         wkQCozh0DUFrs/P7HF0nrzkdltNPsFW2A6Yd8LgZYKFFn3e/010d16Uti9bdBdqCM3sk
         PmV6xWyLoY+XXmzorUCGpABiTZPsJkS7Ough3hWzws5wYfq4SoN3pd/t94TvjRYoVnXE
         Ch9Go9oRJ8xt2LWpp9nikbjWXKRjx4tpiE9kBRzqRcFHGUiXXMj4JM6vIZjHFabqfN6R
         bGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785815931; x=1786420731;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWuE3aPXJBBk1sgCezb0nxhHgt0/Tjj+1abOM/7n6xE=;
        b=WfcFJpOiT3QVy8BVIpU0oL9Zwjp7/yJtwxk+QHAOHseikqEXK0kn1NA+6Gk8Q63xQx
         b1ndnXd936guGExRlaCfQBtlaXNB6LBK2J1I0LF+gkLoYpISHNyumMT0FsvkYKnVXYGk
         WPKjt53KRdYqYLRUgALLuaKSawLy6ZtkD1/QCj1Xuwp86BsuVGHTJEu8PsnpDF8+X/V+
         d6NtmRhIjs2V77vvv1xqqQt7xtgxTRkkZCN+KL7UqmtnkoDWT0dBU1qRvznRgCgrVIJ1
         2jatxxh7TvaWHLs/VMPjb/wkYsHMQK1ZydLUBwMjQowlY7jBpj1CPgFmiVhEf/x4pfR+
         D5Dw==
X-Forwarded-Encrypted: i=1; AHgh+RrfINCfu6mZPZB7vQqLuUjxSl5ONlal2ktskew3URAgcXcsvrAP3FLzmOrwmD67QQNarci1vDVzF3Zw@vger.kernel.org
X-Gm-Message-State: AOJu0YzONDXjRKYrozuQVYZMsVfn1SKoaTnBHXiRi8+CSKywblvv9yHR
	NVhsdePr6lcuuX5nTfSjzNnP8icrImalVlgqs83v18awOQckeJiIGbF/EZxmagEQBlpKJwnZF+6
	b/zbu8Ib477lZMumwNqpht5ZPqSC8ZQF5NSx27/JIJghuHtyD3Th+zkwFqWwZvYY=
X-Gm-Gg: AR+sD11eVKZizcjAr2g+fBpA2UUVjlFjVPY+D9r6hSSvEIKqY2yRH5B+ghHAac1/50c
	TQTKVHAg0rFSVqOL1SGKgL8blkWecfZfowOK/IaUe01Pp9ILtb1RLiTjJkjU50fI8wRPnJo+g4l
	UsLujGrJkY/JsAgS3DcT+sIbDbD/SD7klZy3hxVaDw/Sws8XrNmoAQ83nww/ARPQUViYVECyeZ9
	vcKs7ylF5rwRzjG76N2nB5k9pyPqcs6T5mNZ9JhKclRv6rrCuDNm/Hi/O7LqLJ4RL3UPttn56UT
	m1d/d18fcZ3PoKHXvvqBkkPFA8tBTyeNMfMnzLJZNlks58OllPYzgqS6bXGGtaXhhjvhHKqj94h
	uORV9oADYhWyEzHCf2+CwhDohLvW88p42s+KxprYZMLo=
X-Received: by 2002:a05:6a00:3a14:b0:845:eb88:3d74 with SMTP id d2e1a72fcca58-84ee486504amr11053434b3a.29.1785815929997;
        Mon, 03 Aug 2026 20:58:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a14:b0:845:eb88:3d74 with SMTP id d2e1a72fcca58-84ee486504amr11053411b3a.29.1785815929416;
        Mon, 03 Aug 2026 20:58:49 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29c73bsm4431143b3a.29.2026.08.03.20.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:58:48 -0700 (PDT)
Message-ID: <e7ff32a5-6fd9-45c9-807d-363c645d937b@redhat.com>
Date: Tue, 4 Aug 2026 13:58:37 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/11] arm_mpam: prepare mon_sel locking for MPAM-Fb
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-9-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-9-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSCs are not accesible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with
> MPAM-Fb mailbox MSC access it must be able to sleep, meaning a mutex must
> be used. So MPAM-Fb platforms cannot support an overflow interrupt easily.
> Clearly these two methods can't exist for one MSC at the same time.
> 
> Change the mon_sel locking wrapper function to only use a spinlock when
> the MSC is accessed directly via MMIO. In case of MPAM-Fb, we use a
> mutex, but only if we are in a sleepable context. If that's not the
> case, we return an error. This should not happen, as MPAM-Fb by design
> does not require an MSC access to happen from a specific CPU, so there
> is no need for any IPIs or preemption disabling to satisfy CPU
> constraints. And since overflow interrupts are not supported at the moment
> anyway, we also wouldn't meet the other case.
> Bailing out early is already happening in rare occasions today.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>   drivers/resctrl/mpam_devices.c  |  6 +++++-
>   drivers/resctrl/mpam_internal.h | 38 +++++++++++++++++++++++++++------
>   2 files changed, 36 insertions(+), 8 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

