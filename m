Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF633A9E1
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935789; cv=none; b=jMOaMk+kaaayGcjbSGazRBovGiUr68KN+jwnIvTKc7oP4XiKwb0g+eUF6Y9ztFddrQfj2gdU1vaeCoNVKdzBgEWe85sdc1PwqQuPZ/TNws3cQ1Btgg7B3kSCkeYkXHCyNQ/ubRC2DSRpw+2qrIlHXbhuf943Z3D+kGQUWm7DrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935789; c=relaxed/simple;
	bh=7mi8MoNdHnNXmnSAUgr39QncBchcczs9bxjAVmOyEs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9VoTpMKzz55gmaycSlcbX2UU/KDenRERJe1HAuXuppV6eEojtnJ0yR+Hd3uhOqY52msb60gnstvfN+z27HY3vYg3so635vZmYwNmT0SLpwc5VstC8+ziXDmMjf5CtaaGlHyOptzoT6SpPvO/MNf6lZi+WITJWjiy4OFeYl/dFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4SNcKeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4SNcKeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48851F00893
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780935787;
	bh=7mi8MoNdHnNXmnSAUgr39QncBchcczs9bxjAVmOyEs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y4SNcKeL6s+bDbli3Z1uxBKacFc3x40XZiWD51eWaOuLbK+51o0r1/TchTXXCzeMM
	 EhRKn0DUf5QKhdA2XUJ3PLXCqerW09hkJ6ePIq0GQan+B3lxh8Sq4WK35uKxhj0CLb
	 FkAvaGqRcorQF/teBsPnEmVmCIkUUYJVopNTnNjet6GzTxyv0JUALCNwg/CkkxCkKA
	 nzh1Y2NfnVy2Xq3lG45H57VHC9Fz98JLt5OcOQTg/ql3IrCDuhOBOIEYT6QG7UHxj9
	 iJr3rnwfOIAj8fOQXftnQb/L2fFsX4iJWuNsSBN9znwq45ATc9R/D5byV3hBsFStfY
	 4m4D/qtSSE3XQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39677aed4d3so40158321fa.2
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 09:23:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/uWMtTgBRnxZep/5FMnXtkx3M7iBavTHZLLu6bRVw7NiyF+FDrfgesGPgLtp+yeJVTbeovRF2vZ2+c@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqZJbsQ8TFK6p+qy9RaOpr+oBMuOev808svpVbPgNVYvMSsmJ
	DnbC0CP8y/vMOSUGV1sYPup55PZ65Qb0U+vfq4zegLPY4kiX5F0BIzz/Dvw2FhJKzAhU/y26fEa
	w5AD6a00Xr+E4bpxW3unTORvYoFRBiHs=
X-Received: by 2002:a05:6512:3d12:b0:5aa:b6b:93c2 with SMTP id
 2adb3069b0e04-5aa87be01bfmr4882836e87.44.1780935786292; Mon, 08 Jun 2026
 09:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FRWP193MB2795C5F5840785D43A008E45B4152@FRWP193MB2795.EURP193.PROD.OUTLOOK.COM>
 <CAJZ5v0id5Aef=wwWrK8vPSdfo4CuJ7EkNqasfE=VMBrMuzcPBA@mail.gmail.com> <FRWP193MB27957B4178CD6B36C70DD194B41C2@FRWP193MB2795.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <FRWP193MB27957B4178CD6B36C70DD194B41C2@FRWP193MB2795.EURP193.PROD.OUTLOOK.COM>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 18:22:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gGkOubNGhJ6v0BFQHzN-WFCou750eQs6Wk4epzaqVhpw@mail.gmail.com>
X-Gm-Features: AVVi8CesZs3lWmi4ENobUmQXjR_CulE-_B9f_UY3lwrr7VbTtGXky1xZvB2PMBg
Message-ID: <CAJZ5v0gGkOubNGhJ6v0BFQHzN-WFCou750eQs6Wk4epzaqVhpw@mail.gmail.com>
Subject: Re: [REGRESSION] ACPI battery charging state regression on GLK MRD /
 Gemini Lake platform after bb1256e0ddc7
To: goldi fiche <goldifiche@outlook.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 8, 2026 at 5:36=E2=80=AFPM goldi fiche <goldifiche@outlook.de> =
wrote:
>
> Hi,
>
> by "correctly" I mean the mismatch between observed charging behavior and=
 reported power state.
>
> On my system:
> - AC is connected
> - battery percentage increases over time
> - energy-rate remains 0 W (no charging current reported)
> - state stays "pending-charge"
>
> So the battery appears to be charging (capacity increases), but the syste=
m reports no charging current and keeps an intermediate "pending-charge" st=
ate instead of clearly reporting "charging".
>
> Additionally, I observe that between ~90% and 100% the system correctly r=
eports "charging" in both kernel and GNOME UPower, including a non-zero ene=
rgy-rate. This suggests that the issue is state-dependent and may be relate=
d to firmware reporting behavior at lower battery levels.
>
> The inconsistency is between actual charging progress and the reported po=
wer_supply state at low to mid charge levels.

So I'm wondering if you have been able to test the patch at:

https://lore.kernel.org/linux-acpi/5111702.31r3eYUQgx@rafael.j.wysocki/
