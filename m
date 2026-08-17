Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C91442118
	for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976075; cv=none; b=jeFigPbyjHSuginOmDjHUurupUnGZH+8ocifEmZN4gjXy4ZEZN0DzQb9hIb+byd9Whn5W8kPw+3DcjSRmcmBD2wtKigFHxNqn+MhMRZ0BQK+fmBjuI+6HtjdVHp2e1xHK8J7oam1+kAIdiCBpYwFAlMv+iH7yv8jM7EoYpuFhhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976075; c=relaxed/simple;
	bh=9VkB3gSVKtFraDY680cwegvXjSao802zZYQhy+Kebts=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejUN//4nFKnV0qxPCeGcwEw2oHbHKVBwfRvdhF5jOa9zJMh1yRxdoJZqJx0eCYQL4xHsvoTWEDuIbfRnZO3V7hHv4/pT3KHRmn+ceuHBF7UABRF+2VheteG05AiaCCm7eOdVrfD/JWxeV158ng7CXpS5gMhEpoW4g3W7OSFhzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=bB7uY4sn; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="bB7uY4sn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1786976063; x=1787235263;
	bh=TnkMtvoCUXYG2VQXhJIB1IJgO5Y35pepzPmim5uedHI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bB7uY4sn7gq3YbXq/cj2UtV4bz+0l1X+0JYxpPes1sdIh0bqSfwbYVE8p5w0KZvXs
	 CqxzZANb1PIERYm68IOYH+riQc28tGW3QVtXQnjU+cilBDdNmrk8qSJlflW9D97II8
	 h0+iwZ85GKSGvLdlYkShILh1r/ZZMpvLHn3TbLlKYmZlTw2xDygI94kIHtZnwuULTI
	 gCuI4gY3whvn8XANOTZhq9KW2vS6Guu4SwDPF74fDGe28OEEymzSab9muzrQdjssbe
	 X0LNbwAxKQzPI/4KwQKbhs7VJlCn2dgGl492ieSCUZqM57LoZW28evUZ8VPoo/NCGG
	 MEk6OWkt4RZCA==
Date: Mon, 17 Aug 2026 14:14:17 +0000
To: rafael@kernel.org, lenb@kernel.org
From: Robin Everaars <robineveraars@pm.me>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch
Message-ID: <20260817141414.213075-1-robineveraars@pm.me>
In-Reply-To: <20260817133259.195548-1-robineveraars@pm.me>
References: <20260817133259.195548-1-robineveraars@pm.me>
Feedback-ID: 201127006:user:proton
X-Pm-Message-ID: 1e97f08003590c09b62f32dd91a33fda4801cd74
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------3d17667723df3c05b8354dadc90936a1dc3b44cd6cef5d78f24e7559dc421fba"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------3d17667723df3c05b8354dadc90936a1dc3b44cd6cef5d78f24e7559dc421fba
Content-Type: multipart/mixed;
 boundary=859407cf546d4304b8e67cdd514ca3fc548952c9b5062cf2b47f67ca9e4a
From: Robin Everaars <robineveraars@pm.me>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch
Date: Mon, 17 Aug 2026 16:14:14 +0200
Message-ID: <20260817141414.213075-1-robineveraars@pm.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817133259.195548-1-robineveraars@pm.me>
References: <20260817133259.195548-1-robineveraars@pm.me>
MIME-Version: 1.0

--859407cf546d4304b8e67cdd514ca3fc548952c9b5062cf2b47f67ca9e4a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The lid switch reports "close" but can miss the matching "open", leaving
_LID closed after resume. systemd-logind then suspends the system again
roughly every 35 seconds.

Reading the embedded controller's PSTA byte while _LID is stale shows that
bit 0x04 is set, which the DSDT treats as open. The DSDT returns the cached
LIDS byte from _LID. Its wake path aborts in RTEC on an unhandled
SystemCMOS region before copying PSTA to LIDS.

Initialize the lid state to open on resume, matching the existing quirk
for the Razer Blade Stealth 13 late 2019. With
button.lid_init_state=open, a physical close suspended once and resume
reported open without another suspend.

Signed-off-by: Robin Everaars <robineveraars@pm.me>
---
Changes in v2:
- Sorry for the noise. Proton's external OpenPGP/MIME signing inserted line
  breaks into v1, so its diff could not be applied.
- No code changes compared with v1.

 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)


diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 3836ee75dd66..cdbb1023a8ee 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -133,6 +133,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Razer Blade Pro 17 early 2020, notification of the LID device
+		 * only happens on close, not on open and _LID keeps returning closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Blade Pro 17 (Early 2020) - RZ09-0329"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{
 		/*
 		 * Samsung galaxybook2 ,initial _LID device notification returns
-- 
2.55.0


--859407cf546d4304b8e67cdd514ca3fc548952c9b5062cf2b47f67ca9e4a
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - robineveraars@pm.me -
 0x8B6BA132.asc"; name="publickey - robineveraars@pm.me - 0x8B6BA132.asc"
Content-Type: application/pgp-keys; filename="publickey -
 robineveraars@pm.me - 0x8B6BA132.asc"; name="publickey -
 robineveraars@pm.me - 0x8B6BA132.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRWFoOGxaUllKS3dZQkJBSGFS
dzhCQVFkQWFSa3p2ZTQ5ckJFSk1LSkg3NDZSWEhZKzJmVDc3b3hST2k1ZAo4SnBMKzY3TktYSnZZ
bWx1WlhabGNtRmhjbk5BY0cwdWJXVWdQSEp2WW1sdVpYWmxjbUZoY25OQWNHMHViV1UrCndzQVJC
Qk1XQ2dDREJZSnFIeVZsQXdzSkJ3a1FIY1YvYThzR0dvcEZGQUFBQUFBQUhBQWdjMkZzZEVCdWIz
UmgKZEdsdmJuTXViM0JsYm5CbmNHcHpMbTl5Wng2VjVxUzg5dzdDRFlTSXNjNU54dVBKSTFyZ29F
eVkvdjhkYlAzSApxa29OQXhVS0NBUVdBQUlCQWhrQkFwc0RBaDRCRmlFRWkydWhNcmIyWHVqRm5G
akxIY1YvYThzR0dvb0FBQVpzCkFQOXpJS1d3dWJDbEZFczBKNmpwUUhUS1hGVHErOTlNUmtmREtx
SVRidW1RelFEL1IyT2F6VHA0b0NKTzJiT0QKTkZsaVZBbTh5WFA2QSs1ODZ6UjJZS3QwUkFiT09B
UnFIeVZsRWdvckJnRUVBWmRWQVFVQkFRZEEzcDVGN2I1TwpGc1dLclNXRW1FSGlhL29lN25vLyta
MVcwT1BmZllyRFB5OERBUWdId3I0RUdCWUtBSEFGZ21vZkpXVUpFQjNGCmYydkxCaHFLUlJRQUFB
QUFBQndBSUhOaGJIUkFibTkwWVhScGIyNXpMbTl3Wlc1d1ozQnFjeTV2Y21ldlVkUisKViszVWd2
SVZqcURMRk9XeXlHcDVoNEpYQVBmWVpzRC8vUkhndlFLYkRCWWhCSXRyb1RLMjlsN294WnhZeXgz
RgpmMnZMQmhxS0FBQm9GZ0VBOGU0ZVNMU2FMbXY4L2UyVzFMOS9WS0FiajJaN0pFUzZLQXBpOUJa
Nm5RZ0JBTmhaCkZoTUZ6c3l6dTJZWXRhQjhTWXRWdGhKSjYvZUlRVFQ2VWRRRUlZc0YKPVlLaE0K
LS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQ==
--859407cf546d4304b8e67cdd514ca3fc548952c9b5062cf2b47f67ca9e4a--

--------3d17667723df3c05b8354dadc90936a1dc3b44cd6cef5d78f24e7559dc421fba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmqDFzgJEB3Ff2vLBhqKNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcE8ITHQCsP8TNkRllPDLDbFiEEi2uhMrb2XujF
nFjLHcV/a8sGGooAAE7JAQCdX5WileLA2M0BZWP/OEvnH4u4p2kh46WKZAjb
359HggD+N2nXarx2xySP+/4oAqqwReKK6hKaHLEyjQ9xBXmcHwQ=
=oxXL
-----END PGP SIGNATURE-----


--------3d17667723df3c05b8354dadc90936a1dc3b44cd6cef5d78f24e7559dc421fba--

