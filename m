Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FF3C10AD
	for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891199; cv=none; b=jEuL3rMYHE2MjhcYAbSDadi/zR/pd93O9DQbvrJMnqGlCwMy8Uh5G9YVdqs+tCqYsT1V6VYwW3ugbk0kNyzOwaHgLKExqZzXsqE4sk3WnbHbXKRrSHilO6bkRSb4YKhwrImd58sIWw7u50z+w9UArv7uo58sxP4ZkEq3xxjAncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891199; c=relaxed/simple;
	bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i03CR3On5I/ZkA6/3i2SAz9R3o4ucFB7SoDG9zMnrlrLILXZ4ABhHp6tjTEddVY0rPqEwMc8ryQywODt1aRmK34/UIwSi5jr4FkC0VE889PyRYlRIO6kCP0i3141ax2RQQtjbOBRXH8csdR14/t6pYTOr0hEXZ8xdfhCp0GSFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/eQFjIG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/eQFjIG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4923139e940so14114805e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781891196; x=1782495996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
        b=R/eQFjIGJOmwIPpGAgwCpcPD7gX90JNhp63BcLpbxsSmEfYWhC23L8ze/2dfcH9zMN
         KJIGipk/2pZUHiSDNn6As+WfrOIekJ+SNEGKEK6+YnM6mX47b5wMXv77XGvIN1zaqIWw
         WGUekG7wyIg7AfKUrV/HQ+VswK4gC7W4UgCknjghxhb12acvDOKqh1Ffi8QHWyUMbCnw
         mPg6vw/nkHpOJLF1wurbV8ZZPiOmTu3Stw0F5Rlyf4fUFBZ9e5RULvZG9K0yzI3mlkSA
         57owJPUssf1JYAjTUpI8kqH+VJ+GYZbxgzEgDoQWenMso/gtj/Kbh6nISmYtAn3pGASU
         WqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781891196; x=1782495996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
        b=j8/W49N/GpO6XPQpA8OWx2HJ1Sj47N9U6jI5vbl37JDmFeNFp17tfkV+5sGjYowiq/
         rK/vKpisYtTJDXThsrWo05oRRw2wDVStb9XjnTa64rpebPzevfh1tI0sagiYGo8Ehmsb
         hb4rjUgJCLWy9Ipd8o0pIlz9q6QzwM7eEYxIsH0hGYfK7RkXtKLOm/4Nrk0aPTNmDYNs
         ATzczFuX0UxUT0HCcqbD8/wJbke5dmD9TF+wpLXx1CACq7bXqn2WuJryP/ZoPA1sEEtc
         K/sxO73WJ6viwvDxCYlkBdUT7ph/9xkWZzTLf6p2IFO5xs8e1tHeaR1y7zboL/vLRgSU
         Qj2A==
X-Forwarded-Encrypted: i=1; AFNElJ9LpLTQxTFIFmQUf/tULU6rwwTd64PMNd8KbmyhltiUUYhWYCsDqD3hSlyrHChwu+OTJb/je6zU94sr@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcWraTEGDVG3moLFibxf7AjE7LgTKrIsCNyOrXDcImwSilB4V
	+rXbaBiVpPjLHLnjKdk2gvyQSVR1P/8uPzXMbeuLHU+E/FnVC/JCFPhD
X-Gm-Gg: AfdE7cl28NfIPrtajjSIn7cHCdyk0qnhm2hjnNdarbzamXDIbMoENcvuUVNgBuwcJOI
	wK2p1woJv/PAxNvZO3x18mVbIxDT4jtxGEwIYxZvLuePhByduzREDQSsDisG3isV2V1yRk6bu2/
	tvv56EvnaNzB3WwPw7WsCtB8hHzzW4cCklTyePaJyy9X/kv00Lhyyn/l/BbY7EoGD02UZT2SsOF
	6YJ0LaZczaEjE2dwn39LBWX3vsErql/NOeyOt2/DJ89VX4oFyPLiLa7RQnZeuzlDVzDMTO8EVUd
	P7nd8eqDkXs8BcdMVeH561LvFToGziE3znpPnyAyzV28Nq8jPMh5rdtLA3fdATJo912TuP4S6Da
	TSD2UT+DZ+NFxuFZC92HP/ZL1QQhgFmk/fobITdTSYadtKfOsYS6d6YuCxmEkdUuHWtmNj5nTEa
	MKRbSABRQA/Wt00App+lKCotzVbFDwHzxWeJKzVTJxKV9utABfwUpcyrydySy54YcCHNGIUBSHo
	N0p1Ds=
X-Received: by 2002:a05:600c:a15:b0:492:39b6:5a30 with SMTP id 5b1f17b1804b1-49242591d5dmr53790795e9.35.1781891196410;
        Fri, 19 Jun 2026 10:46:36 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249238bfbsm1569755e9.5.2026.06.19.10.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 10:46:36 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <84dabe49-8405-4213-8b73-433cf736ded9@gmail.com>
Date: Fri, 19 Jun 2026 18:46:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ACPI: APEI: introduce GHES helper
To: Ahmed Tiba <ahmed.tiba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-7-91f725174aa0@arm.com>
 <58f7163f-2fce-41e9-bc35-d1d8e6f4a298@gmail.com>
 <81dd6d0d-427f-49ae-9573-fbe84dc2185a@arm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <81dd6d0d-427f-49ae-9573-fbe84dc2185a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/26 16:45, Ahmed Tiba wrote:
> GHES_CPER_HELPERS is intended for both the ACPI GHES path and the DT
> firmware-first provider, so I do not want to tie it to ACPI.

So what's the plan to fix the build error when ACPI is disabled:
https://lore.kernel.org/all/0f131ee4-d335-45d2-b6ae-49c18df1353b@gmail.com/

- Julian Braha
