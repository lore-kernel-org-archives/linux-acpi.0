Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981611;
	b=sTVNGNGU8rnRSkWnOe2OqzzZ5yLidsuC+glAPIuMh+dU3WhYEKSwcBBt4MpR+pffcOau
	 cTM5u8kvGVAvthB+S7YeT5Xk8aCBv9c9AfRdR84uURtZP8RlMVEZvo5ez3iNINJj1ZENn
	 5CeHluJZ1lwQ4XwRU0dhY66qScHBpFJceUn8BZ2BJvx6K/UanhWpPMskFpm4RIM3wWMct
	 vmRZ0Wy+vKaxbTqr0LxsSjBEaDS8oclGaQwy3AL/+4XjSUo2SCRT6FwoVePnNQS1uzte3
	 g9En5pt44wciI4HvptyvNw2P3vCaO8us0j2iY7/J/Qunby+JKSWozsNnnqwDEjzmDRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981611;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6wCE/CxZZB5YEUW83yNJPByqFX5aqmykXX5lroIzX/s=;
	b=UaJeGWwvfulEGhULikmOAQRKEHulRm43sPi9QuWX2ftBiKgO+LbgoCCl/n8RqKh3ilhK
	 elXtEzuxUqa1kLAhamMA5TpZ2gbDqeTbOh6y+RsWdXSy0nAIEVefBOU/2fehokU5S870r
	 erxKEqZ+Qz5qYklfUWclzNWgngjmMC/fckKVUb0XuN5b/utIMyXd+Tv+aN6OaNg6nCCyJ
	 TL11nqmOFhinPx3ISb1FOE1v+12cjrVR3JfHNyUnCiPMoZI1rz/nTo+fo4Ke/ujFNH49O
	 jqkIbfELgNYN2pEIovnMEd6w7OtV12h+reUy7+sAN3g+3JxelbT6i1cfKrkvTu0MMng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nbX+V20/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE1606A326
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbX+V20/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808731F0089F
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981610;
	bh=6wCE/CxZZB5YEUW83yNJPByqFX5aqmykXX5lroIzX/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nbX+V20/l6QaaHEFphAOuI2+1lXu8ESgsktvTgsrf3knAtCkmCctaOsiEMEJsCmhK
	 e2Vpz9MCyxYljGv5LABtqrltAlgwO1gjvD/vvPPlLaBJAaEoBPaIEp5K7yvb0svzpM
	 5zTVzX+uGYsIkmjIZJLnFemVgbFSPXcXEclKKEq6TQqMmn5J//A0cMiBtxnb82G0XB
	 I2oG8Dr6fvUcc8YZem8G12MZBZKf9RAhRC7f4Ys5gOWS9LJoSlAkEL6kcZ5JKLkNMS
	 QiOgLqcncQkjuXiXA4O0uE5QiDmOrsP3mVWuYIAG7QTONS7PXFdL3B7acKfmhespKi
	 nJtI5ycHnZo+Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfc32574e7so887886e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2026 08:13:30 -0800 (PST)
X-Gm-Message-State: APuU4Z8LT2dxvN8+Ih2CJtQdMqYuBefMi5W8ydGxbEbd++cAO/mkbcWn
	9VykBJAAejKQE/f5ATRE5YoodOUy8YlExQefzXMculLw1P7BInlrVcNezZ8nJzt7LairsywvGEy
	i69mbyDILEYAOrR2lQDAx+pKjIMt8HAg=
X-Received: by 2002:a05:6512:1596:b0:5bf:ff5a:a1da with SMTP id
 2adb3069b0e04-5c003ad07aemr820276e87.13.1793981608986; Fri, 06 Nov 2026
 08:13:28 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014204558.466130-1-uajain@igalia.com> <9925f10b2bd1437293422a05269c1823@igalia.com>
In-Reply-To: <9925f10b2bd1437293422a05269c1823@igalia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 17:13:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i=nr+gN7r-YvViVHScYRW-H_3jJ9OAq91Ciw1Y8DGzog@mail.gmail.com>
X-Gm-Features: AclHuK-38enbewlsp2hEIu4zHJYXVPRvq-Ij77m9fKDTOgyUzzdJh-fIoiQeb3I
Message-ID: <CAJZ5v0i=nr+gN7r-YvViVHScYRW-H_3jJ9OAq91Ciw1Y8DGzog@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] acpi: battery: Query BCT method for steamdeck
To: Umang Jain <uajain@igalia.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:41=E2=80=AFPM Umang Jain <uajain@igalia.com> wrote=
:
>
> Hello,
>
> Gentle ping for review?

I'd suggest finding somebody near you who can give you some feedback
on the list instead of sending messages like this.

The patch is in my queue of things to look at, FWIW.

Thanks!

> On 2026-10-14 20:45, Umang Jain wrote:
> > Short series to query Battery charge time ("_BCT") from ACPI tables
> > for steamdeck devices.
> >
> > Patch 1/2 introduces the steamdeck device battery quirk.
> > Patch 2/2 handles the case where steamdeck devices can report "Charging=
"
> > even when low power PSU is connected which is discharging the device.
> >
> > Changes in v3:
> > - Only query BCT method for the steamdeck quirk
> > - Drop charge_time member from battery object
> > - check for returned value from acpi_evaluate_integer for max
> >   ACPI_UINT32_MAX bounds as per the spec
> >
> > Changes in v2:
> > - comment improvements
> > - split off BCT method handling into separate patch
> > - https://lore.kernel.org/all/20260923082932.1049270-1-uajain@igalia.co=
m/
> >
> > v1:
> > https://lore.kernel.org/all/20260918135628.2322188-1-uajain@igalia.com/
> >
> >
> > Umang Jain (2):
> >   acpi: battery: Introduce Valve steamdeck devices quirk
> >   acpi: battery: Read Battery charge time for Steamdeck devices
> >
> >  drivers/acpi/battery.c | 45 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
