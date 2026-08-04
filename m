Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0834E761
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815495; cv=none; b=mlQHBHfMURb53klfaVNd7h0/kXcU11+Nq0ElbdLLuCRWvlFgQOLONXmyXRZSr2J6TFgEuZOrUjPTS+VS6uvN+FgcfyuHb4vjxSm3ZMFEuHypiicWL73hn1r5lolVVRjwBS/T3Eb3TCqIax9jbi9n9tnMW9aKvUbQu6RudhMG/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815495; c=relaxed/simple;
	bh=Z9DzALkUPtVq0KZcS0GxKNTLT8s7dDub5GBdjETpBTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLskeRIvuGK3LyjbZleCf/nNzrOB4xUiyXxcv8A3en7fQMrOmhKuIKhwSyqMUIw1/4g5prFrawJArfIq3U/adfRpvvlggC/cGgaxEuFEo36jyuIoRCgo24sJFsZu2IRihEo4pORfw1iCSmAWY1EhB9peHAPbZQSUA9AAl54uEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEg/ig4S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kimylMVl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEg/ig4S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kimylMVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785815491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5OLeruoPybsSS8INmKDHZ/s9uZy6DjZH/QBW4ejIp4=;
	b=KEg/ig4SuwqWur92TjYLZhM7wEfUJPKhLVcrPMHYR1sFmhSdmNLW3T7aGMquXjOs4uXIsg
	YDvaZcQ47Q7oA+WfL3yv5J/kzHTMGiJugG/ih8xovqlUJy+J3fjHo64vrmQTnHkzYZBdGI
	wDvfkpa9DoR8bq5xVBfUMVaRcBdpQB0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-R2u0xPLwPi2_zfqdKfn9hg-1; Mon, 03 Aug 2026 23:51:25 -0400
X-MC-Unique: R2u0xPLwPi2_zfqdKfn9hg-1
X-Mimecast-MFC-AGG-ID: R2u0xPLwPi2_zfqdKfn9hg_1785815484
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca3673560so74353645ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 20:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785815484; x=1786420284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I5OLeruoPybsSS8INmKDHZ/s9uZy6DjZH/QBW4ejIp4=;
        b=kimylMVlOCHNn+xoddnKqpGlPXgB9Zm908T8E58z4g2I7lxxXN2YIPBHujPNoe/OnA
         sAxw/10UpBupAwNxL+YkGGQ9dEgdpgo81GUgx57NKI6zdaPyz3ZRG6P7lxtPXb0P4OD2
         jz/ogYd9kiia3fjUKv/G+ltfPMO2fq+0M/jUaz9MlnPrqJam13jecik2y4VIZVG6KbKI
         U70kGNsuS/xoGmTDhUWjoHHk6bYAhbYoiCHfE6W9rIA4OAlwx2Fj8WKasbuOY6b33A/X
         3BAwZg+MIUlyb6sMAELbb7fLlZRlSNzmET02D+ISMYTVdivcrZOe5tJEvfBjy8qIoy/u
         W7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785815484; x=1786420284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I5OLeruoPybsSS8INmKDHZ/s9uZy6DjZH/QBW4ejIp4=;
        b=jgdANLJ5eYoKJrW3G6xNwUYG/5kD+Qwh4BCDJAkO2bAcS7jhouwvCbaiD1CO3JHcdg
         r0PeGix0KFbkx5e3xFPjvtBoqRXCZWoHtd+RghVWYFS6aK/hgNll5UhpVTEHjLOgmwVZ
         +F8tpFUUHYZlIsT0EstBzJBugw5vYmPbCcCNTOKkKt5dsV3oxgAlQ2eT3ZFahd4vgGX+
         ihFhN4pI384fFIB5w0HC7Z1ITF15jLZlI6DXsj8u0W3HSk0ET+ATWNpU9GO8CxXdPidP
         6fHgxfWTTg3dzCsGtixTGj6m90JZWKvZw2UGgVOH8eVjmpDhejf7vhQxcdQL5DFYi6t7
         w6+g==
X-Forwarded-Encrypted: i=1; AHgh+RqbGTPO6cVeIYaVAqHQkohlsvViRmUhFQZanLKcy1hxDGBwVyfzfbTo8Q/p/aeJ/iH3zbZ1q0hPnTJ/@vger.kernel.org
X-Gm-Message-State: AOJu0YzcP3Py8+wNBKpcEY4pB9mZ221zrr4x6bTKaHuzgsxaD6DOPo8V
	SyeYUyvg3EjYvhyC4Q5SfnsLbfEbImsMKUtxWQA/5XI4IaK4Q9wJIrYHd4sN1UFvO1y8IwO3DaN
	LDNO3a+/mAYCFDbnxVI01COcGo10JHvQYPTjFrbuWk6//uKKNgs4gC/sVCo/r26Q=
X-Gm-Gg: AR+sD10W307cxSZ2kTBr2Oha7NVPx1YWsJ/uTc9LYuI8Pu3bJsTTKmGMG7PonRA79Ye
	zeBA+k5Vt5LKAZ5E4minfBxG5v/6zq8fTFZgLHOjAWzI8j4jOXxNVDOKUAyTJRFXl9vNR4qcW9L
	ogCsFsaVeLdLkG89X6Y/V/sJQKBIxT84iNb24bJS8LV1LF5NjsrQ+UE3f6+XORBvM6YrcBEqqov
	1Azqodc+GE+rJXVDlrD2AW724BIUW9nc8BwSgWOPtWE/4gUJpr5Xb50BbXqOVELhXKFFKMUPKEp
	rOlioxNNHIskzoK0C3kFjNNjwKx0XxjdSvJArjwlJvBf096r8ZYfHUow5d4j6NDnVQckWQvDhcu
	/X242zwrIz7kW5XMTuwrWHtuAnvkYKcvCcGotgGnnTNI=
X-Received: by 2002:a17:903:19c7:b0:2ca:53e1:b915 with SMTP id d9443c01a7336-2d052212c61mr131820255ad.14.1785815484476;
        Mon, 03 Aug 2026 20:51:24 -0700 (PDT)
X-Received: by 2002:a17:903:19c7:b0:2ca:53e1:b915 with SMTP id d9443c01a7336-2d052212c61mr131819965ad.14.1785815484051;
        Mon, 03 Aug 2026 20:51:24 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b82sm46004835ad.6.2026.08.03.20.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 20:51:23 -0700 (PDT)
Message-ID: <bfe951ad-9c41-419b-a042-79526dae028d@redhat.com>
Date: Tue, 4 Aug 2026 13:51:11 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/11] arm_mpam: propagate MSC access errors for
 __ris_msmon_read()
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
 <20260731170324.2927758-6-andre.przywara@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260731170324.2927758-6-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 3:03 AM, Andre Przywara wrote:
> Allow the function for RIS accesses to return an error, and propagate
> read and write errors from the lower level up.
> This function is a bit special, since it can be called via an SMP
> helper, so the prototype must stay as void. So propagate any errors
> using the "err" field in the struct passed in as the sole argument to
> that function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 36 +++++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

