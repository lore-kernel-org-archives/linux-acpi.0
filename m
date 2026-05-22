Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8E374E4E
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452730; cv=none; b=lTuKF9/4BaONeUCemw1sYx5NSJ+8IF/bH5tgip9e0/T7SlkGwBuDVM+FdqtxKjGQM4V4L2cnekyygG7NKalqZPCTQ14MAeajzLqsbIqLIcVdet8UG78/XzconE6VDxHIt2bcvvc1f9hjw82fKTi85//G7AHn/Az6MM233D2NTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452730; c=relaxed/simple;
	bh=oAj+E/ZaRtkCNPAFHrQ+iNBaf2fXGnumAcRPeh8rJe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKdeUWN8gTTYfiDQ4AQS6EAxg8tbk1VvCVjk0GF7A3Xgp9ynlg/rC4TA+17Qubdy58QDGIUdub42jFwkwGJQdHLkGDRlikIHgnPlGVEj5FE/MGhgv7AvrW5VK6NyFR2K49dQjHcu5LQXT9/S0saLouFvQkDnus3ax+w2kKYHWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iynBxoIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iynBxoIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10E71F00A3E
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 12:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452728;
	bh=bDHw75jFFhfJ2OzplZAfScB3cpraHkSDbHD8uRXfMmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iynBxoIgegrV05C5kOuWpy8VlwSA8eYYZ9Lg8dlbHIGwNV54sX5kjliN0JGXmSU8y
	 +ufwE0cWqyM9atY1U1guhJXZNJNVazR99THNP828XMsknUQNRadDTa2FRVT9wwVH6d
	 +6yn3vZXe2L801gfEVw2BQrxEedDglhehPmwex582sjhHtvjj562N/HJIkZnlSflVK
	 MCyH8IrgKAzAUxgNp9D9hixPqxCjtpANWbhSRdqN8HlWlK1ZFGBJIxr5sF3Lum6e+C
	 I3KGUrpqS8NzzAE0z0lQTZ1DmCJwl0pzX6y644MoGL9P0Mb2pwoe3GqWj+kL4Rx+DH
	 ITXrBKep76Ysw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a746f9c092so10728351e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 05:25:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/k52fgEpo4imfl425V4FTcDeFciZcPYkxiwwHo3UHeU6k7sWOMUMRYa6ddeMw+JTAWaXbaSDmqm/Sp@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpkERZ6CrRtEvEwkIYePcMigp1zIJ2wwjOpmDU84QfCDjEXk4
	HqvjJ7alu4XHMgs0c4YzgV+KVd5allmix6fwMKoC7XauYTU7VG4W/hA7DQ+x+wGMMzpeXWcqPXg
	UiGyH/5ekTSBghU5dfxXblqjAGIRXtDU=
X-Received: by 2002:a05:6512:378e:20b0:5aa:e35:2270 with SMTP id
 2adb3069b0e04-5aa3222c876mr666958e87.0.1779452727347; Fri, 22 May 2026
 05:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5996185.DvuYhMxLoT@rafael.j.wysocki> <2265993.irdbgypaU6@rafael.j.wysocki>
 <Z01FFT.NPPC3AQH2RI22@kousu.ca>
In-Reply-To: <Z01FFT.NPPC3AQH2RI22@kousu.ca>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 14:25:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbVqppGJgz78XXZS6DdBx0SMjvDzeoeZFZRvU7smTH7w@mail.gmail.com>
X-Gm-Features: AVHnY4I9R9asg0CkA8bbiHfc6cvraxeMcbKv1Z1W3byrGcK-JcEwgmTCdS4a5n8
Message-ID: <CAJZ5v0gbVqppGJgz78XXZS6DdBx0SMjvDzeoeZFZRvU7smTH7w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] ACPI: button: Enable wakeup GPEs for ACPI buttons
 at probe time
To: Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 3:48=E2=80=AFAM Nick <nick@kousu.ca> wrote:
>
> Hello Rafael,
>
>
> On Thu, May 21 2026 at 03:38:50 PM +02:00:00, Rafael J. Wysocki
> <rafael@kernel.org> wrote:
> >
> > Link:
> > https://lore.kernel.org/linux-acpi/E2OXET.4X5GTP37VTNC3@kousu.ca/ [1]
> > Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for
> > buttons")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
> > ---
> >
> > @Nick, I have reproduced the change of behavior introduced by commit
> > 57c31e6d620f132dc on one of my systems, but not the function keys
> > regression because they are handled differently here.  This patch
> > should restore the missing functionality on your machine, but I would
> > appreciate some testing feedback.
>
> I have applied this patch series on top of today's mainline
> (8bc67e4db64aa727). It worked! My brightness keys and mute and
> lidswitch are back. That's great. Thank you! Learning how to bisect was
> a steep curve for me but everything after that has been a really easy
> experience. Thank you for knowing this subsystem deeply.
>
> - Nick
>
>
>
>
>
>
>
