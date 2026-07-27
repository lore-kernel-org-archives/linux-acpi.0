Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A0378D8E;
	Mon, 27 Jul 2026 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195372; cv=none; b=q7EyxbarlQC8Ycbv5S9lQvJ6+qQ5Rerz1PyS44uSB+qrNhvszT8Vl9DlvenRd9aJTKsvSZWHaN5+aPYampMfQUH4PoaNlvME9cvqusnCST/oVMwW2i/UeX8oVwJYXMNPggyXSmioW90D+a6jh5TLVNyzpa+neTLaOIl2Nrrjct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195372; c=relaxed/simple;
	bh=KJvVHItaC++80gXxgICgZBgddr8xXf91Dtc8i4k0kSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTcYisbL8cE1F+kOUgoPpivk7Mpm1JAhHoYtbiux+3GMBHZGlUSYa4SV1yhiJ0FDPm4aEnjP8e5dHwDYYSSFVgZHXCLMXCA6NkuRODyJ2O6R3Mm8ubUaLrzG+0umXh4HR8UD+/yrsUTWN5JJwWWQ4PJHL14TStWA6WwfDjYXrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/IG3Rg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/IG3Rg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3C61F000E9;
	Mon, 27 Jul 2026 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195371;
	bh=PNl7tnAMl7nkr7Gi2tTSL3Q1eKtYp5WOaoWJus3+fR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U/IG3Rg8OTRvEqGn97og+yiQdS9ry3Y7jaoYmnjhZJ1IZ92STvCSYyFdghqFjtiu2
	 LmNW2JZ21w5IfTJMu9EMxOKGudUkSzOoqfyYFoeG6KzgBRYTd8OtzefC3OlaZBH7pM
	 mXrpyipnDZu3mHI7vAAwgVzBSqhpHit4P7hh2k1Ec5414t18x3xfQ09pVWhnjuo9KN
	 7ECnCAMi5mggx1aDth9yZYQO2/e/G1KUVhCEtksif9ALPE9SqSmwS7eSCJtrup0ZG6
	 NiyUUh1kc8QWYfY/qZG0kngMFQAZBObEsMyJq3+kab034dd/Ii892bCDlWqNuO/LEo
	 7FNPXp8b5/jXw==
Date: Tue, 28 Jul 2026 00:36:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
 <sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, Ben Horgan
 <ben.horgan@arm.com>, Reinette Chatre <reinette.chatre@intel.com>, Fenghua
 Yu <fenghuay@nvidia.com>, Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>,
 Srinivas Ramana <sramana@qti.qualcomm.com>, Niyas Sait
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] arm_mpam: detect and enable MPAM-Fb PCC
 support
Message-ID: <20260728003606.14386844@jic23-huawei>
In-Reply-To: <4faf0089-4615-4fb1-bc07-e52b4d43f073@oss.qualcomm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-11-andre.przywara@arm.com>
	<4faf0089-4615-4fb1-bc07-e52b4d43f073@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jul 2026 21:57:15 +0530
Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com> wrote:

> On 7/23/2026 9:24 PM, Andre Przywara wrote:
> > The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> > registers through a firmware interface. This requires a shared memory
> > region to hold the message, and a mailbox to trigger the access.
> > For ACPI this is wrapped as a PCC channel, described using existing
> > ACPI abstractions.
> >=20
> > Add code to parse those PCC table descriptions associated with an MSC,
> > and store the parsed information in the MSC struct.
> > There can be multiple PCC channels, and each channel can serve multiple
> > MSCs, so we need to keep track of the channel usage, using a list and
> > a refcount.

Blank line for consistency

> > This will be used by the MPAM-Fb access wrapper code.
> >=20
> > [1] https://developer.arm.com/documentation/den0144/latest
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>

> > diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devi=
ces.c
> > index fea3161ffbe9..fc4b5f87fbe9 100644
> > --- a/drivers/resctrl/mpam_devices.c
> > +++ b/drivers/resctrl/mpam_devices.c

> > +static void mpam_pcc_chan_release(struct kref *ref)
> > +{
> > +	struct mpam_pcc_chan *cur =3D container_of(ref, struct mpam_pcc_chan,
> > +						 refcount);
> > +
> > +	pcc_mbox_free_channel(cur->pcc_chan);
> > +	list_del(&cur->pcc_chans);
> > +	kfree(cur);
> > +}
> > +
> > +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
> > +					       int subspace_id)
> > +{
> > +	struct mpam_pcc_chan *cur;
> > +	int ret;
> > +
> > +	guard(mutex)(&pcc_chan_list_lock);
> > +
> > +	list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
> > +		if (cur->subspace_id =3D=3D subspace_id) {
> > +			kref_get(&cur->refcount);
> > +
> > +			return cur;
> > +		}
> > +	}
> > +
> > +	cur =3D kzalloc_obj(*cur);
> > +	if (!cur)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	cur->pcc_cl.dev =3D dev;
> > +	cur->pcc_cl.tx_block =3D true;
> > +
> > +	cur->pcc_chan =3D pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
> > +	if (IS_ERR(cur->pcc_chan)) {
> > +		long err =3D PTR_ERR(cur->pcc_chan);
> > +
> > +		kfree(cur);
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	/* Timeout based on the "nominal latency" from the PCC ACPI table. */
> > +	cur->pcc_cl.tx_tout =3D cur->pcc_chan->latency * 5;
> > +
> > +	ret =3D devm_mutex_init(dev, &cur->pcc_chan_lock);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > + =20
>=20
> Here, devm_mutex_init() ties the lifetime of pcc_chan_lock to dev, which=
=20
> is &pdev->dev of the first MSC to call mpam_pcc_chan_get(). But
> mpam_pcc_chan is shared across multiple MSCs via kref, so it can
> outlive that first device.
>=20
> If a second MSC has incremented the refcount and is still active when
> the first MSC's device is removed, the devm cleanup on the first device
> would call mutex_destroy() on pcc_chan_lock while the second MSC may
> still be inside:
>=20
>      guard(mutex)(&pcc_chan->pcc_chan_lock);
>=20
> I am not 100% sure this is reachable in practice =E2=80=94 it may depend =
on
> the order in which platform devices are unbound, and whether that can
> happen with MSCs sharing a channel. I also note that devm_mutex_init()
> is a no-op on non-debug kernels, so this would only be observable with
> CONFIG_DEBUG_MUTEXES=3Dy. But it felt worth raising in case
> it is a real path.
>=20
> If my understanding is correct, would it make sense to use a plain
> mutex_init() here instead, and move mutex_destroy() into
> mpam_pcc_chan_release() where the kref guarantees no concurrent users
> remain?

Good spot and fwiw Sashiko shouted about this one as well!
https://sashiko.dev/#/patchset/20260723155454.1760823-1-andre.przywara%40ar=
m.com

It also called out the lack of error handling should this fail, but that
becomes irrelevant if the code is updated as you suggest.


>=20
> > +	cur->subspace_id =3D subspace_id;
> > +	kref_init(&cur->refcount);
> > +
> > +	list_add_tail(&cur->pcc_chans, &pcc_chan_list);
> > +
> > +	return cur;
> > +}
> > +

Thanks,

Jonathan
