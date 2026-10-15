Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61434D6C20;
	Thu, 15 Oct 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065508; cv=pass; b=RAgJet9s23KNpUzknJqkW0DLnDI5zKNjJaX73SOB2rXuS4llUkgKQQxyR8u5mGmoA2pgPuKu1nRHSPHsn6IVuLHyeW5/Hbgqo8gl1SL2NzbA4USvm1HpgmIYuJykUy0tWrKNfuqY1r66UGSjUEVTYW0ka1yd47ThPsxsDjZTbIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065508; c=relaxed/simple;
	bh=ZQjnLF1YwrB2ataqUQ1gNLQBjQgVRrLmuxGJ+kShVJU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gDRdkmVo4rtsfZzQvchO4UcuDgGJhZ+eYin3Uyr1oUeXIPJHTSEIIFpIYebmpGl7Tp00Vn3mhq6vGI8tK4PLyi33IxA/5H/6avoKugbldMtgm9F6qN8u3RxHeND6/EvRE2ZWwjsc1oTiqgfJ1XrzBH0QVo6rwNzrj7VIQnd1Q7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=ZInmAsFG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="ZInmAsFG"
ARC-Seal: i=1; a=rsa-sha256; t=1792065480; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ai9eX4qBYHOVgw9CLvJ4GF3lh1vQx9N257ohG5l0skYj233gMLHx3YurcJLtQ0jdbN94cLT/ddhboCFCRbgJFW7LKoa7gBTVSAdbTI6QdTYk7vG4N4ZS5eotyzTzBsKsm7x3BTMUUYwxEXjJbb2lhOjkga1nWK+Kl4tJXdNBXoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792065480; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LUx1dLxAkaPBqPMUqfHWgH9b0YKDCw02ZjGIlKa+O5M=; 
	b=FuCEueIQuuACnn+XAygeDXL3zniTimu+czRPaTqGzOa9t7eAogiTiTzT2dHpJLt3JXyR+qJPSqQXZuxNoJaV7YXj/DuI5ndgO0HwvGjVWY7adDpwDFBkMgFzQ7pWHzq52PHTRYI8qff5KjxXapc3Fy970vxBqDIZGjvevtN6u4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792065479;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=LUx1dLxAkaPBqPMUqfHWgH9b0YKDCw02ZjGIlKa+O5M=;
	b=ZInmAsFGhHFW5CGIfXK5qlTENek1oV6GWB8oLpfAeI0I3eQyFB96NjKwPq068qMw
	tE5WUFYCqPYKtNtKKPsARG7ALrqqkihq3XuHcaiT3/PEwIH1K1zljQt3GTSzIY51okp
	Lwz3PTkIYpD0zYnugpv2JfKQGzVMrtTkNmX748+WUYIHQUhmdTRnsnDOMmki76NRlyd
	bAY44pMgzkQ6t789D8nu+WjlFqwM9RR3+y5S+ItU0P8d1TK80OdtGC71hlccCWftdCD
	EA3mDcEhcYpv3kC4zIJYflj+Fa0ofhUYAHH/2Qvb5yjlrSPHlHfB3UWiZGObMK4KBJL
	GUJKimA8ow==
Received: by smtp.zohomail.com with SMTPS id 1792065477586319.75322492405417;
	Thu, 15 Oct 2026 04:57:57 -0700 (PDT)
Message-ID: <134e9482ec396787d6aaf079729c49106ee45286.camel@rong.moe>
Subject: Re: [PATCH 0/4] ACPI: Serialize EC queries, UCSI and ideapad
 methods
From: Rong Zhang <i@rong.moe>
To: Ali Ahmet =?gb2312?Q?Memi=810=946?= <aliamemis@disroot.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Ike Panhc	
 <ikepanhc@gmail.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, Avraham
 Hollander	 <anhollander516@gmail.com>, Jeffrey =?ISO-8859-1?Q?W=E4lti?=	
 <jeffrey@waelti.dev>, Rick <rickk1166@gmail.com>,
 linux-acpi@vger.kernel.org, 	platform-driver-x86@vger.kernel.org,
 linux-usb@vger.kernel.org, 	acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261014190544.150093-1-aliamemis@disroot.org>
References: <20261014190544.150093-1-aliamemis@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 19:52:33 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Ali,

On Wed, 2026-10-14 at 22:04 +0300, Ali Ahmet Memi=C5=9F wrote:
> This goes on top of [1] and uses its exclusive helpers for the other
> users of the shared EC mutex in bko221065: the _Qxx methods, the UCSI
> _DSM and the ideapad-laptop methods, as discussed in [2].

Please rephrase the cover letter and the commit messages according to my
analysis in the other series.

>=20
> Patches 3 and 4 depend on patch 1 and on [1], so it is probably easiest
> to take the whole set through the ACPI tree.

I don't really see the necessity of sending the two series individually.
It just made things more complicated. It'd be better to send a v2 merging
them into a single series. Once ready, each maintainer will do a subset
apply or leave an Acked-by: tag to permit applying through another
subsystem.

>=20
> The ideapad part is only build-tested, so it would be great if someone
> with one of the bko221065 machines could try both series together.
>=20
> [1] https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.=
org/
> [2] https://lore.kernel.org/all/8be1a245-6061-4f86-9223-0da18d5e423a@oss.=
qualcomm.com/
>=20
> Ali Ahmet Memi=C5=9F (4):
>   ACPI: utils: Add acpi_evaluate_dsm_exclusive()

With both series merged together, you don't need a separate patch for
acpi_evaluate_dsm_exclusive() either. It can be merged into "ACPI: utils:
Add exclusive AML evaluation helpers".

>   ACPI: EC: Evaluate _Qxx methods exclusively
>   usb: typec: ucsi: acpi: Evaluate _DSM exclusively

Based on my analysis, EC queries and UCSI _DSM are just innocent victims
of the ABBA deadlock.

If solving bko221065 is the only reason why they are included in the
series, PATCH 2 and 3 are probably needless.

>   platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
>=20
>  drivers/acpi/ec.c                            |  7 ++-
>  drivers/acpi/utils.c                         | 54 +++++++++++++-------
>  drivers/platform/x86/lenovo/ideapad-laptop.c | 21 ++++++--
>  drivers/usb/typec/ucsi/ucsi_acpi.c           |  8 ++-
>  include/acpi/acpi_bus.h                      |  3 ++
>  include/linux/acpi.h                         |  8 +++
>  6 files changed, 76 insertions(+), 25 deletions(-)

My comments to the other series also applies here. Please resolve them
here and there.

I will defer my tags for this series to v2.

Thanks,
Rong

>=20
>=20
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> prerequisite-patch-id: 4bd123d6caded06beb9a977d502370df046f82aa
> prerequisite-patch-id: 19de145660fffa3651defed4e6d536cb78418940
> prerequisite-patch-id: 01d8992be9ebc2b28dd3986fe06269eb2fe959f5
