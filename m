Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D891C19D89E;
	Fri, 24 Apr 2026 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993776; cv=none; b=RaUJs7zxIC2ixZEgsQ3lCH/jWuVUOQ+sRRY7BGIfY6YKGf1QupBKSxvC89QunhrB5UVDFgqVZgEHIwURXvyHcvUPhai1aC/eKWmZCoPw+rU2BMy7AL32ZyuSPwuQA50l6Ctgb7jgrdGgTe+jby7QUXGEt/4sDEHEEt5j/1A6NMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993776; c=relaxed/simple;
	bh=HnzfGQWKuihS8hasi6mXQb1R25245QkYX+mKfAzeOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITuvYmejVqrc6TIvtrvFIa6k2emkqZFvaFqLfAjZ4uSjSdBQqOZIVPFg5/UgZoYtw24L7cY7Dcp4tiu9RAggs9NgzRU3k8wG0VGkKaXOHd7565Ej99gaDCkxuSF05agni5bpWHBz4JB8Li1xfmeFaJ24z9FhwCxeor3etT5bJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSF4ogjs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSF4ogjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F730C2BCAF;
	Fri, 24 Apr 2026 01:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776993776;
	bh=HnzfGQWKuihS8hasi6mXQb1R25245QkYX+mKfAzeOXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSF4ogjseF19HaxkrqhrP7SeqmzeX5wQYuhpbhK4DuB3AWZK8oV8sDauwlMPbXri0
	 5EEmcS1B8I+5mu1sgNg/QqB6xbNRJUldwqSy/iWJvGuKVF5ieybYiakfcWlscLTHYe
	 V7R555pF3xK0SgdywPnkcsvgwCxNMKM6nvg1QuJi64Td8JAXHKuAzTi6fvPs7eHG+z
	 Mdjy7mlpnRrFu1zKxeHPr58iFwiLekY/QpkJgO6ZWx0Uip5knXRNHXRjHQwntOTw7Q
	 BrTSzt/XWq7fHClAmHAlp39FYgXLyqLYOvotbEnxDX6KfwiR07Va5E5o6KC2GPx+q4
	 BK1hTfg+rUEZg==
Received: by venus (Postfix, from userid 1000)
	id 1E0F1180E60; Fri, 24 Apr 2026 03:22:54 +0200 (CEST)
Date: Fri, 24 Apr 2026 03:22:53 +0200
From: Sebastian Reichel <sre@kernel.org>
To: luoxueqin <luoxueqin@kylinos.cn>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: battery: add state_of_health support to
 power_supply
Message-ID: <aerE9b5vE0vBv8Si@venus>
References: <20260423075853.151829-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkbfp54y2lyxkwyr"
Content-Disposition: inline
In-Reply-To: <20260423075853.151829-1-luoxueqin@kylinos.cn>


--vkbfp54y2lyxkwyr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ACPI: battery: add state_of_health support to
 power_supply
MIME-Version: 1.0

Hi,

On Thu, Apr 23, 2026 at 03:58:53PM +0800, luoxueqin wrote:
> From: Xueqin Luo <luoxueqin@kylinos.cn>
>=20
> Add support for POWER_SUPPLY_PROP_STATE_OF_HEALTH in ACPI battery
> driver.
>=20
> State of Health is calculated as the ratio between full charge capacity
> and design capacity, expressed as a percentage.
>=20
> The value is computed as:
>     SOH =3D full_charge_capacity * 100 / design_capacity

$ grep -A15 state_of_health Documentation/ABI/testing/sysfs-class-power
What:		/sys/class/power_supply/<supply_name>/state_of_health
Date:		August 2025
Contact:	linux-arm-msm@vger.kernel.org
Description:
		The state_of_health parameter quantifies the overall condition
		of a battery as a percentage, reflecting its ability to deliver
		rated performance relative to its original specifications. It is
		dynamically computed using a combination of learned capacity
		and impedance-based degradation indicators, both of which evolve
		over the battery's lifecycle.
		Note that the exact algorithms are kept secret by most battery
		vendors and the value from different battery vendors cannot be
		compared with each other as there is no vendor-agnostic definition
		of "performance". Also this usually cannot be used for any
		calculations (i.e. this is not the factor between charge_full and
		charge_full_design).

		Access: Read

		Valid values: 0 - 100 (percent)

Greetings,

-- Sebastian

--vkbfp54y2lyxkwyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnqxekACgkQ2O7X88g7
+pqirg/+P6XjfK8QwcUsFDCUoemLKNtSlv2FwKKWxZpowzrL/DwiDXhsjrDnP6eY
xjBdCx+zwkLYCJOgrakFmpAfAQvdHN4AiGW6Mcy4L51wkQ7MplAJ3K4rh8NxxvPB
V/aMg6x7f2vlNYp8NfQVrpWLe5EF6B7grIl/iZ+TYavUhYX87+kg8KkqtO3+xRuu
gSGQnjbfAy2VbVPaayv4exbBvOv8lG5K670LAyraT/q72+6/jOM9Ny49V8D26IvE
5vVHZWrz1y41xAD396N+U/05HXb2TJv0VZy4JXkac1+lbboP4B1bc+Q71e4W4rWE
uxlEhFWc96lyQk2X3FfQix1s8ohRot9GqI1ZupXjIHbS6teMpUa6ITuJaQFEi189
UNqTULshfbT3LPhalhOhIhor3r7e/nuh1xKCW4Cx1UloNwnCtz6rmuZownS640wh
Jd+ZuU9ZTRZPiq3iUed/bRf2gQa75qIzWHvG56RrK6sX0vTsous2436NmqA6APp5
wJ39uHr5oSzpNL31XSiV8LmqVv1tLPx7V6UgzpThT4xTs3Holza3MhL2iEPByUZI
FNGAhk3iQyKJNdfjKy+w4RIUMEamMzkOHm76/E8ZLjFtYf7OqY3yci8wyEjYJUV0
vnsmodnu3ZmGTqZ0wmgIPTrb6g5h/SsdkMJ/tLlE8cSaXA5/nr4=
=eK1+
-----END PGP SIGNATURE-----

--vkbfp54y2lyxkwyr--
