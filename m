Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13285B21A;
	Sun,  5 Apr 2026 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775378849; cv=none; b=RlNq+BAbbFSaWITyGrTuM7ORolUm66MLSMYKYYpzHHSQISpjBxHFZeY+mngFtPDmx/WUko5/c2FE0tvG8vYt317slLdcxV6d8lSRflYHhd9A88cXMLGNzgcbWBw/2RN7w/JqXuaD1f+JRqxqIQ6IPioDva3pMSeH7nMNfTqXFfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775378849; c=relaxed/simple;
	bh=xup/4L3e2qPp/aUvvUEbGOmH6XGoWtlj4AuMiIDa/BI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/1u/9U0g7FtttFOnXjae9cas7HetH7SEWhuO9ZgrQmhooMjmjlKHq5C5w49tCoBRbQm1t/+oDx8BtABVjFeF1XJbztZHlCerR4d/fUWKbVgZjlwA9ghyscNZV/SA2E0roT+0HJSCNkC6h4ZDtcJ3nlypN/3op+jyi6lrxZMhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=dxIPGm54; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="dxIPGm54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775378824; x=1775983624; i=spasswolf@web.de;
	bh=mnnphBCM14k8Yb+sWdCawmQDPE5ygXLYYT3umDot31E=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dxIPGm54Flj3T7xktLF109HdJ69cTsaVtsV6yAbS1WDof/U/xFNgQUp/SenkKXD3
	 lXG7E2rmb24oPlyM3nNw8pnkLaO+0jeUBTv1k6cabVp7pGseZtMwyi9sa0cmJBxm8
	 mUKj/YugM0OKqOcbqihy+RZNCEihnPkaNj72G4mBXuD8oha5u2tNQCxTj9wiXO5g4
	 nMf8m3j7RigvxNRPkScbFw6hdBFAFPDtOhFATDJUIHgaGGRW4TJnyixSAJ4/L65bu
	 RoxoU67lXpQzXIOlZIqaYlLHmuCKbzsDvIFo78jsLkUgd+SYCgkU1CcKolrhkedkM
	 gSbwHzdEEzXNDdOLTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1vd0mk2yyc-00oUFQ; Sun, 05
 Apr 2026 10:47:04 +0200
Message-ID: <f5f4251da81752ccae59b6ffa158fd8587458431.camel@web.de>
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
From: Bert Karwatzki <spasswolf@web.de>
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, spasswolf@web.de, Nikolay
 Borisov <nik.borisov@suse.com>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, 	linux-next@vger.kernel.org,
 linux-edac@vger.kernel.org, 	linux-acpi@vger.kernel.org, x86@kernel.org,
 rafael@kernel.org, 	qiuxu.zhuo@intel.com,
 Smita.KoralahalliChannabasappa@amd.com
Date: Sun, 05 Apr 2026 10:47:02 +0200
In-Reply-To: <20260403140501.GCac_JDVCaX0eCIDUj@fat_crate.local>
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
	 <20260403140501.GCac_JDVCaX0eCIDUj@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4//ydYOsq11bE6CbPNODuTFldeOnWsndoBvj80SUtAT/iYBpzNY
 oDhfQ26zoUTjGES3ROnAayqPTNqG13pw6Ghe8/GyB7yy9/hS09pUPEcdysGoAbGSsosLHEK
 fjnWFbXfD9D/NijnPvabvOqPkOco1P/+DKgRksMBjQ5Geaq+83nj4W0raLOu9QvCqjOKQq7
 U8IChL7SQ1xuBk5YrePNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JNt5BTMpPoo=;F4LzUbN31WItTFxXg4lICeNJliS
 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

Am Freitag, dem 03.04.2026 um 16:05 +0200 schrieb Borislav Petkov:
> On Mon, Feb 23, 2026 at 04:53:16PM -0500, Yazen Ghannam wrote:
> > Thanks Bert for confirming.
> >=20
> > I'll send a patch to filter this signature.
>=20
> Bert, pls try this:
>=20
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Sat, 28 Feb 2026 09:08:14 -0500
> Subject: [PATCH] x86/mce/amd: Filter bogus hardware errors on Zen3 clien=
ts
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Users have been observing multiple L3 cache deferred errors after recent
> kernel rework of deferred error handling.=C2=B9 =E2=81=B4
>=20
> The errors are bogus due to inconsistent status values. Also, user verif=
ied
> that bogus MCA_DESTAT values are present on the system even with an olde=
r
> kernel.=C2=B2
>=20
> The errors seem to be garbage values present in the MCA_DESTAT of some L=
3
> cache banks. These were implicitly ignored before the recent kernel rewo=
rk
> because these do not generate a deferred error interrupt.
>=20
> A later revision of the rework patch was merged for v6.19. This naturall=
y
> filtered out most of the bogus error logs. However, a few signatures sti=
ll
> remain.=C2=B3
>=20
> Minimize the scope of the filter to the reported CPU
> family/model/stepping and only for errors which don't have the Enabled
> bit in the MCi status MSR.
>=20
> =C2=B9 https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
> =C2=B2 https://lore.kernel.org/6e1eda7dd55f6fa30405edf7b0f75695cf55b237.=
camel@web.de
> =C2=B3 https://lore.kernel.org/21ba47fa8893b33b94370c2a42e5084cf0d2e975.=
camel@web.de
> =E2=81=B4 https://lore.kernel.org/r/CAKFB093B2k3sKsGJ_QNX1jVQsaXVFyy=3Dw=
NwpzCGLOXa_vSDwXw@mail.gmail.com
>=20
>   [ bp: Generalize the condition according to which errors are bogus. ]
>=20
> Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
> Closes: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
> ---
>  arch/x86/kernel/cpu/mce/amd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd=
.c
> index 146f4207a863..7fc78759cd4e 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -606,6 +606,14 @@ bool amd_filter_mce(struct mce *m)
>  	enum smca_bank_types bank_type =3D smca_get_bank_type(m->extcpu, m->ba=
nk);
>  	struct cpuinfo_x86 *c =3D &boot_cpu_data;
> =20
> +	/* Bogus hw errors on Cezanne A0. */
> +	if (c->x86 =3D=3D 0x19 &&
> +	    c->x86_model =3D=3D 0x50 &&
> +	    c->x86_stepping =3D=3D 0x0) {
> +		if (!(m->status & MCI_STATUS_EN))
> +			return true;
> +	}
> +
>  	/* See Family 17h Models 10h-2Fh Erratum #1114. */
>  	if (c->x86 =3D=3D 0x17 &&
>  	    c->x86_model >=3D 0x10 && c->x86_model <=3D 0x2F &&
> --=20
> 2.51.0
>=20

I tested this patch on v6.19.11 and as these bogus messages are pretty rar=
e=C2=A0
I added a monitoring printk():

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 159f0becf8cc..54fa3863ea0b 100644
=2D-- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -608,8 +608,10 @@ bool amd_filter_mce(struct mce *m)
        if (c->x86 =3D=3D 0x19 &&
            c->x86_model =3D=3D 0x50 &&
            c->x86_stepping =3D=3D 0x0) {
-               if (!(m->status & MCI_STATUS_EN))
+               if (!(m->status & MCI_STATUS_EN)) {
+                       printk(KERN_INFO "%s: filtering bogus hw error on =
Cezanne A0\n", __func__);
                        return true;
+               }
        }
=20
        /* See Family 17h Models 10h-2Fh Erratum #1114. */

After ~12h of uptime I got the messages that a bogus error was filtered:
[42603.594231] [      C0] amd_filter_mce: filtering bogus hw error on Ceza=
nne A0
So the patch seems to work fine:

Tested-By: Bert Karwatzki <spasswolf@web.de>

Bert Karwatzki
