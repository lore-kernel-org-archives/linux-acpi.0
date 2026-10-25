Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954327;
	b=YY3ft+FxW73sCmcV0TSo3jLtX9bI4w6AUUuaBr3QgUEnRgKDLL7gQCW4kZKKhMJfqJ8u
	 O8ywft9x0lTKsCDuItJ9VFusyWkB0foSeyctgeNrcBCp/dTkYqukEVR17TKFO/oUYWyeE
	 Dsmrz33z8AsJKzEVKV9Uq7pSICUDLqyFoI4uHroslCNdyo63z89u9vhRt8AOdukXkBej5
	 0DqZ6M0lFMpGBJtqbK+pJtPbGpfbkYNi9/dutbrms1J3ANg1g7JF4OUzJm01rPm2l2nCe
	 lqQFytsxN0BQdSWWX+V9dNp2Kv4PfZwpLYBi1Zkfw0uyTMc88c4q+erk9BuO9k6Ymww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wyaZ7BGveZumfF7hscS0DMRBRSSbSHRt9FPELcPqyEk=;
	b=TZZOzrqexqUMY5CcgZQ1ZWNjFrzxRNq+o32esNec5KWObCXBJAMLk/hvnloDxUnQpMKh
	 ezL6lJ0tIO7t47UTzNgpkbkWMCayW+gh7Y9tG5bY2nniDnfRIHfhlKJD+ujxBaEl/s3TB
	 +O7RW+8Axe8TErtK7pWF9hooASnoAGNp+YAADTgqszX0XjbEXILXJvTw6iQB6MLCZCx29
	 xfqm/56edQmJIlXBVNV4QfULY1gH3MuEkr0JSXcjTsqj3b7qo/bf1UC7s/Oi8MIOjcSZy
	 09P+n0/jdl7qhdt3a3+eqioIXoKBKGqmikuZVg7I0/p47XbQSpjezQ/N+YyW62vltPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XSNUmE39;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D03606A31A
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 18:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D03606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XSNUmE39
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53669f7b518so24648831cf.2
        for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792954326; x=1793559126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wyaZ7BGveZumfF7hscS0DMRBRSSbSHRt9FPELcPqyEk=;
        b=XSNUmE39If1FuL56L0ck+PHzvGyU9hPoG9sZiFevEwP5bykPi8wx1Px43IXI1Al5f3
         R/0cHSoNaSA+SFmZNXU0iAiLRGhmDfU3beeMBJSFQGd75YdycFXnPdzN2NhaZG2Yn6x3
         3OvJ0ZlkSQMaShb9Oh+U2ioBxOagNmxbxYc+EWdqP+K0VBIOjrb2Ib6JZJa9TFPoR7c/
         /u8c7wTKqmoxVOHR+tB+6ACrSoRr4wXECjirCMQp4XzU/k82MBb3F5Vo69DGmTpFAcjy
         EuGpa5tkOg0V6esrhXGQ7ZaerM2NFh2dLsmtoVGryBE0ac3VCi14NpR8JIyHhh4eQmr7
         pmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792954326; x=1793559126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyaZ7BGveZumfF7hscS0DMRBRSSbSHRt9FPELcPqyEk=;
        b=1xn08pqGk8ctKIdnJGQZabS5EpPvkX2xlVAk2CnAzh2EVxRWTrRdxQQ3cNfwhz7XeK
         fki/tISEKi4JEiBe9+XkvgW/L+EkJ03PpJvjfYTTJs3QKH2BKfrvlz6QV1EuUZAzwIsG
         SVbnIpYjA5Q9dJt/J5CS0UbeyZvu3Yt09PtP/qBooW76Coe/EUTPHfCFAq2arEV86AoB
         kd0Zf9shn2H6M5tKsE9iPGZRgH7weCzi4GG9cA02sAb12wZ41MoRcXjldHAAjrUB60p+
         0BygQIBSvZDnUBx2pZgkW6Jm/ws+M1jwg/riTiOLpW4WoS+A1rOumU9OXwt/FA27WUD+
         lZ9A==
X-Forwarded-Encrypted: i=1; AKwUvByMLij+XJGCHb8x/3WaTaxlz+g2OIwKZmigK9734O2E1k7HMas+h9eoWvhrbf4T1rzTMGpTMIekWUgE@vger.kernel.org
X-Gm-Message-State: AFq9FYKovDiM9F+WNwXPbURY4F5E3RjlO5/9jvZK1sXm/CZk3DGxztae
	Q88bfnyTieHEcbFO5CF+8WHDGkBFHvexA3J2xBWiMArZpUGMR7IujjOZ
X-Gm-Gg: AYBFou3cBmM4X8AUdIEe24S7sGkZ7qUJlwJfVbLifuEB6cNB3bgLAU522L1h/l1yrF1
	pKqqxkfZTRI06lMp0jLw4QM2MFxZIYOzY1NwswnOuk8TCcT62cOdiLk8g7reA+cf0gybN6eFCTS
	YLuBtFlxQf0fYaCzWJiXvivlOZ/VyHV8vILhO30rUeCWM0Rh6HVf4aTB/lJpUwE6CLWOjZtygAR
	4UMZLlisAEy+LRF90Jh+teEVjL3VmCzhF3ry1aUXtnlvCtHcGKtCIrKxHI32vkJnz4j4Pxl+8yn
	+ZjC7/g1YjqtwiyDngoBXwTyJT28cgkIuQKWg2KfpuWGbcuA3sZtRno7mbEP64xDuNGRbvzLvEX
	I5p7dpt5Tf7U4qA8Fq0V7bag43dZo7TfYz2zBJCyYE2S/XPQKmsu10tbLtFBcV2A4Ni7pWRexF0
	KQRkIdcKVfapAoYlK5nZkAPu1ANmaesLWnZ5FWquy8fWKfvLgJO9iF9qQc5HSahqLi8bWIuqpxs
	9qdxS8uGLzOErqaoZYJdqNjANFlxOVRY57uO4F5WcNvuwrhZspjJutOIURge8IMQqD8zrTgUCTb
	PeOJOcBuT4RGjmcx0u+56nxiwbaj+z0=
X-Received: by 2002:a05:622a:8b08:b0:536:7747:3712 with SMTP id d75a77b69052e-5383b524fc7mr74981931cf.37.1792954325611;
        Sun, 25 Oct 2026 11:52:05 -0700 (PDT)
Received: from [192.168.60.8] ([207.115.103.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c54cbdsm51721106d6.26.2026.10.25.11.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 11:52:05 -0700 (PDT)
Message-ID: <a6806b89-8086-4297-83f5-b7824a503099@gmail.com>
Date: Mon, 26 Oct 2026 02:52:01 +0800
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
Subject: Re: [RFC PATCH v3] platform/x86: panasonic-laptop: Add
 platform_profile support
To: Wu Zhipeng <zepwu@foxmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Kenneth Chan <kenneth.t.chan@gmail.com>
References: <20261007190446.38862-1-alexyeo362@gmail.com>
 <tencent_7F39F02728B55CE3B1878AAB51BAA0FE2D07@qq.com>
 <2df90a2a-770b-4439-9d01-bd8105084719@gmail.com>
 <tencent_36C6A22A8A475F824CB6BAC101A1F272E709@qq.com>
Content-Language: en-US
From: Alex Yeo <alexyeo362@gmail.com>
In-Reply-To: <tencent_36C6A22A8A475F824CB6BAC101A1F272E709@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for taking the time to test and follow-up. These results match 
with the other machines I have tested the patch on.

With EPP=performance, the TDP toggle works (~10 W locked vs ~26 W 
unlocked). The fan toggle influences the temperature. thermald doing the 
one-shot _OSC unlock matches what I see on the other IETM B machines.

 > 3. Windows comparison

Based on the data, the unlocked power on Linux reaches the same range as 
Windows.

 > 4. Quirk status
 >
 > Noted on holding the quirk until the power side is clear.  I saw 
Ilpo's review
 > suggesting reusing quirk_cf_sr4 for models with the same boolean 
mapping; SV1
 > does have the same CEFM/EPLE mapping, so a simple DMI alias would 
describe the
 > driver's behaviour.  One point I would like your call on: our SV1 
table is
 > cool/quiet/performance, exactly like quirk_cf_sr4, but the RFC 
reserves COOL for
 > the SR4 ("aggressive fan + locked TDP").  If you would rather non-SR4 
models not
 > expose COOL, the SV1 mapping should be limited to 
balanced/quiet/performance.

For the mapping: I used cool on the SR4 because the active curve was the 
aggressive one. Your matrix shows the same shape, with quiet about 10 C 
hotter than cool at the same package power, so cool/quiet/performance 
fits the SV1 better than balanced. I left the QV9 on balanced because 
its active curve was quiet enough that the difference was not worth a 
separate profile.

 > Either way I am happy to wait for v4, apply the exact version there 
and test it
 > before sending a formal Tested-by.

Sounds good. I'm not the maintainer, but sending the CFSV1-2 DMI entry 
as its own patch on top of the posted series seems like the right way to 
do it.

 >
 > If there is anything else you would like measured on this unit, just 
let me
 > know - happy to run it.

Thanks!
