Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183796;
	b=w6kNMlUV2gTiPfbUCgLLJLsoBFFG/WO3K4sNVGajBi/PTNxD4rD8xaCybaEgpYDHkU4z
	 6dhqurZZD7++/8edVnHcY5W1b2wWcEgCxrHUotesj5kcHz4St6A6HSqJursy0ELSehh/x
	 bpBi6dGTO5MXpnmyY8GFQfqrsDTRdz0KzA2qcKAwWYk1S1oI9IMN3Y30gAd1OfjRkauBz
	 vaa2p/g5PXtxRl+D24mDEZBk9YF5OPRvGYVbPk0WLYcBrTx6m5skb5Hxa5cAYX5lqCutg
	 TyK5bHxL5wz/jybbrsPilZFxuDuHo2d14UMkE3UWT8+gAGEdoa4+M8YizPP2WWt7bvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183796;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+Zo3cvqMKBqjRqPSnK6ChwtRnPZIXK0c+XPzYS/weEM=;
	b=zHqt/3aM9UGM59/xoPjU1lkApYJ7nPz7G7gCL1HHbMCVN25jbavKPqx0UUZPLPOmVD3i
	 0n4FW1raOzFf/c5s6uJaVG5cR6OepJzbYVtVN6AnDFFjnTctS72lxbz+HAJt3qAZVNeJc
	 blBDArZDLOua1r4oHb/F3pjTqBUQVWpP2z1lzUMMe6Bwa35p8nid+FnKtmQxyYW3H9v3F
	 gl940DtEBOedNd1Wb6e9Ha6NrWH213g9wadpquV91Yobgg66MaB+kndaYx0lL3Vc/TuOh
	 y1vvo/eusAl0pizhaJmZV7va5tEYLDc7j9eCS/f61QgR7x4Z9xdAZN5gNvWUO7bKD4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feeKw5Tn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C7606A320
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feeKw5Tn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1BA1F000D2
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795183795;
	bh=+Zo3cvqMKBqjRqPSnK6ChwtRnPZIXK0c+XPzYS/weEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=feeKw5TnR1MwTK6wpvlYL8plFL0dZeF+pHKjxr67dtBZMTEW/rveyjtgIUWea/0gf
	 YsaZaERFJKC+ey9+8syL+jJOoPXfW5i9dSOvI41z95kyjD58rTn2DuyR6anF4zprIU
	 SRZ2fqCqNI7OASVBGfQNpt9zJCgb62b11rvJQOh3et3vSFCO3XX5X+XJ1si1n1OAhQ
	 3rriUKaFNJmHHoYXX7k5u425/gm0P9sboNWEo8zvWm1KTIkqJQfupRNDJCOZ9cz/qd
	 Z+sVeW3Tghbe5B2gHJCRbTZ5ZsxBXDWbCRz7/IBHhT+1iKiQZmqNVLLB/4A2o2fcjt
	 VYa+DN3OjkBuw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso1301117e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 06:09:55 -0800 (PST)
X-Gm-Message-State: APuU4Z9v71RtNdBuB3iX+NN20NIzq5J/PuzDpZd87sAyhVhysVh1Jgdz
	GJ/mlDI11h5ELyrgYzmHKNQfM2nxZarP7P5F1riX4KPGK5bcLLLmMrFFUUA8P9zuVM5xAVxCHxj
	Iy1CCS9TO0CFHxv/h08+ezv7zyM46McM=
X-Received: by 2002:a05:6512:401d:b0:5b8:bc5e:b58b with SMTP id
 2adb3069b0e04-5c1bc8a5ce0mr943348e87.67.1795183793942; Fri, 20 Nov 2026
 06:09:53 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111115729.253-1-yuzenghui@huawei.com> <CH8PR11MB40343305FD3C1BE0E18882B5CCFC7F2@CH8PR11MB403433.namprd11.prod.outlook.com>
 <20261113103709.13bfd3d6@foz.lan>
In-Reply-To: <20261113103709.13bfd3d6@foz.lan>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 15:09:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gYX0noVnrvPAc1fByGc6E-2bfK71=XJyH8P3CJ5rBGXg@mail.gmail.com>
X-Gm-Features: Aa3M54qUun4_k5Yw2hWekFBhyYG2GRUm8Rygn4vVViZsOsV-7nzPn16gmG9e_lc
Message-ID: <CAJZ5v0gYX0noVnrvPAc1fByGc6E-2bfK71=XJyH8P3CJ5rBGXg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Validate length of the Vendor Error
 Type Extension structure
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	"Luck, Tony" <tony.luck@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com" <guohanjun@huawei.com>, 
	"mchehab@kernel.org" <mchehab@kernel.org>, 
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"wangzhigang17@huawei.com" <wangzhigang17@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 10:37=E2=80=AFAM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> On Fri, 13 Nov 2026 00:27:20 +0000
> "Luck, Tony" <tony.luck@intel.com> wrote:
>
> > > The BIOS on my machine is obviously buggy (non-zero Vendor Extension =
offset
> > > pointing to zeroed memory, and bit 31 is not set in the error type ei=
ther)
> > > and needs fixing. I'm not sure if it is necessary to add such a sanit=
y
> > > check for EINJ at all.
> >
> > Production machine? Or just an internal development machine?  I.e. is t=
his broken
> > BIOS out in the wild for others to hit this bug?
>
> As a reminder, any VM runs with a BIOS that is not produced by an OEM, an=
d
> there are lots of production environments running VMs out there.
>
> So, I'd say that, if the fix is good, better apply it.
>
> From my side:
>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied as 7.5 material, thanks!
