Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608540;
	b=cIm8FnuQsuxwpQY9zgf6YdC4+6puFYeEcmhjeDDdyEa1RdHdxtMhtzew9HQpXiKE4rFV
	 yqwioYWzpONbVyqjUYLqUlGDVRj08ua/vNovUceXRC+e0XC7wZyU9pgp7/tITRGdbagJI
	 LKIpeqyMeuur1AU90Y/j71gbv8C6tUcLMsRVRjmxfqBAlukplwnpw8YCFuKETz/wFCQVi
	 U910Wcg/oi/M+/nag/dfa/SW4Wj3/0eMJA2fj8tCKOUijbZEt8DRqdJb46ch1d5qZ7Pvw
	 awF9VO3rOzOf9KQ37tlWEfrfh+Br2pUDuu3CoGOUUT+UJTix27CU4+HFmc7ZTmUT9Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608540;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:
	 Subject:Cc:From:To:X-Mailer:References:In-Reply-To;
	bh=1rIB1vRoYUg/eat5sycNG20a1NBZxW/VI6E4kjo2aTM=;
	b=3i6rCOaT7bvUUY48h+ulJ4dDwOENz91DH5yBHPAhkOT/Eg2U8Wx8BO8blOBSZomXzKkb
	 MFvxgVs1n+bx+pYtAkxlL8zX7DUvbwHGK1wXvMP78HR7rFvTrnVFTDdwpaDwHUf5aLz9J
	 XoKE/qQ9D1oJ/TwPoPKGEUi8RN3OxpxdfFwPaTfsz8vIs4sZk7UuFAug6GjCIL9rllV/+
	 F6NcLsOL5SJnDty1zZ0n772Y69HcqmHXrpusV5jbEC/Ye9VRPDFEU0mRPJuzPZcMumCIC
	 f84Odq2SeVROW5i+8VMzGD0HW3GkctdSjhrTctweIGqpNoP88nc8t9LVnDUWJE2k0mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4Ncde+y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BDCA2606A326;
	Mon,  2 Nov 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4Ncde+y
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D1C221F000C1;
	Mon,  2 Nov 2026 08:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608539;
	bh=1rIB1vRoYUg/eat5sycNG20a1NBZxW/VI6E4kjo2aTM=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=g4Ncde+yEUn3Uqc/DM1NJrcWBNtJqH6PnT1tBqCNDfWuk7RkFToVd8GnNs7NhV00L
	 dzFiuW1giTQ5Nod9ajgRdFnA7cbNMM8VSlJ5kIz79HwJXN0pIPPMHFHX+0rRBatl/m
	 9Puk7QV6hRJlSSVN5hWPu6Zt6BA62eHn8BleccUDCvD0H4MHfavVex35E8QJHtv5Ni
	 cwjokAdaMRAlfuxjwF1+JOtq1IulwjeZjglqvrMe00hTe2UD9wioU0jteqR5mhx+qw
	 257e1hXa85D4zg9aHNwAWVdB3eYXZgE0uRn2It2wFqp+uZhvnsxsrYa7S/JK4L6Uh2
	 pCiArhBVsenpw==
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b81a3de448a6ea9d1d628ba9d1bdeef55f94c872718d1fd8c33a13ec9aad;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 02 Nov 2026 09:35:35 +0100
Message-Id: <DMKL5UA6LF1L.JHZVY1JO1AE2@kernel.org>
Subject: Re: [PATCH v13 02/13] gpiolib: regmap: add
 GPIO_REGMAP_QUIRK_SET_AFTER_DIR
Cc: "Linus Walleij" <linusw@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>, "Conor Dooley"
 <conor+dt@kernel.org>, "Mika Westerberg" <westeri@kernel.org>,
 <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>, "Long Zhao"
 <zl020895@163.com>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: <longzhao@ambarella.com>, "Bartosz Golaszewski" <brgl@kernel.org>,
 <linux-gpio@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-2-4f93114ea204@ambarella.com>
In-Reply-To: <20261102-cv75-gpio-v13-2-4f93114ea204@ambarella.com>

--b81a3de448a6ea9d1d628ba9d1bdeef55f94c872718d1fd8c33a13ec9aad
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 2, 2026 at 7:45 AM CET, Long Zhao via B4 Relay wrote:
> From: Long Zhao <longzhao@ambarella.com>
>
> Some controllers ignore output writes while a line is still an input.
> Add a behaviour flag so the output value is written after the direction
> change. This is a legacy quirk. New hardware must not use it.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>


Nitpick, if you'll send a new version: I've just noticed the
subject. It should be "gpio: regmap:" not gpiolib.

-michael

--b81a3de448a6ea9d1d628ba9d1bdeef55f94c872718d1fd8c33a13ec9aad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCauhLWBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hnUQF+MpLNFPuyxRBC6LHqgNWM5/qXE+DdSn3Q
a45RjxU8gIC4JIWdU2Jqs/9Uu6hKFU9BAYCglCj6EnRCcagFtOvXexH591eaGd9w
BX+skRSjoJoLXk+ZLWnvf2wzxPlsHqYV0Ik=
=Ynsr
-----END PGP SIGNATURE-----

--b81a3de448a6ea9d1d628ba9d1bdeef55f94c872718d1fd8c33a13ec9aad--
