Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64830357CEC
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966329; cv=none; b=jJgAcP95RoXMm5GRsEVHIq5Kmj3guh54EzUWHEfmxB4PKHIK8FbvV4160QW3ASoMvfkzMJuqvKWys71raU1q9DNFZ2xAEM4oir/laHfz1qfbHF1LKQa+KMJoU/B7bnb/LBWq51T9SeOQtXzf2t9fzo5ebCgTDXueraBtIigNOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966329; c=relaxed/simple;
	bh=ym6aC+Uv17jnJSfWSxwkJOrckCGteSJ0OGz6xOhRoag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTnM+AATiBaJYTxRZubvqrDNSj6vtRs6MoH7Ci2u2zpdG4OdI+BlLvaSGHorWTiRGQnYIlrUTgBvz6IDYNhoHjeP8DRrcQ91htSU54YlSTN6aIIECzzY+rE5b0BNy1L5G9QRgTQn36Mf4oo/EXeOAHSGCWxK1ai/uvWzgLLoE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH0nJGja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH0nJGja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D261F000E9
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 21:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966328;
	bh=HHby+6xoF8bayEA6nLXmPYZgbuy5cKfxuxsck6XPhgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nH0nJGjaADEzuynxupYmKSV8CKg/GRZt/jFaA2O8SMm0Fkt+uMDshE2rM4M9dBGhi
	 kzGnMti8gSNUfPm2kHDDIR59omPZ5D18aGjagjuiMcaVe6P19uEF+zh0CgmLJ1Hdzv
	 SDYY3VOuAw3u8nTsdgZkiKt6pnG2x/QtNAOdPba7K9G5Ugeyx1vV19/MYs5ED7qgeB
	 96si93kDAKf0UmIBa0X9zEz8Z0IJ3AomO0tPl/L8ZyzEddiueex6+jSufYgwaU0Mvw
	 z+eFqSdTDXL0FYb6MTGRaEp1M2yTWMP6ZAuMnQhOV5PhLEadXSfdCCpFWKhzN4fhaZ
	 UeVC8pyc9MarQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aebd52488cso1754362e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Aug 2026 14:45:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpHxAXUji9l3M1QD2J0T54oOu1cSF0G7hu6eKhGQMX91vc0Zx9YHDCNreIN86fyNvex2PwXMRN8baMu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsq1vIR7aZBX8b7QC5KvKXKvlrYeKRBd3552x4wtGtSbtMvX/h
	Gddaqp3WAs6B0YzyyWpKvzIT7Q2TuScPE2fRV7y9lc7+rRXUYllZSQV6fTDlqli7h0xWWN8PA/Q
	AkXEZsyxujZYNyk/a+31Qq7Qie7EebtY=
X-Received: by 2002:a05:6512:1386:b0:5b0:1bf6:f48f with SMTP id
 2adb3069b0e04-5b2f4cc6f97mr1367700e87.48.1785966326416; Wed, 05 Aug 2026
 14:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718-b4-acpi-battery-notification-v4-0-599c8ed1072f@rong.moe>
 <20260718-b4-acpi-battery-notification-v4-3-599c8ed1072f@rong.moe>
 <CAJZ5v0ijiG23QWjG9C9OfZSB5jxFTg42OwYRS6KVc=Voi2s42w@mail.gmail.com> <9055f4665dfb170f7053f785c76e46dfe364fd87.camel@rong.moe>
In-Reply-To: <9055f4665dfb170f7053f785c76e46dfe364fd87.camel@rong.moe>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 23:45:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iR56bDhRMyika91OVQE1CMbebJK4fL4ZoBTRdM12F+Cg@mail.gmail.com>
X-Gm-Features: AUfX_mzs0vrGfJgWrtdxk7Ana3nHzgt7Eve-h8v-oas_lnatXP4z7Vceb8L2_Qo
Message-ID: <CAJZ5v0iR56bDhRMyika91OVQE1CMbebJK4fL4ZoBTRdM12F+Cg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ACPI: battery: Protect all properties with a
 separated mutex
To: Rong Zhang <i@rong.moe>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Avraham Hollander <anhollander516@gmail.com>, 
	=?UTF-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
	Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 22, 2026 at 8:25=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> Hi Rafael,
>
> On Tue, 2026-07-21 at 22:54 +0200, Rafael J. Wysocki (Intel) wrote:
> > On Sat, Jul 18, 2026 at 1:11=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
> > >
> > > The acpi_battery_get_property() callback calls acpi_battery_get_state=
()
> > > without any lock held, which could lead to race conditions, e.g., whe=
n
> > > multiple tasks read power supply properties simultaneously, or when
> > > other callbacks are called during its execution.
> > >
> > > Moreover, some devices' _BST method relies on a heavily shared ACPI
> > > mutex which protects EC accesses, so it cannot tolerate too much
> > > pressure or else other methods will time out. The lack of
> > > synchronization sometimes nullifies the cache mechanism of
> > > acpi_battery_get_state() when multiple processes read power supply
> > > properties simultaneously, which usually happens after a uevent.
> > > Normally, emitting a uevent implies that the cache must have been
> > > refreshed due to power_supply_uevent() reading all properties, so the
> > > mentioned processes should have seen cache hits. Unfortunately, these
> > > fragile devices' power_supply_ext properties are somehow slow to read
> > > after battery events, resulting in cache expiration before
> > > power_supply_uevent() finishes. Hence, once the uevent reaches
> > > userspace, the _BST method will be executed multiple times within a
> > > short period due to userspace processes reading all properties again.
> > > The coincidence causes lock starvation, resulting in a catastrophic
> > > situation that a lot of ACPI methods fail to acquire the shared ACPI
> > > mutex due to timeout and return garbage data thanks to the firmware's
> > > poorly designed error paths.
> > >
> > > The said "other synchronized methods" are protected by update_lock,
> > > leaving acpi_battery_get_property() to be the last desynchronized cod=
e
> > > path. Unfortunately, update_lock is not applicapable for
> > > acpi_battery_get_property(), as it protects too many fields, far more
> > > than necessary. What's worse, some code path could call or wait for
> > > acpi_battery_get_property() while an outer functions holding
> > > update_lock.
> > >
> > > Therefore, introduce a mutex to protect all accesses to battery
> > > properties, so that acpi_battery_get_property() can take the advantag=
e
> > > of the mutex and synchronize itself. The helper function
> > > acpi_battery_handle_discharging() for quirky devices has to be inline=
d
> > > due to the change, as the mutex must be unlocked before calling the
> > > expensive power_supply_is_system_supplied() helper function.
> > >
> > > Tested-by: Avraham Hollander <anhollander516@gmail.com>
> > > Reported-by: Rick <rickk1166@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> > > Signed-off-by: Rong Zhang <i@rong.moe>
> >
> > I have queued up the other 2 patches in the series for 7.3,
> >
>
> Thanks a lot ;-)
>
> > but this
> > one is not quite ready IMV.
> >
> > In the first place, it is not quite clear from the changelog what
> > exactly the role of the new mutex is.
>
> It aims to eliminate lock-free access to battery properties. Especially,
> synchronize the fragile update_time-based cache.
>
> I agreed that the changelog is somehow hard to read. I was struggling to
> summarize the debugging findings, and it turned out to be too
> complicated. I will explain them below.
>
> >
> > If there are any real race conditions it prevents from occurring, it
> > would be good to give examples.
>
> This pattern can be reliably reproduced on Rick's device. I had a
> detailed analysis to the sysrq stacktraces on his device, see
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221065#c85

So please add a Link: tag pointing to this.

> >
> > Moreover, the exact mechanism of the _BST synchronization failure is
> > unclear to me because in Linux all AML evaluation is synchronized by
> > the namespace and interpreter mutexes.
> >
>
> Well, _BST itself has no synchronization failure. It's always evaluated
> serialized. However, the frequency of its evaluation matters on buggy
> devices.

Yes, it does, because it isn't really serialized.

Please see the changelog of this patch:

https://lore.kernel.org/linux-acpi/12951141.O9o76ZdvQC@rafael.j.wysocki/

and the documentation comment of acpi_ex_exit_interpreter().  ACPICA
drops the namespace and interpreter locks when AML is acquiring a
mutex, so effectively you can get two (or more) _BST evaluations
running at the same time and all of them except for one will be
blocking on the AML mutex.  Moreover, this appears to somehow confuse
the interpreter and it attempts to release the AML mutex in a thread
that hasn't acquired it (see the debug info in this message:
https://lore.kernel.org/linux-acpi/CAP1mzZReJCn6df5DwEPu-JCQUyr=3DPu1cg5xKC=
MttWZkHCQtVmQ@mail.gmail.com/).

So obviously the frequency of _BST evaluation matters and the devices
in question may not in fact be buggy.

> > If that is not sufficient, it
> > would be good to explain why because as it stands, it is not clear
> > whether or not the approach used in this patch is adequate.
>
> The issue is about the synchronization failure of battery->update_time
> due to acpi_battery_get_property() calling acpi_battery_get_state()
> without any mutex held, which results in _BST being evaluated too
> frequently.
>
> The _BST method on buggy devices acquires an ACPI mutex called ECMT. As
> the name suggests, the mutex protects all sorts of EC stuff. The mutex
> is heavily used, but very fragile. It is prone to some sorts of lock
> starvation (or deadlock? I am unsure as I don't have a buggy device)
> once its acquired too frequently. Lock starvation causes mutex
> acquisition timeout in other methods, which is handled by the firmware
> poorly, and thus leads to catastrophic results.
>
> Once battery->update_time has expired, multiple get_property() requests
> originated from userspace will all have to try to evaluate the _BST
> method. The evaluation is indeed serialized, but still causing to much
> pressure on the mutex.
>
> The patch fixes the synchronization failure of the unfortunate
> combination of battery->update_time and acpi_battery_get_property(), and
> thus always ensures the 1000ms gap (i.e., cache_time).
>
>
> BTW, even not thinking about the buggy device, the race condition of
> property access still exists. Consider:
>
>                 CPU0                            CPU1
> acpi_battery_get_property()
>   acpi_battery_get_state()
>     [update_time expired]
>     extract_package()                   acpi_battery_get_property()
>     battery->update_time =3D jiffies        acpi_battery_get_state()
>                                             [up to date]
>                                           [read capacity_now]
>                                         return
>     [fix capacity_now due to quirk]
>     ...
>
> where CPU1 reads raw capacity_now before CPU0 fixes it to a meaningful
> value.
>
> Does my explanation make sense to you? If so, I will refine the
> changelog and resubmit the patch.

Yes, please.
