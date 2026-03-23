Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16388383C75
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258034; cv=none; b=YEpzz1mmt4UcML3Im3J22MFeU8WE1EGm2xG//fz43y/ANQogI52XzKaxWbSn4Y3e6at8oT6/SkX3QFeOCtICpeiVTbhauuj9a7Nhx0ijLPnoOxlGmlQKSh6UiN+shTch8ywhnwe/CzZVT2j4EZSE8tbgPyva45VbjspuGszgAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258034; c=relaxed/simple;
	bh=gEYE2ezf328sEv7vAmhO9x5MtCQ55LgUj3CyOcK+6/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btXxMbu/sOhYVg1hzpkHuGXYBcngp3dIBDSV1h3EDRnT22jvUedb/UCQ0I9QpndXuGpo+UJtUTqY131XukX/WVbTJrajGVAr89uXXKCfWxq93+fsUbtkTZLgaftd1OVw/MJS7UnDhY4MoWkdr0W/LZ+TJTbyQO+/Y3s+LGXbXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=LbtlCFEV; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="LbtlCFEV"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id F1A69C3ECE
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 11:27:03 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 0FCD6C3EA5
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 11:27:03 +0200 (EET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id B3C7A1FED50
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 11:27:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1774258022;
	bh=/vqILUWkNjA8OsHtuubF2QiUIKhCr6jOU46el5rWIxo=;
	h=Received:From:Subject:To;
	b=LbtlCFEVhvY5zJiCdYWdUXRsO/eps1VtRO+XzREF4kB0UEU5jch7ygMII1gAw0ziq
	 AZjiuQmGnh1Anc1VqaemoTgnBInb3ENUrFwa/fX/cTQxl9y6Ukv5eZYh2+YDiDsW8A
	 5tigzt/IXafyu9qPdV3IsSTwFGWvXldeCIrMMfrO892xhzyuAZkl2yV5KVR8wwCKPW
	 TuZjacKQBsu7cSd8vI9xCRzUHTEEOrYL2dgey3su3liPCEZnz61FD5cSw4/OAwG8ki
	 rlsedxaPuZnSPUltYDUQP8iFFv+Z6zszm8pTQXqzA5manZU/nc0f/s8kH6BOhgZ5Eq
	 MRNvFpex/F6rg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f171.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-82a62714fe6so1889514b3a.0
        for <linux-acpi@vger.kernel.org>;
 Mon, 23 Mar 2026 02:27:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVg+cw6yA0TPcoxGfZHZFr1Ce7xySp9V7NiLI09IjSSwsH82hPoTrpiUUJ0XZBoNLWCpH28YlY0QFH7@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmv+X8LT9CnSuq81CNYC8W6x5+F7YshM4zzSMjkbWs1n/yEWg
	yVPc80C1OHBxoSA8hhlMdnOmfJ5R7WTF3lNpLWPfx5vqDyeeduEapbZ65hqJWfwpsoZLQm/2ReQ
	jyrYby+fSJJSea5VncPUHAEZ/lqRTS+Q=
X-Received: by 2002:a05:6a00:2394:b0:81f:4e1c:1d3b with SMTP id
 d2e1a72fcca58-82a8c3a65b6mr9208075b3a.23.1774258019965; Mon, 23 Mar 2026
 02:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAJZ5v0iG-SPmqMYJExeOUGo301tL=+qyi2479QkXoR5Dq0d9bA@mail.gmail.com>
 <CAGwozwGEgLpjFTCF4kinR9+-_Wt=bYw19dcbVOswYe998z8Ykw@mail.gmail.com>
 <030c38aa-353e-4387-a006-42e641b3ac6a@collabora.com>
 <CAJZ5v0jbDqs=adBX-o-MDyNX+=Q6UAkw1=gh2y_9cAMMi+gi_g@mail.gmail.com>
 <35f773ff-6514-413c-988b-765bf2d0d293@amd.com>
 <CAGwozwGpzzBC6Zh9NTskqZ1V1Sth3fHKVr3LALpRkrpaWcorjg@mail.gmail.com>
 <4526e323-0c33-4e38-a46a-78ccd9548fa2@kernel.org>
 <CAGwozwFN4wED6TgJgrKAtNFxY4TCJgnUVOcmb39Bchj8gGXvZg@mail.gmail.com>
 <CAGwozwHPizKuAvN+dxHYPt45OTKKgfCg62a9gv+Cn_EpAtgfgw@mail.gmail.com>
 <1884bb9d-2720-4cde-8a8e-35a9c0c4769c@kernel.org>
 <CAGwozwE=2zdxSA39K2qD0p3_rbhpoMiHD7YbJYBBWC93m+0GZg@mail.gmail.com>
 <c3ea88d3-a855-4ddb-af09-e6fd6e279ec2@kernel.org>
In-Reply-To: <c3ea88d3-a855-4ddb-af09-e6fd6e279ec2@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Mar 2026 10:26:48 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE1XcguHw016kd9xb05Dz0fpyRwPDT=hA7pj2D=WBkJLA@mail.gmail.com>
X-Gm-Features: AaiRm525FBUGZXGGuOjIOisJfAnm28WFo17YFpfEyomQB24Rgp4UqjZC5yyYdDM
Message-ID: 
 <CAGwozwE1XcguHw016kd9xb05Dz0fpyRwPDT=hA7pj2D=WBkJLA@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
	richard@hughsie.com, sebastian.reichel@collabora.com,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177425802229.3276996.10222206085054559698@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 23 Mar 2026 at 05:36, Mario Limonciello <superm1@kernel.org> wrote:
>
> > I wouldn't call platform_profile ACPI either, but it just kind of
> > ended up there.
>
> Exactly, it's not the best place for it, but now it's ABI.
>
> > Where would be a better position for it?
>
> I would say it depends upon how generic it ends up being.  Maybe
> /sys/kernel if it is very generic.  Maybe /sys/power if it's more narrow
> and only going to be for affecting power related things.

When it comes to sysfs, I think that that is clear, as
platform_profiles does not include acpi in its name anymore either.

/sys/class/activity_hint/s2idle/{choices,hint}

Here, I'd prefer hardcoding the name for non-WMI drivers instead of
using a dummy integer such as platform-profile-N to make userspace
implementations easier. For, wmi, <driver_name>-N would be used
instead, mirroring the driver's instantiation name. /name would
provide the definite name in this approach.

The aggregate is a legacy interface, we need not implement it and
defer for later. For an aggregate, perhaps the acpi sysfs is still
more appropriate due to legacy.

The unanswered question remains where in the kernel tree to place it
though. platform_profile nests under drivers/acpi and
firmware_attributes under drivers/platform/x86

Antheas

>
>

