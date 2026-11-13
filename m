Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562635;
	b=PmmDJa5KYxMTbaNLMvDTha26wRwM/Nwzq4LJpCC6iDsTb6b/10iG5KQ7qAFwSgqJblSD
	 px0HQv4Z1j5Gh2Xx+v+6iQ8SojSiBGuJTegGX5/T0Yq3wZAuzCqbhCy/ISLrXtdiTB6YZ
	 u5HUXxdPI+am982iPirZfIwwSocSlNigclzfoQAgSr8vYhQ3BbpeFlbVFzyyQxdbKR48a
	 RVs12nNk/E3Om9VAOu3uw78DodLwowzXCLYHzdeiQWSD/BfOFd6m9vbo/GZpZ9Wkz97O/
	 V39QCle+o0Gh3Gti/sRyQGcN/Vz3ZxkEMO8EgQQzqE7oZLOKSTLD+q1jCId6jqthqCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562635;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LgPdgX1TU3hIXLVu79B9VzFv8HuFp+6oHaduAGW/ehs=;
	b=RLtC1NywcYroOwZrkZPqLn2yAGbb4xZ/w2mYWXcGnuuKXja65YyHxbtFuaHuVWLO3DNF
	 Dgnhx6iQj15vsfkCuwUUqFPKW6b2pRXuhZJV2mQau9H1eDI01xgdI20gTY0W9Gxf64Tbd
	 Oa041cERVboReDrBHY11kZcMcJFeOIrH2h9Qt1n9xr1auSmv4bTcx0VCxzwz0IpPmW0RN
	 hxS06WEtud1A2y0KIjxT5Lg9z/QC9poBOFSyVylDTCtEw7NiJuC3iGyJxItd0DYwp7GEd
	 9OEfPmW/EunMzbXvj/Z6pXk9BQFcjzyXmLfn9W23N1ioX/6ngFxiVrk5vwVWvRlnFaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIC7VXIO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C8606A321;
	Fri, 13 Nov 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIC7VXIO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EF61F000C4;
	Fri, 13 Nov 2026 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562634;
	bh=LgPdgX1TU3hIXLVu79B9VzFv8HuFp+6oHaduAGW/ehs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YIC7VXIObG41v3zDczVKNAh+pOX8Xb2PWBll4SyOFjOJb80K0ZGZBpECpIicCwZem
	 wfMQ12N7d59BW7qAPe2UBA+XJwGtUviNQ6zSF5cEsGGJDcOLj6bCCaOHbRbYVSwuCB
	 y2/KeS5SZ2dkDQ/eYFHDN7vQ26dgX2Fx7E74n7LKQ+dahD7B5Fui/QVQ6MXY4Ow/ue
	 OlmwpxAvd3I8jW5gWYDjXoAwrucClX83GXrZE2Hzd3olvBRPxJ2W7YU7+BqlyfXHW1
	 q7RjBi6fsP29xTcF9vBW1O7J63r6710PNQEtBQojB1HVR2w1xPnOAT+3lnNriyhb6O
	 lcXJE2awRmFtA==
Date: Fri, 13 Nov 2026 10:37:09 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com"
 <guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
 "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
 "lenb@kernel.org" <lenb@kernel.org>, "wangzhigang17@huawei.com"
 <wangzhigang17@huawei.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Validate length of the Vendor Error
 Type Extension structure
Message-ID: <20261113103709.13bfd3d6@foz.lan>
In-Reply-To: <CH8PR11MB40343305FD3C1BE0E18882B5CCFC7F2@CH8PR11MB403433.namprd11.prod.outlook.com>
References: <20261111115729.253-1-yuzenghui@huawei.com>
	<CH8PR11MB40343305FD3C1BE0E18882B5CCFC7F2@CH8PR11MB403433.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2026 00:27:20 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > The BIOS on my machine is obviously buggy (non-zero Vendor Extension of=
fset
> > pointing to zeroed memory, and bit 31 is not set in the error type eith=
er)
> > and needs fixing. I'm not sure if it is necessary to add such a sanity
> > check for EINJ at all. =20
>=20
> Production machine? Or just an internal development machine?  I.e. is thi=
s broken
> BIOS out in the wild for others to hit this bug?

As a reminder, any VM runs with a BIOS that is not produced by an OEM, and=
=20
there are lots of production environments running VMs out there.

So, I'd say that, if the fix is good, better apply it.

=46rom my side:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Thanks,
Mauro
