Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315164;
	b=H5B6p815m/cSMIUq8d+Mlbxelwrzf1kV3pot0UiU0joZKwGeiip9HtfCXtk0UwmHDGbj
	 B9qOEPRmrsn9qhqv7Vcfy9lzVaTzDv/C9LGuNGXuYVmD12mwxuBt2wXudRjoox7XhtyyI
	 e+2As0vNThknIGqUXhoXNCfENe1zKHHNs0/P0P4WI/X7H87Ds+qH/Fn7IquMH8H9eXBZI
	 kJgSnDx3mPXP90NkLPPCKKW/HJ/50EeYPBFsfeIClsN5pPilvczl/HIvSLGykCu3aiyZ4
	 4Q6/4dROdU6cS6UI+9vSxEpqc8IaM+uwmgcWechXpkHO+Qpps6sldsm/gTk3u7xHdFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315164;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=CskMbCuNN7TqHn8jl34uhXVVf0ggCo8k+jKpleHJs1s=;
	b=ceF3Wc8ZoYrPamksxWs9989PR+ttbYJENKF7rEb/7jf4cmvFdEJkrP9BLT/qS0kNy02a
	 crGfjvB+IuJ1g+0/tOZ4RFyKvnE5UI3MGWXFKH+iK23EmVPMzM8mrv7w/mfzGO77X8C5x
	 aiuXQl4Ono8YmEWX2gLXuZ2nXwTPZrpKKV8GbLZe6MY1L8mvtl1Lybe1sRwTlvu7Ucfn+
	 FGroY4kqoAs8GWOh0jtbk3BUEzRCpVwU0HI9J7+lPDDM8hU2W44DKBH4vrJmIROcVh61o
	 HEflcDFQlJ9u98b6i3OP2nSYQu2HBHRzAOHHkDAL2fkbBSLZTVlBIIZiHVHMQ7WZ5PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAldbC00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FF606A325
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAldbC00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0D1F0089F
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315163;
	bh=CskMbCuNN7TqHn8jl34uhXVVf0ggCo8k+jKpleHJs1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kAldbC00mztx1i8pl3G5nZs7nDPsS4PvILq8PeAblAoN+Ptmwlxv5v6P9F9gCQieX
	 8a8NqGsIz8rJET9FpN76RDMMvcXmBhLQHhM6KMaGy7kaHEq2R+UfBwcpxiwZe7dL8T
	 WMhQeXUtwH7GA86l4eExPEgIoWGZahgf4CI9IPMwIYAbl1gbUHlbX1XeTwPaRtmRKy
	 dttDtK/5tgtcHKfJa1N5jXEif+kCtYmXhoeCt5twsregVPIzi5isn/2gOy1a+10nb0
	 D6SMKayVqmsH2XnHeggiX7txfF8TCtJjcegVNtLv5lEp/P8nbvkIR7F/PMofA1gaJc
	 p61TM2IbfLIQA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ada7d53082so21545931fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 04:52:43 -0800 (PST)
X-Gm-Message-State: APuU4Z/D4VVulpNqoSkE/AHTg+SARa4d34X2XEDIVikPnmBaSMmwT/Gg
	705MfNSCXI1IA1Qncsg+lJFGXLGkziQn2wgEKbTLzGquuhdnYzEbikcDaKEf5OmvSs4BE+ycaHi
	X2XUj7FuuexY6fHEgi/tKjijtmgGKOm4=
X-Received: by 2002:a2e:bc17:0:b0:3ad:fc9d:3b94 with SMTP id
 38308e7fff4ca-3ae0907341amr5487881fa.2.1794315162358; Tue, 10 Nov 2026
 04:52:42 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027220537.3443104-1-hamzamahfooz@linux.microsoft.com> <avHUNhepm/Qowd1E@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <avHUNhepm/Qowd1E@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 13:52:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jNE6Xhc92GzWbT=9BW8RPJngQ7j1NBSB4gp+K8q=4_3Q@mail.gmail.com>
X-Gm-Features: AclHuK-uoeQ0E_-nUisIdYMUibomSXOZhN5eRvtOBjENGti_PIKDQZxAp0xrhVY
Message-ID: <CAJZ5v0jNE6Xhc92GzWbT=9BW8RPJngQ7j1NBSB4gp+K8q=4_3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] rtc: efi: defer to the ACPI TAD if it can drive
 the RTC
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-acpi@vger.kernel.org, linux-rtc@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 3:10=E2=80=AFPM Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> On Tue, Oct 27, 2026 at 06:05:34PM -0400, Hamza Mahfooz wrote:
> > On Microsoft C2141 and C4143 systems, the EFI GetTime() runtime service
> > faults when called by rtc-efi, which causes all EFI runtime services to
> > be disabled, even though the RTC can be driven via the ACPI Time and
> > Alarm Device (TAD) instead, which acpi-tad registers an RTC class devic=
e
> > for since commit 8a1e7f4b1764 ("ACPI: TAD: Add RTC class device
> > interface").
> >
> > As suggested by Ard, add acpi_has_rtc() to the TAD driver (patch 1),
> > and make rtc-efi decline to probe if it returns true (patch 2).
> >
>
> Ping?
>
> > v2:
> > - Rename acpi_tad_rtc_available() to acpi_has_rtc(), move it to within
> >   acpi-tad (which allows us to simplify it quite a bit) and declare it
> >   in linux/acpi.h. (Ard)
> > - Add acpi_disabled check. (Ard)
> > - Make rtc-efi decline to probe instead of not registering the device i=
n
> >   efisubsys_init(). (Ard)
> > - Make RTC_DRV_EFI depend on !ACPI || ACPI_TAD. (Ard)
> > v3:
> > - Make RTC_DRV_EFI depend on ACPI_TAD || !ACPI_TAD. (Sashiko)
> > v4:
> > - Move acpi-tad code to existing CONFIG_RTC_CLASS #ifdef. (Rafael)
> > - Add IS_ENABLED(CONFIG_RTC_CLASS) case to linux/acpi.h.
> >
> > Hamza Mahfooz (2):
> >   ACPI: TAD: introduce acpi_has_rtc()
> >   rtc: efi: defer to the ACPI TAD if it can drive the RTC
> >
> >  drivers/acpi/acpi_tad.c | 48 ++++++++++++++++++++++++++++++++++++-----
> >  drivers/rtc/Kconfig     |  5 +++++
> >  drivers/rtc/rtc-efi.c   |  4 ++++
> >  include/linux/acpi.h    |  6 ++++++
> >  4 files changed, 58 insertions(+), 5 deletions(-)
> >
> > --

Both patches applied as 7.5 material, thanks!
