Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23340D56B;
	Sun, 21 Jun 2026 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782045552; cv=none; b=KQ2o7037ocuS7VUVr8kUru+hgbzrHcW7mH538S4WPq2hl4MDjTAAV2ZFBQcwsbl/gMq197DioPXu7SgRQDB2X1ozZJfJ+cJrFCqye6Eqxzq5EGXoKfj+5++cL+iKoS0odv3hy1EYk+0mx629uQIlGEultDwapoGFKhKRaJemKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782045552; c=relaxed/simple;
	bh=wO/wqBaGzCbPEM7XzEA25MLv7E/PJvPT1TgaIhbUgjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFrHypOuZO/z7PjhQ6eQ8IBf1jc/WsrsFZzsbOwzqOT36P/BdOWK+KfvTQB8o68PkmBElB23SCXVRN5GEyFELS68BriNLzqUqZ+0/aAw/YI/ikxeyO3PAJ/eEtfcZF3NQeqZDAelnifV/fNWpK49wpWxReVhrwNmCEAi3pNJScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lSH+HY6y; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lSH+HY6y"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1AAB227231;
	Sun, 21 Jun 2026 14:39:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXCwvyOMEILR; Sun, 21 Jun 2026 14:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782045548; bh=wO/wqBaGzCbPEM7XzEA25MLv7E/PJvPT1TgaIhbUgjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lSH+HY6ydtbP+tfRmGoQF0/5WubN39Oveg2Ee26cJRfmmh30RmfDvy9sOXHYd+kXu
	 GZ8Xn/bXzCmfxVeR6jU8lwSa1J/7N37FO1UcXb/XRSbCM48KYfNZKoTRBUUbG3bpBK
	 mVeZSeOuRkGEVyYhvFUh/fic0N/Rcpqm9EGhc7BPfcmoMQKvEkf94pspKIVhECbJjy
	 /k+EVooAoNeWyMvBZZTmyRcl+/N1Kx0inzBcJj8Th8OpWy+PED8DTswdU/YNB6TchA
	 cuk3GT5jCATwInJ0yuoVUs1x1VhgSDUmGzEVzeKQlze2qFZz635z+PwVgeZvBQj7Zd
	 DRMqCAtCJM76g==
From: Marco Scardovi <scardracs@disroot.org>
To: bnatikar@amd.com, Armin Wolf <W_Armin@gmx.de>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: andriy.shevchenko@linux.intel.com, brgl@kernel.org, linusw@kernel.org,
 linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, westeri@kernel.org
Subject:
 Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614
 series
Date: Sun, 21 Jun 2026 14:38:55 +0200
Message-ID: <plMjpdo0SVyLgmZrd9JENQ@disroot.org>
In-Reply-To: <9237988a-2f5a-4c4e-8586-12899957bfea@oss.qualcomm.com>
References:
 <221cd70d-70f9-4d01-8e8c-b4a5b347b8b9@amd.com>
 <20260617185318.11237-1-scardracs@disroot.org>
 <9237988a-2f5a-4c4e-8586-12899957bfea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In data domenica 21 giugno 2026 13:00:22 Ora legale dell=E2=80=99Europa cen=
trale, Hans de Goede ha scritto:
> Hi Marco,
>=20
> On 17-Jun-26 20:50, Marco Scardovi wrote:
> > Hi Basavaraj,
> >=20
> > Thank you for your review: this is the v2 with the rewording as request=
ed.
> >=20
> > Changes in v2:
> > - Reworded the commit message and the code comment to explain the actual
> >   boot-time replay mechanism as suggested by Basavaraj.
> > - Explicitly noted that the touchpad itself is driven by i2c-hid and fu=
nctions
> >   normally, and that the ACPI event handler is preserved for post-boot =
events.
> > - Rebased against linux-next-20260616
> >=20
> > Marco Scardovi (1):
> >   gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614 series
>=20
> Have you tried adding this patch to your kernel instead of adding a quirk=
? :
>=20
> https://lore.kernel.org/linux-gpio/20260429025247.1372984-1-mario.limonci=
ello@amd.com/
>=20
Yes, in fact it used to work [1]. My suspect is that when updating the BIOS
from 310 to 315 something flipped, making it not working again.
It's my own speculation so please don't take it as a matter of fact.

[1] https://lore.kernel.org/linux-gpio/a42767b8-7a0c-4202-9132-be8fa65baabc=
@gmail.com/
>
> This modifies the code which does an initial sync of edge-run ACPI GPIO
> interrupt event handlers to match Windows and to skip it in certain
> circumstances.
>=20
> If that does not help, we should wait for Armin to get a chance to check
> your DSDT to see if the magic _DSM which inverts the polarity check for
> the initial sync run is there.
>=20
> By matching what Windows this we can hopefully fix this for a whole bunch
> of devices rather then having to rely on per model quirks.
>
It would be very helpful as I noticed all these ASUS laptops in G614 family
ha the same problem as mine [2].

[2] https://github.com/OpenGamingCollective/asusctl/issues/115
>=20
> Regards,
>=20
> Hans
>=20
Thank you all for looking into it,

Marco


