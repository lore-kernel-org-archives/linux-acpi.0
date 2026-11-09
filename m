Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246013;
	b=EKCe1eD0b0Dw+mUURy3l7aT2zdxKSt2LgDGaEuETAcV0GGfYbuIHJtGD1ET16hb6q0Tv
	 8/FDj66RPdneZ+9Htr9pIt+iUlTui51fLteWkqI7C01dtFPnt18VwMTHCgxoemVp/A9YU
	 nuwVW1cP83FpTnho52gvdOF2hOkw/UKF5ZMt95ENPIo+5Llx8jrWZdAbVEfussv5pdiAQ
	 exWC2XZIWq0KRgKkay7XokIttTEmKwBfuHjw7fajQ613ff9AXnQ7vH4427EY4TrxjjtQb
	 Bdo5Rd7i8tA62q9XN2dJTD8EI7zYAkhkQpQEu4ApDksn29yBDhSaBcflQJGUWDc642A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246013;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o7KDuZ1nMhNo4YG48lXW5JSMztCo9HbxwuLzAG/SOPA=;
	b=B63mfOlo7HFNqkxMSfJxt5/2i/sfQHJSjaD2oJ3eIa1W6ZIlFX6AQ5wSTk6qfzzBHj3V
	 aKQYSd15CXjkxttHASp4cH7DeTnngeL1L7XTP9gRaPI0I53RQkIIxkWX60elSwFEQBUmy
	 ullEf+joi6QclsuvfpyGanjk/sbbQcYr15ffa/VCheo1Itu2rC+Jce889Ru+xQu/EoVdS
	 e/1Z+nQQsdQBVgxTQ1rPnF5arwPBH4guLJg/f3hHhjii0j6YorREXlfH3xSh6iF0AP0Hy
	 xyCsu/PQ08w1emWMdo+0tK/Ggpw+uaeEMdbvRbljEc/zoNmAfr+qgtXXS31r+ZfhdgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnJZE5MV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EC606A339
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnJZE5MV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769831F008AB
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246013;
	bh=o7KDuZ1nMhNo4YG48lXW5JSMztCo9HbxwuLzAG/SOPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CnJZE5MVXJeUIGen6nObmOPWrZnw8tp1xFse4tayeQmEtVCNlmXuN7RKnk5ttpwKo
	 G51D6zGfbqZKUTqRKYlt/k27sdm2OthnnMnpwgVDab/erYa061YSArOowkcSuE5SrG
	 6YZSrhisgogsGIDcvHytfEnqtcmzbv8+UlD6d302+i2kSzhGEvwJhMvSeWc6hFOzF6
	 VBgxley+qblJFFmfmtgVssMrzGiECqpr1Q/BaerEzuPL73njFfMFA16mp6PExPJp+Z
	 0S+GfHNtd+kE3XnUERN6dqOTwUZwjKCFWcLOPrsua3ixTt5A+jK5hfqLpjEgG1tsHb
	 IJwQrxmBhETNg==
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2dbe5c4b0so375167137.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 09:40:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHTlXv6aW4wKpwZXu1YMCEJGwe8IGWfdpBkGjJ7wzcYX9IWwdQ1Y8fAiEEfWeBP1e/LBeSp8i2VAXgH@vger.kernel.org
X-Gm-Message-State: APuU4Z/bbZfmjN9CeWCUX3y+o19QgrvToI2ttV0mpIUfQ0mQh5YjhZLx
	6DzJ3+yuxMCSgwdUchIOtgl0FGGC35vZVFUcNKxkThCH0Tun5OHTdEle3eYaLSr+xvbNmLrOMxu
	rr7t7Wdl+S7hUbwrgY6WbvpBH5+mI+RA=
X-Received: by 2002:a05:6102:914:b0:7cc:118e:7bfe with SMTP id
 ada2fe7eead31-7d2db102570mr1357435137.19.1794246012630; Mon, 09 Nov 2026
 09:40:12 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012230632.3574987-1-jamien@nvidia.com> <20261106154227.1445127-1-jamien@nvidia.com>
In-Reply-To: <20261106154227.1445127-1-jamien@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 18:39:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i2FYcSeaZegt8zxVcrBXZtC15rruT_3a0Tr88mmCTJUA@mail.gmail.com>
X-Gm-Features: AclHuK8LYN7BAT51RckggiFWb7BukptqiyDiUMTJJKIqUJL0I_hnRI-HB9HvIok
Message-ID: <CAJZ5v0i2FYcSeaZegt8zxVcrBXZtC15rruT_3a0Tr88mmCTJUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ACPI: sysfs: Expose BDAT data region
To: Jamie Nguyen <jamien@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Punit Agrawal <punitagrawal@gmail.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:42=E2=80=AFPM Jamie Nguyen <jamien@nvidia.com> wro=
te:
>
> Hello,
>
> Gentle ping on this series.  It still applies cleanly to v7.4-rc1, on
> top of the two Sashiko finding fixes [1][2].  Please let me know if
> anything else is needed, such as a resend dropping the "Assisted-by:"
> tag.
>
> [1]: https://lore.kernel.org/r/20261013180728.957618-1-jamien@nvidia.com
> [2]: https://lore.kernel.org/r/20261013193900.1258808-1-jamien@nvidia.com

It would be good to resent this to allow Sashiko to review it again
because the fixes above are part of the mainline now.
