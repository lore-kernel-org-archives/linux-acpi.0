Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D67364053
	for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615806; cv=none; b=edcZ26KlHwpZqjZz0TagwSiz6/Rm2rsL0mQoUw47tP/ij4Edj39q5vjpvbfRJe5a6GyCzuq/vETLjV7tEQgD2o1TEbqV7xZt7dqf8VoWGmi/k9Gj3CS92KdFbQFeOvkvDH7tqXeQO/YZk8PLHVgWsmrcwFV/Jc4Mz3cxGd7hGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615806; c=relaxed/simple;
	bh=ikUc7rizTRERtyzFWSfuipucOWycy9b+VB0eQd/oMHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VN7yZ3AoErd7kNfPJeGugc7v9DGrYkpXe5b1BhPx/7QcptEbe7LK1vNJHGZVej75GpoplMevCMP4atsVdkpAvm9ZbVwoXuHJNkizF02zNg0xK5S8E3HPrVbPNui51UQB74fIGDiN6GR1Y9LvRiFeiNCvmA/F3WDVWcHPkvwSC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaPaGWk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaPaGWk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FB61F000E9
	for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615804;
	bh=JUG7ECIKTKVzDCCjk7JunxoKL8nMh+iWzNtOUaZsFq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aaPaGWk9t1a3NkpMOIMWWL1pbP5DQqEO+r3yDq3J75JcmziSl7tjmEcbgTNnNCxZ2
	 nA1EQybfh8swxySmLPVtNeNNIQH2W2+/AJURWLezz4fbElpgUAlBcxH4wJ/wr8/eWy
	 542OIP3AbMZneUZn5QtO05xKSbv1pybyK3ZFydx4iceJ0UsUiZzHKroHTPHqxAEa7N
	 wWU0gaGCy4RUk/fqc/iqj98yW73pGaGTHTDhaVKdnLTvohOsaI4/IPz9wehKLOpMJL
	 HI4FPGseFOBIJ4YBu5EktYt0jaYwkk0CexFEgWISDlfHbmMjk2rRgTPwd59JLvEOGO
	 t7RxfqhvFv9ng==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so2079582e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 03:10:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro7KyLIIcoP75068GKSdEREDeWAWPm6g9RrB6Cr5jsW/b0K1PpW/TuoDnBMvShZV10fwG6FvI9VHack@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKDwS7m6q8DuG43sK1PYVREvlEDR2VbQ+MsvyxIaR1+82jNXD
	Km3XpIv9sAULVeMiYY4vjqfOHOOlagTNx3d2tkZv8fV8DjzZpDfnBd6lIlHWbbGnUcyX912Nik9
	E1B7ltn8yEbPGj18ZgAfeoX7XiLqGFKA=
X-Received: by 2002:ac2:54aa:0:b0:5b2:a885:f3b9 with SMTP id
 2adb3069b0e04-5b453f7c899mr468059e87.35.1786615803131; Thu, 13 Aug 2026
 03:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813024129.905583-1-dmukhin@ford.com> <20260813024129.905583-3-dmukhin@ford.com>
In-Reply-To: <20260813024129.905583-3-dmukhin@ford.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 12:09:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iB5JkQ_xso_exDjsrbC1ezH68vTAJAh7V4XwV57AqniQ@mail.gmail.com>
X-Gm-Features: AUfX_mwccR5rICunmwKf29OGWieoJwIvSh1D0CG-9vXSWwgNDfPYNqZGC780yBw
Message-ID: <CAJZ5v0iB5JkQ_xso_exDjsrbC1ezH68vTAJAh7V4XwV57AqniQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] acpi: bus: Introduce acpi.skip_ids= boot parameter
To: dmukhin@ford.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 4:41=E2=80=AFAM <dmukhin@ford.com> wrote:
>
> From: Denis Mukhin <dmukhin@ford.com>
>
> In virtualized environments it is possible that a device managed by the
> hypervisor or another VM is described in the ACPI tables. In these
> cases, binding a device driver to it can cause functional issues.

Examples, please.

> To resolve device ownership conflicts, skip enumeration of ACPI devices
> whose ACPI IDs match entries specified via a new boot-time parameter:
>
>     acpi.skip_ids=3D<HID[:UID]>[,<HID[:UID]>...]

No, we are not adding this.
