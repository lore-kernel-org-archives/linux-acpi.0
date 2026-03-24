Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C919D8AC
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326100; cv=none; b=jbUf5svkRr2oUmf8c0p1DOi7Nl6AOapqw/zYmu5xwvgDBtKRcoBjYwul7jYDgOQ7StDP8HWpBmGN2EyCqI+/Yigi8vG26O1qBxxRtIv7OXokAgQH9T5RyPo/3akAinZCTPCChszJ0ttlEj+5xVuMyiPm4UgDbYeU8OvMorvpgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326100; c=relaxed/simple;
	bh=tkaY8+W0TSIaH0v036Dt5NNFgwlG94/sTxmp7SKH06s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu1NiLTUPkKOr+wQhV/PmU7QigSMBPMSMrz11HQON8/ihZs2v+gVWRoGhmLrIxcRNP+riu3BmzJ3xr4gfAfODR4LHM68CMXxPJPjKNZreMILjMTMlOyawmaHIhMyQajtFPfzT1WOKsLV0xeyf4UWrQBACad7UaRVvH6ItUXoHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5G2v6Ue; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5G2v6Ue"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so4641011a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774326098; x=1774930898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RLZupWEMPPAm/gSNoe/pgbNbAKYA8/GEUylx6djroFs=;
        b=J5G2v6Ue7lBavCTsKhxmbSlvgNBbCf2rM4l/sFyYHV7hh6l4AAfBCjQSebkDqJgc4P
         f7Sp+PCHJFeYDv9xMlynkhVOYNehphjmK+7SbtQqqbVuiy04IE6VA/uLZuVHPtbITksQ
         ym+VJyopEJgP4x6kmlfBbboAeS+5XZI/Cp9ROhVDlB1McumrcIJVworBKBQWlVsgU7D5
         zFenHbsYXAdrOVqyhJTjO0XLdfPMG8wiFg3v2fbWqYdCEBkBauoeebAIFSdPdVGkmvyk
         ++ZX6He0xPwNAfwQCYHXHdRGsihe4TLt8CNhn3TZGroDd2eGDcHDACXn5M20NPvEQfum
         oCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774326098; x=1774930898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLZupWEMPPAm/gSNoe/pgbNbAKYA8/GEUylx6djroFs=;
        b=ajdkJf9g9qfrjmHuUEbBjxP23A+qhUKYfx6LYEcn9y0RcOkknOV/b8z0IcuG5JdQ26
         UtvqN4Kdg0FhZkF/GtbNAfQniPY/7ddW3br/hVq+MitHwIl5H5zWjU7hhmyV2OgCGh92
         TsZj9onzRlfF4f5L4n+bR6V3r7kZocZn4mIaTuQAsuQlAsrvehPtHA2rvOSLUuQ4Ccy3
         kFHuKAJ3DtUDbMRix79Zuri3JvvcfFp+ElXkbi+v6P5qUAe9/kRr1Jb5vcWT1jW6pTV9
         P3rmSJ+1x14rnS2YRoi6lPwUnTRPsL3TqGfllUBJhLJNC6OGcbdDH1bt7BrisREYiLRD
         af0A==
X-Gm-Message-State: AOJu0Yzadr59NMkERbKw3Geh2bS+fLdXdh7LFn9hXq1tmz7IeUtbYnIh
	5uVs4d94OoCdv4HJ7lj+Tf/OkpTbaFN/x+71YoqK7Azn93JlTDfx3kCV
X-Gm-Gg: ATEYQzxsrbTuInjtDnNHukmMZoNzIV5ft6F/pq5N8JjoPwxQaNWLbR1RCsfYL4HPtbH
	qqKORFt/iAudCppW9WW+RIDk79XLccDIi65WNINt2pJG4DQX/JGK6aa2CWmOsTIbWlHIi+kuPol
	jVc/LbharLOE6xkjXfdhpqqy2Pzc+0gc2jlq6clzwVryJsu798PwrEH34iDbeE9RFfpDDBwLhvv
	ZidigSIujgfHtmPrW5vgwDY544sNwDw8+XyGewOwvO8NPeJVYrX+2kHkj4CM2FNGD/x+yxiYYM1
	s9GUvWU1cA2TuHITaosr9HYDmWdpud8DPFRYGJmhhsQ/2tUq7YHtndbpwXDObpWX0NKCk5961GL
	zvJFyGDxyxMjHtv+tatI1LGbt2BH81im+JkPVxND/U35kU3mgqz/lshTwbRNj3SKrHGsVh9n6kC
	/YHC0XvX9z7K9gKhwl45PL3SKptxEh9EaKUJkHOwX8UJtImwFK1qAgSvvmLmR87aqOnmeXfAp2
X-Received: by 2002:a17:90b:3b81:b0:35b:a53a:7d0b with SMTP id 98e67ed59e1d1-35bd2d1fe84mr12461024a91.20.1774326098147;
        Mon, 23 Mar 2026 21:21:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c02bf1585sm243302a91.13.2026.03.23.21.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 21:21:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <95e255af-a1df-467f-a516-7c9b89796acb@roeck-us.net>
Date: Mon, 23 Mar 2026 21:21:36 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/26] ACPICA: Fix NULL pointer dereference in
 acpi_ev_address_space_dispatch()
To: "Dumbre, Saket" <saket.dumbre@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Chmielewski, Pawel" <pawel.chmielewski@intel.com>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
 <3030574.e9J7NaK4W3@rafael.j.wysocki>
 <a0ef8b7a-ced8-4384-9d88-e98629596a3b@roeck-us.net>
 <CAJZ5v0gWZmppLYZRu56s1FtBm5eZ15V1EkvT-T-Vrfo2WNWPDw@mail.gmail.com>
 <SJ0PR11MB500584283698C48BD431BE5D804BA@SJ0PR11MB5005.namprd11.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <SJ0PR11MB500584283698C48BD431BE5D804BA@SJ0PR11MB5005.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/23/26 16:26, Dumbre, Saket wrote:
> Hi Guenter,
> 
> Yes, the experimental AI is spot-on in this case (although this is a very rare corner case path)! Internal buffer can stay uninitialized when field object is NULL (in case of loading ACPI tables from memory, doesn't target the PCC region though, if anything maybe just the PCCT table? The flow gets really complex to track each individual ACPI table), but otherwise, the other 2 fields shouldn't depend to be initialized on the existence of field object. The easiest fix would be to have a nested inner if (field_obj) {.....initialize ctx->internal_buffer....} and unlink the dependency on field_obj not being NULL on the remaining 2 ctx initializations. Thanks a lot for bringing this up and please feel free to submit a PR for ACPICA (and get the credit you deserve) which will then be pipelined into a patch for the Linux kernel when Rafael picks up the new ACPICA release commits! If you can deploy the experimental (or better yet, the release product) AI to find more bugs like this 
> and confirm after a human review if they are indeed real or not, that would help make ACPICA a lot better!
> 

My knowledge about ACPI code and ACPI patch submission rules is just about zero.
I'll be happy to submit patches into the Linux kernel, but I don't think I'll have
the time to learn how to submit patches into ACPI, sorry.

Guenter

