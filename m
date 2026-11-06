Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971971;
	b=vUWn3QEhOT8/lytcQ8T+zwhnmcaui8dzsU/Z9NGFKVHuPAOdYHeLbRk3OepQSkFg1XGh
	 cKtjRemBZ343tddSkHuzOrjiHxOfSm+xhCUq8sBnrwaLFNuShN9sMXx/SNEgwEHdUI0ml
	 ndlNEXaLE9IHnOJvrBwdtAqPlkq1ragKguOXaA9gcGHQdFOl9qwioNPnkSLaqKFo9uUcE
	 Zh55ZTCvlhu6LZwuPaMUBetNDZF8RnDE3pQOKmE3AZ1pPq5K52Vk+2ghjjz3dQx9aZb+v
	 6NPNa7LPaYbFSFDudt6YpAReRLvlTgGfbCVV6duPZ9b8oLG0HI30XYrxBNTYVWGNDFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971971;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rku6VQ65uTS6RI9RCpBqPT6w5cxyM8TaHvzEHY5mMwI=;
	b=zCkCaQJgGd7jWThmrO/7sgdjBwAe7HjK3znCj1UfFX6w3RuNCpVa6gD8GMc7insU5OOL
	 2FVL6UZA8E54+/YjXYCx8ZB03K/zwETRtiLrPls/MkNSR7jvZBgMDEZty/AqlmIVdoYjQ
	 MUZwf538MpFG+Xj5tsGwP6rinnZVcgVlPSLK0gPASkzOeSGMZu7O4lNOTsSp3nkg0VhDD
	 8NX4BJjxzuxVFYRo6+jn+yR7lweD+RjcwvKlMkzP9/KLetSjPgsgLV3xaPzy3PmLhJvm0
	 gPPi+kiAFQj/UCxuD89kZLqf8G0950CeAOZpcaYR822Qy+gAVsmRSZz24iIeieruN/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9eBh9oQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C866606A326
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9eBh9oQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777321F008A2
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971971;
	bh=rku6VQ65uTS6RI9RCpBqPT6w5cxyM8TaHvzEHY5mMwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n9eBh9oQfW9QCKPsygCwWyF/4qounZ/O6A5URte3/mGT4wDo5hBPi/dIdCTZd53JY
	 5qIyXnE7j9tFjiOUEBofK0DNfUNUIFPsUh7j6uQduWjMZBpnMXtrKBwFK+Q1qNHAXk
	 B9Z3GRa51Ef4Vi7aeTRjbuNaIoidw50ZG30mQdXIz6sveTRcQ1BPagOtDaxeOnShtG
	 ny9HnDN51yvQe8NDClYkX3AdFmjWzVp5cq0sboZIVU6Tmr1j5Af99pyrweLr2aWYw+
	 4SmIsRuXVQkrqioZvYwXV81owk1tCesy5hT5VdGmwmVOEbdjb8FH6LowXN0n4PNSLb
	 cwDTVoHx32aPw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be416e603cso468426e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2026 05:32:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzm1J8vxj174nFn89PIgbBx0HRNbjXNNsz0ADdGNdwPtl/KCYrcH5CC7oDbQLAupqYYMQfBVU+O5jYf@vger.kernel.org
X-Gm-Message-State: APuU4Z+nvR/cdLT1v6CYpQcwn09TH8Eskx5NieGra7bXZHigJddm8Ky3
	UkkZXf98kpxCUyA9Gw+AwldBYxu49oWzuATS0AbzIs5tVC5bcQ1a2nnm91RvSMEpsUdQ1TEMHLK
	FB7QFj+iOHcTWTuzvzTPKs/Fh164Zfpw=
X-Received: by 2002:a05:6512:2287:b0:5c0:4c9:a4ed with SMTP id
 2adb3069b0e04-5c004c9a616mr663332e87.4.1793971970285; Fri, 06 Nov 2026
 05:32:50 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-superm1-pinctrl-acpi-v1-1-2367e584912f@kernel.org>
In-Reply-To: <20261105-superm1-pinctrl-acpi-v1-1-2367e584912f@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Nov 2026 14:32:35 +0100
X-Gmail-Original-Message-ID: <CAD++jLmA7cpMfYiFrpJJ89=QW+XS85wg_VzqyU5C=pDWuxnHmw@mail.gmail.com>
X-Gm-Features: AclHuK9U3egiiUujijb5vInGeTIpSRkU7PBiBdg1W14kj--CHWhvbS-XNc59sTg
Message-ID: <CAD++jLmA7cpMfYiFrpJJ89=QW+XS85wg_VzqyU5C=pDWuxnHmw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Drop CONFIG_ACPI ifdef
To: Mario Limonciello <superm1@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:03=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:

> commit e7280ab196ba4 ("ACPI: bus: Use acpi/acpi_bus.h without
> CONFIG_ACPI") added a stub that means that we don't need a #ifdef
> anymore for the _AEI check
>
> Signed-off-by: Mario Limonciello <superm1@kernel.org>

Patch applied!

Yours,
Linus Walleij
