Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86068339714
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272740; cv=none; b=jyyJWXux8ICgLY4oL9j63vMswhWLEKiikE9mo6apqaZyEjUfkTES3ywrz/lCQJzft2+ncd2d3iHrEV38vEr7WQGp15MV8tKqm3aa0ygGAmDnPGWY7FW7I95A9kR1siIQ/hu1awL9zLCCxpE8b4GUHPEV5+/R45kPpQ6TBY9KDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272740; c=relaxed/simple;
	bh=rCOj1B3gr1JnXoG7HSverRstLScVLNetVk9OLJIu9Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYcgBf51X82Fgb1yoEzSi2kRo7KkoNhiPGAR3ITJ0Us4lRO/MCEmOjvm8Js1mcQDnKHNnLBFanvy/fJNj+sSpDk/ot47pQU02F9hBva5UMmYqJuEtXQ/qqT8uq3cs9gbPHQerDIaUAgQx1JPBEI71rbC56jcI3NLemw6YO+RVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2JO15Sm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2JO15Sm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso7080945e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272738; x=1781877538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/VUlUPpXOllmyVmEEDrtg8rYUBnngZlNPs51gJxMN9Q=;
        b=j2JO15Sm6m7kqDxHFbmff7Fcn2FaxAYOTGHxTSdGgRNVf4WmMMi3icwIQCLjK/OA53
         P5pNSXzMqP2c/CDcjov+wRLENU0KBYuTCG/jygk62yRNMa2Hx+q9BnYoIvKbK3FZcvUu
         uRG/v0jLtQ2EAIqNUpDh0Ah2BZiBLegD/1gQMHcElQ/RWVeioCEwhw+trk0dkgWpqruj
         KQYNI7iRueBthed2rR/irC2opL+aEk6xK9yUC8oEr54j3BbJKLL7rasYT/feZM0nRgH4
         fYcIZVrSeYGlPpkXTl54nEDV2nLytFSEK88gc0fX9ijKwBwX0Gkhxkz0GsBUQf27zfk0
         21rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272738; x=1781877538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VUlUPpXOllmyVmEEDrtg8rYUBnngZlNPs51gJxMN9Q=;
        b=bGmAcN6UPlhCIP8s9RJMZfxbku67sGsZkihdGba3Dar4O3N/NQnLT5hYQZNWxsuE+9
         QpKQjBGFR+3aJl9/PyfltYEeIjRG/2PSaswIglMNogfGv1Gh4kIbD4bzSt46l6IMwmdN
         szwTjgmTURD92CXaM/kajS78wHRni7kr9Dn1Pk0tU9hck3C69H2tN+4SoAPT/lespsbP
         WG3Yg1gDhgl8qd5WSmeCskc3Zs/PW34HRUNFZDefOJY83aXhkLT156lcZEP0TP5LOPCv
         NyoBDNdmHMJ1qTzEr8Glci1bHyAVpsB6Vaww6GqTh5LOBY4yb3rTAJoWILV3KHH5r8k1
         rqxA==
X-Forwarded-Encrypted: i=1; AFNElJ8tUp3tjcCr4qQoVe1EQpeAYCTfJgTXz8LWcs+0YNYy+jP2isMOTL2ZR0lnUS6ZkhOymF5PXbeLn+fK@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyDyJ4wxqEUnnOiiq5s3/c93YKMDiJAPCXzQ55sC7ShGVDTol
	GPmjdQna//530VSKSs+nsyFdzn1/vgEfE0iS2IJ1E5OIKernQ6VMwZB6
X-Gm-Gg: Acq92OFv+6nkxpsxpSMzggeR52mzK0R8qNwjvXCT8aCDEhQ6SrkgrJFqzvh41ZcoT9o
	Kf1SQVRa8Ue5XPRHzksyu1jNF4rxHzxYrVoRv8p7kyR4y/4jPOkj9omQMcFe7q5HeiSsTaUDKBr
	V/BLX8drYV3RYvSwzaVvaGXHsSn2I2KcyBqLO0y/CDGwFFRoppGlvjqfXiTu3Q+vwu2YOMCgZZy
	oL4DHI0rmimQ44vFTmknmc0+13mhqcPnq18AlvWvi/6ABHv+wJodxNRiMBxH8SJ6lysYRc2tAiL
	jhyOoE9Cp/coMprUNwsi5dMDr8MlmzlaGFoQ0I5ZzIHqAcADCYLU4o9ovYe6jmzvagoBGEskzt3
	kQy8abWGQ11sw+hbwO633nxVnM5ARtzmHfAVORZ4tU8GybAkKeTEjae0UaZ+MKzh3g8AtKK6wYi
	LKugen8yDrIL0KUbK37GtCY5iZLd1Ww6TeKCrK1KoermMbeaH1LIYqz4Ji+GGcJCo4KvEYFhkkq
	nLwPwyqyAmu+w8NfBY=
X-Received: by 2002:a05:600c:2d53:b0:488:b187:3c with SMTP id 5b1f17b1804b1-490ec4b9023mr22801305e9.14.1781272737618;
        Fri, 12 Jun 2026 06:58:57 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea9520f9sm42465265e9.1.2026.06.12.06.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 06:58:57 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <2941bab8-e61d-49f2-ac6d-30d58c8a16d2@gmail.com>
Date: Fri, 12 Jun 2026 14:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ACPI: APEI: GHES: Add Grace and Vera KUnit
 coverage
To: Kai-Heng Feng <kaihengf@nvidia.com>, rafael@kernel.org, shuah@kernel.org,
 kees@kernel.org
Cc: csoto@nvidia.com, mochs@nvidia.com, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20260612120929.28965-1-kaihengf@nvidia.com>
 <20260612120929.28965-4-kaihengf@nvidia.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260612120929.28965-4-kaihengf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 13:09, Kai-Heng Feng wrote:

> +config ACPI_APEI_GHES_NVIDIA_KUNIT_TEST
> +	tristate "NVIDIA GHES vendor record handler KUnit tests"
> +	depends on KUNIT && ACPI_APEI_GHES_NVIDIA
> +	default KUNIT_ALL_TESTS
> +	help
> +	  KUnit tests for NVIDIA GHES vendor CPER parser helpers.
> +	  They cover Grace helper decoding, Vera payload parsing, and
> +	  section routing.
> +	  They are enabled only for KUnit test builds.
> +	  They are not intended for production firmware paths.
> +
> +	  If unsure, say N.
> +

Hi Kai-Heng, could you hide this option from the Kconfig frontend
when KUNIT_ALL_TESTS is enabled?

E.g.:
tristate "NVIDIA GHES vendor record handler KUnit tests" if !KUNIT_ALL_TESTS

From Documentation/dev-tools/kunit/style.rst:
"This Kconfig entry must:
<snip>
* be visible only if ``CONFIG_KUNIT_ALL_TESTS`` is not enabled."

- Julian Braha
