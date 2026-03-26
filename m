Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEF2F745E
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532390; cv=none; b=s1GayoEVWXDdH++cBM3F3NmRl02pqswMOjKjdDGPGd+QdG6zUqKot37wShMyo3vfjFkuVunYsYOX9X7BWs9NfS7JjlvnKmf7QoNz29w5xv+xzynL1Zo05sPvp/kgep3CbPUgxftqBSZqJRbtET76hrXmoGTCTkgJd2/wUWKjVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532390; c=relaxed/simple;
	bh=+4Y9H9eO6cpx1PePYfQmYSHAbgpkwLBxg4CHNcTD4ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVYYHdAMthRA87l9qXk47e49SK5cVZkmaYWmLP5Jtd+qYZbWnLvdpSnTF8962PmlYu+TIAamzHwqHkkrRaKM02BcQwPtyPLRSmYmfnpXTIGrAC8CscA4XTk6CTZU7qAci5pfUU9WPOs7XN6yZtxWTklIIstdnfxudSdiKI03Px0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDDIs+zR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDDIs+zR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35FCC2BCB4
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532389;
	bh=+4Y9H9eO6cpx1PePYfQmYSHAbgpkwLBxg4CHNcTD4ik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eDDIs+zRWv8biBCzz5laC/tQGszYT1/pUSMG+DcraeMU/bGZO+AsK9nf0qS/x0LvK
	 oj2fUKRS+Wh+8a+6Q3K0XbK+4SX7ER4D8C1852b4Bn1TLx4uoqX2aMQEOfW4mcL66+
	 vHANRqWviOHtFis3L+WWYnubqmqg2/53P8HpiDJ+l9Og/fjzuC6BoNVpuFwIWVuM40
	 b853a2H3XeJmn1uZItiaFe/o5piEMjv+tC9R6S8f2LNhP/d/UVFSXK9ePLwJ9FwSic
	 wT2cfnAD6uB4Nc5lgEQnOJM5wGdNapi9SBYoqOBSAImDSGIPEY1B0XlKDSv1/zG2jG
	 H2pytoA7h30WQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-404254ffe8aso553937fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 06:39:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeaxaUuaiz93cR/QWPTHHJYm1dbsqYMqDAtLtwDbbitRgkoeKvfv9eobPNs4EVQEo9YgtO04gcvc1i@vger.kernel.org
X-Gm-Message-State: AOJu0YzuGscwkCErkiwIG5wtmDeLXfVK5M7Okwz1l0+vjOF9TJlWzTWU
	0Zah9QfLyakrOwsAb25DoGweFma3R17WyALGh72nXeq4WyNvsXrthceyDq4XSf8sfLp4ldjvNfW
	BLYNbriZbwNjWWtymySdbDqjYyUDg9lw=
X-Received: by 2002:a05:6870:d29d:b0:41c:1d37:3825 with SMTP id
 586e51a60fabf-41cd7cf8bb4mr823402fac.17.1774532388923; Thu, 26 Mar 2026
 06:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125072933.3706006-1-lihuisong@huawei.com>
 <20251125072933.3706006-2-lihuisong@huawei.com> <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
 <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com> <2d2d2d40-c73a-4988-90fe-fad75e35c75b@huawei.com>
 <f2be1178-28f4-4412-adb7-1530944a76ed@huawei.com>
In-Reply-To: <f2be1178-28f4-4412-adb7-1530944a76ed@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 14:39:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0heJsOWA5z7CwrON4zvaebj8-C_HBe5ymYa+FAbfJgy1A@mail.gmail.com>
X-Gm-Features: AQROBzCSOYLBI5xlCMyjk8kQUyaAs9DI8jToaji69jYNv1tFlTYiJrptJnooqh8
Message-ID: <CAJZ5v0heJsOWA5z7CwrON4zvaebj8-C_HBe5ymYa+FAbfJgy1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:17=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
> Hi Rafael,
>
> On 1/30/2026 9:59 AM, lihuisong (C) wrote:
> > Hi Rafael,
> >
> > On 1/15/2026 8:18 PM, lihuisong (C) wrote:
> >>
> >> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
> >>> On Tue, Nov 25, 2025 at 8:29=E2=80=AFAM Huisong Li <lihuisong@huawei.=
com>
> >>> wrote:
> >>>> The global switch of cpuidle can be turned back on in some case.
> >>>> So add enable_cpuidle().
> >>> No, this is not going to work.  The "off" switch only affects
> >>> initialization AFAICS.
> >> I think it would be work.
> >> The cpuidle_not_available() also see the "off" on do_idle().
> >> And cpuidle_idle_call() check this function first and then select
> >> idle state.
> >> Cpuidle doesn't select and enter idle state if this fuction return tru=
e.
> > I verified that disable_cpuidle() effectively prevents all CPUs from
> > entering any idle states and the cpuidle function is correctly
> > restored after calling enable_cpuidle().
> > What do you think?
> Could you pleasetake a look atmy reply?
> If not ok, I will drop this from my upstream list.

Sorry, can you please remind me what problem you wanted to address
with the help of this?
