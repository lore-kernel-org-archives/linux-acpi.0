Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D44457B2
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838232; cv=none; b=K8VHhlDodUuSlUepI8X1p5AJzEBXJoo2Op62P6t93+iTcOb16kXNTF6q/gyxIQya7Ii1a5f8GzfqgIpEULrBIJfmzx+sXFpkhtRyNGpUD2P4L+aMldWd/ghfnwNS3q3TRnrxn5IPTRFi6WBUWfNAwUYXZCMCPnuhhcIZDSuFOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838232; c=relaxed/simple;
	bh=rQadTISyIyt+64+NYnKtupY0oo0nC4sKeX8xC6U+has=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEki7GyYuCxIv4DWvvVq35xCRicTBUnk7Ofk3F/qh0U8Dx4aUdD0fiBYo94q7ZhXFamKmOQpyZShTK55B0IK3QkjNG+YEz/Gd8XD1rhH2rlTyJPGQ0S97egCe/Hxqp7PLLW7ISSnsJQxGGFAj7PeE6b25ycXoy+IbqAZghKSsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsOnGbO8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsOnGbO8"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a051b73866so7075277a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 04 Aug 2026 03:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785838228; x=1786443028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQadTISyIyt+64+NYnKtupY0oo0nC4sKeX8xC6U+has=;
        b=bsOnGbO88BmEGijCblkq7pB8DXI3ea9/PSuNsrS1tBwPey40zrDK8x59vHRK5Sxq1D
         lW/+VSqzPVjJYx7Lc7X7NU6MnL9FeA+xLwEZQklBoqc8ty9Od6jHX7dwyyLFtlxDYNA+
         0yqkB8GorK1Cn5j4mqICQKN/4GlmltEAeIGaChNq73DaVu1bfB62UQCIz8k2LXUGP+0B
         B7CCMSVcgvl+EpZbVU8iokIcgBTNdqRLIsidmKz8g3V1/UA8QTfOSCBkzLlmH2HSGcbF
         bzVx3A4SWSp4S56jIxV3sM56pxB/rQKf1UPT+UJL4wH4ns3uK+ArYu8uY5St5/pdTTFi
         vuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838228; x=1786443028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQadTISyIyt+64+NYnKtupY0oo0nC4sKeX8xC6U+has=;
        b=otKBL66A2eshPa6nr6jsvHcQVSWA9d0NzpJX3WRF0WWmhDzD9bZWE2+85cUAZaC2Tf
         yDlI9tFfkjwAJaRP48e1J/PhkPEc4SnXjeNMfGn8ezL85vH09fRbZCa08QumYql7Wf/3
         P+pt2sXoeOtXBYqqPSBrSHj2uOlmoLkiAIbS9NJfYJk6UftVpULWc9zMSMq+QDPnNMnJ
         zo7Updmosru1f9vQtlORK2UbCgBAMgUjsNM2Hu3WY256WlRnhnPPLxbxnd2TplJgku0A
         y7M+joKdvpVFEK5dt39qkTJNlIm5Sc8MmwPeDIIYNpLJ+Fn3ziOSnY+xEj0BBxgr1DEA
         QzpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGANFr4+A1Melhey7DVvoWo6ybkL3mn8eF+NVSrQHWZwCK465dYJwr9JwJwssabQVtOjMadNQVDSLx@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuleADigEmX4NZ8Oh0YDDnTm62/qRegxHUB+y8TOpzc6LlGB3
	tWvMj+kddUOTxbSyeRyoILe+TXCqo51NSrfNhBHVLxypGnaW920CnxzY
X-Gm-Gg: AR+sD10lfd9VYyWi/SK5r2eAuHMQ3CXm3fQnlkcCMh5LHD5w+kZ64B8p+FFH7eqQto8
	US+Za2IaU27hTkRCOEwgOgO5BIWwOeUs/FtrUy0J8i3N7YIC59EFKcTx/E8i5GjMoBUguFOONSg
	WSw7Nhqa/vY+DtT5otTOnmbUTnrzQ4xWHz+QNmIKJY626hRIKt+wlIEmiEtLj25Cwfn0kfqXt9y
	PIb+kKM0lWSrmvuCwIiVq782QPelks8BQmxu4VV2APS6DEitVxcXUryAqHxHHp0J4Nkqygfs5/G
	T9661fHcTa50CZ/Tm8+BD4vw2HO0AMvD7D+7KHuhrzlP9ahSq+67xMFF9EMFUD2h9aWHcWGopxr
	pAlyZzbmmyx1lC8+2KrLDa9BgThqWI0kDwwV0dMOwsfoNkA+t5qri1yNg+Ng0oU2vHKBGtPbW5A
	w9WFjkpPRtH9jGOFS5zAKW10b9s+fS3nTItV/INGTkquPEMQKhzehcptF6
X-Received: by 2002:a05:6402:4591:b0:6a0:a492:1f46 with SMTP id 4fb4d7f45d1cf-6a0a7c61027mr11459221a12.8.1785838228405;
        Tue, 04 Aug 2026 03:10:28 -0700 (PDT)
Received: from [10.0.0.5] ([59.152.127.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c63daf7sm6419448a12.18.2026.08.04.03.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 03:10:27 -0700 (PDT)
Message-ID: <a532b34e-ec46-471b-b755-b60cb16a7dda@gmail.com>
Date: Tue, 4 Aug 2026 18:10:20 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
 <daf0bb9b-246d-437d-87ca-16706113b201@gmail.com>
 <CAJZ5v0jByxtQ2tmNm_ZyyBnDMBNjuqQwD_367NRyGNzF7wQtRw@mail.gmail.com>
 <7792f017-42b0-4a09-9941-5259138e21b1@gmail.com>
 <CAJZ5v0jCFFNuG7WtCE2CG+hP=YNsYMdXH_945QgkgAUcr4Lryg@mail.gmail.com>
 <37daa35f-06aa-49d0-bf0a-1b5ac9f44c89@gmail.com>
 <CAJZ5v0jyy0+hqU3=gmBrgMzLBVhdUQwDj8d0_jGCqZwqyWT=_g@mail.gmail.com>
 <588c2e18-e6fb-4fc1-95d5-7a5dd0f556fe@gmail.com>
 <CAJZ5v0gXtKEaNDdSRqd57zg9GbFN-VDHrU5-=EEQPdSa9Zk-xw@mail.gmail.com>
 <CAJZ5v0g4ctzLpEro2Mu7EbSo8RNmYUCM6+J2p_ExCXseQAx13Q@mail.gmail.com>
 <1da0b5a8-336c-455f-9098-a8c834721039@gmail.com>
 <CAJZ5v0g6He-X-C1Ctr4nsnL00mgLiD1mThwyX2jhUj9qKV12+A@mail.gmail.com>
Content-Language: en-US
From: Julian Silver <mendaxca@gmail.com>
In-Reply-To: <CAJZ5v0g6He-X-C1Ctr4nsnL00mgLiD1mThwyX2jhUj9qKV12+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-08-04 02:51:44, Rafael J. Wysocki (Intel) wrote:
> https://lore.kernel.org/linux-pm/5120454.31r3eYUQgx@rafael.j.wysocki/

I have tested this on v7.2-rc6 and it looks good to me.

Thanks.
