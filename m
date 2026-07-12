Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795437A820
	for <linux-acpi@vger.kernel.org>; Sun, 12 Jul 2026 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894890; cv=none; b=t1M6yL2Mp+LcCXy7Rtcglyv1Z+07xCoV6Zkd2bAS6BlzzedTUvKaDx7osHUJ1hPali2ryx04SlxOpXMXYd4yyv26HcqMDM0TB8d9gIo82u6juUOvLNblnJPfU81gexPBym+uJh2ytnNjolBD2mbYAJahC7foR+gLMRat9+olyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894890; c=relaxed/simple;
	bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+c/fnzh2OhYubO5jDISMNt/almudaFcm+0oIo4octF6lEZS2uL2Z8cU1VJeJkmOnpvdoMdhDZaRsORVOgVKKsWPJimJJ91JUu3V2AvtpXNQGSowzjgF7XOxRiJHMAPoYuLRN1X36YOkdBUY6QVpV7gzXCB3yvbbAAvR26FOseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=es9ZEdAx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="es9ZEdAx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17879855e9.1
        for <linux-acpi@vger.kernel.org>; Sun, 12 Jul 2026 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783894887; x=1784499687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
        b=es9ZEdAxIcbFw1bX0rbFbs/J+Hem6iEGnVb3ZzpzC6RcVxDjUV+idFAKIpsFC46Bym
         A/NJGC+TpeGR9uTk1yl0cZhka+XaPP+4x/WdCcJiokP/wRe4i2mas4FhcRYPtdH8QVJs
         V7GDZ0OS1F8cBp81RmUxJEsc6UpLwZQSLvhpd8E6dy5KxXeOLZdyAJolQRvZNyEKSW1w
         RUbJsV7SWWKR71oOuu7yIRX91gqaRGW3imRr91cViZbhhGPRcJgN1gZRoli/a8HMzAwq
         AeDHppeB6kJ4VXUsBKiopTipGR5RjYeWx6PPQPAXjR4DpMD4kr80exOPMvKiY3ehJRdP
         Y6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894887; x=1784499687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
        b=VRqq05dwMV1Xk2iVjWCrdSKK5k+CrvjA/0Lhjo23/hit+QGH+1AGQarM69uxZ/y0Fh
         QNN/UVW2SXTrJDDkW68X9Pj8kmqR2NzJIBVLR08OLhgiTHfM/R02YUUm76xAeURjvwfv
         ofX8182whPEulMkhI78/yias5LkHZxunD5QrfBFGyM39ypG6YVeCQg+2E248RIbE/WVh
         Zwei4X7wCqh1gotx1Tjx/EfQpxuYnydrf4k8O1jVvxTwuoiRIcsHad7KqV+iuuBQuMgo
         2GubVzzcvYroroCdQ1kpfwX+JuGsxXCrJcvW2OCk6Lmyddq4BmUOnW1zNnU5BzpwLK93
         Btfw==
X-Forwarded-Encrypted: i=1; AHgh+Rof51eQBDLbAGqYUTjeIK7lgMBZZ5v52PIfEB8I+Z1/9OAoBL+uLTnsJFSyUfThI1QiUui/zTEDXgj8@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+7RIk4qGmicXF6jJLqY33DlCTHwGx0zO3ZfDciMEA5PFbaJM
	3bHKS1w2AI610VV0ugPFuieiQLy+O2J3FEU4SJI4bjn5tM/M0npOv/pJMu0RE0KvWuI=
X-Gm-Gg: AfdE7cm7oUwSJOofEq2uBmSG5Ph1lfSu0j+vIqVvoUVTFO0rCdcA2xLMbTzun+snDOJ
	ARscrl/uHSlNJf8flWibqdF+J+5o2FMKYn990EvTO7UbTpiYEbiKkiw88UFizen4O2FZgjLH7IS
	lSvFN00HC+/PGODngDhfFvdVj0Ghrjxb8AIAUJxrdbn3zTWg/OT7rKB3fURWDZcMLe7yOTAxnaD
	FQUUk/g1fWQzpN1rSau72mRBSX5RnGbbo5r7ineXNXSFkMNGehWC1eRVyI7QhDBy8k5j5ZI9idW
	SlIo7kaM31JsbUFzWify8N04inFlXr9+fM3TcF6aTTcXp8hX8RG39ThjLsIpFazCckrZISonNt8
	+lDsAhU9y8me9shley9N8P0WuAc6AmnwbGCgmhKKEYDzNNGOVSD/8v2VQzV9OLfJRQ/AUD5NT+X
	7MJLu0YWivBDpdrXU8xw==
X-Received: by 2002:a05:600c:3543:b0:493:f6c1:2f09 with SMTP id 5b1f17b1804b1-493f87dc753mr64927015e9.6.1783894886966;
        Sun, 12 Jul 2026 15:21:26 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb742a49sm296924145e9.12.2026.07.12.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:21:26 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:21:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, 
	Dmitry.Lamerov@arm.com
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
Message-ID: <alQTUuwze5ZjGabk@monoceros>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o63zw6szpf3k5nqs"
Content-Disposition: inline
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>


--o63zw6szpf3k5nqs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
MIME-Version: 1.0

Hello Ahmed,

On Wed, Jul 08, 2026 at 02:59:09PM +0100, Ahmed Tiba wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--o63zw6szpf3k5nqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpUE2IACgkQj4D7WH0S
/k5Aagf+IcCM3MbiQFXq44EFdGthF9zwEU47GU8P9/gSXah2GXOz59WKWZqRlJgo
j4mZ9uRbJqwLqZ7OtPIZj1IyEY9Bmeix2uL7sJuVUBcZ2qRaX3OxW/xi8zEaH0fi
1DgPWPB5MHOhvc5d5JJAeoqaV3TCXNxNEF8uvyiaGJWFIr7oGvWZVJCPTmjbqVt8
vzyFYzCac+qNGAzM6F6FhjNsegEgpsSAP2XIIruYv2+iPpHWzMbx+LpknKOq8Rws
N/Cmj3SBH5ULfApKqkL4QqeHk6RnfAclAjr/EdYS7nE6L5Bdot9DOOil56IDxCps
pX4u0VGI9OqUoeIeIDXaS9GJsG261A==
=Eag/
-----END PGP SIGNATURE-----

--o63zw6szpf3k5nqs--
