Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AF2D8379
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452789; cv=none; b=lrfZTGW2yn0fB6sRmscECuxRJrUUhHjpxoj48RlXaXDAMS8v3YIsEEUZLiqxn5DHHpUqVeqF/ciX6tPr86cjfkWjF35/6OO/ORIlRC7IiSJ22Lx/S0YIGRi+nspP6xwHXaPrJvVmm1r5Aex14ywDgEoYRCz/jxpnykRLv4FFNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452789; c=relaxed/simple;
	bh=sazABkgWILYJbT/fSZ5nybhIAFlfvwWEQTr0JVSdCfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMwF3tJpsaMKJvhdb9qVj03rTCLKmxOIYe/m3amk9l/8/+kjSSPGwhe0StcxcWApLIpQMJU2wTrkYZXlRWqB5FKMeIg2QuLHYH8CdnH7EPTzWXqpTwKYZHGehagFp4fx4xD4ZTiV1PNUcS9vZ/JucluzcihTgbBOMKsCRurQUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbTUhmBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbTUhmBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB61F00A3E
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452787;
	bh=Nq7EhUik6pZ/sLXQz1K03citYVZ4BEoOPNjJog1N8yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cbTUhmBGdeXVrO+s8JnqlfMru4w2QyzdBxFenj1H3I63WSJf1vFacNaKgNhmYFmpB
	 0IMCndJ8x3Z0+jM4wzEAbp9Cz4wyfukeFsY4v0cSfHtiH57ubxnTgm72tM87T+/vbP
	 OBPDNUTbH9ZXR+ofAMN+ArYVXMkl3H1JSwm/dcqE7fXY3ymLWgLj83KKEisKeGeltv
	 gsLJATEaIJewqEw7SuwVI1kpR86J60Xlv3GzeIVa/QoVSKYpNGxz+U/vOOG9B7rVtL
	 VP56uWibhN9iep7f8uPI1sPQGYNp2nUe3+Bm4uiWeGO6eAGTYCLrZ9P5sf2TvvTihx
	 ofBTHIErvJuMg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a877510541so8385120e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 05:26:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/+TLo5C8GneD18Nk0VNmKL6bjCX11Y56Aan7FFvRUhzd+9HayN1ZT8tEBRBg1oikn7ru8rFwRD5YZe@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMdQCoUccPHbp/C9QzR/2wDRgV/zp9LjfJhWfZT9KOe23RZq1
	CFgf6/o5BBobowtbQbvc+VLM0BFVTwOtwt3X1p6N1dQpPSNQTIkiDLm50rbRKYEszkFQeHgp3S1
	OcGY/fD5pN5KIT3rWPSPL9kEk1+EfoM0=
X-Received: by 2002:ac2:4552:0:b0:5a8:fbe1:15a3 with SMTP id
 2adb3069b0e04-5aa323cf57fmr774655e87.39.1779452786406; Fri, 22 May 2026
 05:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5996185.DvuYhMxLoT@rafael.j.wysocki> <2265993.irdbgypaU6@rafael.j.wysocki>
 <Z01FFT.NPPC3AQH2RI22@kousu.ca>
In-Reply-To: <Z01FFT.NPPC3AQH2RI22@kousu.ca>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 14:26:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+-DhPhv4K8KMW4QfUo4k8JXamxTM0XZJwB8EfME_BkA@mail.gmail.com>
X-Gm-Features: AVHnY4JAIzrkrURxmPL70ycwZb_578J1WpyOBLDP-zMiJpksgQUkhI-PN584pzo
Message-ID: <CAJZ5v0g+-DhPhv4K8KMW4QfUo4k8JXamxTM0XZJwB8EfME_BkA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] ACPI: button: Enable wakeup GPEs for ACPI buttons
 at probe time
To: Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 3:48=E2=80=AFAM Nick <nick@kousu.ca> wrote:
>
> Hello Rafael,
>
>
> On Thu, May 21 2026 at 03:38:50 PM +02:00:00, Rafael J. Wysocki
> <rafael@kernel.org> wrote:
> >
> > Link:
> > https://lore.kernel.org/linux-acpi/E2OXET.4X5GTP37VTNC3@kousu.ca/ [1]
> > Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for
> > buttons")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
> > ---
> >
> > @Nick, I have reproduced the change of behavior introduced by commit
> > 57c31e6d620f132dc on one of my systems, but not the function keys
> > regression because they are handled differently here.  This patch
> > should restore the missing functionality on your machine, but I would
> > appreciate some testing feedback.
>
> I have applied this patch series on top of today's mainline
> (8bc67e4db64aa727). It worked! My brightness keys and mute and
> lidswitch are back. That's great. Thank you! Learning how to bisect was
> a steep curve for me but everything after that has been a really easy
> experience. Thank you for knowing this subsystem deeply.

You're welcome!

(and sorry for an empty reply message I've just sent)
