Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182032;
	b=gyaOuUCi5ilgsP+dC7mq/CKPmwHe2CvZWqDpGeVBamfe7T95pS4cu9TDPasqqMK4W+xX
	 aQBAG31lO0KdlZsLtU5Fqv379jemalgre+EwRpkLMMtMeJT4SwC79Cdww4bJ0hlDxecdP
	 fcm6OCyGXUI5LpYsxh/zJCE7dJn0kBgmSgm7dwBJ+2vjE1s8dcKfaCy5gEM/RfFHFEmh0
	 Lmdw0iq+g3hs/kyMe79joEO+jPetx7OUHvQyXTfyKriD3Glcdd9SXFcBWr8YcX5KUZf7q
	 sZbYpD3PyxKm/knhttg5T3iTY5Q6g+kWTK8o30k5kA7BYBagbCVYYbfXblq3OtbR2RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182032;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ly1iWxY7rLjjdssZhsEu11VfdZr+uM9OeSbN8T86Qrg=;
	b=vKyO01GvKuGhHZY2AkC0jaJt/cD+Kxwk+eSsh+yp27coxLlCnwVYpdkmWD9+tIhlkC/j
	 bPvKy4KKfB0yJU3o0SyGzAdLuJD20VTj3neDflpQATG+MDy8O9Rc+qdi5yt4VqWxBuAsu
	 sXqA5gPndFvrlmFoivrAVB4vErRB4zRRKOHTsgtB05pQS1bTt15DaxVZIlSAdKh+iu3lE
	 M3I4msseqH7YMCH5yII4reRxT+bn86TtlGJrdiT8w0eD3PctioVbKay1fgSnfvV3zWZWn
	 /ecB8vDooav+rK+mF58lAAQ7pli0D19HIMr+DxDzABV8yQhqEAq59DzuBU2P2LtFAGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nZRJ/RVD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BD606A33D
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZRJ/RVD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE331F000CF
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182031;
	bh=ly1iWxY7rLjjdssZhsEu11VfdZr+uM9OeSbN8T86Qrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nZRJ/RVDtHanE9RNw22hzAh9KG2XNYArMbYCPRawTGj29a0sqjknQlynTkc7HMj6e
	 XfEHoCVu6nkNToHqdJZdfXNHoAFbek/3tmn7Tgp02RN2JGfac+4STUaHIKUxUQgKju
	 2amQQMchvo5qBxhQg3pwPdnXjV6GDfnig0OHkPRGX1vl4SovfmsDMm+eD3YbzH4Cdu
	 7Q9sdZm/Ia8NXREXvDg7MluTQ+ayzNsr3FLWl1R8TvH81usup5xc3vEU5WTGiF8rk8
	 Uq6JYmR3kuNJsjzGy6x5435qFMKksPjerBgU9OPEtp+MLAnAc0KSMZPJLGS2+QVJkV
	 VBoRsfDNRDKxA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c148d4dbfbso757920e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 05:40:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHvNza75BQFE2rDtHKTV23t0HHWqZjGHvnQy/9wx0j7sxlxKxfvCDW/rFxWMM8FLwb1zR8Q0jRay52/@vger.kernel.org
X-Gm-Message-State: APuU4Z+CBq/1uZT3R89B+4iA6DKuOhiKthLUDpCxWFDwAd/DR8YebEvK
	ReTAX9z2Nkhrm4FJ2NMqIiSh4p8WjDt3PJE1euAD6r4ruQXYVP+kZXvAEIGwlWYkOonZ8UI/VIX
	JV8C3ORbiwprtM/017gGjWm7J8rxbKiA=
X-Received: by 2002:a05:6512:2c9b:b0:5c1:56fa:9c53 with SMTP id
 2adb3069b0e04-5c1bc661b8emr1175378e87.6.1795182029910; Fri, 20 Nov 2026
 05:40:29 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116101742.13702-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20261116101742.13702-1-johannes.goede@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 14:40:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hBzBHHqhvL6686-rzptktDe7FbYyv08NQrH8kFH7ffWg@mail.gmail.com>
X-Gm-Features: Aa3M54q_jnmN5wSKyzyQFpi73UzY8Fq7_tJynfxbDPk0hxI-RimyvhCnv7FQJmU
Message-ID: <CAJZ5v0hBzBHHqhvL6686-rzptktDe7FbYyv08NQrH8kFH7ffWg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: GED: Add support for GpioInt() resources
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:17=E2=80=AFAM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Hi All,
>
> Some arm64 devices use an ACPI-GED (HID: ACPI0013) ACPI device with
> GpioInt() resources in their _CRS resource-list to handle GPIO events.
>
> This is done instead of the more standard way of using a _AEI resource-li=
st
> with GpioInt() resources inside the ACPI device describing the GPIO chip.
>
> This seroes adds support for GpioInt() resources to the evged driver to
> handle this case.
>
> The first patch adds makes acpi_ged_request_interrupt() properly
> propagate EPROBE_DEFER errors, the second patch is a small refactor
> and the third patch actually adds the GpioInt() resource support.

Sashiko has feedback on this series:

https://sashiko.dev/#/patchset/20261116101742.13702-1-johannes.goede%40oss.=
qualcomm.com

Please let me know what you think about it.
