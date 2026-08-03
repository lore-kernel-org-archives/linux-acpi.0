Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF7423E96
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783121; cv=none; b=thRUny7vERaDeMYYUbtC3iE+TuJbJcP53WpexOZB4yiiC9iBPuj4npaVSNffBD/sYYjUWNaRuRjh6P5nd4ay2jfUhTDT7ScWbBcQjcn87XWofm3nLDxy3PfExhrRA2URq8eCz+7srDvfpTdsGj5L1D+/Q7ABojCD+kADH+5A8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783121; c=relaxed/simple;
	bh=iM5Z/oLcSCR6iWyjXpj6dij8yyM7ihBxh2QC9XIR3ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0ywLI50m2gYyLal4i+ayHQOyHOGqWjSiW6cwhoZfSWqduq2PW6UFuQp+qCj++xvMkyzdaaOSGyTZIpNbCzn6nIYRqybLMHhNrcYp/M4wdyWiVfQfiZJ0pVucEY0evgESwIPynJXlZVFn+8noOiaJMzuABkp20TFJF/1E8Qsht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMTWMpGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMTWMpGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FF21F00A3F
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783119;
	bh=iM5Z/oLcSCR6iWyjXpj6dij8yyM7ihBxh2QC9XIR3ko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MMTWMpGk1qBzFG99s3mkfXUNJFhgXIDVkp4/uN7rg9p05cwHr3uIIeOkcKapgqdNK
	 dtnuonhBiDfU5aiQzNhElCckusGB9gfgGj2lzv9nIH6nPzlFgh+J0bJlAfuHlo8VB4
	 zLaSmjAN6/l7zlPBn/+vv3K4wdVfWA3gPxW0VxnUR3ciu9yEOfRueTPsDSCaktMBnl
	 NP1pJ8j1hR77vWG/rYAKaF5orPGAOhpwi4IWbbaUSNhLQdgU1QTcgiGM24M0AHXXgL
	 xk9mEcasJedI07bEa6bp1vUeF+c0d+sXETEN30Snmx5eLOGXcQmYdrYq4h1MQak21b
	 43OtXe+BP1SmA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39ca0a30148so33547111fa.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 11:51:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoqAtQ9kob25QgJQQy43PxDwPEk2GZHZfeCnfuzCeMGERlQpx2/L9dvlRJrYe8GwngwBV4FtiwunyUY@vger.kernel.org
X-Gm-Message-State: AOJu0YxUM1RCEpyH56rGECWCQPuMl7eQVfnzIzRd9OyyDnm5v+dpKc5j
	OcM5iLA5WrniLd/75TduQ2Aj5n9RyNMCZwQu/FGrqoxjFokuPhM2/ToE4e8f++LvIKyVHZjdaKP
	JroF8eQq5vJYgMeQchHYcuk1hrSUqJ4Q=
X-Received: by 2002:a05:651c:1508:b0:39e:ed7e:45b8 with SMTP id
 38308e7fff4ca-39f8613cb28mr22393461fa.1.1785783118064; Mon, 03 Aug 2026
 11:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
 <daf0bb9b-246d-437d-87ca-16706113b201@gmail.com> <CAJZ5v0jByxtQ2tmNm_ZyyBnDMBNjuqQwD_367NRyGNzF7wQtRw@mail.gmail.com>
 <7792f017-42b0-4a09-9941-5259138e21b1@gmail.com> <CAJZ5v0jCFFNuG7WtCE2CG+hP=YNsYMdXH_945QgkgAUcr4Lryg@mail.gmail.com>
 <37daa35f-06aa-49d0-bf0a-1b5ac9f44c89@gmail.com> <CAJZ5v0jyy0+hqU3=gmBrgMzLBVhdUQwDj8d0_jGCqZwqyWT=_g@mail.gmail.com>
 <588c2e18-e6fb-4fc1-95d5-7a5dd0f556fe@gmail.com> <CAJZ5v0gXtKEaNDdSRqd57zg9GbFN-VDHrU5-=EEQPdSa9Zk-xw@mail.gmail.com>
 <CAJZ5v0g4ctzLpEro2Mu7EbSo8RNmYUCM6+J2p_ExCXseQAx13Q@mail.gmail.com> <1da0b5a8-336c-455f-9098-a8c834721039@gmail.com>
In-Reply-To: <1da0b5a8-336c-455f-9098-a8c834721039@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 3 Aug 2026 20:51:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g6He-X-C1Ctr4nsnL00mgLiD1mThwyX2jhUj9qKV12+A@mail.gmail.com>
X-Gm-Features: AUfX_myF8OwVYwT4pBH1PqlOFv8YfvQAumFBZafcm5ubEHHbSA3UYGkJN_QcxIg
Message-ID: <CAJZ5v0g6He-X-C1Ctr4nsnL00mgLiD1mThwyX2jhUj9qKV12+A@mail.gmail.com>
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: Julian Silver <mendaxca@gmail.com>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	linux-usb@vger.kernel.org, regressions@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 3:16=E2=80=AFAM Julian Silver <mendaxca@gmail.com> w=
rote:
>
> On 2026-07-31 22:11:15, Rafael J. Wysocki (Intel) wrote:
> > The attached patch (on top of the current mainline) should prevent
> > cpuidle governors from requesting idle states deeper than C1E when
> > intel_idle is used until all of the device_initcall()s are done.
> > Please see if this helps.
>
> Thanks for the patch. There is no more -110 error after applying this.
> Feel free if you need other info or test.

A new version of the patch has been sent:

https://lore.kernel.org/linux-pm/5120454.31r3eYUQgx@rafael.j.wysocki/

Please test that one if possible.

Thanks!
