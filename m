Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0D263C7F
	for <linux-acpi@vger.kernel.org>; Thu,  2 Jul 2026 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991927; cv=none; b=Js+Ij+8A+zNpgJJa/bmuz+pGsahIfWekV/ehypRqogCOKKePbltR1aifQ+/V/TcJVzq1ik8mMhxlh0ho2h1+aFVQ+5k8SP6YdJ9pBtK+24ng6KrM+/pHtGbmfpTlmClEpvzKQyG0FEspBBQWFzSBgloHAk+8Ae7DzJzOQBlxyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991927; c=relaxed/simple;
	bh=TxQCtqjtAk2iQqQD7O6uKHlwflcfM75/SGEiXcjbbI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVPcwBt/r7gK0cEPJnUhInzcX31y4FZsLqHaV0v7d83J9Fegi0q9WHOjiwt1tKc+jmdL2l8WwC6tlzyAm2XNLDBhD2LOkm4RNqPyiV4RL8xFmCD7i2ztxiCsvSsshI2PGGKP5ug4MtKMVgXiwTmfSFtIV+5cm5glD1dazXgWyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUbn8wYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUbn8wYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E792E1F00ACF
	for <linux-acpi@vger.kernel.org>; Thu,  2 Jul 2026 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782991925;
	bh=TxQCtqjtAk2iQqQD7O6uKHlwflcfM75/SGEiXcjbbI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XUbn8wYjcbFq3YuGEIAkjj+cxW3RoKyHvCBLm7FrowkVoQWmsezKMFntmVRriW0Dv
	 Bmn3JOAf0ClmyXsdxe3ZYXNQfFGE9gVQx8N38QQzEvmwOSUoMrR1hVtw+4lgyLMjv9
	 7LAWIaWtgGDMZnnMlJZJJ0tVAR6wh2fmQelm7x/QFwtBuxUHoxnq9Zvn0ROTNLV02z
	 3yvqDPAN/YLi4tHC8aZ6+DN/RSpyl/0eLXv7DjJa7lAvMU3FaUXJkJWxF2pf6GaUIX
	 6w/+t1kyHfcJ0hHuRCaNOvk6Frr1GRRiKzIIAC8up5IXaAYlRGr6Xv9nnj7E8MOIVb
	 FPyjOZFGbgpgA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb89359a3so1362128e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2026 04:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpW7yzUBNdDjwKBmddKp/GCis/dNKdF2O75cjN9fUoB8PGhannS+ss7R6CjPl/QPpjC7ktlZgnWkoWp@vger.kernel.org
X-Gm-Message-State: AOJu0YwSzdqpFfYUKsOVJiLqewxCOxhAXuflnJ0dUanAdOvoAsHceYWU
	ny/uFHzGybaxQpMXgEdqrU6J57XlwRS2dkh3syagFJQRCIFM2hFcfMy8lGYYjHodIJ4/34LQSFY
	qnBt52qWjarW9LUorNMFF68fNnHZFJVs=
X-Received: by 2002:a05:6512:2511:b0:5ae:ba92:f43b with SMTP id
 2adb3069b0e04-5aec80689d2mr1445491e87.52.1782991924360; Thu, 02 Jul 2026
 04:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6027395.DvuYhMxLoT@rafael.j.wysocki> <akYsRl024Ll80oye@ashevche-desk.local>
In-Reply-To: <akYsRl024Ll80oye@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 2 Jul 2026 13:31:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hszyrY+GLz0Q1HcNgMua056xuw8Uxf_O63OmyObPtkXw@mail.gmail.com>
X-Gm-Features: AVVi8CcB1CehQxSaZBKpjLXdEZ66xS6KSnQB6qAqVEVmAqLCZyXITmn8Rg4ltiQ
Message-ID: <CAJZ5v0hszyrY+GLz0Q1HcNgMua056xuw8Uxf_O63OmyObPtkXw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] ACPI: bus: Remove struct acpi_driver from the kernel
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 11:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 01, 2026 at 09:15:27PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > Hi All,
> >
> > After converting all of the drivers using the struct acpi_driver interf=
ace to
> > proper platform drivers, that interface can be dropped now, which is do=
ne in
> > this series (patch [1/2]).
>
> What a nice result!
>
> > Additionally, the no_pm flag is set for all struct acpi_device object s=
ince
> > they are not going to be directly involved in any kind of power managem=
ent
> > now (that is, they will not have PM-aware drivers and they will not be
> > included in PM domains).
>
> I am in favour of this cleanup!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!
