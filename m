Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE9355F5F;
	Wed,  3 Jun 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497767; cv=pass; b=CX3pQ0leB9IbE2EoAuwm3kkMwMWcTbw/Sxa4EvB24/8GP6Z7PrlpupQdc4A8MMFgo5swfbM+rPE7nuTD06h1a9WudbM7Vrwl1+nJihGAqIq6JcdMirnHhuVxSmp96SgHTxKNquVIyh1pcqA3c5O7jj+muOdi6q7k6Yu5h0wdFGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497767; c=relaxed/simple;
	bh=goz8yLeo9gG5v3dsdArKbkhWjXvMBsuRDJ3GYNbH/2M=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UKw5+Asi+ph/fCvZvW4O8z9Twxj/5lPVlqhnPSuNWQAnfkHGie0MBIZ3JPJu4QaZPZaV/iM6a5iyAffHwpmDXxMXhXbPXCxZhMsDnAIsE/3vVQy+DEzP+jDoExB74c82byr7WC3clA+owERzvCY0EtuGT75LghuHwx934AjjDVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=p/yP31Yv; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="p/yP31Yv"
ARC-Seal: i=1; a=rsa-sha256; t=1780497739; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dt05ZuF70sVD7pzvX4aqeviJ6Jbvyn+daqW0L7CWCVzTE6FLbRNUyKBnMwcpACeQgxV2fv8Y5yrHhEEu/QqCZm12gW7iezb+BMVs6JScNNfKzLd9dZM9cr2fzjL48XazQvj/w7TR6mNf/mJQSmVycP3u6csr0LAK/clR8VYUH2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780497739; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SQ9n31AEK2Oq0UoNRbUbsBFKNQI/E8NaEPAXNEGfybY=; 
	b=aObBDRrfsChNg9PaqGyvysc2Gf2eIKEItfdI5tJVhCSCkffKWGKQ0pccaZuDqvq38F6IuTKKuRKbjROHdiwRP6a77Zq6AIDeqHXiFHQ00wr3+MKzGjAIzFqvgZ1czC22ewgxqagdP1gP8Li7s5YL5hrNi5BmGYMyNrJ0iTL2Qh4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780497739;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=SQ9n31AEK2Oq0UoNRbUbsBFKNQI/E8NaEPAXNEGfybY=;
	b=p/yP31YvoWSgclYDOnnTrT5i3W6fSadwrVoMwYcpSgxgMmPnl+SJjQFOQ5Fxz4U1
	cvt4AQEM9azldnrpPTUwuAvRUu3ly2k0m/+mjUXkJMbgLUbvOcQJYt5RYj1OhNW7Cw/
	cXHFSIWNDtLq2rpVWvviDMbZdyCttc4HnN0/YmFYJYgzmsneG/bhWGuksIe1yzd6T+J
	4Dj0Z3S8+I4+uvX5eeCels6pRWHNIc0uZDb4Wk+9A7vy55mOUNrQv6/AQ8Wo3UvnBpL
	D1rzeae9fX7PObRMYIe1unnzXkZtE15B/rSG6OhI9/kBtqDOk+ZMHzJFE/JALPgDICm
	16b24eUO8g==
Received: by mx.zohomail.com with SMTPS id 1780497736618955.0272782729544;
	Wed, 3 Jun 2026 07:42:16 -0700 (PDT)
Message-ID: <db42e87bb1404578f33b2c921bc69af73a33c9a8.camel@rong.moe>
Subject: Re: [RFC PATCH 0/3] ACPI, x86/cpu/amd: Parse S5_REST_STATUS from
 ACPI PHAT on supported AMD platforms
From: Rong Zhang <i@rong.moe>
To: K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov
 <bp@alien8.de>,  Mario Limonciello <mario.limonciello@amd.com>, Yazen
 Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, Thomas Gleixner	
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: Vilas Sridharan <Vilas.Sridharan@amd.com>, "H. Peter Anvin"
 <hpa@zytor.com>,  Andrew Cooper <andrew.cooper3@citrix.com>, Mikhail
 Paulyshka <me@mixaill.net>, Kai Huang <kai.huang@intel.com>
In-Reply-To: <20260603063317.13665-1-kprateek.nayak@amd.com>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 22:37:08 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 
X-ZohoMailClient: External

Hi K Prateek,

On Wed, 2026-06-03 at 06:33 +0000, K Prateek Nayak wrote:
> x86/cpu/amd bits uses the FCH register to read the S5_RESET_STATUS which
> is known to be inaccurate on some configurations where the firmware can
> consume the status before the OS boots.
>=20
> Vilas and Yazen noted that the ACPI PHAT table has a read-only shadow
> copy of this state and is the preferred way for OS to consume the S5
> Reset Status.
>=20
> Introduce generic helpers to parse ACPI PHAT records and use the
> platform specific helpers to interpret the vendor specific reset reason
> records.
>=20
> Since these records are read-only, the status cannot be cleared once
> consumed and the last reset reason will persist across kxec until next
> reset which reintroduces the case prevented by commit e6416c2dfe23c
> ("x86/CPU/AMD: Prevent reset reasons from being retained across reboot")
> by clearing the FCH register once consumed.

It's not only about kexec.

The last reset reason register could remain unchanged when the reset is
caused by a voltage drop on a power rail, probably due to a broken power
supply or VRM. This wasted me a lot of frustrating time debugging
irrelevant reset reasons.

Eventually, I RMA'd the broken device and submitted the patch to save
other's time.

Also, some bits are not cleared by hardware as per [1]. If the firmware
doesn't clear them either they will persist anyway.

So I'd prefer clearing the register in any cases.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537#attach_303991

Thanks,
Rong

>=20
> This can be avoided with a boolean flags passed over as setup data
> during kexec but this scheme adds unnecessary complexity in
> implementation that has been left out for now.
>=20
> Patches are based on:
>=20
>   git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi
>=20
> at commit 3109f9f38800 ("ACPI: button: Add missing device class clearing
> on probe failures") (tag: 'acpi-7.1-rc6')
>=20
> Series has been tested on both, a Zen4 platform that does not contain
> the PHAT record, and a Zen5 platform that contains the PHAT record.
> The Zen5 platform was also tested with CONFIG_ACPI_PHAT disabled to
> confirm that logic correctly falls back to reading the FCH register.
>=20
> x86 folks have been Cc'd only on the Cover letter and the x86 bits. ACPI
> folks, my fellow AMD colleagues, and the lists should have received the
> entire series. If you would like to be Cc'd on the full series for
> future posting, please let me know. Sorry in advance for any oversight!
> ---
> K Prateek Nayak (3):
>   ACPICA: actbl2.h: ACPI 6.5: PHAT: Add more struct definitions
>   ACPI: PHAT: Add generic helper to parse PHAT records
>   x86/cpu/amd: Fetch S5_RESET_STATUS from PHAT when supported
>=20
>  arch/x86/kernel/cpu/amd.c |  34 ++++++++++
>  drivers/acpi/Kconfig      |  11 ++++
>  drivers/acpi/Makefile     |   1 +
>  drivers/acpi/acpi_phat.c  | 133 ++++++++++++++++++++++++++++++++++++++
>  include/acpi/actbl2.h     |  14 ++++
>  include/linux/acpi.h      |  14 ++++
>  6 files changed, 207 insertions(+)
>  create mode 100644 drivers/acpi/acpi_phat.c
>=20
>=20
> base-commit: 3109f9f38800841e46769e95e1ba11f1f8c7b230
