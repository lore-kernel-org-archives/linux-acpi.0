Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C63C2799
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514913; cv=none; b=sjDUOPB11DELTLPA1iBSF8RDA1RIuA567EcuJwDAhMIocI1tFQwxrYolpBiZeXX1eobtiEPtqw+uSP0pSXAbgTTniwQbDDQ79DLCkkcldgxvtkZaJGnULkWd4xp1Q5HBE1fV6CTzXq8VCxsnC2wem8jElqP1r23JXjwA+iPWDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514913; c=relaxed/simple;
	bh=xDpz5toXT9+YnrNMtuCC5O0FW4S4IE6N5NmMAjyruQI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKU3BabBRS7yA22rXJoUyRyZeuHNVNqbOQ50cS4ovh2rSZAkccBa/wLD1bcWJP95bzydf4sFUutUYO4GyPJ8X9Oc+PX2B88vLgWCXEECRRdKHLU3Jwf28Cngx9DOT41+MBk/f+5LhQWmVNco//dZaDGA4d0Ga4jngeIBlWcVhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaBDsuuB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaBDsuuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1792BC116C6
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774514913;
	bh=xDpz5toXT9+YnrNMtuCC5O0FW4S4IE6N5NmMAjyruQI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=RaBDsuuBoxRR8Qgxvg+UmO5s2HdbVnCJ0XdMWvufgUaAdaZns67Q3xi0cOKih1S4w
	 v8DKEUyIui23rs4Z7hjw4rbchPkqyeuDhZdfMlUOYWEOnnFdiljamN2Vs4MonazcM9
	 /NnenSW3iVfaEwVZ7t3JzXtupUSRZ08iXrklLXOuVrlg3tD7vO/GIa6uKMicekUn1Q
	 CwZNC15gHeTE22JTO/Bh2RHV8Fdco+zDEker5K+kXxnIFIKzpQvgKX5r2NJNeM9L7H
	 xgGID5ptAHpiY8+Ut5ld7Q0z7SS6bJqAVGJAmBXE23g8PWTlBK2OKFPc2XXvj98qVP
	 7MP+fyPAZWFDQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38bcdda57b0so5032371fa.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 01:48:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWf6MFgWaNZvmCQCdEDyfZp/R7RT0DzIFEp4BfvkHJ6YLc8u7R+YmtdVjNQKocJvppV/66CCBI9yk4n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7t9wDuo3M3jDiYrVYoNGCOzs/YHFF9I3aH9NXviGLxT96FHQs
	e/HiTvu99AWaLB1JQhhQWP3V9jaGZdSeFKw6Jpw133JfCsgTRVgJ3wpVhjrgLYDDvocU3Z5kf5Q
	9a12v8A6XJlvqKM87kg5oj8COJFwbx8JNJVUaDhjh8Q==
X-Received: by 2002:a05:651c:1587:b0:38a:332c:777a with SMTP id
 38308e7fff4ca-38c43206b02mr27254831fa.34.1774514911324; Thu, 26 Mar 2026
 01:48:31 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Mar 2026 01:48:29 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Mar 2026 01:48:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260326-pci-m2-e-v7-5-43324a7866e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com> <20260326-pci-m2-e-v7-5-43324a7866e6@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 01:48:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfcT2hLOQ6yVQrvdgimsA1oDzGM3e_7nAWyUAFoOyhH6A@mail.gmail.com>
X-Gm-Features: AQROBzDDnGGEISO25bRpZEkvayXNWHPvGoERJaG_tDIkHVVI5jwB71NCISyV7hU
Message-ID: <CAMRc=MfcT2hLOQ6yVQrvdgimsA1oDzGM3e_7nAWyUAFoOyhH6A@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 09:06:33 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices. Spec also provides an optional interface to connect the UIM card,
> but that is not covered in this binding.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
