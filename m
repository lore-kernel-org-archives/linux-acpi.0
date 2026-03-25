Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF813081D6
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439141; cv=none; b=FWdH1yfiMe18RMwO82dpco4n3xaJY/7t8/jrayXxK+1h2Skk8hk8KBLPI37qcxCjhU2zU7C+3pJ48HJAOeBEY55YEbaiY4uylB+5HBXUsXkJQH5AhAAiNr1xWQ6pru/90DhUYuj606chLXphsNh9F0EEMNmZwvQ4lytzKJBNxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439141; c=relaxed/simple;
	bh=NWCObwknDxL9jFnRT3Io9KO5/6yqxc/4HWvzuWQvR28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI5jn30ieC596rC22SMLbyudbJdxHeCk9wtK4/oKbwzapYtZNsyug8SP6uS4oYeSMYWOB11GKOm2ma+yKL0otMlliyLnIEndXIOBww6P1cwa0MQoFeF5joTS4l7XFokqi0qA+ln9z2tFP2UEGJJErwUaQglhunA04Jk/8VpSEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxipGUfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxipGUfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD21C2BC9E
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774439140;
	bh=NWCObwknDxL9jFnRT3Io9KO5/6yqxc/4HWvzuWQvR28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UxipGUfZsnX6stFSDUi6lYK3f9nZD21SAobNzZrAbM23nZUf0fS82CCinZSyg/P3d
	 QZKcruJNVKAV0iRAIoKWdA3yR/JzAb62U82xuzHqcMCLYM4AwdBK20ofGMJmYznx3S
	 u5SPQJ+BOhgH08ZjJWgqUfjL2DmtIAQY12MmJBQoSeqH4ehynu05pHm8iB7PwyB28B
	 ndnr8SQuNjbMvObedxxMXmdNhNdZJ0wYyP/sGVHzMgf31xu8GgnpaXejMbOo/3eKuw
	 lFeXou5yanBa0mWz1/62OcWLbHz13pPY9fGNnvNS5/kZbH3NPXHMxHWLJfQBQ7ZZwi
	 ugS0Hkl/a6BHw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-46708149af2so1357156b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 04:45:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdRG7hb4LlVJVi0byWPOtfn1oiYrsqJreslAYt/mjNP+YYQMGcGcXmB9m3ZVEXe28AvtFdsFpILXy3@vger.kernel.org
X-Gm-Message-State: AOJu0YzZL8sALJ0bk3qThCFTcSlhzNAgjzg1TZ4aYRlgU17a7GcVFQay
	MH7m9/E/oGq8PSykjtP8P2RTqcRHaqhdYZ466KQh99jBz2oR22qmYsmIJnUAWJUNplqiiHf/7/Y
	zs5SAxjMLjO2kwaR6I35eWidzDvQiqbM=
X-Received: by 2002:a05:6808:c135:b0:455:d5d1:8ac0 with SMTP id
 5614622812f47-46a5c7b11dcmr1466600b6e.53.1774439140050; Wed, 25 Mar 2026
 04:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324113300.1002569-1-ben.horgan@arm.com> <20260324-nostalgic-adamant-coucal-7afd8b@sudeepholla>
In-Reply-To: <20260324-nostalgic-adamant-coucal-7afd8b@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2026 12:45:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gn5NTdSj=i5iRpK03kT0V-UshADp=VaaEAO=wzLsjjUA@mail.gmail.com>
X-Gm-Features: AaiRm52ie-6qBDWvATbl_bA6WtdJxcNCkAJ2eP-Qt6sw2MyXVhpV8Dh-n97Puik
Message-ID: <CAJZ5v0gn5NTdSj=i5iRpK03kT0V-UshADp=VaaEAO=wzLsjjUA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI / PPTT: Remove duplicate structure, acpi_pptt_cache_v1_full
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Ben Horgan <ben.horgan@arm.com>, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:43=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Tue, Mar 24, 2026 at 11:33:00AM +0000, Ben Horgan wrote:
> > acpi_pptt_cache_v1_full was initially added as a stop gap until the
> > equivalent structure imported from ACPICA, acpi_pptt_v1 in actbl2.h,
> > contained all the fields of the Cache Type Structure. Since, commit :
> > 091c4af3562d ("ACPICA: ACPI 6.4: PPTT: include all fields in subtable
> > type1"), acpi_pptt_v1 contains all these fields making
> > acpi_pptt_cache_v1_full redundant.
> >
> > Remove acpi_pptt_cache_v1_full.
> >
> > No functional change intended.
> >
>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

Am I supposed to pick this up?
