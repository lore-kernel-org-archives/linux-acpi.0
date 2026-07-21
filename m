Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B93C1F29
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624966; cv=none; b=UAXSKC0Kx0w65yxaGyEHtNO1f9SCG7PLKd9pwTrtw+2v2WkoerLOcxgAIOJlz4uTej58tEzZBjqoZfgFO2OZbrGa+q0VgsnrGgcTIyGWSYU7xHyio9ysJqr2nZRo+vLK5QWzVp5/LafTj7HFUxdP3LstLNf+HenQw4E98da9wBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624966; c=relaxed/simple;
	bh=4wB31opfSJxQGOyhrpE5g1SMhfmWmHTES3FuDZOGSPA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rojQRuc5E8cyqJ1IxHpw2ZE+hXdwzS5y0PTHxHTLUllw7BbeJ7Acl46j+6bXptPNDUd2TJ1tVzzgYKKjD9rpHDrlVqxEfOlfhn3LWJwNhm2ugSvDfv668sCq4CiNOeGSeKa1wdPm0pMRfxsDZJ6T1M/6PsrziaP1tAK0VejDpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC701rNZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC701rNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B78A1F00A3A
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624965;
	bh=4wB31opfSJxQGOyhrpE5g1SMhfmWmHTES3FuDZOGSPA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=IC701rNZje+dgfTqbLnJ30zaA30NDt/Xo4YfQs5LzmrHX9HZyeYyKzyUX2HvEPF97
	 1u4VvvvWC38WaQa274nSGTyUrcyKsap2cHKcgCYFePScep8erTz1dw5qfrFDKomFZn
	 dxFq+CVi3oKPHbY7xwFOFO38JVrztihw1pXlx7pbJOzO035qZw8vWmiYdourkFBo0U
	 okYvfFTI0oetvbPPM+HdJfbKD8rfTpQplzEcPEEF6w0l4wzzNgOjYGxRifx3uNrh1B
	 l1zWF7sG1v2LTDfKq78JBivVrcm9XKWD+bI1GzHNk3frZd6RQelOQNwbDInWQy+Fsr
	 SkkgFzrv/BznQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b01cb18515so10632055e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 02:09:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxuZkvvpWaMIbmvf82prPyvyK1UwP4wtK6qsYxpYzXpBA9aoJm4
	wh4l3+riivHZ5XpOifbBdZHdRoTLQMAPNzPcnbqe7IBN4lRU62Xio0G/GhjJdqFMPocfk2+ah+N
	QCF1KTHFfwVfkx0wbxBO2Qqw8ZvEsnOqPKx2WWpGwQw==
X-Received: by 2002:ac2:4846:0:b0:5b2:8ad7:93b7 with SMTP id
 2adb3069b0e04-5b28fabf50cmr2774646e87.53.1784624964271; Tue, 21 Jul 2026
 02:09:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 02:09:22 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 02:09:22 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260721065413.2306137-16-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-16-wenst@chromium.org>
Date: Tue, 21 Jul 2026 02:09:22 -0700
X-Gmail-Original-Message-ID: <CAMRc=MedLNu+xzDW=L6_EhVMQphkWEp020HC9hpmDcueN1R6_Q@mail.gmail.com>
X-Gm-Features: AUfX_mx6IxoN9pFtIb0B19rivB9mMh-kCXBeeOUX0vuwCx66Zlnj8MCY6QcZGPk
Message-ID: <CAMRc=MedLNu+xzDW=L6_EhVMQphkWEp020HC9hpmDcueN1R6_Q@mail.gmail.com>
Subject: Re: [PATCH v6 15/16] arm64: dts: mediatek: mt8195-cherry: Add M.2
 E-key slot
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

On Tue, 21 Jul 2026 08:54:10 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> The Mt8195 Cherry design features an M.2 E-key slot for WiFi/BT combo
> cards. Only PCIe and USB are wired from the SoC to the slot, along with
> some auxiliary signals.
>
> Add the proper representation for it, replacing the PCIe wifi node and
> vpcie3v3-supply property under the PCIe controller, and the vbus-supply
> property under the xhci3 node.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
