Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD273B583B
	for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366865; cv=none; b=DZwGN5CH150EzOz56bIQwPr/lOfl99jaQ3mLoXkuY1Y9wdSj/sNsZbZ6OEc+HDfaVD4CsEVE4eppDhT2qWtgmSucqW9aeu5yDFVz7V6XlIKfHTxvTTQsbmlWdwge6d31z20BzVcydq7muo+Dsth39Sz0sxNkHcG6dhgZPrIR7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366865; c=relaxed/simple;
	bh=WaFoIc7myQNPVLE1G1hgiNCf3Znb1dO1znMKfxcex3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mj2v+t07uIzu4U3HeWg+ve6fteKazGOH+GY4yFsB4qtfJO6bLql/D1sdC+kJTLoz5qVO7YRjgaAAYy7ZAJCzcTIbFfwumbUgFkv0Jt/KHz0JyDZXA47QtRdH1xx1dmj7T+RiAb2IN/vLYWQeaVzQA13Ush0SG3BcF8pTF+5cZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD8jF2bP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD8jF2bP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0FC1F00A3D
	for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2026 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366863;
	bh=d03GkZSF1Q4U6VHI+t+IMgnnTt83u5+Z6Rv6mkqWL30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WD8jF2bPnP6OqUZVE83UhL7GCVHQ7RePhLiCrPeLeuypBW2vE6l88CMrm80W7HfYS
	 Ipe9RM9OcuDRbS1q4PDKmbLJxukDAZdjDNQtvbqmsQM6yGsxRirBv5lUf5mfMF0Z6I
	 nycppDlB4PZadl9TIDj5Q4hubATu6U782ftpgwzTEfyyRfQVYLU/fvpjIAC9K4D1nn
	 7cFJLorYs1AA6PwxaCXUh+gCkcdD3Hb/R+PniiN/fT4exNB1ldnf7ddJd0leOsLRsQ
	 RM5JPqAgrqMdVjbPzf5Db0/CxtEEzeNQSIDacQNZnTtIj0H0Z7f2iOtFoMEFKdDMKE
	 aesjU/lsFG4Yg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2aa3be376so1175841e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2026 06:01:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YxhayPTxkCj5LuEdf4Z8CX0CNKKnFBIEw0YtvxlKv0c2PzRGR61
	QzaeDYV0CiRqPZ0lOfkjKSb6KcdWjJyAdaGDM5Jg3lsTA9ShHUwigIEeINufqnwkjTQhcaVmgk4
	irrtKhoHjpMvKuVuHRvIaSJcYsLap5HA=
X-Received: by 2002:a05:6512:234e:b0:5ae:b01a:d213 with SMTP id
 2adb3069b0e04-5b3181820bfmr249170e87.3.1786366862289; Mon, 10 Aug 2026
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4764923.LvFx2qVVIh@rafael.j.wysocki>
In-Reply-To: <4764923.LvFx2qVVIh@rafael.j.wysocki>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 10 Aug 2026 15:00:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hF49YtVAxHWtxVZBdWrboXAdGKage0nKPTD2x9y_AVoA@mail.gmail.com>
X-Gm-Features: AUfX_mwMOJ8Clj8i2vonrf1iOWNghCQ1J7SGvNNkxsAwHXIPIH1146xZuXdfJyk
Message-ID: <CAJZ5v0hF49YtVAxHWtxVZBdWrboXAdGKage0nKPTD2x9y_AVoA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] ACPI: bus: Rework acquiring the primary physical
 for a given ACPI one
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi All,
>
> This is somewhat late, but since there will be follow-up changes tree-wid=
e,
> it would be good to get it into the mainline sooner than later.
>
> It is based on the observation that the majority of
> acpi_get_first_physical_node() callers want to hold a reference on the re=
turned
> device and the function is potentially racy because it doesn't get such a
> reference itself.  There were also some comments from Sashiko pointing
> out to this as a "preexisting issue".
>
> The first patch adds a acpi_get_first_physical_node() replacement called
> acpi_bus_get_primary_device() and returning a reference-counted device (t=
he
> former is retained for the time being, but made use the same code as the
> latter).
>
> The next two patches change the core ACPI code to use the new function
> instead of the old one.
>
> Later on, patches will be sent to switch all of the callers of
> acpi_get_first_physical_node() over to using acpi_bus_get_primary_device(=
)
> and finally to drop the former.
>
> Thanks!

I should have mentioned that this series applies to the linux-next
branch of the linux-pm.git tree (and will apply to linux-next when
that branch is included into it).
