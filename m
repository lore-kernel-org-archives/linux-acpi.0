Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01923CB546
	for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2026 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973594; cv=none; b=OHIl+tFNbndumL+uBOI59c4QX6y4wTbjPnvzGSJpDbvA8VeR5yTVc1c7kYcjtRtqGrkiBP90/mb8lMvH55lEOy5FKa6AuOSufHSlO5GuAvTYcUHf0pz4ZTJQ2hGj/RTcXj4J0IZxT12MEwj5dSFg9aNieOpK29sK9SO1To+0v2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973594; c=relaxed/simple;
	bh=N8NRYZiAc0GbQ2ukRshSewRBt/14xXXjMLb1Z/jDpXs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=E9k3FD2mUUO2vhmOVwNV8gwgCWHXhX1jImeLlmOlhTvdaqx1LFOlch6X6y+IP4VZIN6iJMPWJ7W+life6VvXl5SsAHsU5EEzePaHXT051lGPDYFL9TnUBm0lk4vr8vjb82ewJz78LSMJR9vweK/cuTi7lDyU1pAiyTldfn8XeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PMeQjPkm; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PMeQjPkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1786973584; x=1787232784;
	bh=WB3HOqKozoDejGa9wrVapHPczcxLhbubRBpqXlPmjEE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PMeQjPkm+GhSbwiP3dfCHmQ6yOkQDbhhb5YCpyDQr0udShWJ3rSuGLSCorZi6JUyO
	 p+EKV7X/njAi2142M7roHxDY5qj5QpK+zqsG0cLMxKnnb7dDuoqmC9M0ti3TU6/2an
	 +I4kkSsyhjpqjnU3lL+yUY8TXUtO2208+Rq+UKk4mYfd8h2RgHnqvDa4hcSO/3mm73
	 Kkubxe9cxkvh5WznXRaEdI/7LEe7D5pimvBy2WGEylgQRyGLtvdI4qe+0J2rzj/yxo
	 dIFrEEJjtRNIvTFc+73ntDg1MkqB+rhztTKIJz00foQBwwZsoXbHEP/DnTdyl8rwV+
	 FTFRSVL6iaFIQ==
Date: Mon, 17 Aug 2026 13:33:02 +0000
To: rafael@kernel.org, lenb@kernel.org
From: Robin Everaars <robineveraars@pm.me>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch
Message-ID: <20260817133259.195548-1-robineveraars@pm.me>
Feedback-ID: 201127006:user:proton
X-Pm-Message-ID: 2d586b0d576ae593eae11fd74751b1cc12d569cf
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------d35936f088b00bad37c328ad8491ba16f8be77c1d9f6375b1cf05493e7159bd5"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------d35936f088b00bad37c328ad8491ba16f8be77c1d9f6375b1cf05493e7159bd5
Content-Type: multipart/mixed;
 boundary=8aa390150df785f36f3c4a75515b3e5faea93ae6cdde102fc861c7432563
From: Robin Everaars <robineveraars@pm.me>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch
Date: Mon, 17 Aug 2026 15:32:59 +0200
Message-ID: <20260817133259.195548-1-robineveraars@pm.me>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0

--8aa390150df785f36f3c4a75515b3e5faea93ae6cdde102fc861c7432563
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
 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 3836ee75dd66..cdbb1023a8ee 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -133,6 +133,17 @@ sta
tic const struct dmi_system_id dmi_lid_quirks[] = {
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


--8aa390150df785f36f3c4a75515b3e5faea93ae6cdde102fc861c7432563
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
--8aa390150df785f36f3c4a75515b3e5faea93ae6cdde102fc861c7432563--

--------d35936f088b00bad37c328ad8491ba16f8be77c1d9f6375b1cf05493e7159bd5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmqDDY0JEB3Ff2vLBhqKNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdLS+wD9jY1Jh+SD1STIjnuFiEEi2uhMrb2XujF
nFjLHcV/a8sGGooAAOkwAP4xSQ8lDcCcn+KlDgE0I3lnbXskomeO9930yM8f
R/stvgD+Oxsx8th9SuutS/U+J7RooJxpzZ7r3mfZ1HskzMyXHw4=
=y8u8
-----END PGP SIGNATURE-----


--------d35936f088b00bad37c328ad8491ba16f8be77c1d9f6375b1cf05493e7159bd5--

