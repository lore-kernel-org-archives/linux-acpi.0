Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257638;
	b=SBCCAEBAxWzdY2ffc/Sam4wGPK/9WJZjetJ6E540pYcjAQapp3g4zAqb7pgQeFi5pW88
	 ps8nRZuVXXYoPkIJ+WY6TDw6fPtwKQfZaiKhcAIT5Jy9OG5CkWqAK112xc+4kYK5yU2is
	 WHTXjwRm4GzGEg4Zunaqonu0bhMKCizAGAiXGDnglYa+vi4u1JGsissdCoPc0rJjkJXF5
	 pNVActw7faQYuSAPo9uNl+8v16WvH5CiJuHuJNV1HAJ7tTgw8LHR5xVT581F40iZlEYHm
	 Qb11bsGp/BzUtzM29Csk4eYBlLL9go05PhnRr8X/5hkJCcnEDtkMmE+Hn9MP6oatUyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Jmt38VSybUfRmaDQpT1smyRUpyrHpCkYyLBz6czP0+E=;
	b=MxtU0WW4kZyiepU/pVVq8GHLz1iiP37Q6LtvoRCktytKQQWTo7H3LDxXaGivbZWLHG7g
	 sAFE4PCAHTYRTovj4srFCQd1aJ2Wc86adDYDWZ4jeNVP1SXCzWWtncWuXgAYWVFg8y06C
	 P9UAKLFDeLBf0CvOQHbmjium7F9v2EyY9bQceOs5tri/lvwy/z7V5UM84EYDyh9axhxsk
	 x2YF8qry3XYK8xdMsrloIdV7rT3OKOp//DwYD4ooUwnWLad8rqeBzBCxoCLlC8Z6v2qHH
	 7cdsLirxXMbHkr/0mXIvpGz0k03bOVUtmxcscntuetAw4XkiciZCM5iFNgoWOJvOLgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfOffgL1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BCC606A325
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 20:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88BCC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfOffgL1
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b309147589so14281337b3.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 12:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257637; cv=none;
        d=google.com; s=arc-20260327;
        b=A0mc5EUkxghh8J0tlsrQxEJbWzqP5LoyZxTi5gs1g8+8i2E2Du3h+gMKEhPp8VHof0
         HB7chMNk8/6bT+wfR7xwJTfxS0sAb1REUI+S5/71HTLrS/dzGh1gZ19BugqkTl38PbIV
         tmjaMKQ5jW4NX6Go1DdEkSocLW+dDWBfZ8NPqUrwE1Q80nXbHMGRqRfVv99NxL7pCMN0
         uowKrNFR3OvsfpNeZdDKeMRSK7LJmxVxlxw174qv7cmDlddEeossOCXOA/SP3779o3Eg
         vKS2nhXOdwoIOoa6gG8AjySJTEfn1kbr9r9jZgohXCBuZg4PQOZxOAxIuT7ANMBLJskl
         Kt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jmt38VSybUfRmaDQpT1smyRUpyrHpCkYyLBz6czP0+E=;
        fh=5xfARx3lzbVOx1kCpAwfZCylAiZKbG2FdNNjIfEdP1c=;
        b=ByTAkJafKu5T2O5WycKth078k8Qz0aBffgewQp3CATzd1bK8ZnT2/r3qL+gf/fU4cY
         XwMkl/ssT+JS13cwqpgVYME5UgnanHvLj1xosDwOfdaLLLPjWz1Ph5Q6WdV9U/u4O3LG
         WndUvtAjrpRgV4AK/VR1RUIZtWBhfVWksPZ4HtWg79N+k6Npz21hGodUeL30Sh5VaM93
         mvgM3srh7oogWZbqEx5aIAAs/eOZlQzvNEK+gCU4upSFH4ylUodNAmDRgiyR7TpiYzg4
         XPZiwf0fi3e2jCJGZ0JpE4gM1q4EJbJAdMRZfobx0dlU7RYzd9r7HOy5qNG28pb+WC6l
         pntw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794257637; x=1794862437; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jmt38VSybUfRmaDQpT1smyRUpyrHpCkYyLBz6czP0+E=;
        b=OfOffgL1e5pS9KApLqMKSOtYp/PiC4nEGAGeABKgi0XaPguyLagXG4iTOIObju11mY
         ROboINMPx18T8yjS+hrOxAcZ1PoOSowoXNRoXA+OAXblcktUcyiJTHd8rK9ki3QFOZVF
         HLcPhfhHUHFtyDCymVL9EXd7xgGfN2NY6SSME7K1lEUir1iBe8Gz8HsuA5Gx6IRihVKZ
         JCC7REJDFMQ/yNTOJ1OwLEeF16uJME3Se+a9A0tLVgaFLbBQDN9Cn2ObQjWvF/sagiO6
         J2jvlkVdlK5SiAY2XBpq4ImK0D5Hz8ApR0zoHw8hZTG3l3r1QdI56yeLarMivwmfYTZ8
         +WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257637; x=1794862437;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jmt38VSybUfRmaDQpT1smyRUpyrHpCkYyLBz6czP0+E=;
        b=JwLmGr4fhhzqOAiEIbkRqBYdfaKdlg6iCsyscguu0zaMxmA09+f6lCCJcg4fiQrIyM
         QU+SyTZd7bp3RtFyEr7Qst4k1ArZCmKMcHNQ6lEbabJ8ADNbdh+Z6j4j0wmNGSJOCS9e
         qKS4ptbu8zo2uIyjJa6hk7bM2zNGyqTRJTB0AbcNZaV2nzoaDtUns4DaOOIS+VdWj2uo
         4OFlRmWePoDCDdETdWCCELLMprG6dTL6SJ0lzWq9r61ldgYkNVzGZ7q5qjGlSI9XysNy
         k3ULIuG/FJvNV2yszZDp9OG1rpCLd4V2ODhAikNp2cBM0oFWEL1L0wJ5esBgJj2cYR6h
         tNtg==
X-Forwarded-Encrypted: i=1; AL+hErF7WLNSDuAhObSn2MZhya1ywRMNjhPwMAiMMQRHh7M1LJGaXryHPogGdwNqzXHN0o8uAN8Ay8Iuq5Ll@vger.kernel.org
X-Gm-Message-State: APuU4Z9I3rNDdVK1+WoCEQluYjN3zCsRBpkM7J3WKPkoV+Tzh3dAU82D
	DTi093rozLXyW2tCC9ApQPMwSsAz5EL1inuzF83xkBQgPlV2hx+yVAdypwmlNqN0qxAe1Kcw1/y
	vSjiCfH0WtEEyuxdW9GTP1CeqOYSC1WE=
X-Gm-Gg: AYBFou0+pCbk5t9j8tRuNwBtkkiWbbEvghD5HDnfQIapOcrsQB55bk1OcZ68n5es+7M
	0M3Xpf7cpmNFkCPku+LJZfzrIsgGLEcV8O1asKvLa1ye5MuVSSavHT4RrwekZJgw3LgYS4D04nf
	7Kth/Zv4Wp/4gj9cKxIOMm0EboqQv4OJh6iMtsFb8DWuI+p9nzj6cUrBmEQ9qvW2lXUrELerHoT
	RvXHGxCq25/F9lKgDbnfUb+JoEjZJxPhW9ev7Yu4U+MhnNYLpv0DjiUBlMCbcl0q6T8UNIikSCM
	aiIlB+eiUQTKB1C0wJJ/7in1EAd7E3dIiLWog5jJbEprGGQLgM7ArK2I7Oury8GeXZTnZYviG2H
	lwspA/Ig1Q0VhiApmLrmqezrQCyKpcaLWBBLVkdy6NUyBvUtxdPgs6aVoZC8IxjyzfEAIDjo21y
	ySqXPXqraQbHWtZUXXHeG2ErwAp+taDP8Cc+qBmYfGyFeoXGleoYQ/36k4w7/DH8wa7S90DkUVQ
	VXd0l0=
X-Received: by 2002:a05:690e:1442:b0:67c:c1d:e5ff with SMTP id
 956f58d0204a3-67c56156f8amr601035d50.0.1794257637455; Mon, 09 Nov 2026
 12:53:57 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
 <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
 <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
 <CAE5sdEi9iOwEmuhzWZ=O5u30UVCbCerckhggBqEY9qU5jBce4A@mail.gmail.com>
 <avBSrChTZTQL2rNj@shikoro> <avG91GDyffzeuBVg@ashevche-desk.local>
In-Reply-To: <avG91GDyffzeuBVg@ashevche-desk.local>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 9 Nov 2026 12:53:46 -0800
X-Gm-Features: AclHuK-KDMKaM_e9NpAk3xqUpIS_Ve35CQkQb83drMO2sX7vNTmcfNH71KM102c
Message-ID: <CAE5sdEg5YMcJd0nkej92VKWDK5kpCzfyXSf279Ri+k6y9r=qNQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Jarred White <jarredwhite@linux.microsoft.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Allen Pais <apais@microsoft.com>, 
	"rlmenge@gmail.com" <rlmenge@gmail.com>, 
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>, Jeff Kirsher <jeff.kirsher@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 04:34, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Nov 08, 2026 at 11:45:00AM +0100, Wolfram Sang wrote:
> >
> > > For Cobalt, the firmware exposes the designware input clock frequency
> > > through the ACPI HCLK object.
> > > Is there an existing way to retrieve or configure this clock frequency
> > > through the ACPI tables, rather than hardcoding it in the driver?
> >
> > Calling for Andy here for being the designware + ACPI expert.
>
> We don't have the common way, it's unspecified. However, many drivers and some
> firmwares adopted the "clock-frequency" property. Unfortunately for I2C it means
> the clock of the bus, and not functional clock of the controller. So, I'm
> afraid you will need to have your own custom solution. Also makes sense to look
> what ARM people do in the same situtions (I know that Qualcomm tries hard to
> enable ACPI on laptops, if I was you, I would ask them first).
>

Thanks Andy for the suggestion. Not sure how to reach out to Qualocomm
ppl, I'll figure that out. I'll re-spin the patch for now.

> --
> With Best Regards,
> Andy Shevchenko
>
>
