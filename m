Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162136AB6B;
	Fri, 19 Jun 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864950; cv=none; b=I7bfKF2XRfsnF/QxHhjYxswyb5YXih4NjrBzpjhbUnLXowKoZnZi8S/Tm12tzQLe4zPsh20Pe+/lAzRTO75zY8ruNUYBHI7rSG+NPh/49DsyUrJnAh13TwHU7bYTRwjvDvsnG+HUiozsRJ1g3O4eeewX6/vko/bJzfRpFWwlsHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864950; c=relaxed/simple;
	bh=CFDmWz892+RRuXtn1rIXr2e3YTyzaRMAi8rs7X9Ivbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fk4AOeBxO2kbaUsg3XjSpXqV6Z/p8iq+CgJ9KsA1usAP4kAO8f/D6qNZSHegd7uQF7DS65qPCT+/63NblhNMZsWt8s5J8wma5alcflXA3dzOA2gaMbIW3pSvvxyRX2fSoEEcHMhe+lVeoH24Rbz/4te+VdNEV+LrIprs57YPypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JfA52Yhq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JfA52Yhq"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5B60B26E3D;
	Fri, 19 Jun 2026 12:29:03 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vY771eyNqugE; Fri, 19 Jun 2026 12:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781864942; bh=CFDmWz892+RRuXtn1rIXr2e3YTyzaRMAi8rs7X9Ivbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JfA52Yhq5T+8wrwPRLbYF1U/aGXa739tH7s5X4Wcb+YKcWcW78AmxmWfVw7bwsjpb
	 zGiwt8HZj/ri6aHOj+YFalCyRJPjXHY35Ro+yrb+WsdVBED0lEbI4CTD3z1qyDfATV
	 FwAgui9bsD4KbboohtHdL7/t8J+HQwR3daW9C7aJoVYyYOffpPyq6Pzd3FynAFPK0h
	 JUsFSKyGZBd5Hvi75VXtnEZo7n5HKM8oYzsNCf12xHgLWs/9J/BaDzHF/wUb2ROP2b
	 RnX/qDlGsJL3Zajz5paq/XTmYr37O0avSMcgo0TgRTlzhTUKDbzK7vWgmUw7GfEY1l
	 SXX5LivNqhQRw==
From: Marco Scardovi <scardracs@disroot.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Basavaraj Natikar <bnatikar@amd.com>
Cc: w_armin@gmx.de, brgl@kernel.org, linusw@kernel.org,
 linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, westeri@kernel.org
Subject:
 Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614
 series
Date: Fri, 19 Jun 2026 12:28:49 +0200
Message-ID: <P9sY7IKaQumFwq7UGDqIPA@disroot.org>
In-Reply-To: <9643455e-f4ce-4496-bcdf-1122420c18eb@amd.com>
References:
 <0e6ea9d5-68ac-4d18-b40a-25e70216b288@gmx.de>
 <_tDfR2zvSRyshOH99j8NCA@disroot.org>
 <9643455e-f4ce-4496-bcdf-1122420c18eb@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In data venerd=C3=AC 19 giugno 2026 12:17:17 Ora legale dell=E2=80=99Europa=
 centrale, Basavaraj Natikar ha scritto:
> On 6/18/2026 11:37 PM, Marco Scardovi wrote:
> > In data gioved=C3=AC 18 giugno 2026 20:01:40 Ora legale dell=E2=80=99Eu=
ropa centrale, Andy Shevchenko ha scritto:
> >> On Thu, Jun 18, 2026 at 06:59:15PM +0200, Marco Scardovi wrote:
> >>> On Thu, Jun 18, 2026 at 16:35:37 CEST, Andy Shevchenko wrote:
> >>>> On Thu, Jun 18, 2026 at 06:46:28PM +0530, Basavaraj Natikar wrote:
> >>>>> On 6/18/2026 4:44 AM, Marco Scardovi wrote:
> >>>>>> On Wed, Jun 17, 2026 at 10:33 PM, Armin Wolf wrote:
=2E..
>=20
> I also checked the BIOS 316 ACPI dump =E2=80=94 the stalling path is byte=
=E2=80=91for=E2=80=91byte identical
> to 315, so the AML is unchanged and it'll still stall if pin 21 boots low.
>=20
> On the OEM side, I'm connecting internally with our AMD contact for ASUS =
to report
> this behavior and follow up on a firmware fix.
>=20
> Thanks,
> --
> Basavaraj
>=20
Hi Basavaraj,

Thank you. Does that mean that my patch will not be required anymore?
If that's the case you can consider it as null. I don't mind having the boot
flag added until it's completely fixed on ASUS' side. BTW I have the suspect
that my model is not the only one with the long boot bug on ASUS [1] [2]
but actually the only one who came up with an actual patch on the kernel.

[1] https://bbs.archlinux.org/viewtopic.php?id=3D307251
[2] https://rog-forum.asus.com/t5/rog-strix-series/linux-boot-is-very-slow-=
at-this-moment/td-p/1138746


