Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69532ABC0
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607442; cv=none; b=p9tuVVqOeSHeWsK2tJFitXijD1lYPOHgPA9NwlwfnxKP92miSq3XvM6c06J2tfr7UNFsrOZj1sG4vDLvqesMjr0nkBCZSeyWtc6ClOeNOG+FyE72lKgeZ2mNNdic2Hwt+9eLqCv8ryaeue+YMBgatOzaH9noPew5rK8qIeW1f4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607442; c=relaxed/simple;
	bh=Uk1paIY8euqKKlETQZ8oULEMJ7HstW0bVetbSs+wtjk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iprJUblRJIlFqnTqEWxcYxrRawU8A87SMJlo9cH30DTxys69rjPKgN86lW59R43sK/IIBStswk1br9tToj1PS8jBLo6zKXssAZJtbSBlUfj1rkfyl+svAtIz0Q3/nTNH7BdJ6ofkLPnzfkm7YeY2ubEiJchz0nrF43lGaT1frmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPN0dW6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPN0dW6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B9F1F00A3A
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607440;
	bh=Uk1paIY8euqKKlETQZ8oULEMJ7HstW0bVetbSs+wtjk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=RPN0dW6PuazA0DKoZ2ps2OmJJ3t8w5Z4d769XH0gGOekHGK+UzxclezCPCuebxz0R
	 bMiCG7stnBWSKK4KUw/HHvytQteBYxb+DQedgiF5NOEq6xYCQGMoMr6OQ6NunZSUj3
	 gFsFhFyPU5SmiSGn1//yco5O2nFhuWD9OB73iL+0vl7qWkOcly5jCzj2aYNKbxUes4
	 DFuEg/5c3MgF0iAnb9feN4f+m3Pdd3yHZRP6C+15w4+uew5Vd7hj9VcqvuRYoG55t7
	 oUXGEPZouC4ZQ26OQFMOeB/ZIRmXJwSRzWJ4QVdO8UrF3KX8I95kFTNqSv4NjKxBrN
	 y39JW28REyEXg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso1015932e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 07:30:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YxCZa1R+v2MjUIiqmwc467LvK8c6GMN19QBa2k1r17AbILaiGjA
	QALrSW4TPmslnVYZzYsu9z+P9S5R0MRAbCr7z2/wvITCQSYpR6jajspeOkIcC/GBGm7SOywhEd2
	1o192EU1mOJV0CcRet6XwYN+qucsa8NQ6z/U4qatS8A==
X-Received: by 2002:a05:6512:1415:b0:5ae:b88c:3ff2 with SMTP id
 2adb3069b0e04-5b0114afdadmr1759669e87.51.1783607439457; Thu, 09 Jul 2026
 07:30:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 07:30:36 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 07:30:36 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260709095726.704448-7-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095726.704448-1-wenst@chromium.org> <20260709095726.704448-7-wenst@chromium.org>
Date: Thu, 9 Jul 2026 07:30:36 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfx1qoHWs08xOqNzmp3+RroPXQF1ps0Q_bu+17DWz0eWw@mail.gmail.com>
X-Gm-Features: AVVi8CcTCqwQAcyQVn3vmM3d_PiKCDTxzoT6aStAZSp__o8inJgUu4b7eftjDFw
Message-ID: <CAMRc=Mfx1qoHWs08xOqNzmp3+RroPXQF1ps0Q_bu+17DWz0eWw@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] usb: core: Move struct usb_port and related APIs
 to port.h
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

On Thu, 9 Jul 2026 11:57:11 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> |struct usb_port| and its matching container_of() macro should live in
> its own port.h, matching the split we have for .c files.
>
> Move them as described. Also move usb_port_is_power_on(), since in the
> next change its |struct usb_hub *| parameter will be changed to
> |struct usb_port *|, and becomes a non-static function that only
> references |struct usb_port|.
>
> port.h is only included from hub.h, as a subsequent patch will directly
> use fields from |struct usb_port| in a static inline helper in hub.h.
> The USB internal headers don't have header guards to help with this.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
