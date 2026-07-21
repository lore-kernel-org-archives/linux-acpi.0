Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF483C1F5B
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624992; cv=none; b=eQwQ5dnBtQ4+nvVqG2v+qsqXV956zf1V2qYApdVaepIJA6Zg7j4YArKW5xjEU0H1+0zOemL5Q1cSugj2H9pKxIOn/oMpnKiANmv2f1f3id2mAU7MxZVLgfqxObFGDBGRWtGTWvqnYWIEgUSrgvp4tNFT1bfRmIghFKtCJcolI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624992; c=relaxed/simple;
	bh=uvM+G7VRk/YqTwwm/37jHxsh/YM0a3jwdT/iGpNt7ns=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATE9nZ2WqaxM4ZsarBp+rHAhEEgiiz6ymdM8GG4ccvBMgJmzrvCjUYHwdmD7Y8gGtM7wWidsYBSgj2aQXqDfNPwynIpiZFeWkhcP8i7n+1eNNhi4JQ/ya4xq2CgvdGJZSTCduSH9U2VGLvTwaWV7yUIVvB9Z4gnGpenFTFrHnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVQO9e13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVQO9e13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED7B1F00ACF
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624989;
	bh=uvM+G7VRk/YqTwwm/37jHxsh/YM0a3jwdT/iGpNt7ns=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=MVQO9e13QUrl1ydM9tLxQtUaLCsnbcAtu8NgunLGYE4inVyVPW19Oav9+VQRrvtqa
	 wmKELzHocua82VssA7btIuIuDdOSyzsdxQUjVe1815Zw/htwZXJ+yQtpe+a+6wt5wh
	 +4j1aVXPzGCBf7oD26cJMav8pl/WEdSZrXJuFV0Zy0Fg4XrpxIa68x5pQQNY8vbOon
	 2Jb4Om5yt/pVv3lweKK87+3r6/K0Ayn0C1tuO52khz0O+QvalM2yny3NEZ0hZ9HF7h
	 frdv1XoaboFv7IEsh69K3VaUb3f5IZL78qHP2sWT5Aq9Z3gHI3BUoRl6RBQJCedg/p
	 0FRgkMqlPYC1A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c74722e27so55735451fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 02:09:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy7v3n06m2iMoGtQkJXl9vxZBXjvoE1p53gvQnFxAVt6+SlyRWy
	73KwKsWN5GPNOlhHthH/r3tCeSRKUlSeatZcdEuFN97Qx4NYfeorTIgzcURf4v1GNtl0eLa6cDu
	WGRqwF62/RRu6zeuog5jVxV/pqL2BAL/df5dYBzlMRQ==
X-Received: by 2002:a2e:b8c7:0:b0:394:8fc:8c3d with SMTP id
 38308e7fff4ca-39eb273c8e4mr29254061fa.4.1784624988499; Tue, 21 Jul 2026
 02:09:48 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:09:46 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:09:46 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260721065413.2306137-5-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-5-wenst@chromium.org>
Date: Tue, 21 Jul 2026 09:09:46 +0000
X-Gmail-Original-Message-ID: <CAMRc=McBNjvJK-dMBgifFxtgw0-bM_jaMYwJOWCRnV1PTLt-2w@mail.gmail.com>
X-Gm-Features: AUfX_mwsGGPfxToi9CFWvHg8F0vayIDb1DET27lB_HvrcHXw8Ht65VkjHJmkwKw
Message-ID: <CAMRc=McBNjvJK-dMBgifFxtgw0-bM_jaMYwJOWCRnV1PTLt-2w@mail.gmail.com>
Subject: Re: [PATCH v6 04/16] usb: hub: Use assign_bit() in usb_hub_set_port_power()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jul 2026 08:53:59 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> usb_hub_set_port_power() open-codes assign_bit(). Just use the
> assign_bit() macro instead. This makes subsequent additions to
> usb_hub_set_port_power() easier to read.
>
> This change does not introduce any functional changes.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
