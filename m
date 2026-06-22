Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264DF36BCC0
	for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2026 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121024; cv=none; b=pBg81Ms5G0sFCiKDlTkMqwsrdRGdUsHTnWoZJDHKXpII6MTejRLSGi5jIQZAGY/qiEZnZmQT6I2SZyXzBMHQQDjG793nyqzRqDudTZsJLztrdEnOGGiHhyJGSuPHyg19l4QmM5HedMa3B6WFThOH/OwN6Xzesj62hSKkDkl4Zic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121024; c=relaxed/simple;
	bh=sR51GIcIqNFtV3dQKBdjBGaALcUo3WJE7E/Et89xIUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TQj/LMAw6s8eGRxWRRDUBrR+sEs48bQJIMBmPtkI6HKSNEEsYbKztYzt7FepVcXJ+F5aymNuaqwhfOjDwRJcmVxMW1yrYdqRKsMQADcCCwLekK9LL0Otkzjmx3fjFUuNeLfbR8ugno47wN0Fj+qTKnvXquyaQBKY99IZND947uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Uo2+LUTD; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Uo2+LUTD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T6OMGlJa40Q9T6dI10weGVXZ3INrLA2lPZOh1zkcU1U=;
	b=Uo2+LUTDdWGAdCD08UMXRK9DM0TO1MVw3aA+H3xx+PIA/UI7w4Kt1bMBd01BkMEP7JlbeCqfq
	2MLV7YggYrq1Dp4rs4c7z92oy5uYfnKarKZtU+UZJUq1KPJyrBOaUUk4LYYME0pZPN+SJ+ydMSz
	csfZM8dP9tl/dTUKWDZhBmU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gkNCY42CpzRhWZ;
	Mon, 22 Jun 2026 17:27:53 +0800 (CST)
Received: from kwepemf200003.china.huawei.com (unknown [7.202.181.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 50FF640537;
	Mon, 22 Jun 2026 17:36:56 +0800 (CST)
Received: from frapema500006.china.huawei.com (7.182.19.102) by
 kwepemf200003.china.huawei.com (7.202.181.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 17:36:55 +0800
Received: from frapema500006.china.huawei.com ([7.182.19.102]) by
 frapema500006.china.huawei.com ([7.182.19.102]) with mapi id 15.02.1544.011;
 Mon, 22 Jun 2026 11:36:53 +0200
From: Mauro Carvalho Chehab <M.Chehab@huawei.com>
To: Jonathan Cameron <jic23@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: "uswg@uefi.org" <uswg@uefi.org>, "taoxiaofei@huawei.com"
	<taoxiaofei@huawei.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Dong Wei <Dong.Wei@arm.com>, Samer El-Haj-Mahmoud
	<Samer.El-Haj-Mahmoud@arm.com>, Jose Marinho <jose.marinho@arm.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [RESEND] troubles with ARM processor type changes on UEFI 2.11
Thread-Topic: [RESEND] troubles with ARM processor type changes on UEFI 2.11
Thread-Index: AQHdAiC3zXX3hVkmG0i2Z5Vam7BRhrZKIFqAgAAwj9A=
Date: Mon, 22 Jun 2026 09:36:53 +0000
Message-ID: <d685e5a9d5a2470c8a30cfd96e2f81d5@huawei.com>
References: <20260622102518.0ad0e4de@foz.lan>
 <20260622094233.1088c8bf@jic23-huawei>
In-Reply-To: <20260622094233.1088c8bf@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 22 Jun 2026 09:42:33 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 22 Jun 2026 10:25:18 +0200
> Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>=20
> > (as I got no answer, I'm resending it, c/c some ARM people as well)
> >=20
> > Hi,
> >=20
> > I maintain ACPI HEST support on QEMU and I'm one of the Linux kernel re=
viewers
> > for the RAS subsystem. I'm also the author and maintainer of Linux rasd=
aemon,
> > responsible to handle RAS reports (including from GHES) on Linux.
> >=20
> > There is an incompatible change at UEFI 2.11 spec at Section N.2.4.4.1,
> > which, according with UEFI 2.11 changelog, it is related to this issue:
> >=20
> > 	2462 - Fix the Type mnemonic description in the ARM Processor Error In=
formation Structure
> >=20
> > This is the second time the specs changed the meaning of the type field
> > inside the ARM processor error info:
> >=20
> > - Before UEFI 2.9A, the spec has a list of values for error type.=20
> >   From the specs, type, at offset 4 was described as:
> >    =20
> >             - Cache error
> >             - TLB Error
> >             - Bus Error
> >             - Micro-architectural Error
> >             All other values are reserved
> >    =20
> >     Yet, there was no information about how this would be encoded.
> >    =20
> > - UEFI 2.9A defined the actual expected values as:
> >    =20
> >             - Bit 1 - Cache Error
> >             - Bit 2 - TLB Error
> >             - Bit 3 - Bus Error
> >             - Bit 4 - Micro-architectural Error
> >             All other values are reserved
> >=20
> >     However, even being an incompatible change, the spec didn't change
> >     version field at Section N.2.4.4.1.
> >=20
> >    Linux, QEMU, rasdaemon and likely several BIOS implementations
> >    were updated accordingly.
> >=20
> > - UEFI 2.11 changed the definition to:
> >=20
> >             - Bit 0 - Cache Error
> >             - Bit 1 - TLB Error
> >             - Bit 2 - Bus Error
> >             - Bit 3 - Micro-architectural Error
> >             All other values are reserved
> >=20
> >   Again, another incompatible change and without changing the version
> >   field at Section N.2.4.4.1.
> >=20
> > With the current mess, it is impossible for the OSPM (and RAS apps) to
> > properly map ARM processor error types, as for instance, type=3D2 can
> > mean:
> >=20
> > 	- Bus error (up to UEFI 2.9)
> > 	- Cache error (UEFI 2.9A and UEFI 2.10)
> > 	- TLB error (UEFI 2.11)
> >=20
> > Please issue an errata incrementing version number, to allow OSPM
> > QEMU and rasdaemon to properly interpret this field.
> >  =20
> FWIW I fully agree that an errata is needed. (Though, even though ambiguo=
us,
> changing meaning should probably have been done by deprecating that field
> and adding a new one... too late now!)=20
>=20
> It seems a bit odd to do it this way but Mauro, you should be able
> to file a code first proposal at:
> https://github.com/tianocore/edk2/issues?q=3Dis%3Aissue%20state%3Aopen%20=
label%3Atype%3Acode-first

Thank you to point it to me. I opted to open this as a bug:
	https://github.com/tianocore/edk2/issues/12708

As the root cause for such regression was another bug:
	https://github.com/tianocore/edk2/issues/10524
=09

>=20
> Make sure it has a code first label.  I think you also need
> someone to take it through the committee though (I'm sadly not
> in a position to do so at the moment).
>=20
> Samer or Jose (+CC), can you deal with this one?
>=20
> Thanks,
>=20
> Jonathan
>=20
> > Thanks,
> > Maur =20


--=20
Thanks,
Mauro
