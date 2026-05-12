Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2068395AD9
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581510; cv=none; b=TiHWAvZNkJ8up+E4GWHH+HD509kX//EyvwPyAumiklMdDncecFAQj+85YDZjztMmmdgZ1reTg+cyBVcovCH7MRBJc9e54gsQ1nv1S0Ov58Io4ejPHeaQqlZ5p7YlXiV/BwSL8/D+oTVUAhuqaStGej7L3vyFDsPODHJF1QnCuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581510; c=relaxed/simple;
	bh=32LPTv9sn4Ul6hLhrEXtWArmabeJg95nIbsw4ehfkbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjm45uxJh++gczu79uU3a78KA4nT5wFIEzAovwod5Tu+kKhrQoPNO0CqzEOYl/FKJHRMviF75+GPYHMY3e7sK2xu+yiayZqfIKVWeK2FGT7nqdvHrx4JBWaTS90qtJXhxpuCZvs11hOhmxhGhakbv1k/BuJzJIiQgJyp9mMOzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6RgRwLR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6RgRwLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5597C2BCFD
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778581509;
	bh=32LPTv9sn4Ul6hLhrEXtWArmabeJg95nIbsw4ehfkbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q6RgRwLRLviilcsH6KV+KIeLg783ae6fd/sjrlHmeXlNpGTw//JI25W4S+WFQ4Q2g
	 PLUj6thvtEyaWvkRqYJ6mo7q0CI5PNSh85KvvCxco3fChi2iOFuWYVKnZL19YS1n9J
	 mfRDRDjVwK7ou9Im7/7St4Bc8ZhhSsRfjcm45C9VugYtr1oC8RlN9Sv1/39H2fzvIa
	 z4lW41F2idlZ0UApBUg5V0FSMwQlEDjWutSShLic0E+MQ6Hm+nI7NMDj1pjCYVaaBk
	 9DvCe9BzOPSOXNF/9dwFNKUntTrGYpV+UCBQrvUAq99TEufGZ3V/yXKzj33Q5wubz2
	 PN7r/oBm63yyA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8891febd2so6323519e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 03:25:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ81bPwN9BVT5CnGbLvpSKbYXuWPgHPVwPmeoCyiv7iQ7evXIAgb+mDbHkD3OgsJZx4JrZy2Lm278sCM@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvwOt7PgeydNGaaxMCf3TOfou2N0dZJuo3hlmsnRmwk1JVJRy
	HztwIQJhjpeqF8RkSuZXjeS3E6xiiGhTUOzFhG5t7xe2Pv5kHNYYgmgig3E7QmwNqIRLspSEre3
	fvbRGUDk8VV3SZ2ZXq++20+3Ae9IbUOY=
X-Received: by 2002:a05:6512:114b:b0:5a8:6c7b:f9d7 with SMTP id
 2adb3069b0e04-5a8e31f5ff3mr782938e87.41.1778581508146; Tue, 12 May 2026
 03:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4731840.LvFx2qVVIh@rafael.j.wysocki> <a944a591-409d-6a73-3c6f-5c29bb2583f9@linux.intel.com>
In-Reply-To: <a944a591-409d-6a73-3c6f-5c29bb2583f9@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 May 2026 12:24:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gnTenRLB1LtiHx9Vs0TB6+wjWUrjCTAqdZwDZcOL91TA@mail.gmail.com>
X-Gm-Features: AVHnY4IZdS0_f1nXUVzxHo99Ohu_qYwl3sye0ITAdGf2oTXEPo4yyiwaloVrK8U
Message-ID: <CAJZ5v0gnTenRLB1LtiHx9Vs0TB6+wjWUrjCTAqdZwDZcOL91TA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: Add ACPI_COMPANION() checks against NULL
 to probe
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	Andrea Ho <Andrea.Ho@advantech.com.tw>, Eric Piel <eric.piel@tremplin-utc.net>, 
	Alex Hung <alexhung@gmail.com>, Shravan Sudhakar <s.shravan@intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:56=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 11 May 2026, Rafael J. Wysocki wrote:
>
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Every platform driver can be forced to match a device that doesn't matc=
h
> > its list of device IDs because of device_match_driver_override(), so
> > platform drivers that rely on the existence of a device's ACPI companio=
n
> > object need to verify its presence.
> >
> > Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> > against NULL to multiple platform/x86 drivers where they are missing.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Don't these fixes need fixes tags?

Ideally.

> So this part has the changes that are needed pre-7.1?
> And the other is for changes going into 7.1?

That was the idea, but since you want them to be split per driver, I'm
going to send two patch series.
