Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794059770;
	b=2V5NFCDGVo9T5gp7CWT4cSiISeoHGjTTyKAnuaQvNxczy9lLaZ30b7ERlKv0iz+8uXt4
	 ovMQ0DayCN8SUY+Rym8U4RW4PQv5cyKp/dtbhsAMkF4/igZrLj61SV2UAdJrFtPJ6/F9V
	 QaCTj27MZ9uFXvc71p8denSZowIV/lHKDibrSWYk1sdbJIHh/Nx9PxCT4B7BE1t0Y0zuA
	 8VIJxaqlgFWBdbzdV8n0dpgkf5b1jb8LU539oEqTrxVnkDA1vI11b/1wI1jCAfmPevCXH
	 Azx5RRZYP5u03wqXUf1OA9Qo/6ZTyydV4uSdMKMK8Oh6Zon9sJjPb8IEPc8M0Iciixg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794059770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vXwIUjXp77hYc2R/kc6J/JRFYx1vYu9yjBnWkWwz1xo=;
	b=aFWZ82rf+BBu2+eZE5rMP11Et/A+lLpuXnuP2Qyas5Jr3IdxrGnrQ+oRZlv/nBOns8eB
	 BTcyCAkWBDiadWajq18Ud0IX2czpl0rg1TSgwPfbHLR4gjojm+lIg3nSYxhFKWlqwnri4
	 Bt1GC/AHJMRQTeQiiuigrLuBTLHWjhvMaA+wAKDID6nO3shGT7W3eM5JYLTfiwlsYjqRw
	 npjXp8MOHkmdMHRcCdqYKZeaEvBZ7Idl9SeaM46hRB6BIxib/IWyEbWNlwTkyKYR/Arvi
	 zFse0RvL3tG24Iuuo+nXHPe/i/O1kUIR6t59pTD0rBsRze+7u08El+iG9O/TtIhn1Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QPQYMWy7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44570606A326
	for <linux-acpi@vger.kernel.org>; Sat,  7 Nov 2026 13:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44570606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QPQYMWy7
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b31448caccso13314937b3.1
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2026 05:56:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794059769; cv=none;
        d=google.com; s=arc-20260327;
        b=QZIPJTNCDNzRYQVgEcVQDfdXA8XQ5xa8sbHZJ4weR6VefIDvDJZWktA0yBxTqjediN
         SamEEF54iaJsJIAllwVige+qJ2L8R5vix4hJaRhX5t9Nw6q7svZVLOvK2VaDmkIOKL1E
         Az+oXce1AoJsYu1sb+tmiLojXkhMwq9SOcYfXls/d+RW5B1hJp0RXRNRR8QjlBwrxiPH
         fXmqW/q0id3VceMPA4Xls7JrEch3YLkbOrGK1cTGixEzv/D/q8LqQZh5kHXC6WoPX9FK
         Jk6nIjp48b8ZQ4O4RkeFpXsqH4GxBSIeDzk0swGL7ZRmLGZ1ZrjVBBJkt2S6JxPHmneJ
         1XWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vXwIUjXp77hYc2R/kc6J/JRFYx1vYu9yjBnWkWwz1xo=;
        fh=nMdqUItj5z3FEuSnUGuBSLU6Wf8mIYru0qLxKU69xAw=;
        b=SHJWTBtGBUjdtz4xYg9nhBT51YYawYqat01aebR2MPnOefMhM1TV9WVEHeavriPg5u
         ZcmFqnF4rkPcEd/42DnyPGgrnZkXKomxdrbIRiF0PRPtCpoS+1VIq11gewzBOcU1UfP4
         wUQlItiaB6d5qXgEVo/mrwI6ipZ0U4CETukbZZAKpECCoZndiQPxkPmZwc01PacCIHL1
         a5SHqQ5xl2U5Goi+AqC3yLAqur2yXca9/uxyK/O8V3knPnNh56I9KLZZiqj3fyEXRKy9
         GjtDGu4QVztmDgvu74aqaFvqnVkC4v1KV0Sgnn4YM+sxcPxlfMswU68WFf4R0yMULxFL
         yeAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059769; x=1794664569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vXwIUjXp77hYc2R/kc6J/JRFYx1vYu9yjBnWkWwz1xo=;
        b=QPQYMWy72eNto4tQUnulLnMpxOQQX/+irw8cRocDOhl9IH9rYeIx/4gvYRebRtiWGA
         am8rG7QGBYIl8M+fFafPUSfBe847J4JVotpdxuzP7k5CTx8Ckt8NQyqFZVDHGtIpcglC
         Vx45lLt6uPvcvYGKX4UTuRNlKxAaKfWsvWeZqliydSHa4eKNP8mYJY1UsTO+hRy48+BE
         GQ/SBw++WEXgNykb8D9QbUxKn1wKQXac1b6c9g4+xbB0gWWFmsrWObgMQfrSsM3tx4L/
         5vz0HzqgZROT4/9FxvrUIuOkQelqER9GbwrLUzpa+J2vEFWu0zTB96J75JXz3r9SdApq
         m/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059769; x=1794664569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vXwIUjXp77hYc2R/kc6J/JRFYx1vYu9yjBnWkWwz1xo=;
        b=kAZUmw4xvmBtxRV3JnYKb8Z5sG3DK7zOKBBno0quLeWjU76ik+9whvG/OohYug2eCy
         i9tRzffu+udcXEFumvrdKkU5sGDb6JL3vljvZv/t9z7AkJb+D+be5YEc7ltHLkAC7/G4
         R/BDcrBMUaxotVOsrTl4lLffGcfTq+hofG3bpr5UxtQit+DVx4SzLWX8T956yDi6Uxgj
         480IruRd6D6aJjtOoE5EFAjkCJIfBPcEQxK3pDtNHapblZRnE+9406hjVAHu8gwtBSmr
         VKB00gDGGw7uKpSjDmVhSd2YC3rp75Qwd2YIMBqH2XmqmVKwVAD6/RxQR0obCzH32Aoa
         ibcg==
X-Forwarded-Encrypted: i=1; AL+hErGurDSheut8yny0hfJgSt19fOYztstqSRb3PMNlwrE8wLqJYkr+g8XZ06d0AONCffs6ivEVpnCaCL5E@vger.kernel.org
X-Gm-Message-State: APuU4Z9c9xHfOi3SggjEEt7Dq+MJ5JCsfr/1BxBC8jzowfTWeoVzoUsR
	IiXUlG0FJlzMq6nW1h08pzg+R4wGRwueTtcFCW8Hl/d/JJdXmskEDSoz0B7Rl+rTknEoIhw8Vou
	M9eLHB24AhHGu/rDf0s1eSAbrMWr+Y6g=
X-Gm-Gg: AYBFou1bKWGVbEViYM0UVY5nUjlFMJLzWtOq6a7lb45C3VaP5kHKC9XJMvKB4b7DK99
	fjzGqhpU8ZP/z8wniVxJbEXQivEnkT6q6rKkZQrBWrOd2mOqKaKVgQSliXmF4q8NPW7tfHXSMi5
	pwqT90FfY53IoYXxaYkdElHiNCNp2Z9tdNrYcDqpKJfHjWnxX13NwkWm3RcnpIsC9iF7Vs/3XZT
	YwO5xg63befrF6mEaqcR7y1EAYHpfX8Ao5AaDXSxp6VbvgHfL55NUMHTusrNObOGXWYQ/VTjsci
	mwhilWCvew9YU44k5GQhNM04OJXfLgbH48cewSkn8mYqiItjDKvcgBb6+dKuJ4W0s0C1V5soMSP
	jpmEqx4yzT7UbbM8sc703d72Cvp1qDUPBEW7KAP7WtV753Hs99JgzgSHykSRCok6xjIukYsBvMv
	ISUo+eDi5Zx7i/aLWGv7K3f/VUKb3KI0ERJBVqApq+O8J1lAUOwfYIXHOsV40lzUPL4XVXkP//S
	8VEZL3W6RyXPNdgJKc0JPYBchV71Jd2SQQ1si9HSifOc6wECI9/YCpQh6KS+A==
X-Received: by 2002:a05:690e:4144:b0:67c:1d44:7887 with SMTP id
 956f58d0204a3-67c1d4484eamr2616415d50.13.1794059769189; Sat, 07 Nov 2026
 05:56:09 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107210058841pJqeakmrIVxw9Uu1aqCHK@zte.com.cn>
In-Reply-To: <20261107210058841pJqeakmrIVxw9Uu1aqCHK@zte.com.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 7 Nov 2026 15:55:32 +0200
X-Gm-Features: AclHuK-iIbre76arm7YsKKgk9O4j5Q4N4M52GRLIKhagF0WUvCqb_aZvfwDucCA
Message-ID: <CAHp75Vcv03fUWx1ebtZtGsURL6s7DvnKPq4K_Zr=DT6OTjc=PQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: lpat: Avoid division by zero on degenerate LPAT tables
To: shao.mingyin@zte.com.cn
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, 
	andy@kernel.org, westeri@kernel.org, srinivas.pandruvada@linux.intel.com, 
	rui.zhang@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 3:01=E2=80=AFPM <shao.mingyin@zte.com.cn> wrote:
>
> acpi_lpat_raw_to_temp() and acpi_lpat_temp_to_raw() linearly interpolate
> between consecutive LPAT table entries by dividing the difference of the
> other coordinate by delta_raw or delta_temp.  The table is provided by
> the firmware through the LPAT control method and
> acpi_lpat_get_conversion_table() only checks the package shape and the
> element types, so nothing guarantees that two adjacent entries have
> distinct raw (or temperature) values.
>
> If the queried value lies between two consecutive entries that share the
> same raw value, delta_raw is zero and acpi_lpat_raw_to_temp() traps with
> a #DE exception and oopses the kernel.  The same happens in
> acpi_lpat_temp_to_raw() when two adjacent entries share the same
> temperature.  Callers such as int340x thermal zones and the Intel PMIC
> opregion handlers pass firmware-controlled values straight into these
> functions, so a malformed LPAT object is enough to trigger the trap.
>
> Return the endpoint value instead of dividing when the delta is zero.  In
> that case the query value necessarily equals the shared endpoint, so the
> other coordinate of that entry is the natural fallback and no interpolati=
on
> is possible.

> Fixes: c55d62820efe ("ACPI / LPAT: Common table processing functions")

I'm not objecting to the code, but this is not a fix, it's hardening
for sure, otherwise your expectation is that we have such a table IRL.
If so, this commit message should have a pointer.

--=20
With Best Regards,
Andy Shevchenko
