Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003513B5301
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686127; cv=none; b=iEo0lN0SPiTA+9wz4C9p4KkgNVwpLSc2FkW/DtMUeaVUTdcOMqLR7V5yc1JvVWIn6xDqhOYZw+P0/P8wudUKBq0S9BG0LG1924TeV5ZKu2Q5A6Y8VFAZCFNx5ptJ+og9EuCKSUtVUvZwUlZ28FEn5xNeHsjhNZC35gVvKGsc/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686127; c=relaxed/simple;
	bh=ukOrggYuv0kQY36w0Ecno7EtoAZjidAyzoOwF7YzJSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sP1a5qys+YWrDWQ9tBRmogEAbnWhzbEzHwIoTNjrmWeI2DHpaQaV+uTJqvHWWGvSPWfqFs9VelSjk6bk1cESI0k84Zs3DMs+03iudm+q8dLoQEvN1ZqvOuZDilhr2MDCAeHPnUI89x0X2N4w2c4P39zKSPxSrKHw0ZC0Zmrak8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz56eucV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz56eucV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD171F00A3A
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787686125;
	bh=ukOrggYuv0kQY36w0Ecno7EtoAZjidAyzoOwF7YzJSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mz56eucVwP4mqCdqbsNbfN0Lb08+q0ObdKaQ7RAObEeBwoC3F1ifaeZ2enLxDvFdE
	 PTDfhX4pcipNdpZRBRoMgYVp2zKiu3STOop1imsBV4PW04LFLDOkS9olnTRMnIYUB9
	 3XccmnEU7wv+ennYnquFXqmxcac4T+W38xX6scDurpy/utEYNZ1dULRTRmki9Fm+u8
	 hNWClERZJ/+qya/4/6moZdK9F0EA1GDe3jdx9QaAK1M8zFlwrYTbRqG4VcTCD8+bGP
	 T5eI15uXKshySc/B4o6CDOuWhHsbdHbRA4lxrF7p9va5XHAQBVVINY11WigssFsnZ9
	 ZGc+oMtM+bzVA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a1f628b109so892861fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 12:28:45 -0700 (PDT)
X-Gm-Message-State: AFuF++n4MQS7PsLEHiNbQlo0fgi18JcmZPPEAxfqQQwAn6GA2hmdm4MC
	69uU62+fmmoW6/8mbgpeo/pJme0Td9kh4dWNoc6anBeJDnYcZvQqmCN4pomXsWMfQquNhfGEvh9
	KMlNy5AiUk9/RTF00sdN8jD+s6NKfdnw=
X-Received: by 2002:a05:651c:43c2:20b0:3a1:980f:5905 with SMTP id
 38308e7fff4ca-3a1fd4592c2mr1353121fa.3.1787686124091; Tue, 25 Aug 2026
 12:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820153152.1801259-1-maciej.wieczor-retman@intel.com>
In-Reply-To: <20260820153152.1801259-1-maciej.wieczor-retman@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 21:28:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0QfFEiYr0rBcGpDHNfB4vsvZAqKs_yVY2RCFmLDTwMA@mail.gmail.com>
X-Gm-Features: AcwNN1WbEkFlRwU5zN06Ai0aFv_KYOGEqHNA0dWXIy1lgdvwHtmDu9ZyzNX66vI
Message-ID: <CAJZ5v0i0QfFEiYr0rBcGpDHNfB4vsvZAqKs_yVY2RCFmLDTwMA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Update the SPDX license identifiers
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:34=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> ACPICA upstream changed its license to "BSD-2-Clause-Patent OR
> GPL-2.0-only". Update the SPDX license identifier of every ACPICA file
> carried by the kernel to the GPL-2.0-only license. Specifically all of
> drivers/acpi/acpica/, the ACPICA headers in include/acpi/ and
> include/acpi/platform/, and the ACPICA sources shared with the acpidump
> tool under tools/power/acpi/.

This change is not necessary because after the most recent
arrangements, the upstream ACPICA license will be "BSD-3-Clause OR
GPL-2.0-only" which is in agreement with the SPDX identifiers already
present in ACPICA files in the kernel.

Apologies to everyone for the noise.
