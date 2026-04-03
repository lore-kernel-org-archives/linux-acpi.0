Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726E3ACA77;
	Fri,  3 Apr 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225123; cv=none; b=GW2Z3tmBZZagj/hmq2hrJnGpL+U6ud1389IBEPjbqPkqF608XoFpwz8AcOICrGZdYdmQgmmcWeJ6kAGHxsmKFQG3Dc8DMe5GXkwZKYe0LiGyu8hoaH3zaD/8syqutER6lvsrTQ0TnKxZepMJQv0pqmSabYWiellHbipmFsrl980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225123; c=relaxed/simple;
	bh=ACyD9VPlxH4DuZr6Xy0SSxZORID6JjdVrt9U7rl1ID4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRlvA2mtZWctC1iBzFt2/osuhgJBIvA+coDngE+p+ekd+n+NHe1ztmsMTi6shsf8yd4MVqquCqEn27aw69ftkpseDJSaLsTrTAIY4FpmSX4VvXHeG295Fg2EP8BtSkE5vECGJYr7b4OvipOIpPlmc79+24HhC8KixzFKiqYIjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T8P+nj2z reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T8P+nj2z"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B94C440E0031;
	Fri,  3 Apr 2026 14:05:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AkY9n7tBmiH2; Fri,  3 Apr 2026 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1775225115; bh=3LzBlPp578dQdg5dxIS/Ahl9D0iuA9KuJ3bxld0SUkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8P+nj2zV5MZpoafA7H3AEuEZRNVxK590h0oDNGndJaqm3tvoQtWDqYk2aZxw5L2z
	 t8+4GqKWqguN5EyIiJPGX9u4Y+A6LtkPxtPVnnr24KfW/ViBQaF/xC0dsqnQccH02g
	 bUmzmvB5viRmm5ztIPLrtM2RnN74jr/ikCuVqVXlfZLDgMIso1LUMXX0K7d6SY+iBU
	 b4VIiP3caU0mStR/7W8d8UPieGID+1mnkyWny3wLykRjvLDYQmvDTLYJkVddoMb4fo
	 Rp/SexBGUKbGP3YqxpBXvIwWhD353BmfaGA7G8OEmdDkFZrYEY7nKKbFwyn5Mb+GWr
	 rPm19DMNFw9Qy9yTGB5uQn0yFBs8Hc15fASHtKASpw1+56Qd0h3hIlvhRr4txJOnwj
	 LDGZlsgmJYrv8h+RXlAIDolTqMD54ppsDMNRUQjR+T01KQ3/coY/E+R+/xcv4q8YRG
	 pxj351To4xQBy8n2NEm3JL8KpY1daSyulnYVGFppn7GsEmpZaUVenTVA8OxNdv4ON4
	 XCdotH9Ah88PFnzi/EPEvyj4mb/6iL8Bv3nFPA5Pn8BlpGDKtfCh7WQTe+WxjiQn58
	 00vDg4r1VCFwPGukyP8mjNS3HtihI7aiWnmtNSQqQk7ssAXHjqv9RahCebYo8AmfAw
	 EtNZqPtD50MEsw5H8lDruDxc=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 62C9440E00DE;
	Fri,  3 Apr 2026 14:05:02 +0000 (UTC)
Date: Fri, 3 Apr 2026 16:05:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
	qiuxu.zhuo@intel.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
Message-ID: <20260403140501.GCac_JDVCaX0eCIDUj@fat_crate.local>
References: <20250918210005.GA2150610@yaz-khff2.amd.com>
 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
 <20251009132055.GA472268@yaz-khff2.amd.com>
 <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
 <20260216202546.GA420258@yaz-khff2.amd.com>
 <20260219143345.GA5486@yaz-khff2.amd.com>
 <4e0c5a7ce9f1ab35eaec2c2908df3681ce6eda4d.camel@web.de>
 <8530d765-6676-4ba4-98b5-07326c8dc924@amd.com>
 <290ee50cbe68d246a9899b03d5c7ddebc549f0bf.camel@web.de>
 <20260223214825.GA3130@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223214825.GA3130@yaz-khff2.amd.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 04:53:16PM -0500, Yazen Ghannam wrote:
> Thanks Bert for confirming.
>=20
> I'll send a patch to filter this signature.

Bert, pls try this:

From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Sat, 28 Feb 2026 09:08:14 -0500
Subject: [PATCH] x86/mce/amd: Filter bogus hardware errors on Zen3 client=
s
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Users have been observing multiple L3 cache deferred errors after recent
kernel rework of deferred error handling.=C2=B9 =E2=81=B4

The errors are bogus due to inconsistent status values. Also, user verifi=
ed
that bogus MCA_DESTAT values are present on the system even with an older
kernel.=C2=B2

The errors seem to be garbage values present in the MCA_DESTAT of some L3
cache banks. These were implicitly ignored before the recent kernel rewor=
k
because these do not generate a deferred error interrupt.

A later revision of the rework patch was merged for v6.19. This naturally
filtered out most of the bogus error logs. However, a few signatures stil=
l
remain.=C2=B3

Minimize the scope of the filter to the reported CPU
family/model/stepping and only for errors which don't have the Enabled
bit in the MCi status MSR.

=C2=B9 https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
=C2=B2 https://lore.kernel.org/6e1eda7dd55f6fa30405edf7b0f75695cf55b237.c=
amel@web.de
=C2=B3 https://lore.kernel.org/21ba47fa8893b33b94370c2a42e5084cf0d2e975.c=
amel@web.de
=E2=81=B4 https://lore.kernel.org/r/CAKFB093B2k3sKsGJ_QNX1jVQsaXVFyy=3DwN=
wpzCGLOXa_vSDwXw@mail.gmail.com

  [ bp: Generalize the condition according to which errors are bogus. ]

Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
Closes: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
Reported-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
---
 arch/x86/kernel/cpu/mce/amd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.=
c
index 146f4207a863..7fc78759cd4e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -606,6 +606,14 @@ bool amd_filter_mce(struct mce *m)
 	enum smca_bank_types bank_type =3D smca_get_bank_type(m->extcpu, m->ban=
k);
 	struct cpuinfo_x86 *c =3D &boot_cpu_data;
=20
+	/* Bogus hw errors on Cezanne A0. */
+	if (c->x86 =3D=3D 0x19 &&
+	    c->x86_model =3D=3D 0x50 &&
+	    c->x86_stepping =3D=3D 0x0) {
+		if (!(m->status & MCI_STATUS_EN))
+			return true;
+	}
+
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
 	if (c->x86 =3D=3D 0x17 &&
 	    c->x86_model >=3D 0x10 && c->x86_model <=3D 0x2F &&
--=20
2.51.0


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
