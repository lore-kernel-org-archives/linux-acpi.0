Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928A3932D5;
	Fri, 13 Mar 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404948; cv=none; b=eSem6RCb76VI3d4+6CZNiC62KJL97YRIgok+a3Yz59CbEXITDOX+kpi4OeeFe/dLr+Lfi/6+x2NC7ILfjnK2osula0bnNcsBfefZShkFKbUfzaaX5i968VVDaCB6DsSfDGsFq8LFzxr8pnuQkqB7c3aUTLLRJnHEfyx4oS2N6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404948; c=relaxed/simple;
	bh=NsHC0kNrAHdfS7pNUXaLvX1NpNaUrbNIEH2naPbfATA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCGrl0Iv05TWUgWoWKF9Vwr9fzVIOmBz9AGv3zd6stE+krkJpbTOSR9z3NAX9jlswrGuL10FLpCGw64t0gzZLTfDUaP8v7zBqgva1wKFBpgdeDrIEJBp9AxGSNKqA3dthj+nqXdLiiEfSRcmnCl1LcEWc6D+alDAxYruURd11k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BV51aAh7 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BV51aAh7"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6BDF140E01DB;
	Fri, 13 Mar 2026 12:29:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zujmNSO9K58C; Fri, 13 Mar 2026 12:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773404940; bh=XGInUvHstf/WRRJfGqlHPmb5HuivTBWzScQVQD4wc6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BV51aAh7DJl6lZdoc2T7gcetMenDZhHQ5YAnmAPzRkz611zOqUB6sodHXviFaCHBy
	 KPMk37G4izD6TeymC8j0nql9F2Fdt3kIZj0EVLyd+CcgdNrZ43oTOX47aq5O/wzUbK
	 a7RJOeKQe+FwfL4xJrsPeYgLvjL/z1JWYiTWBqu5fNd57rtnSzuwHH326Qtor4RrCb
	 d/E1EJ+2m4by4FEtqKVklxwgqObEvjbED9aM0LgfGXFkauMK6iNr1gvAA2ey6iFXzy
	 iRYnRXGPTCYQToltvu6OxboxPzp6JpP4Ci2hdeXrHFpHH0M8rozWE+fl97yBwvTL67
	 9YbZtZr+2SnndxSLUjmrquTfUXG3j6EJvliYOtczEVVkxOElzQIupjuuJLCmnbiOxF
	 W0PDy98Dzv/crx0D41RVj1Oe56m1oTkiHBVVAuE7haWvIhV9Rt3VrCOyOM2MaDAt31
	 /z0c3C99vsEKVtTN9r7wpebeiDMMDcmXGRrbTRY/XU9UBFHREtDjbIljy6oEHmF6Sv
	 w2a1YubmkS7NaK2KaxFxCDyRT9YEY7iZ+vuPtdA/mCpsjVulGFE2wZ5LrQFNJ8AMmu
	 /PyS69jMDhAeiVDASNP9hkYefVUmKu5RB54fdiSke7SwkGgIcsD/fiBvnbqHqvnnNA
	 A4MaG569JuByJhIJCLzxh4Ps=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0A61640E00DE;
	Fri, 13 Mar 2026 12:28:44 +0000 (UTC)
Date: Fri, 13 Mar 2026 13:28:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
	Kees Cook <kees@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] ACPI, x86/boot: Remove {set|get}_root_pointer() ACPI
 callbacks
Message-ID: <20260313122844.GBabQC_L7iROuslPNd@fat_crate.local>
References: <76675c4d49d3a8f72252076812ef8f22276230c2.1772282441.git.houwenlong.hwl@antgroup.com>
 <b5d7f0734005eb08f31e7b9b72e253efcd2614ab.1772282441.git.houwenlong.hwl@antgroup.com>
 <CAJZ5v0ibAwNi95giT5tF-7UvZ4SijneHkOtOB1d83SbjYLv4MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ibAwNi95giT5tF-7UvZ4SijneHkOtOB1d83SbjYLv4MA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 01:20:53PM +0100, Rafael J. Wysocki wrote:
> On Sun, Mar 1, 2026 at 6:05=E2=80=AFAM Hou Wenlong <houwenlong.hwl@antg=
roup.com> wrote:
> >
> > After removing pvh_get_root_pointer(), the only get_root_pointer() AC=
PI
> > callback is x86_default_get_root_pointer(). Move the implementation
> > directly into acpi_arch_get_root_pointer() and remove the
> > get_root_pointer() ACPI callback. Since the set_root_pointer() ACPI
> > callback is also only x86_default_set_root_pointer(), remove it as we=
ll.
> >
> > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
>=20
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

I'm assuming this means I should take this set through tip ... eventually=
?

:-)

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
