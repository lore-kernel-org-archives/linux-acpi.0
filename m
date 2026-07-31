Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F6310645;
	Fri, 31 Jul 2026 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464173; cv=none; b=T6BdSA1YU1M4mUgeMSSAfqwTq2YQGVtem/Y7c+jOBV73m6x95GXlvgN6SOt0usUJXWQrUtXW7jAgddhuMJQVEhI5/lu+LkW5k+ArEr8d6Imx7ONmAyGi8QopRpdsos9C4AzE+AEwRg8Bay5/EtOMd/B0meDhqaJ+egoWREPoc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464173; c=relaxed/simple;
	bh=RgMzheITu3GaizUOL1WH8xqqu4GZm2loEyMx/JOelFk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RFVy+Rj3e+ZUNewsRhPXpceeAUDwQpdmguPlaElWQrSVA7jWavl0YkJRFJn7IM04ldPPE5xWUgt4FdiC78Hy4MEsTrrR48QOmMK7oNyEMO3jdrSjjrd44Jo6rGdHL2bBWEyPNhNrzNH1z2o2Cwjvl6X4C6lYqaRWTqSgpeUzDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aMsoZlXx; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aMsoZlXx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785464162; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=hc3mGOfYflVhngcBU0mpXS3nwU3AmmEu7q+5ujBogpY=;
	b=aMsoZlXxh6uZbXbgptdun/LxIER20MXgJXTUAo361GJ74HDj+COa5V8o72x1kxVQa/wKhhvMX6KfbpDkr0kan0cLvD9BjBHgNGXZd6pplT5xPQeWKQQEkVMUndtrnnn2DxZDhZEeW+sYu5sX3Eq3DSlMpcbDYyfhrvOnwBc4pTY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=yadong.qi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X86a7kc_1785464160;
Received: from LG41624401116(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0X86a7kc_1785464160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 10:16:01 +0800
From: <yadong.qi@linux.alibaba.com>
To: "'Ben Horgan'" <ben.horgan@arm.com>,
	<james.morse@arm.com>,
	<reinette.chatre@intel.com>,
	<fenghuay@nvidia.com>,
	<linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>,
	<guohanjun@huawei.com>,
	<sudeep.holla@kernel.org>,
	<catalin.marinas@arm.com>,
	<will@kernel.org>,
	<rafael@kernel.org>,
	<lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<ying.huang@linux.alibaba.com>
Cc: <ptg-linux-kernel@linux.alibaba.com>
References: <20260720072409.2660-1-yadong.qi@linux.alibaba.com_quarantine> <d471ead3-d6fd-4e2e-a800-5bbeba42cb90@arm.com>
In-Reply-To: <d471ead3-d6fd-4e2e-a800-5bbeba42cb90@arm.com>
Subject: RE: [RFC PATCH] arm_mpam: remove sanity check of accessibility when error interrupt is SPI on SMT platforms
Date: Fri, 31 Jul 2026 10:15:57 +0800
Message-ID: <000d01dd2092$8739f760$95ade620$@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQHSkGkfR30OQX7y8B7c/MgsEN8rbgJ7XVU9toWBJYA=

> Hi Yadong,
>=20
> On 7/20/26 08:24, Yadong Qi wrote:
> > On SMT platforms, an L2 cache MSC is typically shared between =
sibling
> > threads. Per the MPAM ACPI spec (DEN0065B), the MSC's linked device
> > should be set to the processor container of those siblings, so the
> > kernel derives msc->accessibility as just the sibling CPUs.
> >
> > Per the MPAM spec (IHI0099B), when an MSC is not integrated into a =
PE,
> > SPI/LPI is the recommended error interrupt. SPIs are not per-CPU, =
and a
> > sanity check in mpam_msc_setup_error_irq() requires accessibility =
=3D=3D
> > cpu_possible_mask =E2=80=94 assuming a shared interrupt must be =
routable to all
> > CPUs. This creates a conflict on SMT platforms: the MSC has a =
restricted
> > accessibility but a shared error interrupt, causing probe to fail =
with:
> >
> >   msc:N is a private resource with a shared error interrupt
> >
> > This RFC patch removes the check to allow MSC probe to succeed on =
SMT
> > platforms, but this is mainly intended to start a discussion. We =
would
> > appreciate advice on the right way to handle this conflict. Is this =
a
> > spec issue, or should the driver handle SPI error interrupts =
differently
>=20
> For advice on questions broader than just linux please ask arm =
support:
> support@arm.com

Thanks Ben, I will send mail for arm support.

>=20
> > when an MSC has a restricted accessibility mask?
>=20
> I expect the MPAM driver could be taught to deal with SPI interrupts =
without global
> affinity.

I guess MPAM driver could set the interrupt affinity to accessibility =
mask if SPI interrupt
is per-MSC. But if the SPI interrupt is shared between different MSCs, =
it seems no proper
method.

>=20
> >
> > Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> > ---
> >  drivers/resctrl/mpam_devices.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/resctrl/mpam_devices.c =
b/drivers/resctrl/mpam_devices.c
> > index b69f99488111..e8b2b5e00d7c 100644
> > --- a/drivers/resctrl/mpam_devices.c
> > +++ b/drivers/resctrl/mpam_devices.c
> > @@ -1964,13 +1964,6 @@ static int mpam_msc_setup_error_irq(struct
> mpam_msc *msc)
> >  	if (irq_is_percpu(irq))
> >  		return __setup_ppi(msc);
> >
> > -	/* sanity check: shared interrupts can be routed anywhere? */
> > -	if (!cpumask_equal(&msc->accessibility, cpu_possible_mask)) {
> > -		pr_err_once("msc:%u is a private resource with a shared error =
interrupt",
> > -			    msc->id);
> > -		return -EINVAL;
> > -	}
> > -
>=20
> To do this the MPAM driver would have to remove the interrupt from =
balancing,
> IRQF_NOBALANCING, and
> control the balancing itself.

Yes, but another problem is SPI could be shared between different MSCs, =
interrupt
affinity could not be set correctly.
Currently, the error irq handler print the error message and disabled =
MPAM, maybe
we can allow interrupt from any CPU?

>=20
> Thanks,
>=20
> Ben


Best Regard
Yadong

