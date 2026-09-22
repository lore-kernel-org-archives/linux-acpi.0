Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA353D0A4
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078972; cv=none; b=a6F0N/zaPBod6bFBp7Pq7SS8R5SPTxuFCXJ+Vw5sn+fbdhvW1+uY4xkOwQ2cA6YBbcIay4ZZFAJbgKx1nf9v+oel7lYUG8FYOc97rKTOelSeTlTm2XFc+1tcaTzrGkFMZCcCs35sV4Zk++LtiECvyetX46yLT3rjHLqH3V2nuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078972; c=relaxed/simple;
	bh=gqKwaL+/AcGiqt0SEqNOonv02Mge4jL0jxPzbOQ6yJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJCFQ/A1x3tMvtzluzkSlCSYZD+rinWFeoyVtXnRD+idTlLai5ECbtZeIKy+qh3Q9uVLPED12iyzuvN4NFhp3Iauortz/ivxkccW7oIIMj9FURJRcyaSlE2vksk0L5ywlR8bDMk/3XxK1MoclRjI7Ri7xYv7u6EgRFjbWp6NlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUd7oCph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUd7oCph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606B71F00899
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078970;
	bh=gqKwaL+/AcGiqt0SEqNOonv02Mge4jL0jxPzbOQ6yJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aUd7oCph+9i8ACVufMzt89mdZPx3sPvEVZR1YbHK1v/rQDJfyT1G/JEF1Xpkuihv6
	 WejvVmeXEKX00xGTJQMuntZc/bsNTfVVb9jobxmwY3wgnbIYG87xwiVIy1IvK+cgDU
	 9SoDO66pTcRjDGUzDMikTtWnFnYIni+wGpwEWDJI08ta0E5UoPUaaNSaQeYAZV6ojF
	 zuPmle+uEOaiTNpUVUzUSY9qlKLt4xE9A/2U0bPo9XSZLZFo2DQdjGB5Npkjtk8qDE
	 CZbtp4mng1tU35xNVlqSSyxh5d/T0tlohMtvKJ+KNhgKspQ0JitAYo0HiclGZ2u9Wd
	 /Q4Sgm/4/X1Kw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1b845so3334025e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 05:09:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFt6QcPwMuViUk2eaemXdcXLMWLlotkskr0Ihv2bygFEkxauyWG88+uwglYuDfMvJMWymhO9yaX3Cn@vger.kernel.org
X-Gm-Message-State: AFuF++kqESCxB5FjgWjdEzr1i4PQzrEeXsf/FWbPqaTreKmdpVh8Hw8+
	q0AWPi7J1ML3AnYyZdCcmiYU4ZGpKnDkmExueTcIf7SOInGwjvbTmpBf9pSkfc1AS6hZWidPDYu
	CBr3k6K6fXPprpJzMNFOIc4oPWaTYzKs=
X-Received: by 2002:a05:6512:3f26:b0:5b0:129c:ed85 with SMTP id
 2adb3069b0e04-5b8c1833735mr4656415e87.1.1790078968689; Tue, 22 Sep 2026
 05:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501165542.GA491695@bhelgaas> <561131dd-0e42-437a-9724-a036238a9bb4@gmx.net>
 <5f716613-d996-46db-96ec-6c0251219922@gmx.net> <449c834d-d115-4242-aa5a-43daa085f178@leemhuis.info>
 <81ac70ae-c51e-4960-8dd3-bed47ceafafb@gmx.net> <012b3ebc-62f0-402e-afa9-02712e67e72a@leemhuis.info>
 <86030fc1-473b-4695-a2f3-c30b5f19614c@gmx.net>
In-Reply-To: <86030fc1-473b-4695-a2f3-c30b5f19614c@gmx.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 14:07:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iw9Jrdv2MaCu5Dou3Ust5L-YsEMWDpZPP58-ag_pbZSg@mail.gmail.com>
X-Gm-Features: AcwNN1UGH85E-0STnNRfBuN9iOHz5RK2V5gbiUx9oFANBoJIrdCdCHY4pgwi5FY
Message-ID: <CAJZ5v0iw9Jrdv2MaCu5Dou3Ust5L-YsEMWDpZPP58-ag_pbZSg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add quirk for Acer Swift 3 SF314-56G (MX250)
To: lxuser <dittrich.m@gmx.net>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 8:49=E2=80=AFAM lxuser <dittrich.m@gmx.net> wrote:
>
> Dear Rafael,
>
> the Acer Swift 3 SF314-56G with NVIDIA GeForce MX250 (bios V1.14)
> suffers from an ACPI power resource regression where the power resource
> controlling the dGPU is incorrectly marked as unused and turned off
> during initialization.
> This causes the GPU to enter D3cold state, making it inaccessible to the
> NVIDIA driver.
>
> The symptom was:
> nvidia 0000:02:00.0: Unable to change power state from D3cold to D0,
> device inaccessible
>
> This commit adds a DMI quirk to prevent the power resource from being
> turned off, similar to the existing Thunderobot ZERO quirk (cd7ef20ba8c6e=
9).

I would have applied your patch, but I need the same information in
the Signed-off-by tag and the email From: header (preferably, your
full name followed by the email address).

Thanks!
