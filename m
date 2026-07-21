Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B8360EE8
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640344; cv=none; b=FENyadIv1OSJOKRnQi0W7ZmAb6BNuCbujTjJSwKcIMGTOTTsOducNM22ey4MNeDKs1FYtDUUgGl/nLnWll9777kUdOveQ+xWtCfreHwODpx5XW80TZhtuWjxmgvG2ND1zLwUJwcnrzPBzqwDMSVfoJC1p7u+ddXmqm8nRuohnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640344; c=relaxed/simple;
	bh=hg3r3rHhdHBLluXAp0WXBWlTRUfEV4ZufSgvWF2Rk+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OE/7c3uS+e82Q/vy49I97itYOfTJqd3G43RKBzfkamEMYtcasKSSy5x1mv77w213U4gplvRJOVF+sC+IK42v12siPTSwOLPw8quHjjf0owiAzx/KiUtLboqm4MYxTHzubj/qd8FU9ZKiWAUiu5/qrAN2FgwD1U/vdhSnpFaJxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOlFZBze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOlFZBze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A675F1F00ACA
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640342;
	bh=hg3r3rHhdHBLluXAp0WXBWlTRUfEV4ZufSgvWF2Rk+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TOlFZBzeG/KSQgbMDkfUvLuxtiU0E835Yth5rBlPgp2Qik1xmWL4lkBvv9rxQOdLx
	 xmvElpnRhAvX/gbgj4n823msNyY5u/tSrX0AZ8gDb51kwp9tR4j8RWx2fVahqRWS/W
	 UnmUKbTz/2bITrHhL1Ix9hkWyK1NmdymeUt5jj9OCrGZygfyHYGbACyGKACCQOzN3D
	 7X2iB7jHZwFg+VTswHZ36VQ41/xf49GYJw83bJYhHn/OOpdKFUp2wgp/xgS0MFRLDu
	 A+XmHWaw3Lv9UZOPmuY/51uhcoDSg9gLNpLCeFfSBkIK16tZsaBEpETld2sOsUycFN
	 cZOs/Qi0zMgKQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso9932391e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:25:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoOtbWG9oSpOsaxxEKAdjv4qpr9R7fGKVJQHq2+SCJbPnKby1P0VuK4O7Tj2BOHCbdCbnVSKF8eeP4a@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKqj/Lo/EXMd+4BOFbSSPg5YJvF4iAid0zX0Ouqs8rYTrf8Ss
	Wch3Zj5+y71Ichz8IZUBG1FsPSHVrsldZyRIRG+pMq4oiCXGnF65X4IvzDCc4ECf/KQwxpaLfvd
	I4J2HX0PuqtaLZ1twptPmjODgYBdmWTE=
X-Received: by 2002:a05:6512:39c7:b0:5b2:a328:cdd5 with SMTP id
 2adb3069b0e04-5b2a328cef0mr1440639e87.49.1784640340999; Tue, 21 Jul 2026
 06:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710053106.730399-1-rdunlap@infradead.org> <532f6e46-ee9f-4170-8ec4-72374e761cb0@lunn.ch>
In-Reply-To: <532f6e46-ee9f-4170-8ec4-72374e761cb0@lunn.ch>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 15:25:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAMdafpPD0KL-OkNqw+1D5BJDbDd=rWgCR9-NTkovGgQ@mail.gmail.com>
X-Gm-Features: AUfX_mxXNh_iEn9L5HnP2L_qFMduzYLKmEhs93aMG1pc4wGHGSi8H6gqxV6ssxE
Message-ID: <CAJZ5v0hAMdafpPD0KL-OkNqw+1D5BJDbDd=rWgCR9-NTkovGgQ@mail.gmail.com>
Subject: Re: [PATCH] docs: ACPI: DSD: motorcomm: fix docs build error
To: Andrew Lunn <andrew@lunn.ch>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "chunzhi.lin" <linchunzhi0@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 6:37=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 09, 2026 at 10:31:06PM -0700, Randy Dunlap wrote:
> > Separate the title with commas (since they are all run togethe in the
>
> nitpick: together.

Fixed up and applied as 7.3 material, thanks!
