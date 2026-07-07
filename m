Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102363DF011
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jul 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423095; cv=none; b=tJWn758P3YKwJXura/uF+FjqZzk0v6yWXd0yEuEpDih3i92ZeZia6lSKzlfpWmzUXROQO0tXhhW0LDVyWP4J39u/i7L//IxOL8Bs3gCMbjP/qDPKHZi2nm93JNPpqn63ICM+0mpT7nLBLPe2wK9JPeZLxMf3jLWYCNAV/DsFgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423095; c=relaxed/simple;
	bh=NOdz3nMifEjSm7c4pE4HSutRvb0Ohw1dNuMlCenv8wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InG2xLVPrjDvDHr4L6V19LrAQMXHbz4/dq79C/XaGo+3gNCXt++A/u1VCZpc7u19xmnEVYYN7xr5YYbNUkqQvnCx3OKEfjObuSSij73BtuShNPlNWdx8mX2jeYWUE+1Dk/Z6GhXwQcc99h/B24EK3XBhjQ4F47gbFpbvLX94OaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdooZGY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdooZGY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE891F00A3D
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jul 2026 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783423093;
	bh=RE1DwalSGn6K9yfNR7G1p6eC6N8qMZtqcg7LH+d7xgs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QdooZGY1vBtLROt3ptkfJJxYJBBbBSmo1lJYmYYJH4evPMWyXil0R/u2E3Zwz0z7Q
	 s7FU9e3t13YfnhV+vjOnuzynoTK4X5JYpF77qy1rHrlnAcQpeMOhVhEJGVW5agIDQe
	 RuOXXDQ0+mzdCB2mArinNEwSdKv+NKcYW1WRqJqOxY733DRrOLFmACRm+VGQkCNE9O
	 rimu7iLZDm7rVokpi/clkNxHVGnbDjRRWnbh4zOFD6qOhOkZ8vbfW5SdtDKERL6c4j
	 NcPZ8uC9kaWDxN96nnQxi3PvPGBN/W7lkZizwXKAbdqkvqywlT/WGtH/kYy4y2U9BK
	 gG1wdkXzAxI0w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aebc8cb5bcso2696322e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2026 04:18:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro5+H/xEl3FZR+9Iuq6KQ9lwE4Hp7JeFtcfd+sZWByQ89s1t2lpmVVc00Gl4I+7Jm3fEavEb4Hm6s9N@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn6kWk4JPpxtx+W5la02LwAm5u4tQh/zaMC7N7Tuo/mG30UDWl
	wHhH+iDfWKUYN0mnnp9iYDktcN9cJGLrNRNQW79m6fa3DUgF7EmIEN56zusUD2HQEcdiilIppK4
	lKLdfxyn/177Hk32JYHIm09B+rWcnTng=
X-Received: by 2002:a05:6512:1502:10b0:5ae:b57f:eee8 with SMTP id
 2adb3069b0e04-5b007bfa837mr881391e87.3.1783423092201; Tue, 07 Jul 2026
 04:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM9P193MB158895CFE0DDFA62FCD1DA5ED0F22@AM9P193MB1588.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P193MB158895CFE0DDFA62FCD1DA5ED0F22@AM9P193MB1588.EURP193.PROD.OUTLOOK.COM>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 7 Jul 2026 13:17:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h47_XU74PtF2nOrNDfjBoyOLvicv72+sdfRm91P+DfCw@mail.gmail.com>
X-Gm-Features: AVVi8Cfd6RQnNH6BgzaYN_BJAt0bzVDrVgMq3Y8FfnLOY0l0wlCzsUptC-21p_I
Message-ID: <CAJZ5v0h47_XU74PtF2nOrNDfjBoyOLvicv72+sdfRm91P+DfCw@mail.gmail.com>
Subject: Re: Regression: ACPI battery status incorrectly reported as Not
 charging after bb1256e0ddc7
To: golne tree <lrepper@outlook.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 11:28=E2=80=AFAM golne tree <lrepper@outlook.de> wro=
te:
>
> Dear ACPI maintainers,
>
> I would like to report a regression caused by commit:
>
> bb1256e0ddc7 ("ACPI: battery: fix incorrect charging status when current =
is zero")
>
> The commit fixes a real issue on Huawei laptops, but it appears to introd=
uce a regression on my system.
>
> Hardware:
>
> Manufacturer: Default string
> Product: Default string
> Laptop: Denver NID-14106SSDDE
> Kernel: 7.0.11-1-cachyos
> The same issue is also present with the unmodified Fedora Workstation ker=
nel.
>
> Observed behavior:
>
> When the AC adapter is connected, the battery is actually charging. The b=
attery percentage increases
>
> However, the kernel reports:
>
> POWER_SUPPLY_STATUS=3DNot charging
> POWER_SUPPLY_POWER_NOW=3D0
>
> Relevant values from /sys/class/power_supply/BAT0/uevent:
>
> POWER_SUPPLY_STATUS=3DNot charging
> POWER_SUPPLY_POWER_NOW=3D0
> POWER_SUPPLY_VOLTAGE_NOW=3D7400000
> POWER_SUPPLY_ENERGY_NOW=3D24760000
> POWER_SUPPLY_CAPACITY=3D84
>
> The battery does not provide current_now, and DMI information is unfortun=
ately only:
>
> system-manufacturer: Default string
> system-product-name: Default string
>
> Looking at commit bb1256e0ddc7, the following logic was introduced:
>
> if (battery->rate_now !=3D ACPI_BATTERY_VALUE_UNKNOWN &&
>     battery->rate_now =3D=3D 0)
>         status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>
> On my system, rate_now is always reported as zero even while the battery =
is clearly charging. As a result, userspace always receives Not charging, a=
lthough the battery level continues to increase.
>
> This suggests that some firmware reports an incorrect rate_now value whil=
e still charging, making the new heuristic unsuitable for all systems.
>
> Please let me know if you need additional information (acpidump, DSDT, de=
bug logs, etc.). I would be happy to provide them.
>
> Thank you for your time.

Here's a patch for you to try and let me know if it makes any difference:

https://lore.kernel.org/linux-acpi/6283544.lOV4Wx5bFT@rafael.j.wysocki/

Note that if you don't report back, I have no reason to make any
changes to address this problem.

Thanks!
