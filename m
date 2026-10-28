Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178930;
	b=PCSyS8Ei/mES43gjKjrvzlhgBUzj2fjcQJy4oWbY0uqVpbGrpBdQayqx6m6GP6LmmlPp
	 6o2RgS0AnpUUhSoVoI/j5LUvUmt1JYDrBrpiBpvnRvO9RnbT6p3X1fuXeePyb4GItMOyU
	 iAgLxhLD5VCNHbWbhCp13/5A6Sc99EOUZT8IlqsOtWT7C84fj35WMWTgAGWN7alRCompf
	 gEvusNXfLIj1SnrPX4RA/x78U3Ce7pEMxtEaxOEAjltXW8mjltuWCZaPNpnZro6g08WcR
	 euM7cJ/DZ2mUs9wBFFlogLkKA/CNGVwk+0tp6CCV1Wreh7okpzDb45hRoqMvH+s3hcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178930;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1PN3XFQA8hmS+b9H5ZLf4bj/cunANQckoieL+vBmMEg=;
	b=mV+fI5T+NCaQ1BjzgEh0opWG8eOGKd1sOGia9hL/g8zfgSGjOCplodj6CdNK0fDeSly+
	 BodCwHX+mTwZ0prmh5D7RfavN0bLbqqxx/jOn7sY1agtGUQ7x0Vg9JwjHQQClO3VhLfg9
	 xFaQFPMC8ZC7EiFKi25szzpKAv1TCIrXgQpsrclrCidgSal5ecV2vcQlfnWRI5W/xi+Lf
	 nbWizmgBD99MhtBd/70Lw+ScOwHF0eTIXEJ82c2d0e67DnYbnp+h/UJ4yUjG0nGzkH4Ex
	 x8sKtrJHClaf1mWVGX+XwzwVh2MI8degYkjmbkc5+XQ7q2mAkFot4Kwbnr8SADYkPJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=qdf7NK3y;
	arc=none smtp.remote-ip=109.224.244.116
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A19606A31A
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2026 09:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=qdf7NK3y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793178925; x=1793438125;
	bh=1PN3XFQA8hmS+b9H5ZLf4bj/cunANQckoieL+vBmMEg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qdf7NK3yWEY+tumIWnnZtkKag9R6cHp0wpcrD9+gA4gdoJ6znBeXKu9UkMN7IqV8o
	 arSoNhHmwFp0Kb3ZAcNOX3RmcqnebxUyUOCgBUI3hgVyj+sb5H0hsnUzXDlk2XE7P8
	 rdWmMFl0G5pwqbIAsHzi6tSqeUzIFTHSfxozem4+aqNTbFCpxjJVyLvx3fzguQVN2y
	 fSGXw1H9SU35PF84RXDJCvDqhCZYh5eFGuj+gqvENdFz0yZz5dcfqccXidkB+vM0ng
	 5fErZ5wjqAmni5uuGt54x6abEB2BUOdUyLwD59VE3rAsuM7D8V6se+CKdab79tMxGT
	 1HSju2+QPQ60w==
Date: Wed, 28 Oct 2026 09:15:22 +0000
To: Sasha Levin <sashal@kernel.org>
From: Mikkel Sejdelin <mikkel.sejdelin@proton.me>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [REGRESSION] 6.18.57: resume from s2idle triggers poweroff and hangs when tiny_power_button is built as a module
Message-ID: <dyJyEj-TY1YtRVdDYPD4xnYF_aIP78z9wliSc3251tj6aZEZxux0c81AiZAFPpZvbg6rjgqivtHTFfY29YHTS9WZmw569IbyVF0NPVTxqrA=@proton.me>
In-Reply-To: <20261024-rc-reply-0001-tiny-power-button-s2idle@kernel.org>
References: <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me> <20261024-rc-reply-0001-tiny-power-button-s2idle@kernel.org>
Feedback-ID: 151291767:user:proton
X-Pm-Message-ID: 677249792e5eb5522e0e2f6eeff973e20bcae6dc
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:26:52 -0400, Sasha Levin wrote:
> I have dropped f4203ec64e11 ("ACPI: tiny-power-button: Convert the
> driver to a platform one") from the 6.18 queue. It cannot go out without
> ab06eb920401 ("ACPI: scan: Register platform devices for fixed event
> buttons")

Now that ab06eb920401 is queued for 6.18 again [1], could f4203ec64e11
be queued with it? ab06eb920401 alone does not fix this report: on my
machine (control-method power button, PNP0C0C) it changes nothing, and
tiny-power-button keeps binding next to button until it is a platform
driver too. 6.18.59 is still affected.

I tested v6.18.58 + ab06eb920401 (with Ting-Han's 2/3 and 3/3) +
f4203ec64e11 on this laptop: platform devices and bindings unchanged
from 6.18.57, acpi-button binds PNP0C0C:00, acpi-tiny-power-button
stays unbound, 3/3 s2idle resumes OK, no SIGRTMIN+4.

Tested-by: Mikkel Sejdelin <mikkel.sejdelin@proton.me>

Thorsten: regzbot has ab06eb920401 as the fix for this report, but it
needs f4203ec64e11 as well:

#regzbot fix: ACPI: tiny-power-button: Convert the driver to a platform one

[1] https://lore.kernel.org/all/20261024105710.593-2-ue081723@gmail.com/

Thanks,
Mikkel
