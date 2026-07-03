Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EF3D093C
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081053; cv=pass; b=BWwddjEAtUE6wFF672wG3YxC9DxUdTfjYz0vlWi6mo9jtTRitmAxUG1megpFewYYKUnMnRXEbabl/keu7FKnZGxd/R8JpNSqJQa5huCc6EQr54Lusb7NXN7l1gr6Psjx4b6yZE49ejIsPKNOKOh5TrOo5Q9oGbvJHsbZlTKa1n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081053; c=relaxed/simple;
	bh=wKIP/2g7MTxmMgVnWjjRdFjs9hik6bQNvbKXHobNWdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfYz5ajsFrmvU3GJo4VoABHj5z7eSiUk6zSy8ZFhirCPK7/V01DTTTpQAvJVMf9weBFQ3JinWTPEeJ/rft3ZFTg+9mFbHsWGIGTtDFb7AL1wzmHYx0FGtRLaFIFS3WCpa17f7hGcXC6nBQXVcQYr+YBj4TjLablGQc3wqv/WLk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=La4rLw5G; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="La4rLw5G"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664cb440f9eso588907d50.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 05:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081051; cv=none;
        d=google.com; s=arc-20260327;
        b=nsV4pHLPuVtkDIM2zDNWSMMNeRuDwyl//kvaNSpnk0mT//R5KiPt8mJAwUJ//htHkl
         HfRTPCPgCHT/wmbawZZV1cRBDi5ykw8wTVMPeAqAb/ddLT869vbWUl7lZSYjPANbLL70
         9lb3Al1Euv7B7XzzY9hBo1ZzruKsS4cttKDL82M6vCIqS8qjjCUyWBL6ZGmxlkq0RG4J
         OpX6K/W50PBo56WAR4mkDcY9v/YDe9s/+RoEwe5QI9C7gMTTFc8u9eItjBAGNNpsn3pE
         HNtSRiSTTq7s6dC+UkeYXb3XTbUcWhhPNUqyUYr2N8guhijU2ygEW6b+2D+VZRL9wYmR
         tZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wKIP/2g7MTxmMgVnWjjRdFjs9hik6bQNvbKXHobNWdc=;
        fh=JH/umvhcNPNtZ3GPQCsMWyO8nHrLbAZzHpp+BIN5qGs=;
        b=ElBQloMB9KYen+j1d7kBOak5vA//J1V2ZJ/jHfc0K+qE6m/AWq2KoZCbXaCBnXBPQo
         RflVxFfi0ZhZnIaEFJabdqq8X/PQ3YYo2bCKqcuW0xF7ASRuWESdXdaVfD4ZbRx7xTKA
         g+O7HW17PPMRKV8tpUtIJknvsMEoGEL3gSht8nTSiilCn1R6XWkuf2REe/GRHu6BwNyW
         0XugqI2T4fGUeKZmxNkodvZZf6pK0M2lv5xRp8XwCfPdldElvZ1W4T37g8TcfrrhSFxG
         MTgpRLUZ0HfZfAD2CdhVdlSkffIABymfTLbondWhhgPCb84y03cXxPpn1A13ncB0NcIJ
         BGhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783081051; x=1783685851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKIP/2g7MTxmMgVnWjjRdFjs9hik6bQNvbKXHobNWdc=;
        b=La4rLw5Gf5gqClv10KJUzRgbRZWpkKExtGoirU0CX9a9jrQYpre1JYB5m/lZqJPlf0
         3cYEc+cCqrXzelFvrandfTJ1HTW1qcjS4V28uWSp/W6eKpaaI5WeEngCHPnPmiZ1hWWd
         iGuEVo1TxLdpP8k9+6p9LSymgO+vPjFK4hGRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081051; x=1783685851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKIP/2g7MTxmMgVnWjjRdFjs9hik6bQNvbKXHobNWdc=;
        b=EUZb5Ot5wCVEKDqN+KyvH2LLqfqZbCRbLFuey4DSfI4gswuEzJhHbJyFS6ndQF82l7
         RzVlxXOm1wjEQS89cASgPUOKGQ9grIgxpNOku2t/Nfh9VSPkAi1xh597d/7dfMIv9FtM
         UkALMyM/qPajesucBMlnfKwe9nNm5U0QNkXcsDrl40ojAyXnTzkFKeSRiHgE8C/Y3mSU
         8NtOaNOitzmXca9YyFY52xhLRJ3PYWxp1OWj6GPp4gCJ2ziFHwpvykL5iIuve6Yy+J4e
         cCFpmfaikyj0yaXi5KEgX9VAYjHptDeEp26vCWtx4X3vJk7zO0v6k6oiQS5AiK/7xKb3
         pmLw==
X-Gm-Message-State: AOJu0YyjugfPhKnxse+7REBeHuqnqqbSbUHquEZGUyarzU0MoLr50ZGu
	nvm0sdR3c+oX7bBuZrRNS8bIsyLcIJ7zzvxzPmWBjZs0PX08ASvWb2RZ2JJ6Og5ZndwVrDVyiMo
	xd6r10fkbj2oQ7ZsifrKGCQN29h8c5Y/B5Ul9iB/W
X-Gm-Gg: AfdE7cnkLg/B1VWvx6RZ1hUsKmYpXmCj+ieepQLnpydOM7A24R27oUOl4deCPYWmqK4
	qOIqsDiFz4v3EsWu9vrSV5UfWZupEm49k48SqkEshVEWPhvKHRzVqPUUTs1/yNbIFH9a3iUv/4p
	YtRh93RPXp1iiNnQlREdIlbly2FvxH594sXfKDyCePGH2cQNch13iN4ARDvWmZSHSg/4y2B7YvW
	Az8eAaM2MeeovQAzTgDI3Gf9wWNlPPQ70fVA1nFuGuQXsihlWfqZBZr6LnfSC8/BQkIwC7vQrfE
	IT9NbBI1WqXvgIhLMtGnZOtgwPg=
X-Received: by 2002:a05:690e:bcd:b0:664:ae03:524e with SMTP id
 956f58d0204a3-6652195244emr9486423d50.6.1783081050982; Fri, 03 Jul 2026
 05:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-4-wenst@chromium.org>
 <CAMRc=MfPC=Jm6RFkCYG6vsYQiWHxBeNq0L59rwahF_6Fu2Ledw@mail.gmail.com>
In-Reply-To: <CAMRc=MfPC=Jm6RFkCYG6vsYQiWHxBeNq0L59rwahF_6Fu2Ledw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 20:17:19 +0800
X-Gm-Features: AVVi8CdRG77FVnl6YqrCOnoh5pU554e35My8Xh7iayyOJ32J-OMwjYcWxPxxPu4
Message-ID: <CAGXv+5HMVaERvte8YJDJ0fq0zoMvO7-7caAGQhsAB-9sUHoGtQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] power: sequencing: Add pwrseq_power_is_on()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 8:07=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, 3 Jul 2026 13:03:04 +0200, Chen-Yu Tsai <wenst@chromium.org> said=
:
> > The power sequencing consumer API already does power on state tracking
> > internally. Expose the state to consumers through pwrseq_power_is_on()
> > so that they don't have to reimplement it locally.
> >
>
> They wouldn't be able to do it as the field is private to pwrseq core any=
way.

Which is why a helper is added? Note this is returning the requested state
on the consumer side, not the actual state.

> In what situation would consumers need this? Typically you know what stat=
e the
> handle is in if you control it.

Mostly just to avoid extra tracking in the USB port device. For the hub's
port power feature flag, the hub driver actually queries the hub for the
current state; no in-kernel tracking is involved, i.e. the consumer doesn't
actually know what state it is currently in.


ChenYu
