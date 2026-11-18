Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012109;
	b=SCxbu8Q0RCJRTo5DOT3b/NC76IRr6sd+HSz0gILdEJHwuP/BSYEDsnycaiEm5rGTlMVZ
	 iHaJCYsPsLjTo8No/R8WSiHjRjmtQzxmAc9tPzX0zL6PNTFmDgrs67jskSI5Idg62pvSu
	 SaPmNocw+FUEGTJkVR8ghVgOoY4zzlSL/PTuhlPDvkGAkif8rlTDzkNHO8qzGNuPaqJgT
	 Zc8KCv2FiBUk1AKWWT0yJEMIIHyO4mmlHErQd+bHZsVyGK0fsrhg9LAF7UZobTTEQpslo
	 j7GsgJ1gtBJLRvIpty6L9RfQ9kOCZKF9dBizoyacEUOjLrZi1g1Z50dkcc2MjgWhuPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012109;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uEWqDU0LG/ft1XSpwdekX6PonsmuMVmcofZKxwquxNg=;
	b=xAYySxt+xU2miwxQ5n8qkIKaFLTNhyVYSD/I7u9JqvEdiAaL0IZ1rZwX4ZKVXE6Avb2r
	 n9eOhxSGBug0dMVg9BBnp9L7Boi9m4+6yQsCfFXTxnF/jL+gLHKV3TULmSjetoKD1RqH1
	 xKW76dNsPFrOyZb5BUaZ9/oiGHZ2UK2klpLyIocoGinkPDnVlv/WIdSYmKqN+Lzekt6Mp
	 BJfwEoTRDqV/MYOYh7H+20E/r0Vo3v1zv+7XZMXTpcUk3j2SqEGejTTmQMUTbxON21hmC
	 j4F2KE1aV18umq0qOGpwTcp4ECjOsaEquYwv2v9ykPXyLQBFXXSnaw4SX+dnh/LoWuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSsNxiS2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070C60A2608
	for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSsNxiS2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8E21F000CD
	for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 14:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012108;
	bh=uEWqDU0LG/ft1XSpwdekX6PonsmuMVmcofZKxwquxNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FSsNxiS2hjeUKjZLyeQWIXDnGj3hmK5L7hp4mbZybh0b8H8hnR2vEE+SggUWIIFhf
	 76Yc4hp0nI4TmJqIfoSO831VdCgMTnse80KrBjqiqrmyH04oM1Q1i07DYC+WRwoUz3
	 W6kZD344rtGJ4/ymBnV/y2QT3k7GWuH7ZMJ36tiaz8Y3K9goSi59T7szNygLuR0ui1
	 7BEmzNLDdWQ5i0xdx+F9G35n4TAqPaDkP9XqBDy9xJDYE5iajM5Wkf+oGKrfHzcAb+
	 dbn8YCP6bB687okdy5oDYfN/wFQXuKqFEOJjCoa1eH5r5y8hfLgItbaSdOUDlhs2sm
	 nA8NQNhq7BgVg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so11068561fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 06:28:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFrCvgNX1Jz2nnEWgbi/Kq72yfdzkK+gyt67wApsSYP6dckaF1TfMKAuqL8PgqmA3xZVT6t6uZsZoCR@vger.kernel.org
X-Gm-Message-State: APuU4Z+92tJcLZxaKgg9xKOpyonTYPgR7QxB0eOI+r1g5YHK+79k+TUY
	XLG2hvc3wI5YmWrztxpyUefByPyApuem08VpaCdnjwb9AdQILnLpQJGaV7y1Va5RLWEQI3uMseD
	VKQLMtQO077n/5CaBlkqCfUeLqGWtn+Y=
X-Received: by 2002:a05:6512:31c2:b0:5bf:d9c8:6e8a with SMTP id
 2adb3069b0e04-5c1a9d27f26mr850005e87.50.1795012107305; Wed, 18 Nov 2026
 06:28:27 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110144436.1529000-2-ca@modelmiser.com> <CAJZ5v0jTHbr2KD3PXMdcOCs+QUrGrjGGuxOH7cbOe4kEF77d-A@mail.gmail.com>
 <20261116200935.2464922-2-ca@modelmiser.com> <CAJZ5v0gQgAAHWwS1ftxaTKHSeq1ADH7-Z6sm77d=_vWBrrkgTA@mail.gmail.com>
 <20261117221910.941588-2-ca@modelmiser.com>
In-Reply-To: <20261117221910.941588-2-ca@modelmiser.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 18 Nov 2026 15:28:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0igTxCekeQvHRBWon1n3xwEjKWrdo=ihex4nAfF=J-cYA@mail.gmail.com>
X-Gm-Features: AclHuK9_RD-cf7kltsYphMuQqxjbY1As-ur1LNkjfwtAWPltB8hmaoQr6kJXcQE
Message-ID: <CAJZ5v0igTxCekeQvHRBWon1n3xwEjKWrdo=ihex4nAfF=J-cYA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pfr_telemetry: keep the state until the last
 file is closed
To: Chad Aldreda <ca@modelmiser.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, 
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:19=E2=80=AFPM Chad Aldreda <ca@modelmiser.com> w=
rote:
>
> On Tue, 17 Nov 2026, Rafael J. Wysocki wrote:
> > I've fixed up the above, thanks for the notice!
>
> Thank you. One leftover from the rebase: 3ecdc4c7d2bd ("ACPI: pfr_update:
> wait for running calls in remove()") still refers to its prerequisite by
> the old SHA, dacb7cef6f32, which is now 59a1090d0d17 in linux-next. It
> appears three times: in the first sentence of the message, in the Cc:
> stable line, and in
>
>   Fixes: dacb7cef6f32 ("ACPI: pfr_update: keep the state until the last f=
ile is closed")

I missed that, thanks for the due diligence!

It should be fixed now in my tree.
