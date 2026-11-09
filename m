Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253078;
	b=shym8lRs+LeOr2NQuODms+2XzLfuKmbw9/KcB6b69sWDwvsmb+UvajQdwXbSi8/Tv+R3
	 sEijfXZ6pqFOkf9PQoikDZv4EXp3NghImvk/UlnHtyvWnHDW64knu2rHLFsOCKJeGCcC7
	 b/azewgiHnZxXHxjJHdecbwAYhOZkpovJegJ6VHL/yoxWLVT8XAubHe44n7WI+YNIx7Qz
	 bTs4RmRsNQxqPP2o0YM3RYB6m4hRqCZT827oG6Heq6WLdE0wAognyDnEgUCsIXP8aDjzz
	 55pNhAcksb/wGI7gVeZiIySVs89ruqSUueJBNd+FMvt6sJUvtKMIImIBi+EM0BMRYDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253078;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MvWd0+CmwRokWvhLXpRIo+Vb+Gi+G9Ir/IiNgUEH2gU=;
	b=Ax1GMhh8HVsMkagTAYE5XCMEJ9V6OIx82kCEsJN3LpZsqcoqKdkwtFcSgoSS2g8Ve4hg
	 3r3eTiSdkn09a9V/bEIf/mIGraLwp4ll7aIa7ngE2o9j71oa1ldANyTrxPIiILYiJ+OPo
	 n3Zfbgn71zKHtWYe0y/NJkkNm7CIti+HqbZK+YARNt2qCgnsennfwapBgkv3ybwHmC3ao
	 XG2tLfOozsmwc+aIjvmTmhjPrqPfpQmW94HZX2Qv+8FvdzAgZkxJgMLuVE5akRXj87pXD
	 L4Mp8Le6puUB1RgdhlXP1knpvEGM6VrRkG2Rcqo8/g4fGtJxbhRPmg7vN7mLAf/t3Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cb2LBgsg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA954606A32A
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cb2LBgsg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE261F008BE
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253077;
	bh=MvWd0+CmwRokWvhLXpRIo+Vb+Gi+G9Ir/IiNgUEH2gU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cb2LBgsg4n4sruyHj68RZq3ccVRcm5UuufSQqvsWoLVd3qVz8XzzsQWfgHw5tSGEg
	 pnbDt8jyDOtgQcuDXSppvRmXz6+GdHI65SpERZ6/usCv7vacjt+EkL7n3Ls6Ikr0Lo
	 Nlo01B8n9LjysiLed3s1rkW2YkDAiWoaNySqdsE53+WMqHUz4wivQxAjQHlvXi6R2u
	 y0gJYq7BWHrhIwqDkqY+K3UDmnnyWx7Rl8IWwLXoQGrceK7lrqRXnvi87XeYvNXj4a
	 dbaF1Ssx63xVGaryj9W1GN2E8iRypW66ZKa/ZoEAIXSk+Wk3kBXBewt9AduCWz5aks
	 kJpdbRUxxdgTg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3adf87fc0c6so8789861fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 11:37:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEbZtIvOgVsI+85TcPnLUy22DrEV6LU82JSHDPbbjQvSufcX6wJaO8mAGZ6GY4HIJiTL4kYRQBvpkxf@vger.kernel.org
X-Gm-Message-State: APuU4Z8+6guao89IO3I7TsPkuCdvSqhbP/N2r2U5EQwsG+2DLPMq4ptu
	lXYERW9Q9Jgk4jr6qGPMyshtBQRZy0vzDwMBPNlGWpufwoiks7dt6FyC4B8AdDdqRB9NBA6QRs/
	JlJUZdCKQ995AMQIN7FDwpY6fxcMqi20=
X-Received: by 2002:a05:651c:41c7:b0:3ad:de02:e9a6 with SMTP id
 38308e7fff4ca-3ae09623c97mr429461fa.16.1794253075553; Mon, 09 Nov 2026
 11:37:55 -0800 (PST)
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
 <ed4aac63-ac58-4e2a-ae45-ebf4da158228@oss.qualcomm.com> <CAJZ5v0gGeKEqMWvP3cQrXztZt-faFZJF+yNfygcBPT57f-a8Lw@mail.gmail.com>
 <34c23beb-88d5-4456-b84f-f00e31578468@kernel.org>
In-Reply-To: <34c23beb-88d5-4456-b84f-f00e31578468@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 20:37:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0haqd=UiGJq307O48NV=Ha2xHZiFQduHYaAPOf=2KA9=g@mail.gmail.com>
X-Gm-Features: AclHuK-vX_OAFSpUyezAsyhyijSyOhOZPP76kuRi9FiBvZGn9m4D3huc1FthJj8
Message-ID: <CAJZ5v0haqd=UiGJq307O48NV=Ha2xHZiFQduHYaAPOf=2KA9=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Make platform profiles firmware independent
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Wu <jackbb_wu@compal.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 6:39=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 11/9/26 10:46, Rafael J. Wysocki (Intel) wrote:
> > On Mon, Nov 9, 2026 at 5:37=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >>
> >>
> >> Hi,
> >>
> >> sashiko validated this series
> >>
> >> Is there any other comments for these changes I should take care of ?
> >
> > I'd love to see some feedback from someone having a vested interest in
> > this interface.  Mario?  Mark?
> >
> I am onboard with the new approach.
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

All right then, applied as 7.5 material, thanks!
