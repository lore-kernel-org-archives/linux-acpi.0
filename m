Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8C55C1B7
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992440; cv=none; b=aTqCrszJcrxHadQqLWOJqFblfhqJBCcCnchu7lHb8pA/NbMKB3zn2E3T8/6AlHUiCo+g9f8aQwajO1K+AypXaS1xjVXEFiRet7OdGR29P7/8b4MYVuY42mOUxDqK0Wmbd37/vgDy52/cTqn2z8RK9me+VYK7DDU3HImeMtxk1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992440; c=relaxed/simple;
	bh=ZiAPS13SBViJAeGyjA9BX7XuQ8gbRdx6U669BmENfBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvNlyjwOeB4H25Rm5mk5u33RF9cELN8ruGjOZoVLtqPLeHCxE5f1UmkMhubpglxmPoyzLUjhtrQzCVCtGwcV/s7tbFvNT7in6CDxLHY8QNlOGvwKAKZp22rAHDcG2HAkbPIXS+jVodjtDqQAxBt5ezBm8ixL80UHU0sQy6pWPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4QGpUVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4QGpUVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AAB1F000D0
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791992436;
	bh=OoiplF2AF1BX9cQRvAuQTa3Gh84ToZoBDZYkpiO4u6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N4QGpUVY7JlCMsbdfS2MvPexL/n56AMj/1mnUspFfFODeQqNLQMN2UMFbmf+pVf+n
	 6Zkz3pvH+GOSptbajKkVtglCaOb8Hu/8apexGCk1EllDt1BGw9Qn5f7nggcHbQtofI
	 54L5Ru9NmLhmFJAci98fmuR5bT6Wuzb6QbCSvp5fCNmShIVL+i7lz24WdeVJslKXr3
	 vBSF6ewDKeiA4QjPqttCZNlaZrp3Zy1Pvj6ceVUzdDW0G7/IDowpp2/UDaqQ8cperz
	 wY9xQfKGMr5MNigvu35y/U5vFvP6EMe0EI7+AA1tn9bFLTZuaz3Hch8DjfyX8ZV6Si
	 cwXBrxEL9N4mw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso572256e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 08:40:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz1OLugdT9VUSuwhQ2wSTLsVqkGoypPjpu/T1ndgu3zsoau4JzJtVprP2HH7OnRwMjmeBicRj1bQSzi@vger.kernel.org
X-Gm-Message-State: AFq9FYKFnwKmQ8s+p1kaDj1bJMLdgLLLc26+QFwMTh9z6INwokKS1xae
	S6D8rJ3adXIeIu+tXFsK7tU3KmU7JQkp014NDKQ+Svkxuh9/iwwnFv7vYdIa8kUsQx3EXOCndzZ
	3q2r9HZCevcTyp1jSqpxsgGjBGbaWeQY=
X-Received: by 2002:a05:6512:1255:b0:5b8:f52b:8135 with SMTP id
 2adb3069b0e04-5bcde6bf6b1mr5978934e87.17.1791992434324; Wed, 14 Oct 2026
 08:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014132703.93355-1-aliamemis@disroot.org> <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
 <20261014150537.121547-1-aliamemis@disroot.org> <8be1a245-6061-4f86-9223-0da18d5e423a@oss.qualcomm.com>
In-Reply-To: <8be1a245-6061-4f86-9223-0da18d5e423a@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 17:38:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVszW7+hb6OT_ffBhpV4bz6jpNn93rYq+EkT5qYypxFQ@mail.gmail.com>
X-Gm-Features: AclHuK9RzTMB30DOSPm5PKW2yUA0YUKVt7Xq-VwNIHUydXb0MjJaUSsggHSRKGc
Message-ID: <CAJZ5v0hVszW7+hb6OT_ffBhpV4bz6jpNn93rYq+EkT5qYypxFQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>, 
	Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:30=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 14-Oct-26 17:05, Ali Ahmet Memi=C5=9F wrote:
> > On Wed, Oct 14, 2026 at 03:45:10PM +0200, Hans de Goede wrote:
> >> Hmm, I wonder if we should export the lock added in patch 1/3 and
> >> then also take that in the ACPI EC interrupt handler ?
> >>
> >> The ACPI code already uses a threaded IRQ handler for both EC GPIO
> >> IRQs and GPEs so sleeping in the handler should be ok.
> >
> > Sleeping is fine, but the interrupt handler completes the EC
> > transactions, so taking the lock there would deadlock an exclusive
> > _BST.  Doing it in acpi_ec_event_processor() where the _Qxx methods
> > are evaluated, works though.
>
> Ack, doing it there sounds good to me.

+1

> > With the brightness key queries also
> > running the \GTST copy, 283 of 891 _BST reads were broken without it
> > and 0 of 804 with it.
>
> Nice :)
> >> I'm just thinking that if we're going to do this it would be nice to
> >> cover the bko221065 UCSI case too.
> >
> > UCSI and _Qxx alone aren't enough there.  I emulated the ECMT users
> > from the 83DR tables and the EC helpers kept waiting up to ~680 ms of
> > their 1 s timeout behind GBMD/SBMC until the ideapad methods were
> > exclusive too.
> >
> >> Note this is something which can be done on top of this set.
> >
> > I can send a series on top of this one for the EC queries, UCSI and
> > ideapad if that sounds good.
>
> That sounds great, thank you so much for looking into this.

+1

> We should probably ask the reporters of bko221065 to test
> the 2 series combined and see if this finally closes that issue
> for real.

Yes, this sounds like a good idea.
