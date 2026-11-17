Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946970;
	b=fqI33etiyLuQTqDIgCalQw3s2EXJCbFoyDv7/ebSfML9Zw2iFvyD2lGa2VpBO8Ou3P2d
	 gL7CXxRuuOU5/QhimUHiR0o3+cOkCK56NZyHj6//+xxXiR4Pej5+Vc+3i4pYi276QO8eF
	 mlFlfQILFKDsK851cAIA+5MBNSxFUlhMuJnz0LqyuU0b2Eonq2pO773ETlabn4O6dU4An
	 a4RJNHBq6a+Jb0tFlHfJISGwVZL/KqjdmGMj3MFj3WvM9EsURqmkEMceyphV1lmJx03SL
	 uByXxIKjfhaefleXFZziSvgbZoEeRoxIq8DKeVI9Xz9z9oPANJDOvpjQ0rsdDfmJ13w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946970;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZtQeR/ddy21JbXrMZ+LXpeOqWubRGUzX5o5Gn48azrs=;
	b=DogW283a22cbJkZx692cLWja399dfmd9h1znid1b+1nHaj/jJQrfJh4bB4+m5VgIYxMa
	 6rGscxvffqXDlZTGGg5VlNYoEERkh6EwqZKDsxJ9MeJkL3+09y7G1N60AamZ7MXOxEO4g
	 uX/7P4Hzh55yds7IzCxr4FAG7JxHsih3HRlaFpFCVkBYXVeQnzxEBT4jK8Rm/7dCsj873
	 0iTQfcdeoKsOj4ijBKT+8OYVUMkTlLGxJy72zo0Byuk33YneksMCzL4juX5XdrjsMivHr
	 AaNoEuqojAb1jJN4gbm1FI1TQxTaVmPwaez8n248XTw+6ka0q9Guw+fNmwkYi0DTWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FG4I/h8l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530A606A32A
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FG4I/h8l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755591F000C7
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 20:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946970;
	bh=ZtQeR/ddy21JbXrMZ+LXpeOqWubRGUzX5o5Gn48azrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FG4I/h8ljRamYVPM7NsX+kdiQFbGzR7sN38whq50p+nPWuDu4Bqo+zDGqjemxLt4f
	 s8srbgyrZXTHeA7LCHCYt7TfmQF2A+LVZL2BnKbBe93f8wiqMbw0ib46ReZHdw6OvT
	 aTPykAkJ6EU7ZLVoTEYZnxaOLYdJzDGqosSzDSvwObTvSViReIIxMNl3JTR3MJiLlo
	 QOv5rIcgg2cBdecPh3A4Qz3Wuco5PAMPuRtXeerYPOxJkTkXB4LWpopeQY6VeTfH4j
	 xKSW4rQjykZPyB5W+lS1ufJ9BbyzvHf1kYzFIvXxiXLuZav6xfY4IWC3pqvjmQciUg
	 xsCanBYATnnbg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c1593fd141so209846e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 12:22:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE6gYqZBE8p2UKI6BlXA+IEVOLv9F0jLeYrR++W9S3u6HsZML4Y+baiwP7S2PNtL3s9Wgo3oJNM8wTv@vger.kernel.org
X-Gm-Message-State: APuU4Z/HVJdbxb1c0Q705pdzrdpvzxa7A9r0to1D29eKQjMcQWqrW7vT
	NyDskVlyIndcaMq48i6MCZfAkIghukA5IzJUcw9XEa1LJ1JMkpDYYX/rsswKruBXxJFRe72DAZ3
	RZtxcCJ2/30yarLzR6re/k2lfi3KQgUg=
X-Received: by 2002:a05:6512:308c:b0:5c1:4e66:7bbe with SMTP id
 2adb3069b0e04-5c1a9c25e4cmr84934e87.29.1794946968890; Tue, 17 Nov 2026
 12:22:48 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
 <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
 <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
 <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com> <CAMuHMdWfH+_4ijxko=LS_P6b1Y76WWDc8m4xL6qW1H+qKRQ98A@mail.gmail.com>
 <CAB9z6xC4c=o1DwVARBek7ozDxaCON9rpwTmJ810sDGyP0XYQDA@mail.gmail.com>
In-Reply-To: <CAB9z6xC4c=o1DwVARBek7ozDxaCON9rpwTmJ810sDGyP0XYQDA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 17 Nov 2026 21:22:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jg61_W6hgtMzKdMa+f27ApaNunnpkzM0MoYxN+aV-xog@mail.gmail.com>
X-Gm-Features: AclHuK_c_NJ9owiTS0vj6s42B-axpqzhO3Kp4-jOW_Jw2rhEoqZi8QT4VogQuuA
Message-ID: <CAJZ5v0jg61_W6hgtMzKdMa+f27ApaNunnpkzM0MoYxN+aV-xog@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] platform profile: Extract the core from ACPI
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Wu <jackbb_wu@compal.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, linux-acpi@vger.kernel.org, 
	"open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 7:27=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
>
> Le mar. 17 nov. 2026, 17:39, Geert Uytterhoeven <geert@linux-m68k.org> a =
=C3=A9crit :
>>
>> Hi Daniel,
>>
>> On Tue, 17 Nov 2026 at 17:03, Daniel Lezcano
>> <daniel.lezcano@oss.qualcomm.com> wrote:
>> > On 11/17/26 12:48, Geert Uytterhoeven wrote:
>> > > On Sun, 25 Oct 2026 at 00:56, Daniel Lezcano
>> > > <daniel.lezcano@oss.qualcomm.com> wrote:
>> > >> Platform profile providers already use device-based callbacks and d=
o not
>> > >> need ACPI types. The core is nevertheless confined to the ACPI buil=
d and
>> > >> refuses to initialize when ACPI is disabled.
>> > >>
>> > >> Move the implementation to drivers/platform/profile and introduce t=
he
>> > >> firmware-independent PLATFORM_PROFILE symbol. Update all provider
>> > >> selectors. Keep provider-specific ACPI dependencies and the
>> > >> platform_profile module name.
>> > >>
>> > >> Isolate access to the legacy ACPI kobject in an optional compatibil=
ity
>> > >> object linked into the same module. Retain the legacy ABI on active=
 ACPI
>> > >> systems, and initialize the class even when ACPI is absent or disab=
led.
>> > >>
>> > >> Use subsys_initcall_sync so the class is ready before built-in ther=
mal
>> > >> and CPUFreq providers, but after ACPI has initialized its compatibi=
lity
>> > >> kobject.
>> > >>
>> > >> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> > >
>> > > Thanks for your patch, which is now commit 699041135f75b13a
>> > > ("platform profile: Extract the core from ACPI") in pm/linux-next/
>> > >
>> > >> --- a/drivers/platform/Kconfig
>> > >> +++ b/drivers/platform/Kconfig
>> > >> @@ -1,4 +1,20 @@
>> > >>   # SPDX-License-Identifier: GPL-2.0-only
>> > >> +config PLATFORM_PROFILE
>> > >> +       tristate "Platform profile support"
>> > >
>> > > I guess this can be invisible (perhaps "... if COMPILE_TEST"?), as
>> > > you have updated all provider selectors?
>> > >
>> > > If not, I guess this needs a "depend on X86 || COMPILE_TEST", so peo=
ple
>> > > configuring kernels for different architectures do not see this opti=
on?
>> >
>> > The goal of this series is to make the platform profile firmware
>> > agnostic so it is available for all architectures
>>
>> Sure... Are there any users of it on these architectures?
>
>
> ARM64 is about to (patches are cooked)

Geert has a point though.  There are arches that don't need to see this at =
all.

You can add ARM64 to the list while adding support for this to it.

> Others IDK

Well, exactly.
