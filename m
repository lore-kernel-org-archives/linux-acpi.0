Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731C352C28
	for <linux-acpi@vger.kernel.org>; Sat,  1 Aug 2026 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785546964; cv=none; b=hoXJk1YFiQmRlB1RMD6UO8N4cEiISntWJspgydZe2mQYAxoQsZwml1HE3g2XSuV46NP8aTSVlMVnAq2SiTYae2o3cQRqHXQn5ZnsdE3E4fVDRri9wfiCbmPK4bZ3p3ff2s+4+JNuvXsJsuaNWFqYePc/4lx0RRVYh5dK6UOuuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785546964; c=relaxed/simple;
	bh=P5DcjewuX8maw0JP6QOsw+RzcVQfrHT3SGrqsYsm8pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZsiWPiMiQ9becW5HqZyRNo82OeDfPTbwF2Bohq/cb9lV/aVqajXC5q8RB+KkS1pX0ECURh0AinNO5/n8A8QChgHkmvcWMOjRSOIpSReSxgSgv67uaGw3fumpsZa9wdbWXhqWsNsJgPoKEkwLh181FUPgfo9AMGcPUKCAlREGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUG2PBht; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUG2PBht"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4a456e44e01so836267b6e.1
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785546962; x=1786151762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5DcjewuX8maw0JP6QOsw+RzcVQfrHT3SGrqsYsm8pc=;
        b=EUG2PBhtzmnPToycy9YV17Sgre1g2YTm4OMWJUqch279MoleH2d/7qowQsEyYbz3w/
         ggOE4zNqAjq9/QExBCUGQ1jOkudJzs6F8iZcjUfpiRBdJDLp4duyg3dMwlO6b3CwH4tw
         Xu/BYa6h3ktkqtWeZyf+d+NxsYdoH/xgFgawhmp5Q1H39P1LNsK6imFJ16sFUDA2riQX
         N/ciYxsIYjBx9TynY/lsNhs2ob3UrFAtlCFTuOYq9LzJt9r99M8ffs3KY++C9AhshxV1
         KPKRufWCexH/F2e7hQ304v6pHVZp0S62yT4Ce4+B1FBGMVAbVu5cIN4xSx7cqCmqpYgL
         5LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785546962; x=1786151762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5DcjewuX8maw0JP6QOsw+RzcVQfrHT3SGrqsYsm8pc=;
        b=UwF6JgNFdgPp8PDb7cst+1IV4aQfe5EpGquT5vx7ha/SFUSYkIRP5jY/VbVqUA8oyi
         SlS/Jr3z0dxkRAhKD1BH3BBufG46kJGLlyU++ZuWftPqTu1KiaIhXgiebiUVd4ju17b9
         y/PGL51L0dJQ1sa6BnFfYsLQhaDgCdapa+slX+O8c/9fDvfiosuSPVpBpAPjdyBTQkGU
         G0ZwTJaJ6W4NzyxxkD3dg35kEeFJVSo4jhsCp0AWDtQr6lZtTRx0kr0ewy4vLFlAwhb9
         uofpVVp3a1M2kX9zqW+DeelWLWEpLhJgJr2rw6uewCT+S6K/mRZD/5VpAJfQPj8Vep7k
         312g==
X-Forwarded-Encrypted: i=1; AHgh+RoyTbAWUGXCz+FfzIjh6Qzzg0cPIaeyXH+sakwkniUByrlRnZvcYZBu0lCnHDMtlnbUbfW7StTdcDXS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5NpDX0HJ31SMrabVa8VbOglSPfv2x4FVcSghqO/ttcdrvCDOx
	8zq28KhFR/o2YbFQu4oA36wx5HPgAEg0rfgu29t18JWAM797+JuGcnVY
X-Gm-Gg: AR+sD13EyZPJJa/D2GEAOrEAjbcc38UOQ6cIUQ4P5g02cRgRvRLUcGNUrsPooULrW6z
	4ewwcLSG7Y++3JMkF7uYwdixyfvPWXHYVtF78oVa+725xdvRfF5YwwD6S9Yvwyi46yUzgWDxM5L
	eNXXKuBOechUzkdZkLFA2nF5Fpqwexm5UaWekaV7pemVjWVqN9gGKYAjdJeUIkOgfxm+6EOOgIV
	wTM2FB2TwQp+LEcZquAYz8CeDUFEWanAgRCuX5Eidgt/GDeFe0gk2JDqqO2NGfRAgaAvssodCRt
	KjR7N6xLpiLiusHJRduXfVK3vTvlSYQfZMDSON4Vg0Zse+np1KU4fZ9HKJ6f6MNhaJHnajqe4e1
	KW7HOnMOo7zopyVc3Dk1kscDoUEWHSwfjjr+td5URMyehMGktt/1wMfO2/GDFdgEGuWsWSq0ujv
	o2imd9O5q+wFeq/UNRy4gvBM8py3B9c5MzOCkWCCN0QTUxTX1lSlhQi4yRRg==
X-Received: by 2002:a05:6808:384c:b0:4a3:f4b7:cbdf with SMTP id 5614622812f47-4af5e2725cemr4182772b6e.15.1785546961793;
        Fri, 31 Jul 2026 18:16:01 -0700 (PDT)
Received: from [10.10.0.5] ([59.152.127.200])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58ce3e8esm1904627b6e.3.2026.07.31.18.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 18:16:01 -0700 (PDT)
Message-ID: <1da0b5a8-336c-455f-9098-a8c834721039@gmail.com>
Date: Sat, 1 Aug 2026 09:15:55 +0800
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
Content-Language: en-US
From: Julian Silver <mendaxca@gmail.com>
In-Reply-To: <CAJZ5v0g4ctzLpEro2Mu7EbSo8RNmYUCM6+J2p_ExCXseQAx13Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-07-31 22:11:15, Rafael J. Wysocki (Intel) wrote:
> The attached patch (on top of the current mainline) should prevent
> cpuidle governors from requesting idle states deeper than C1E when
> intel_idle is used until all of the device_initcall()s are done.
> Please see if this helps.

Thanks for the patch. There is no more -110 error after applying this.
Feel free if you need other info or test.
