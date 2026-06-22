Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3437187F
	for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2026 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129694; cv=none; b=aLvVl7FA/+zCe/os5WXs0gVDWC6AatZ/QczbguoGPrR4WOJMLPYyB7Po3vuXJjA4eEg+bDiCS8j+jYO99pYFdLUH/SeLYssau1minrBW/H89TnkvxhofyYyjSGf6DdfeldvQAWigqlNqhzITVfHMJ+0SJpT2uGdW4LJR4t7REMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129694; c=relaxed/simple;
	bh=w06c/yEjW3DUOtwyWrE0AS+OGg0r41Ows2FCMuTL+dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWNHvHB+cgrNB12JMYHdPUPOuGB5sxjcZmXOVQLS316ylA0pp5x8bbNdeWXCd6nQmpsn7IwqrCk3rb+AZA1weGAwa6rCyNuUCKgqVX2s6LzH0Av2SNIfinCEwbLIIvNuIVWn4RMnfGzD9dP4EMipFLRsw8SsQxuJzS4BtxxhrO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cp1cLAx2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGSa7Ow0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cp1cLAx2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGSa7Ow0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cp1cLAx2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hGSa7Ow0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cp1cLAx2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hGSa7Ow0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A22F75A1E;
	Mon, 22 Jun 2026 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782129691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLYrrlUTwElRkEosQhItc0YYK/0FTyGYN4Ess53CiUo=;
	b=cp1cLAx2OgGlqJpkCvTFbV9hShgjUS1USyXNPKWjE9EF7eFqI2TKnoIw12eOsVIq5SZmkw
	iBiwt5qg1shHveiDmVJqHZW/qXUok5flIEkYME6Bb+CrJnrLFNviTXJMkSMD8onf6GmH+W
	DJdgsslTkldsZcpgbk3Hpjf95SUkAXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782129691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLYrrlUTwElRkEosQhItc0YYK/0FTyGYN4Ess53CiUo=;
	b=hGSa7Ow03F0nhFECiIY2e8SuStbXo2rEFkkOWALHE/hHy3eppXQDKc2WugzX7K4iODiN5v
	+QeBukr4IJLUYyAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cp1cLAx2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hGSa7Ow0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782129691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLYrrlUTwElRkEosQhItc0YYK/0FTyGYN4Ess53CiUo=;
	b=cp1cLAx2OgGlqJpkCvTFbV9hShgjUS1USyXNPKWjE9EF7eFqI2TKnoIw12eOsVIq5SZmkw
	iBiwt5qg1shHveiDmVJqHZW/qXUok5flIEkYME6Bb+CrJnrLFNviTXJMkSMD8onf6GmH+W
	DJdgsslTkldsZcpgbk3Hpjf95SUkAXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782129691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLYrrlUTwElRkEosQhItc0YYK/0FTyGYN4Ess53CiUo=;
	b=hGSa7Ow03F0nhFECiIY2e8SuStbXo2rEFkkOWALHE/hHy3eppXQDKc2WugzX7K4iODiN5v
	+QeBukr4IJLUYyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57E88779A8;
	Mon, 22 Jun 2026 12:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hdpEFBskOWr4TAAAD6G6ig
	(envelope-from <trenn@suse.de>); Mon, 22 Jun 2026 12:01:31 +0000
From: Thomas Renninger <trenn@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Kees Cook <kees@kernel.org>
Subject:
 Re: [PATCH] Revert "ACPICA: Replace strncpy() with strscpy_pad() in
 acpi_ut_safe_strncpy()"
Date: Mon, 22 Jun 2026 14:01:30 +0200
Message-ID: <2799887.obQ9GjlxrE@laptop.fritz.box>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To:
 <CAJZ5v0i5G00LX9a5+DiH=RfTEmCK39ZUhxk3pwTzimuc4==Ckg@mail.gmail.com>
References:
 <20260617075633.534689-1-trenn@suse.de>
 <CAJZ5v0hOZs3TMgdCc+cfK_TVbmDj6z=PTYcDmdqtrZWhHOHG+w@mail.gmail.com>
 <CAJZ5v0i5G00LX9a5+DiH=RfTEmCK39ZUhxk3pwTzimuc4==Ckg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2778970.sy0gbHreEd";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7A22F75A1E
X-Spam-Flag: NO
X-Spam-Score: -6.61
X-Spam-Level: 
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

--nextPart2778970.sy0gbHreEd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Thomas Renninger <trenn@suse.de>
Date: Mon, 22 Jun 2026 14:01:30 +0200
Message-ID: <2799887.obQ9GjlxrE@laptop.fritz.box>
Organization: SUSE Software Solutions Germany GmbH
MIME-Version: 1.0

On Sonntag, 21. Juni 2026 19:38:06 Mitteleurop=C3=A4ische Sommerzeit Rafael=
 J.=20
Wysocki wrote:
> On Wed, Jun 17, 2026 at 8:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > On Wed, Jun 17, 2026 at 11:25=E2=80=AFAM Thomas Renninger <trenn@suse.d=
e> wrote:
> > > This reverts commit 97f7d3f9c9acb70d4eef7bcdef3218823d142733.
> > >=20
> > > acpica has it's own safe strncpy function: acpi_ut_safe_strncpy
> > > and must not use kernel's strscpy_pad.
> > >=20
> > > Closes:
> > > https://lore.kernel.org/all/79e9e913-0fb1-4110-804b-c3b5d0edafe4@kern=
el
> > > .org Reported-and-tested-by: Jiri Slaby <jirislaby@kernel.org>
> > > Signed-off-by: Thomas Renninger <trenn@suse.com>
> >=20
> > Applied as 7.2-rc material, but I wrote a new changelog for it.
>=20
> And dropped because of
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?i
> d=3D1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
>=20
> The acpidump build breakage will need to be addressed in a different way.
>=20
> I'll take care of this next week unless someone beats me to it.

In case you agree with, you might want to take this one:
https://github.com/acpica/acpica/pull/1203/changes

Robert seem to have retired (his mail came back)? Please advise if one (I)=
=20
still have to add/push someone so that this all gets synced from acpica dow=
n=20
to the kernel.

Thanks,

        Thomas

--nextPart2778970.sy0gbHreEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEo0EXulPW3gW/5bAoTxjWwdl3vVUFAmo5JBoACgkQTxjWwdl3
vVU/xggAnEbYZ8P85burDtzt3K69koNRmKodu1v9RQGUt+a/h96M4Ux2CqYXy1iS
LfafStg0I3/Ig3RSI/Bxwh5ry70XW/4ta/+1lxzlRFcaH0nx13XeGdeJJKTabalb
jCJjbxLaf35iK63AIKqd2gNL/cfxkYsw7cblXyj0I2PFGAgcZ15NrMbuMsOudVCf
KkRiRm8ktAc+aNG6YlTh1GyI0jwMAynt7UcEEDvB5Vf9OgrJ+xJwqcuojKlt7oup
acZaCJr2asToodl6BG/Uf2awxFSVTN/c33f07YF1rywLKaofbRpwFtKkZGdrOopv
OBtezkY8xFIEH6mdGGiTbTJx0hvCzA==
=LZEc
-----END PGP SIGNATURE-----

--nextPart2778970.sy0gbHreEd--



