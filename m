Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF941D22E
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814951; cv=none; b=SplLh4KSTOsuraR5/DhzVuY5bOLiSmAoC+SUHV8QZtr5FPoAgrLESGE8GaW4DaXM3ATDR02+aRIMSGwUfsFAp1uv/5QleEM57k8Usg3d2ZkQx1o3CieM/WMmqMbbutlggEwwRRVm8N1uuHm6EPFmE7vUWN4pGN8OMp6N3DRfIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814951; c=relaxed/simple;
	bh=l22xpU40dvmJDDg1Ii9jlPtLHdA0zjEOXqOPydyZ2+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHMQjk4kedpFWC3raM91KuCw1ApT+yzkIVrcuYeFuSCCen5HTtWCalMOibn4Axc7r+OfMNPaxUCqkbG48rWnTikq3LgepoytG0534tQHk+ILohYJtBLt3F0cyLiEutOp74VWOy8HJ19OH0NfUr5AWC4fRp5FDFHhxZKYZcREKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBgo52h9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4nDbEKV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBgo52h9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4nDbEKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785814948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rd+7vAfqiUBzcRKGEyy2nh9xcJ8M+Wgk6xnmdZSE0Jo=;
	b=FBgo52h91Mxl4Kz/FjSQCS5EMefm+ly4BUrdSMT4hAMl+y9Zuu7PXI9qoGi5OQ8Qf6LpwE
	TlX8piKdZg/NAsFgL0aemT9MxJUMlQbDvGdsnWUl15JA/S88z4CcCfxn/7PSc38ctcidOW
	KUukX0tpQoG5TtJecJTTz7wj068KpTk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-BGDAnaFENdO3kiYWoPN1bQ-1; Mon, 03 Aug 2026 23:42:26 -0400
X-MC-Unique: BGDAnaFENdO3kiYWoPN1bQ-1
X-Mimecast-MFC-AGG-ID: BGDAnaFENdO3kiYWoPN1bQ_1785814946
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484ba00601so4934354b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785814946; x=1786419746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rd+7vAfqiUBzcRKGEyy2nh9xcJ8M+Wgk6xnmdZSE0Jo=;
        b=D4nDbEKV0KfZKuYyvruyLLQEbxHf6lSl83zpU8NyVvkY95tkzfRKQtDCSg6HPeAY+O
         Uf83qz7A/nffLSw38jg8gp9i/m2GcBP01m30CqpkbtwpA2AxdNoyMolenqir3VgVJo3s
         /9VuTrnlIrqVF6H0ZfJa6sdruNbOizh5krvyMKzKDqZgzAl8kUpeFpQSQCJsJCQfIzmf
         SmHw7X2M7EYijAbUG6kGWtl2lUrAOmT4DF8fO+IBO2lpq+SdjMIvwBO70BBMjoHWnmbJ
         /uL0HeIDHktfLYuCYNrbdZyvQ33vDe52nKG8L2D+Dz1IzrYez1ZYVcEcFXj99539FMeW
         1WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785814946; x=1786419746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rd+7vAfqiUBzcRKGEyy2nh9xcJ8M+Wgk6xnmdZSE0Jo=;
        b=duGHFINxD0lbALtxvmxOSsF1IQNq4axC5Kq+SVVf3+XKJC44b9fB/fu6xjSHsFEifG
         ag/rbAU+o449aH0VXaP7eAcKhX1UCmbACmxTTP29fB2bW9afxqD5lrB7WxFM/mrVKh8i
         wevxGV22oQEBAi5vKmFnIfa+imgw2P+O8BIlG0uWzXPWtJEl/H/Y8Ob5LvcbzYnVf8+m
         X1Qcztm+2RgR/S8iTkfHbLZ7yWt+ugyffvFWvm1MeBF/CAwNbwQwZnla6uyKWR7clg2I
         ccXLwfRoX6Fv2xi7yu1IMOnPNAz7hhOamW89N2lzT2ol1JqN+ARFVtoUWanjZ0cQ/4gY
         dGug==
X-Forwarded-Encrypted: i=1; AHgh+RpgXJHUQPvwYB3BjbKrLVwjIXni3HMUrlwwGSv9LSFVQpB9VHaBTqI4Ot1CntnQLvqN3pVyyrcK6OPP@vger.kernel.org
X-Gm-Message-State: AOJu0YxfP7et/7FTwaOSzuzZKLSJo5yTBEX9cRf0sJdkH3PhrTt7mE9n
	WHCSb/5vTFWvfEaSqe2VfOVWlLqpj8ZU3yGkRmc3SGf3pOzuPn81AXMSfAkTkmY7gotpKMqTIOz
	fuL5vI/Z7GMdhl+H+NmsktOs+uE5Q7OxiLxZe9+Mb7g3c9xsyIxFBxceHH6iUm1A=
X-Gm-Gg: AR+sD10JMneL/vrTaMPCb3hiO7HIE2bdy8NLa+UH2Rgwg337Jcwv8rLbF2l+QRlYHgf
	QrzMMDUoC1S4B3ZStHgP4q64HwWTzeYY176eUZJ5RKTK9dlzOdJnc668l+pV35KaS3bfGCi29Jj
	hLX+6igLJ99y6wv7naoDxo/se+grnfuX5sH+N92l6K6Ykfq+Dg/SOsyfeDA1eAT5N4oEMZ5Vup1
	ktkH3DiURfADM3E+ePlHkxd80gAdLK5PZGqBdpInjRvju6fvqKVeXRBwtBdggqoRH+85HRuPBlx
	kwSbKUhdrPY8TdT7GNE9aJokHo85MQ+4OPgemJBVdOv+8p0D+N+RjnmhVJwI+ddIchVYewpEoVt
	ljIjFA2Hg6S4NnJCD8HSo5sFWlJX0225kFZvEM973Esk=
X-Received: by 2002:a05:6a20:734c:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3c92a5a8071mr12890698637.12.1785814945796;
        Mon, 03 Aug 2026 20:42:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:734c:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3c92a5a8071mr12890658637.12.1785814945289;
        Mon, 03 Aug 2026 20:42:25 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04506csm46284807eec.17.2026.08.03.20.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:42:24 -0700 (PDT)
Message-ID: <26bb2daa-555f-437f-99bc-b92080bec9d1@redhat.com>
Date: Tue, 4 Aug 2026 13:42:14 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/11] arm_mpam: propagate MSC access errors for
 hw_probe functions
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
 <20260731170324.2927758-3-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> Allow the functions probing for MSC hardware and features to return an
> error, and propagate read and write errors from the lower level up.
> This uses some "scoped cleanup" functions like scoped_guard() and
> ACQUIRE() to avoid the complexity of error handling when a lock has been
> taken. Since the mon_sel_lock is a bit special (even more so in an
> upcoming patch), we define a new GUARD type for it.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c  | 126 +++++++++++++++++++++-----------
>   drivers/resctrl/mpam_internal.h |   4 +
>   2 files changed, 87 insertions(+), 43 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

