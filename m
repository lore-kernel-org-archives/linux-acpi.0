Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDD44A739
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292706; cv=none; b=CJl+agXNfGajZITdINOwyHso/om7xDL7xrP/KlVfRvF3qTHNuiDJZulPzlGD2FMKi4S0haffjV3pLBLJmGOG0WS/JZMvuXIES49j83xH+Q7Zhx3wzYVxeE6pa0bzZ/dPmiccdTDu0LEV4EBY6WvprYvvGRROuFOtedr81v0++Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292706; c=relaxed/simple;
	bh=qZso5+tzWQHCXky+7guPOq3xtLsdo7VjIUMsEHMspys=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChD0j68Agusafv1YkWFNW8wrETQP0gmT4wQ1RuntUWmro5LGjPtigQNbHQoNjVQXUioqQX1TTR7Kru0Z3FjR8WPG/d3IvAAx1o8qMQKIgydKwbtj9/3kH9v09xAuFvllvlZVNFJRDcBP7UKRjsfB2znXGdJJOh8xqVA0s44rs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=BMGIp88V; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BMGIp88V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772292697; x=1772551897;
	bh=zRSTQhcmXP9RiVFEmAv2f/Ks0Imx0oUxm39MAKJZDSI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BMGIp88V64xTpoQJRvPUDUzF3XyzavQCBSNXNq8cOpOAhQ04p7UWmK/3b5CgOnxRm
	 bzxJnxaL7oqADGeWZin574gzIpUbLNoqj1viOHRB1EnjusI4LlyGZn5JNqooxn4MZc
	 KBytl7mo6RjPy7g4IudBjfY8z/x0bH7nJ55mgtolKEKfw3cu4esTsnfs5Mhc3bLcQe
	 eAGOlkIFlag60LDXpjHUREY+pNrsnq807NmGTXdyKbafNIqQk10BdM7szNFUap6rFs
	 6ikyjQ1cAebjyhGOzcjsCwR41kFusWRF8o5pJQqKkQ1AEsz96gC95a4Z81A9JSSLgM
	 HiC5Eb+tNYHVQ==
Date: Sat, 28 Feb 2026 15:31:33 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: Athul Krishna <athul.krishna.kr@protonmail.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "superm1@kernel.org" <superm1@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, "bp@alien8.de" <bp@alien8.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Suspend broken on 6.19.4
Message-ID: <lA7Dz_m7_nCF8KkRyEOcSCLg799Mm9_DN2r9hx7ISjw32OoKiB1r_YjGHIFX8vgqxpOkVJ8d_yHb-VsGAvIWC942D4-zdWxAIP4_k6ZIQi8=@protonmail.com>
In-Reply-To: <CAJZ5v0gL1=m6j5r3ZAp61nmwBb+wd2Y9zPSv=a=NQem5XiZMCg@mail.gmail.com>
References: <aW3d4B3xMwe-pyzJwFnM7q4q5WjOjAajU2c6gk65arrBx5-soWv9AAZPzZHxAiX1XOxILELauRQdnxGxMectmmW76xfxyQyErVEH8nR_iyw=@protonmail.com> <CAJZ5v0gL1=m6j5r3ZAp61nmwBb+wd2Y9zPSv=a=NQem5XiZMCg@mail.gmail.com>
Feedback-ID: 97021173:user:proton
X-Pm-Message-ID: 9804cc3601cb3f13d993c3f6ec85fad774740e4b
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, February 28th, 2026 at 7:21 PM, Rafael J. Wysocki <rafael@kern=
el.org> wrote:

> On Sat, Feb 28, 2026 at 1:40=E2=80=AFPM Athul Krishna
> <athul.krishna.kr@protonmail.com> wrote:
> >
> > Device: Asus Zephyrus G14 (GA402RJ)
> > CPU: Ryzen 7 6700H
> > iGPU: Radeon 680M
> >
> > Problem: Suspend broken on 6.19.4. On closing the lid or systemctl susp=
end, screen turns off but device does not fully power down.
> > No obvious errors in dmesg except:
> > [  219.151441] amd_pmc AMDI0007:00: Last suspend didn't reach deepest s=
tate
> > [  219.164301] ACPI: EC: interrupt unblocked
> >
> > Bisected:
> > commit 6cfed39c2ce64ac024bbde458a9727105e0b8c66
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Tue Dec 23 18:09:11 2025 +0800
> >
> >     ACPI: processor: Update cpuidle driver check in __acpi_processor_st=
art()
> >
> >     [ Upstream commit 0089ce1c056aee547115bdc25c223f8f88c08498 ]
> >
> >     Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
> >     driver registration") moved the ACPI idle driver registration to
> >     acpi_processor_driver_init() and acpi_processor_power_init() does
> >     not register an idle driver any more.
> >
> >     Accordingly, the cpuidle driver check in __acpi_processor_start() n=
eeds
> >     to be updated to avoid calling acpi_processor_power_init() without =
a
> >     cpuidle driver, in which case the registration of the cpuidle devic=
e
> >     in that function would lead to a NULL pointer dereference in
> >     __cpuidle_register_device().
> >
> >     Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle dri=
ver registration")
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >     Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >     Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
> >     Link: https://patch.msgid.link/20251223100914.2407069-4-lihuisong@h=
uawei.com
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > Reverting the commit or downgrading to 6.19.3 resolves the issue.
> > Attached dmesg and lspci.
>=20
> Is this problem also present in 7.0-rc1?
>=20
Nope, not an issue in 7.0-rc1 (7.0.0-rc1-00286-gaed968f8a6cd).
