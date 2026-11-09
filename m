Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249139;
	b=oxCPJDF9anMpRz32eL5Xn2SddX7fpBVYKeTSARAP/DFbR2YNhYYcrYyi9VKtsHgRvq3Y
	 W/twSgfjPoCKhOjwN5RgeQdlXuZ7YB7Yo0I0rkJ7CJiE+wHfUPWQAjUrEMVb4MbUQnZMC
	 8fVqisIEwPv4rdMjcTudnG57QJIC0vNv+x165MDCsjC0ZTb0eVDIUPgHwGBQucG+UPI8/
	 Onc2E73hMA0Im0C/d0RSTTlZiQXWxXoATR2i1wY2yDibWIwdxf5XLzwdMqKKhSXNoH10W
	 7pGIshsxyEgTjZdAD5hRbYcKT8QInTlOj7k9Tj3JgeTiTXa/axz6o/Jn+uQXmWCx/zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249139;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AabjF3kCjbqAZX2M1/nnB3VL6whiVsR2g4lcFusaBqM=;
	b=vVzUGu8c/0Zx0YCN0VivLQK72xqNAU3hSHqf6ekbHmqNM36p1hlTSTb2PolRGYn1r8zY
	 0b4JU1NhYLf6nGN/E800dE+rYMPse8IP8wHpiIe8qXfCIzQpw0qySo4qLBhoiFMCL85FC
	 k6DElVbU1K8QsbF5GmWXcL5dKHUNoinyYQkp4xw+Aqs0eOuDYI8/ng5ekFWmDFogsiacS
	 DrH18/on46CVb8Zi6iRN2okvQYetWa6C1Hiphcj7re5H8Jmslu0+tUqH/NdC1CQSbCSMN
	 tIAE7Byip5Em/eDVIoq8c7lfYJ/ki6i6J+Uyxwdm8KFLiVVqE0LxgP9Mw3E5DAt4dKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkHpHFOF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396B606B59E
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkHpHFOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03F01F008A7
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 18:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249138;
	bh=AabjF3kCjbqAZX2M1/nnB3VL6whiVsR2g4lcFusaBqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YkHpHFOFP0g8RR2eVdQgch4FIpO2HVB2S/jkNLMgaLgL4wSJp3+hmN+GbnXnTkFSA
	 6Ht74Km1FLdJnUwKQ0VsXqzpGZnN2lOC7G7bCItMXR3Cbf6NxiIHiEU6oQi4rQN74A
	 +tYtfL/9vJ6sRIGTL+JoMpG+sUbyxZaM9pMOZsjrd1d1td+78zcHKVo0Ut0H+NkwzA
	 o1t/XnoTbe+lMoDGIsbv0X32u5TSx6dlcCsyVKR0qGYL7678PKqjSFXVkwKojNdpOG
	 /05TYNVSA6ggHp+K1nu7TySiM7ytKCu7Y9jMW7LpEH3OthQPekvoinsochn223ou0g
	 wj0PW9KTodzBQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be416e603cso829070e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 10:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHhH0An7gu+GepYWlFqH6dHEvY8A6PUu8KimmzOpJYn2Pi2Ko55wJpo62F567Jzm+cjeqGH7DilKVYF@vger.kernel.org
X-Gm-Message-State: APuU4Z9gE91/vzLJ3CEMAYK74fEhfxNRGLxZS0fBOvI0Ih0k6pPIcByk
	RzF3d9OnTAW9QWpOjbmPyAg+ecQtxJf4IZHgRGsuOsBKvOqfInZWXgeEbmZxBAOZH2vAbNjp7FJ
	xDjw6x4z+JOn0r9pHFpRKkKqomfPdKzY=
X-Received: by 2002:a05:6512:3f0d:b0:5c1:4e17:1ee7 with SMTP id
 2adb3069b0e04-5c156eb0a32mr71702e87.57.1794249137037; Mon, 09 Nov 2026
 10:32:17 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJZ5v0jv9VQhZKbQcWYHEU0sQUPn5sLsRmqHzEtZ4T6GY0t3ZA@mail.gmail.com>
 <20261030014412.1652-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261030014412.1652-1-atharvatiwarilinuxdev@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 19:32:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hHOKFYS4D+CLRiCF0hiRK6SOY=VKJ619rTNauipnHsrA@mail.gmail.com>
X-Gm-Features: AclHuK_I2Ur9BBcerWA9T-cAm-CBK6sVJcd2gsJpUYWkE4XceQZr0yZqtQR7ioA
Message-ID: <CAJZ5v0hHOKFYS4D+CLRiCF0hiRK6SOY=VKJ619rTNauipnHsrA@mail.gmail.com>
Subject: Re: [PATCH RESEND] ACPI: processor: Use Apple-specific methods for P/C-states
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 2:44=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > You haven't provided a motivation for the change and I know nothing
> > about Apple platforms, sorry.
>
> APSS provides more P-states than _PSS on apple macs, for example on MacBo=
okPro11,3
>
> _PSS provides 17 P-states ranging from 800Mhz to 2301 Mhz, while
> APSS provides 28 P-states ranging from 800Mhz to 3500 Mhz
>
> Same with ACST, on Xserve3,1 _CST provides 2 C-states (C1, C6)
> while ACST provides 3 C-states (C1, C2, C6).
>
> This is also used in older macs only (before 2015).

Which one is used in older Macs, ACST?

> And also macOS uses these.

Information like the above should go into the patch changelog.
