Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD8239E80
	for <linux-acpi@vger.kernel.org>; Thu, 27 Aug 2026 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789429; cv=none; b=QtiZUGYSPjrOYX9ySm9QNo5Sr2gJEhQ3MWXfy2BaJZugeIMA3dpXWkY4DAyeDkfy24WbSjcKTXIzzUC0sozuDM6RkzG54clugBDISl60+0CA7dgX7+Rfx+IZWSpchVnnhYpzwpa5mlu6WhigNvYQnQVKmPx5IHpT6LQ7hJnVcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789429; c=relaxed/simple;
	bh=NpFoAN3ARoByq+Fs2sx4uXcEiHmYv9k+CBvlMh5NByY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpL7PJ0KHRkYTvsdJTF2H9zx55p4XT4xz7ovTI1UdGixr+61vPF5xf4NLJGDA60SH4O52L+fvvWvdjC3cYeLc186Pb8aaIT0TtHjYHWIzl8VCelnS9MsP0mfSrzykKBFlZ7pSTOxk+SNqUPx96qhHT/aMGw2Hc8j7DUOTN7JXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Smk83bzV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DX1Aueue; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Smk83bzV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DX1Aueue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787789427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kI48VtjA0m79pfKThr79GcCuUw/Tq7WCD7HinJujWM=;
	b=Smk83bzVDcKDOlhffKdsWDNIW76PbyUVLHJmf1FIlZCuFiWc5R4VZvGBw+eNN77qAAns5D
	d9wc4OZdBJ6GqJQyglKg9HTIsI2BGavD/Y0L+ty7nnj+L2R0Ya+PhSPt0qi2KzDPpoJSU+
	x0meOwTrhAhKqyWbDV3saKqoVFBOrr8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-DLOJspDHO66VRxjFbXu_Jw-1; Wed, 26 Aug 2026 20:10:25 -0400
X-MC-Unique: DLOJspDHO66VRxjFbXu_Jw-1
X-Mimecast-MFC-AGG-ID: DLOJspDHO66VRxjFbXu_Jw_1787789424
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso2324194a91.2
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787789424; x=1788394224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7kI48VtjA0m79pfKThr79GcCuUw/Tq7WCD7HinJujWM=;
        b=DX1Aueuee4LYfJ9W27naBvENe8PUUiZkwCO9PKwt1GJJwpD7pyCTXO2IM5AlntgJWh
         mSo967J9Kgrr4kUxCS7OqVPwcUhHauUvrB1ULeSWmCegjH156pFa9qDvqUSF4GvqAx3w
         iHkQJIgYJy7kpdRjcznJlBH4FqG7BdtuTlL+HjEzzlwJAXW9l69V6d6zf/IdV0cH84px
         9pti+Tdd5ZNT6KtykU/LWadGbFAHC29k15LlxdfHk8S9ewchQ6D1VePmLf2jRTrNdGoP
         vrRIO8WuWnLPERR+JCi+srIo8jrP+bLei5ZxKBUeS/6i9dOPN3ZHHfnZHQkZiZQIGWIG
         VCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787789424; x=1788394224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7kI48VtjA0m79pfKThr79GcCuUw/Tq7WCD7HinJujWM=;
        b=TujCoX70stVapi63TLRdsv1P5QRcmfFJTMKmFmMi3RkOGXYm2MUoT1XfP3xU5a9qEu
         FEg7g35aVzrLvK1RC216erfmBCUYAQjCjVXG1bBOLbL6VyAcSJceAlesMf51yADdvI04
         z78tFBOjGm+v4+hBBLze6bHkmR39OL3+SpBDnX7WzqGNqCDCoZKhN22ZyNOPmO1poha4
         yqv/RrVYvlx8K4iyJM0uu6PPpS05/Cm2a5V4nJXe6Go9/FbyoGY6wvwzO5223phiTnYT
         pbCLdGt3orrFL4le/kSutAI/tWXIPAN8pq5sUn0n4gZV/+WgUDgGShg3W7bXr10LkLK8
         6vyw==
X-Forwarded-Encrypted: i=1; AHgh+RrFOnyKQ977UHnrXr2Onx7nNI1LO2AjuY54JTxS1nDPGV+mbE5GH/mItiWbvbbo/d0tUFd3YCn1bFNw@vger.kernel.org
X-Gm-Message-State: AFuF++mDGMNJQJteIRZpYQe/DBEPqy+I9zuX4n2sqZlpd5YSXng9r119
	m1GxNikthGRtfnkgIP37te/OS4qwjZ0aUZvB11JLj+/DzBeiAsDEjLPUqF3Ev1CEduQ9qIVSAu+
	+8xvw4Rhhk76WZfy1hdwZVfN3DLM1kq3CzckKtkJ2/kJUHA594HFl/IAUjIo/WgM=
X-Gm-Gg: AR+sD11lhQ2LYh0AlsfMXbLoEpJnjMpXNQ4BQZnRnSeE3rEO+FDcVFeL1NPoXHnVDrI
	KuXSwkmeyw13TIrnCMqglMn7vBDygoDEzKR9nWpryEYP4LAXaZ6M74dthxOMNuBfx7uHCj3cdmD
	F6VcvlJ+FJNk1JvtwykpMVwWxNg/J4TpoYsE6hEF8ZOTueBTvKSQuLQG+LET79FYZwELqs5HPZj
	++sKoMgzE38wjsucvt1MrMpdutYMTQpVcB3H8R9TuyI+IDpn535bYyWOKzRCBjP5rCMhqgcsw51
	s7XRfBgWH9LfbOP6+OdRqxzzxOCW4j58/rbBL9QBAWxjFj/6pqLwIBsjQZni5kAbz7ZqrbKRAyb
	MVxByY5DcDIejhk2dRwjiwxQP2G8Rt9IEaE1wRg8lqw==
X-Received: by 2002:a17:90b:1dce:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-3966d3e1cfdmr21940245a91.10.1787789424343;
        Wed, 26 Aug 2026 17:10:24 -0700 (PDT)
X-Received: by 2002:a17:90b:1dce:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-3966d3e1cfdmr21940059a91.10.1787789423479;
        Wed, 26 Aug 2026 17:10:23 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283da048d3sm12020839eec.28.2026.08.26.17.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 17:10:22 -0700 (PDT)
Message-ID: <996cd400-44e2-4b4a-8286-1235c3248750@redhat.com>
Date: Thu, 27 Aug 2026 10:10:13 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/12] arm_mpam: detect and enable MPAM-Fb PCC support
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
References: <20260807105451.3728284-1-andre.przywara@arm.com>
 <20260807105451.3728284-13-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260807105451.3728284-13-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 8:54 PM, Andre Przywara wrote:
> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> registers through a firmware interface. This requires a shared memory
> region to hold the message, and a mailbox to trigger the access.
> For ACPI this is wrapped as a PCC channel, described using existing
> ACPI abstractions.
> 
> Add code to parse those PCC table descriptions associated with an MSC,
> and store the parsed information in the MSC struct.
> There can be multiple PCC channels, and each channel can serve multiple
> MSCs, so we need to keep track of the channel usage, using a list and
> a refcount.
> 
> This will be used by the MPAM-Fb access wrapper code.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com> # on Arm AGI CPU
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Tested-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
> ---
>   drivers/resctrl/mpam_devices.c  | 112 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_fb.c       |  41 ++++++++++++
>   drivers/resctrl/mpam_internal.h |   2 +
>   3 files changed, 153 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

