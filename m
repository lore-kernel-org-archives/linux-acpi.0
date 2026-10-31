Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793444460;
	b=TJBCVQX1naDgg3G5RJbmjTTdk5c09flWR5xEqTpNC9B5Ly5zONYYV+MNX2CDEiAzfhHh
	 W95Trbk1pUlx3QfxYpeLo/myW6tlPWqzhIBxRQSyG70EbC7AHeTST95oabyTTUIKN95RY
	 itbgJ555At+9uqGJ6jKgl1Ark+KZykAh6Cq97IATp7aQKat65rMn0kiI83f1/8vxEKQ4P
	 ZWCRbuX1Fa1pO2MzoDhAbErqzqCX0wyEnin+0BT7TV5bBdm0Hu4yI3DvV8SXvHNq5CnzO
	 rpOmh9v2RqGFlw8dXhoCLmACGibIaYljBDNKWZygwM+uvg/y/cnwJm3a+gxaSIA46+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793444460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bYKG5RgnATZ1B22wMaO0FmpK08dnO5PC7Iw5zWUVYBQ=;
	b=nLIfTUMFHZrcTa+Zb5SQXovVG+esOrTUdUxYgcB1LhZXNMdop6RqQteouOHqO6z1jUHv
	 HLO2/3gXZOoq5YEm3JMqrtadPuC865ZDh22lBmQEktTCf4D2E2I7Ceb4REZPEfTlGtmeC
	 F8QSdkgJvPgQlk+zZezCr4EgyOEJMdqnhqh7XgyNhR51Iw+rJ8GFZo7Ud7cmEnp3nJE32
	 WRpOcfYEbGzX9FY8GsrW27qw3krMZm1rs+IDYPMJnuDB2X8h1m0TbTsFZ4qPo4y4gXTtT
	 1pCe6+ZcnFwJsmz3pMrRWzqLdHc52fAm3HuNcR8yeuLcy+cKZhwPdnzgOBr4e98qWfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MALobg8B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF0606A31A;
	Sat, 31 Oct 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MALobg8B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA92F1F000C1;
	Sat, 31 Oct 2026 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793444459;
	bh=bYKG5RgnATZ1B22wMaO0FmpK08dnO5PC7Iw5zWUVYBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MALobg8Bu9F/3yIq/k9Mn82q/PkyNtskHEivWNnu2umOmma1+Vk+AdKxj95fgmhwt
	 xkBOG4pueys1OWzX9DTplvBKmEDT6JSDX97Ru1u8MAM9bJ5CJwTwygHqSJKPKtz5M5
	 RGCmcHZHH4gm9CXcm/HjV1G+JDFlnvom9ak/u0jN4IRDmdo0vVZykMd3VrOnkVYgLg
	 UZd+AtmsDO3CA5ASwp6SgbuUEor3uiKoyUJW79M4aGRY8dPBx68bsNcxYqz4mBBoZK
	 A3kL9dnsY1pW6dO1ao42KW2usn9KKtvYIgW8of2Jcpgf6U9Ip+VYaNezEtw+vozDIu
	 SmUJRu2qr1vfA==
Date: Sat, 31 Oct 2026 12:00:53 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, linux-edac@vger.kernel.org, Vikram Sethi
 <vsethi@nvidia.com>, Ashok Raj <ashok.raj@oss.qualcomm.com>, James Morse
 <james.morse@arm.com>, Len Brown <lenb@kernel.org>, Shuai Xue
 <xueshuai@linux.alibaba.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Breno Leitao <leitao@debian.org>, Ard
 Biesheuvel <ardb@kernel.org>, wanghuiqiang@huawei.com
Subject: Re: RFC: ACPI code first proposal, _OSC to negotiate use of Memory
 Section 2 CPER.
Message-ID: <20261031120053.0141d7ab@foz.lan>
In-Reply-To: <20261030143802.0000231d@oss.qualcomm.com>
References: <20261030143802.0000231d@oss.qualcomm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Oct 2026 14:38:02 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Hi All,
>=20
> In the discussion of Pierre's patch #1 the question of how a firmware
> could know to send the newer Memory Error Section 2 CPER rather than the
> older record given it currently has no way of knowing what the OS support=
s.
>=20
> Having discussed the problem inside Qualcomm, we can to the same conclusi=
on
> as in Pierre's thread - an _OSC is probably the easiest way to solve this.
> Andrei then drew up a code first ECN proposal.  The text is below, tweaked
> for plain text rendering. Link to proposal #2
>=20
> Please draw the attention of others to this. Feedback welcome either on
> this thread, Pierre's thread or directly on the tianocore ticket.

This sounds to be the best approach on my eyes.

>=20
> thanks,
>=20
> Jonathan
>=20
>=20
> # Title: OS support for CPER Memory Error Section 2 records
> ## Status: Draft
> ## Document: ACPI Specification Version 6.6
> ## License: SPDX-License-Identifier: CC-BY-4.0
> ## Submitters: Qualcomm
>=20
> ## Summary of the change
> Reserves an additional Platform-Wide OSPM Capability bit to negotiate sup=
ported CPER
> record format for Memory Error Section (older MES vs newer and richer MES=
2).
> Memory Error Section 2 records are defined in UEFI 2.11, Section N.2.6 (A=
ppendix N, page
> 2171).
>=20
> ## Benefits of the change
> Memory Error Section 2 (MES2) records were added in UEFI Specification 2.=
11, yet no
> mechanism to negotiate OSPM support for the new record type (Linux kernel=
 support is still
> being added upstream at the moment).
>=20
> This change proposes using a new Platform-Wide OSPM Capability to negotia=
te between
> firmware and the OS for enabling the new format. Until the added _OSC bit=
 is reported by
> OSPM, the older Memory Error Section records will be used. Although this =
means a platform
> may in practice have to support generating both record formats, this is s=
een as a better than
> always emitting old- and new- style records which would leave the
> deduplication/reconciliation up to OSPM.
>=20
> ## Impact of the change
> Platform firmware should only generate CPER MES2 records if OSPM declared=
 support for
> MES2 records. Otherwise, platform firmware should only generate the older=
 MES records.
>=20
> ## Detailed description of the change [normative updates]
>=20
>=20
> 6.2.11.2 Platform-Wide OSPM Capabilities
> =E2=80=A6
>=20
> Table 6.13: Platform-Wide _OSC Capabilities DWORD 2
> +---------+--------------------------+-----------------------------------=
---------------+
> | Bits    | Field Name               | Definition                        =
               |
> +---------+--------------------------+-----------------------------------=
---------------+
> | =E2=80=A6       |                          |                           =
                       |
> +---------+--------------------------+-----------------------------------=
---------------+
> | 22      | Functional Fixed         | The OS sets this bit to indicate s=
upport for     |
> |         | Hardware                 | the usage of Functional FixedHardw=
are            |
> |         |                          | (FFixedHW) OperationRegions.      =
               |
> +---------+--------------------------+-----------------------------------=
---------------+
> | 23      | CPER Memory Error        | The OS sets this bit to indicate s=
upport for     |
> |         | Section 2 Support        | MES2 CPER records. If not set, OS =
support for    |
> |         |                          | older CPER MES records is assumed.=
               |
> +---------+--------------------------+-----------------------------------=
---------------+
> | 31:24   |                          | Reserved (must be 0)              =
               |
> +---------+--------------------------+-----------------------------------=
---------------+

My only concern is that it may run out of bits soon if we use those
for each new incompatible types on CPER records.

>=20
> [1] https://lore.kernel.org/all/20261019203915.2019037-1-pierre.gondois@a=
rm.com/
> [2] https://github.com/tianocore/edk2/issues/13430
>=20
>=20



Thanks,
Mauro
